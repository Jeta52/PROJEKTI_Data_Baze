-- Trigeri i pare : Paga te mos jete me e vogel se 300

delimiter $$
create trigger CheckSalary before insert on punetori 
for each row 
begin 
	IF new.Paga < 300 
    then signal sqlstate '45000'
    set message_text = 'Paga duhet te jete me e madhe se 500 euro ';
    end if;
end $$
delimiter $$

-- Trigeri i dyte : Data e afatit te kthimit te mos jete me larg se 15 dite nga ajo e huazimit
delimiter $$
create trigger CheckDeadLine before insert on huazimiiLibrit 
for each row 
begin 
     IF datediff(new.hAfatiKthimit, new.hDataHuazimit) > 15
     then signal sqlstate '45000'
     set message_text = 'Afati i kthimit duhet te jete maksimalisht 15 dite me vone se data e huazimit !';
     end if;
end $$
delimiter $$

-- Trigeri i trete : Triggeri per lexuesit e fshire nga databaza 
create table lexuesi_i_fshire (
ID_Lexuesi int,
l_Emri varchar(20),
l_Mbiemri varchar(20),
l_Emri_i_Prindit varchar(20),
l_Gjinia varchar(20),
l_Data_Lindjes date, 
l_Adresa varchar(20),
l_Telefoni varchar(20),
l_Email varchar(70),
l_Profesioni varchar(20),
LogDateTime datetime,
LogUser varchar(225),
LogAction varchar(20)
);

delimiter $$
create trigger lexuesiFshire before delete on lexuesi 
for each row 
begin
	insert into lexuesi_i_fshire()
    values(old.ID_Lexuesi, old.l_Emri, old.l_Emri_i_Prindit, old.l_Gjinia, old.l_Data_Lindjes, old.l_Adresa,
    old.l_Telefoni, old.l_Email, old.l_Profesioni, now(), current_user(), 'Delete');
end $$
delimiter $$

-- Prcedura e pare: Te gjendet numri i huazimeve per secilin zhaner te librit.

delimiter $$
create procedure Stats(out nrTagjedive int, out nrKomedive int, out nrRomaneve int)
begin 

-- nr i tragjedive te huazuara --
select count(l.ID_Libri)
into nrTagjedive
from libri l 
inner join huazimiILibrit h on l.ID_Libri = h.ID_Libri
where   Zhanri = 'Tragjedi';

-- nr i komedive te huazuara --
select count(l2.ID_Libri) 
into nrKomedive
from libri l2 
inner join huazimiILibrit h2 on l2.ID_Libri = h2.ID_Libri
where   Zhanri = 'Komedi';

-- nr i romaneve te huazuara --
select count(l3.ID_Libri) 
into nrRomaneve
from libri l3 
inner join huazimiILibrit h3 on l3.ID_Libri = h3.ID_Libri
where   Zhanri = 'Roman';
end $$
DELIMITER $$

call Stats(@nrTagjedive,@nrKomedive,@nrRomaneve);

select @nrTagjedive as 'Numri i Tragjedive', @nrKomedive 'Numri i Komedive', @nrRomaneve 'Numri i Romaneve';

-- Prcedura e dyte: Procedure (pa parametra) per shfaqje te dhenave mbi librat ne biblioteke --
delimiter $$ 
create procedure LibratNeBibloteke()
begin 

select distinct Autori, Titulli 
from Libri 
order by Autori; 

end $$ 
delimiter $$

call LibratNeBibloteke();

-- Procedura 3: Gjej librat e zhanrit komedi 
delimiter $$
drop procedure if exists LibratKomedi$$
create procedure LibratKomedi(Zhanri varchar(15))
begin 
select distinct l.ID_Libri, l.Titulli, l.Autori , l.Zhanri 
from libri l 
where Zhanri = l.Zhanri; 
end $$
delimiter $$
call LibratKomedi('Komedi');

-- View i pare: Te gjithe lexuesit studente, emri, mbiemri, mosha dhe niveli universitar
CREATE VIEW LexuesitStudente AS
SELECT distinct l_Emri, l_Mbiemri, Mosha(l_Data_Lindjes) as Mosha, IF(Mosha(l_Data_Lindjes)>22,  "Master","Bachelor") as Niveli
FROM huazimiILibrit h
inner join Libri l on h.ID_Libri = l.ID_Libri
inner join Lexuesi l2 on h.hID_Lexuesi = l2.ID_Lexuesi
WHERE l_Profesioni ='Studente';

select * from LexuesitStudente;

-- View i dyte: Te tregohet sa femra dhe sa meshkuj lexues jane ne databaze, dhe totali i tyre
Create view StatistikaGjinore as 
Select count(case when l_Gjinia = "Femër" then 1 end) as Numri_i_femrave_lexuese,
       count(case when l_Gjinia = 'Mashkull' then 1 end) as Numri_i_meshkujve_lexues,
       count(*) as Total_lexuesit
from Lexuesi;

Select * from StatistikaGjinore;

-- Funksioni i pare: Mosha mesatare e lexuesve

DELIMITER $$
CREATE FUNCTION Mosha(l_Data_Lindjes datetime)

RETURNS decimal DETERMINISTIC /*by default not deterministic*/

BEGIN
RETURN date_format(now(),'%Y')- date_format(l_Data_Lindjes,'%Y');
END $$
DELIMITER ;


select avg(Mosha(l_Data_Lindjes))as Mosha from lexuesi;

-- Funksioni 2: Te hyrat per vitin 2021 --
delimiter $$
create function TeHyratPer2021(cmimiRegjistrimit real, vitiRegjistrimit int)
returns real deterministic 
begin 
return (select count(*) where vitiRegjistrimit = '2021') * cmimiRegjistrimit ;
end $$ 
delimiter $$
select sum(TeHyratPer2021(cmimiRegjistrimit, vitiRegjistrimit)) as Te_Hyrat_Per_2021 from detajeteLexuesit;

-- ------------------------------ TRIGGER and PROCEDURE me i heq librat e demtuar nga biblioteka ---------------------------------- --

delimiter $$
create trigger HeqjaELibraveTeDemtuar before insert on libratedemtuar for each row 
begin 
    call HiqHibrin(new.ID_Libri);
end $$
delimiter ;

delimiter $$
create procedure HiqLibrin(id integer) 
begin 
  update libri
  set numriKopjeve = numriKopjeve - 1
  where ID_Libri = id;
end $$
delimiter ;

-- ------------------------------ TRIGGER and PROCEDURE me i heq librat e huazuara nga biblioteka ---------------------------------- --
delimiter $$
create trigger HeqjaELibraveTeHuazuar before insert on huazimiilibrit for each row 
begin 
    call HiqLinbrinEHuazuar(new.ID_Libri);
end //
delimiter ;

delimiter $$
create procedure HiqLinbrinEHuazuar(id integer) 
begin 
  update libri
  set numriKopjeve = numriKopjeve - 1
  where ID_Libri = id 
  and numriKopjeve > 0;
end $$
delimiter ;