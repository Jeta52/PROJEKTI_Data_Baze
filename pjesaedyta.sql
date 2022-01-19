create database Biblioteka;
use Biblioteka;


create table lexuesi (
ID_Lexuesi int,
l_Emri varchar(20) not null,
l_Mbiemri varchar(20) not null,
l_Emri_i_Prindit varchar(20) not null,
l_Gjinia varchar(20),
l_Data_Lindjes date,
l_Adresa varchar(50),
l_Telefoni varchar(20),
l_Email varchar(70),
l_Profesioni varchar(20),
primary key(ID_Lexuesi)
);


create table punetori (
PID varchar(10),
Emri varchar(20) not null,
Pozita varchar(20) not null,
Adresa varchar(50),
Telefoni varchar(20),
Email varchar(70),
Paga int,
primary key (PID)
);

create table detajeteLexuesit (
ID_Lexuesi int,
vitiRegjistrimit int not null,
dataRegjistrimit date not null,
cmimiRegjistrimit real not null,
PID varchar(10), 
anetaresimi_fundit date not null,
anetaresimi boolean,
foreign key(PID) references punetori(PID),
foreign key (ID_Lexuesi) references lexuesi(ID_Lexuesi)  on delete cascade,
primary key(ID_Lexuesi)
);

create table libri (
ID_Libri int,
Titulli varchar(30) not null,
Autori varchar(30) not null,
Zhanri varchar(15) not null,
NumriKopjeve int,
dataEPranimit date, 
PID varchar(10),
primary key (ID_Libri),
foreign key(PID) references punetori(PID)
);

create table huazimiILibrit (
hid int,
ID_Libri int not null,
hID_Lexuesi int not null,
hDataHuazimit date not null, 
hVitiHuazimit int not null, 
hAfatiKthimit date not null, 
hDataKthimit date,
PID varchar(10),
Verejtje varchar(10),
primary key(hid),
foreign key(ID_Libri) references libri(ID_Libri),
foreign key(hID_Lexuesi) references lexuesi(ID_Lexuesi)  on delete cascade,
foreign key(PID) references punetori(PID)
);

create table arkiva (
ID_Arkiva int auto_increment, 
ID_Lexuesi int not null,
ID_Libri int not null,
primary key(ID_Arkiva),
foreign key(ID_Libri) references libri(ID_Libri),
foreign key(ID_Lexuesi) references lexuesi(ID_Lexuesi)  on delete cascade
);

create table libratEDemtuar (
ID_Libri int,
ArsyejaeDemtimit varchar(30),
DataRegjistrimit date not null,
PID varchar(10),
foreign key(ID_Libri) references huazimiilibrit(ID_Libri),
foreign key(PID) references punetori(PID),
primary key(ID_Libri, PID)
);

create table furnizuesi (
FID int auto_increment,
ID_Libri int not null,
PID varchar(10) not null,
Emri varchar(20),
Sasia int not null, 
Dataefurnizmit date not null ,
primary key(FID),
foreign key(ID_Libri) references libri(ID_Libri),
foreign key (PID) references punetori(PID) );


create table Vendndodhja_e_Librit(
ID_Libri int ,
Sektori varchar(2) not null,
Kati int not null,
foreign key(ID_Libri) references libri(ID_Libri),
primary key(ID_Libri)
);

insert into Vendndodhja_e_Librit
values
(24568973,'A', 1),
(24568974,'A', 1),
(24568975,'C', 1),
(24568976,'F', 2),
(24568977,'D', 2),
(24568978,'B', 1),
(24568979,'F', 2),
(24568980,'E', 2),
(24568981,'G', 3),
(24568982,'E', 2);

insert into lexuesi
values 
(100001,'Jetë', 'Lajçi','Salih','Femër', '2002-06-26' , 'Peje, Rruga "Alia Izetbegoviç", Kosove ', '044 266 407', 'jete.lajci@student.uni-pr.edu', 'Studente'),
(100002,'Jeta', 'Kajtazi', 'Kushtrim', 'Femër', '2002-03-11', 'Peje , Rruga "Vellezerit Peterqi", Kosove ', '049 700 600' , 'jeta.kajtazi@student.uni-pr.edu' , 'Studente'),
(100003, 'Leonita', 'Mataj', 'Ali', 'Femër', '2002-10-10 ', 'Decan, Rruga "Arif Vokshi", Kosove' , '049 926 617', 'leonita.mataj@student.uni-pr.edu' , 'Studente'),
(100004, 'Melisa', 'Alaj', 'Petrit', 'Femër', '2002-02-28' , 'Decan, Rruga "Enver Alaj", Kosove' , '045 543 161', 'melisa.alaj@student.uni-pr.edi' , 'Studente'),
(100005, 'Leotrim', 'Gashi', 'Hamid', 'Mashkull', '1999-04-26' , 'Prishtine, Rruga "Muharrem Fejza", Kosove' , '044 558 774', 'leotrim.ga@gmail.com' , 'Menaxher'),
(100006, 'Granit', 'Aliu', 'Shaban', 'Mashkull', '1998-08-14' , 'Gjakove, Rruga "Elena Gjika", Kosove',  '044 998 774', 'granit-aliu@gmail.com' , 'Ekonomist'),
(100007,'Gentrit', 'Krasniqi', 'Pajtim', 'Mashkull', '2001-08-05' , 'Gjilan, Rruga "7 Shtatori", Kosove' , '044 814 754', 'gentrit.krasniqi1@gmail.com' , 'Sekretar'),
(100008, 'Vanesa', 'Sadiku', 'Shkelzen', 'Femër', '1997-09-22 ', 'Istog, Rruga "Zahir Pajaziti", Kosove', '045 713 448', 'vanesasadiku@gmail.com' , 'Asistente'),
(100009, 'Anadrin', 'Kadriu', 'Premtim', 'Mashkull', '2001-01-11', 'Prishtine, Rruga "Agim Ramadani", Kosove' , '045 448 712', 'anadrin_k@gmail.com' , 'Student'),
(100010, 'Drilon', 'Avdiu', 'Mentor', 'Mashkull', '1999-07-17' , 'Mitrovice, Rruga "Rozafa", Kosove' , '049 512 315', 'drilon.avdiu@gmail.com' , 'Jurist');

insert into punetori
values 
('P001','Qendresa Krasniqi','Drejtoreshë','Prishtinë,Rruga "Muharrem Fejza",45','044-432-001','qendresa.krasniqi@gmail.com',650),
('P002','Alban Imeri','Regjistrues','Prishtinë,Rruga "Ilaz Kodra",122','044-438-998','alban.imeri@hotmail.com',500),
('P003','Vjollca Sylejmani','Regjistrues','Prishtinë,Rruga "Agim Ramadani",32','044-543-11','vjollca.sylejmani@gmail.com',500),
('P004','Endrita Hoxha','Regjistrues','Fushë Kosovë,Rruga "Anton Çeta",67','049-876-509','endrita.hoxha@gmail.com',500),
('P005','Albert Syla','Regjistrues','Obiliq ,Rruga "Hasan Prishtina",93','045-764-013','albert.syla@gmail.com',500),
('P006','Blerta Islami','Regjistrues','Fushë Kosovë, Rruga "Lulzim Osmani",87','044-765-190','blerta.islami@gmail.com',500),
('P007','Bleona Bardhi','Regjistrues','Obiliq, Rruga "Hasan Prishtina",23','044-555-882','bleona.bardhi@gmail.com',500),
('P008','Arta Kadriu','Regjistrues','Ferizaj, Rruga "2 Korriku",65','044-327-181','arta.kadriu@gmail.com',500),
('P009','Kujtim Lekaj','Pastrues','Podujevë,Rruga "Ali Ajeti",122','049-875-125','kujtim.lekaj@gmail.com',500),
('P010','Pranvera Aliu','Pastrues','Prishtinë ,Rruga "Eqrem Qabej",98','049-182-786','pranvera.aliu@gmail.com',500);

insert into libri
values 
(24568973, 'Krim dhe ndëshkim', 'Fjodor Dostojevski', 'Roman', 43, '2015-1-4', 'P002'),
(24568974, 'Mbreti Lir', 'William Shakespeare', 'Tragjedi', 27, '2014-12-5', 'P003'),
(24568975, 'Xha Gorio', 'Honore de Balzac', 'Roman', 22, '2007-11-8', 'P004'),
(24568976, 'Zonja Bovari', 'Gustav Flober', 'Roman',34 , '2018-8-16', 'P005'),
(24568977, 'Lahuta e Malcis', 'Gjergj Fishta', 'Roman', 50, '2004-10-25', 'P002'),
(24568978, 'Procesi', 'Franc Kafka', 'Roman', 28, '2021-2-27', 'P007'),
(24568979, 'Leximtari', 'Bernard Schlink', 'Roman', 12, '2019-4-16', 'P004'),
(24568980, 'Kronikë në gur', 'Ismail Kadare', 'Roman', 45, '2017-2-7', 'P005'),
(24568981, 'Prometeu i mbërthyer', 'Sofokliu', 'Tragjedi', 11, '2013-5-15', 'P006'),
(24568982, 'Shumë zhurmë për asgjë', 'William Shakespeare', 'Komedi', 19, '2002-6-26', 'P006');

insert into furnizuesi 
values 
(201, 24568973, 'P003', "Dukagjini", 22, '2018-12-28'),
(202, 24568974, 'P004', "Dukagjini", 22, '2018-12-28'),
(203, 24568975, 'P005', "Rilindja", 14, '2018-12-28'),
(204, 24568976, 'P003', "Dukagjini", 13, '2018-12-28'),
(205, 24568977, 'P004', "Buzuku", 22, '2018-12-28'),
(206, 24568978, 'P005', "Dukagjini", 22, '2018-12-28'),
(207, 24568979, 'P006', "Rilindja", 22, '2018-12-28'),
(208, 24568980, 'P007', "Dukagjini", 10, '2018-12-28'),
(209, 24568981, 'P005', "Rilindja", 22, '2018-12-28'),
(210, 24568982, 'P003', "Dukagjini", 12, '2018-12-28');

insert into detajeteLexuesit
values
('100001', 2020, '2020-5-6' , 5.0, 'P008' ,  '2022-1-5', if(anetaresimi_fundit > CONCAT(YEAR(CURDATE())-1,'-12-31'), true, false)),
('100002', 2019,  '2019-5-21' ,  5.0, 'P004' , '2020-1-5', if(anetaresimi_fundit > CONCAT(YEAR(CURDATE())-1,'-12-31'), true, false)),
('100003', 2020, '2020-5-17' ,  5.0, 'P008' , '2022-1-17', if(anetaresimi_fundit > CONCAT(YEAR(CURDATE())-1,'-12-31'), true, false)),
('100004', 2018, '2018-3-15',  5.0, 'P007' , '2019-3-15', if(anetaresimi_fundit > CONCAT(YEAR(CURDATE())-1,'-12-31'), true, false)),
('100005', 2021, '2021-7-30',  5.0, 'P005' ,  '2022-1-3', if(anetaresimi_fundit > CONCAT(YEAR(CURDATE())-1,'-12-31'), true, false)),
('100006', 2017, '2017-9-8',  5.0, 'P007' ,  '2018-9-8', if(anetaresimi_fundit > CONCAT(YEAR(CURDATE())-1,'-12-31'), true, false)),
('100007', 2018, '2018-5-21', 5.0, 'P006' ,  '2022-1-21', if(anetaresimi_fundit > CONCAT(YEAR(CURDATE())-1,'-12-31'), true, false)),
('100008', 2021,  '2021-2-17',  5.0, 'P005' , '2022-1-16', if(anetaresimi_fundit > CONCAT(YEAR(CURDATE())-1,'-12-31'), true, false)),
('100009', 2017,  '2017-3-14', 5.0, 'P006' ,  '2018-3-14', if(anetaresimi_fundit > CONCAT(YEAR(CURDATE())-1,'-12-31'), true, false)),
('100010', 2019,  '2019-1-11', 5.0, 'P004' , '2020-1-11', if(anetaresimi_fundit > CONCAT(YEAR(CURDATE())-1,'-12-31'), true, false));

insert into huazimiILibrit
values
(0001, 24568973, 100004, '2021-12-11',2021, '2021-12-26', '2021-12-15', 'P004', 'Nuk ka'),
(0002, 24568974, 100008, '2021-4-23',2021,  '2021-5-8',  '2021-4-28', 'P005', 'Nuk ka'),
(0003, 24568975, 100002,  '2020-5-18',2020,'2020-2-6', '2020-3-6', 'P008', 'Demtim'),
(0004, 24568976, 100005, '2020-3-19',2020, '2020-4-3',  '2020-3-26', 'P008', 'Nuk ka'),
(0005, 24568977, 100003,  '2021-8-30',2021, '2021-9-14',  '2021-9-17', 'P003', 'Vonese'),
(0006, 24568978, 100009, '2021-11-11',2020, '2021-11-26', '2021-11-22', 'P007', 'Nuk ka'),
(0007, 24568979, 100001,  '2019-6-25',2019, '2019-7-10', '2019-7-8', 'P006', 'Nuk ka'),
(0008, 24568980, 100010,  '2021-2-28',2021, '2021-3-15', '2021-3-20', 'P007', 'Vonese'),
(0009, 24568981, 100007,  '2018-7-16',2018, '2018-7-31', '2019-7-30', 'P005', 'Demtim'),
(0010, 24568982, 100006,  '2019-1-15', 2019, '2019-1-30', '2019-1-28', 'P004', 'Nuk ka'),
(0011, 24568978, 100005, '2020-4-19',2020, '2020-5-4', '2020-4-27', 'P008', 'Nuk ka'),
(0012, 24568980 , 100002 , '2022-01-02' , 2021 , '2022-01-17' , '2022-01-10' , 'P004' , 'Nuk ka');


insert into libratEDemtuar
values
(24568975, 'Kopertina te demtuara', '2007-11-8', 'P008'),
(24568981, 'Mungese te faqeve', '2013-5-15', 'P005');

insert into arkiva 
values
(14451, 100004, 24568973),
(14452, 100004, 24568974),
(14453, 100004, 24568976),
(14454, 100004, 24568976),
(14455, 100004, 24568977),
(14456, 100004, 24568978),
(14457, 100004, 24568979),
(14458, 100004, 24568980),
(14459, 100004, 24568981),
(14460, 100004, 24568982);

-- QUERY 1 --
select ID_Lexuesi as ID, l_emri as Emri, l_mbiemri as Mbiemri 
from lexuesi 
where l_adresa like 'Prishtine%';

-- QUERY 2 --
SELECT ID_Lexuesi as ID, l.l_emri as Emri , l.l_mbiemri as Mbiemri
FROM huazimiILibrit h
JOIN lexuesi l on h.hID_Lexuesi = l.ID_Lexuesi 
WHERE year(hDataHuazimit) = 2020
group by ID_LExuesi
having count(h.hID_Lexuesi)>1;

-- QUERY 3 --
Select hID_Lexuesi as "ID e Lexuesit"
from huazimiilibrit
Where hDataKthimit > hAfatiKthimit and hVitiHuazimit > 2019;

-- QUERY 4 -- 
Select l.ID_Libri as ID, l.Titulli as Titulli
from huazimiilibrit h1 join libri l on h1.ID_Libri = l.ID_Libri
where year(hDataHuazimit) between '2019-01-01' and '2020-12-31'
and h1.ID_Libri not in 
(Select distinct h2.ID_Libri 
from huazimiilibrit h2 
where year(hvitiHuazimit) = 2021);

-- Query 5 --
select l_emri as "Emri: ", l_mbiemri as "Mbiemri: ", count(hid) as "Nr i huazimeve"
from huazimiilibrit j 
inner join lexuesi l on l.ID_Lexuesi = j.hID_Lexuesi
where hDataHuazimit > now() - interval 3 Month
group by j.hID_Lexuesi
Order by count(j.hID_Lexuesi) desc
limit 5;

-- Query 6 -- 
select sum(cmimiRegjistrimit) as Shuma, vitiRegjistrimit as Viti
from detajeteLexuesit
where (vitiRegjistrimit = 2021 or vitiRegjistrimit = 2020 or vitiRegjistrimit = 2019)
group by vitiRegjistrimit;

-- Query 7 --
select l.l_emri as Emri, l.l_mbiemri as Mbiemri, k.zhanri as Zhanri,
count(*) as "Numri huazimit",
sum(if(j.hAfatiKthimit < j.hDataKthimit,1,0)) as "Vonesa totale",
count(k.zhanri) as "Zhanri i preferuar" 
from lexuesi l
join huazimiilibrit j on l.ID_Lexuesi = j.hID_Lexuesi
join libri k on k.ID_Libri = j.ID_Libri 
where year(j.hDataKthimit) = year(current_date())
group by l.ID_Lexuesi
order by k.Zhanri desc;

-- Query 8 --
select d.titulli as Titulli from libri d, huazimiilibrit h 
where h.ID_Libri = d.ID_Libri and year(h.hDataHuazimit) = year(current_date())
group by h.ID_Libri 
order by count(h.ID_Libri) desc 
limit 1;

-- Query 9 --
select d.Autori as Autori from Libri d, huazimiilibrit h 
where d.ID_Libri = h.ID_Libri 
group by h.ID_Libri
order by count(h.ID_Libri) desc
limit 1; 