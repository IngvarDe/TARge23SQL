--loome db
create database TARge23SQL

-- db valimine
use TARge23SQL

--db kustutamine
drop database TARge23SQL

-- tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values (1, 'Male'),
(2, 'Female'),
(3, 'Unknown')

-- vaatame tabeli sisu
select * from Gender

--loome uue tabeli
create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

--andmete sisestamine
insert into Person (Id, Name, Email, GenderId) values
(1, 'Superman', 's@s.com', 1),
(2, 'Wonderwoman', 'w@w.com', 2),
(3, 'Batman', 'b@b.com', 1),
(4, 'Aquaman', 'a@a.com', 1),
(5, 'Catwoman', 'c@c.com', 2),
(6, 'Antman', 'ant"ant.com', 1),
(7, NULL, NULL, 3)

--vaadake Person tabeli andmeid
select * from Person

-- võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

--kui sisestad uue rea andmeid ja ei ole sisestanud GenderId-d
--alla väärtust, siis see automaatselt sisestab sellele reale
--väärtuse 3 e unknown
alter table Person
add constraint DF_persons_GenderId
default 3 for GenderId

--sisestame andmed
--
insert into Person (Id, Name, Email)
values (9, 'Ironman', 'i@i.com')

select * from Person

--lisame uue veeru
alter table Person
add Age nvarchar(10)

-- lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

-- sisestame uue rea andmeid
insert into Person (Id, Name, Email, GenderId, Age)
values (10, 'Kalevipoeg', 'k@k.com', 1, 30)

--muudame koodiga andmeid
update Person
set Age = 35
where Id = 9

select * from Person

--sisestame muutuja City nvarchar(50)
alter table Person
add City nvarchar(50)

--sisestame City veergu andmeid
update Person
set City = 'Kaljuvald'
where Id = 10

select * from Person

-- k]ik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
--k]ik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'
--k]ik, kes ei ela Gothamis
select * from Person where City != 'Gotham'

-- n'itab teatud vanusega inimesi
select * from Person where Age = 120 or Age = 50 or Age = 19
select * from Person where Age in (120, 50, 19)

-- n'itab teatud vanusevahemikus olevaid inimesi
-- ka 22 ja 31 aastaseid
select * from Person where Age between 22 and 31

-- wildcard e n'itab k]ik n-t'hega linnad
-- n-t'hega algavad linnad
select * from Person where City like 'n%'
--k]ik emailid, kus on @-m'rk sees
select * from Person where Email like '%@%'

-- n'itab Emaile, kus ei ole @-m'rki sees
select * from Person where Email not like '%@%'

--n'itab, kellel on emailis ees ja peale @-m'rki ainult [ks t'ht
select * from Person where Email like '_@_.com'

update Person
set Email = 'bat@bat.com'
where Id = 3

-- k]ik, kellel nimes ei ole esimene t'ht W, A, C
select * from Person where name like '[^WAC]%'
select * from Person

--kes elavad Gothamis ja New York-s
select * from Person where (City = 'Gotham' or City = 'New York')

-- k]ik, kes elavad v'lja toodud linnades ja on vanemad, kui
-- 29
select * from Person where (City = 'Gotham' or City = 'New York')
and Age >= 30

-- kuvab t'hestikulises j'rjekorras inimesi ja v]tab 
-- aluseks nime
select * from Person order by Name
-- kuvab vastupidises j'rjestuses
select * from Person order by Name desc

--v]tab kolm esimest rida
select top 3 * from Person

-- kolm esimest, aga tabeli j'rjestus on Age ja siis Name
select * from Person
select top 3 Age, Name from Person

-- n'ita esimene 50% tabeli sisust
select top 50 percent * from Person

--j'rjestab vanuse j'rgi isikud
select * from Person order by cast(Age as int)

--05.03.2024
--k]ikide isikute koondvanus
select sum(cast(Age as int)) from Person

--kuvab k]ige nooremat isikut
select min(cast(Age as int)) from Person
--kuvab k]ige vanemat isikut
select max(cast(Age as int)) from Person

--n'eme konkreetsetes linnades olevate isikute koondvanust
select City, sum(cast(Age as int)) as TotalAge from Person 
group by City

-- kuidas saab koodiga muuta andmet[[pi ja selle pikkust
alter table Person
alter column Age int

--kuvab esimeses reas v'lja toodud j'rjestuses ja muudab Age-i TotalAge-ks
--j'rjestab Citys olevate nimede j'rgi ja siis GenderId j'rgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId
order by City

insert into Person values
(11, 'Robin', 'robin@r.com', 1, 29, 'Gotham')

--n'itab ridade arvu tabelis
select count(*) from Person
select * from Person

--n'itab tulemust, et mitu inimest on GenderId v''rtusega 2 konkreetses linnas
--arvutab vanuse kokku selles linnas
select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
where GenderId = '1'
group by GenderId, City

--n'itab 'ra inimeste koondvanuse, mis on [le 41 a ja 
--kui palju neid igas linnas elab 
--eristab inimese soo ära
select GenderId, City, sum(Age) as TotalAge, count(Id)
as [Total Person(s)]
from Person
group by GenderId, City having sum(Age) > 41

--loome tabelid Employees ja department

create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

insert into Employees (Id, Name, Gender, Salary, DepartmentId) values
(1, 'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Female', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, NULL),
(10, 'Russell', 'Male', 8800, NULL)

insert into Department(Id, DepartmentName, Location, DepartmentHead)
values 
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

select * from Department
select * from Employees

-- left join
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

--arvutab k]ikide palgad kokku Employees tabelis
select sum(cast(Salary as int)) from Employees
--min palga saaja
select min(cast(Salary as int)) from Employees
-- [he kuu palga saaja linnade l]ikes
select Location, sum(cast(Salary as int)) as TotalSalary 
from Employees
left join Department 
on Employees.DepartmentId = Department.Id
group by Location

alter table Employees
add City nvarchar(30)

select * from Employees
update Employees
set City = 'New York'
where Id = 10

--n'itab erinevust palgafondi osas nii linnade kui ka soo osas
select City, Gender, sum(cast(Salary as int)) as TotalSalary from Employees
group by City, Gender
--sama p'ring nagu eelmine, aga linnad on t'hestikulises j'rjekorras
select City, Gender, sum(cast(Salary as int)) as TotalSalary from Employees
group by City, Gender
order by City

-- loeb 'ra ridade arvu Employees tabelis
select count(*) from Employees

--mitu t;;tajat on soo ja linna kaupa
select Gender, City,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City

--kuvab ainult k]ik naised linnade kaupa
select Gender, City,
count (Id) as [Total Employee(s)]
from Employees
where Gender = 'female'
group by Gender, City

--kuvab ainult k]ik mehed linnade kaupa
--ja kkasutame having
select Gender, City,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City
having Gender = 'Male'

select * from Employees where sum(cast(Salary as int)) > 4000

select Gender, City, sum(cast(Salary as int)) as TotalSalary, count (Id)
as [Total Employee(s)]
from Employees group by Gender, City
having sum(cast(Salary as int)) > 4000

-- loome tabeli, milles hakatakse automaatselt nummeradama Id-d
create table Test1
(
Id int identity(1,1),
Value nvarchar(20)
)

insert into Test1 values('X')
select * from Test1

--rida 303
alter table Employees
drop column City

-- inner join
-- kuvab neid, kellel on DepartmentName all olemas väärtus
select Name, Gender, Salary, Department.DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

select * from Employees
select * from Department

--left join
-- kuidas saada k]ik andmed Employeest k'tte
select Name, Gender, Salary, DepartmentName
from Employees
left join Department -- v]i kasutada ka LEFT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

--- right join
--- kuidas saada DepartmentName alla uus nimetus 
select Name, Gender, Salary, DepartmentName
from Employees
right join Department -- v]i kasutada ka RIGHT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

select * from Department

-- kuidas saada k]ikide tabelite v''rtused [hte p'ringusse
select Name, Gender, Salary, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id

--cross join võtab kaks allpool olevat tabelit kokku
-- ja korrutab need omavahel läbi
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

-- päringu sisu
select ColumnList
from LeftTable
joinType RightTable
on JoinCondition

-- kuidas kuvada ainult need isikud, kellel on DepartmentName NULL
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

-- teine variant
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Department.Id is null

-- full join
-- m]lema tabeli mitte-kattuvate v''rtustega read kuvab v'lja
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

-- kuidas saame Department tabelis oleva rea, kus on NULL
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

-- kuidas muuta tabeli nime, 
-- alguses vana tabeli nimi ja siis uue nimi
sp_rename 'Department1', 'Department'

-- kasutame Employees tabeli asemel l[hendit E ja 
-- Departmenti puhul D
select E.Name as EmpName, D.DepartmentName as DeptName
from Employees E
left join Department D
on E.DepartmentId = D.Id

--inner join
-- kuvab ainult isikuid, 
-- kellel on DepartmentId veerus v''rtus 
select E.Name as EmpName, D.DepartmentName as DeptName
from Employees E
inner join Department D
on E.DepartmentId = D.Id

-- cross join
select E.Name as EmpName, D.DepartmentName as DeptName
from Employees E
cross join Department D

--
select isnull('Ingvar', 'No Manager') as Manager

-- NULL asemel kuvab No Manager
select coalesce(NULL, 'No Manager') as Manager

--kui Expression on ]ige, siis paneb v''rtuse, 
-- mida soovid v]i m]ne teise v''rtuse 
case when Expression Then '' else '' end

---
alter table Employees
add ManagerId int

--neil, kellel ei ole [lemust, siis panb neile No manager teksti
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

-- teeme p'ringu, kus kasutame case-i
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

-- lisame tabelisse uued veerud
alter table Employees
add MiddleName nvarchar(30),
LastName nvarchar(30)

--muudame veeru nime
sp_rename 'Employees.Name', 'FirstName' 

update Employees
set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1

update Employees
set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2

update Employees
set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3

update Employees
set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4

update Employees
set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5

update Employees
set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6

update Employees
set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7

update Employees
set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8

update Employees
set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9

update Employees
set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10

-- igast reast v]tab esimesena t'idetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

select * from Employees


--loome kaks tabelit
create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

--kasutame union all, mis n'itab k]iki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

-- korduvate v''rtustega read pannakse [hte aj ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

--kuidas sorteerida nime j'rgi
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers
order by Name

--- stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

-- n[[d saab kasutada selle nimelist sp-d
spGetEmployees
exec spGetEmployees
execute spGetEmployees

---
create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

-- kui n[[d allolevat k'sklust k'ima panna, siis n]uab Gender parameetrit
spGetEmployeesByGenderAndDepartment
--]ige variant
spGetEmployeesByGenderAndDepartment 'male', 1

--niimoodi saab parameetrite j'rjestusest m;;da minna
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

--- saab sp sisu vaadata result vaates
sp_helptext spGetEmployeesByGenderAndDepartment

-- kuidas muuta sp-d ja v]ti peale panna, 
-- et keegi teine peale teie ei saaks muuta
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
--with encryption
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

sp_helptext spGetEmployeesByGenderAndDepartment

create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees where Gender = @Gender
end

-- annab tulemuse, kus loendab 'ra n]uetele vastavad read
-- prindib ka tulemuse kirja teel
declare @TotalCount int
execute spGetEmployeeCountByGender 'male', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@TotalCount is not null'
print @TotalCount
go --tee [levalpool p'ring 'ra ja siis mine edasi
select * from Employees

-- n'itab ära, et mitu rida vastab nõuetele
declare @TotalCount int
execute spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Female'
print @TotalCount

-- sp sisu vaatamine
sp_help spGetEmployeeCountByGender

-- tabeli info
sp_help Person

--kui soovid sp teksti n'ha
sp_helptext spGetEmployeeCountByGender

-- vaatame, millest sõltub see sp
sp_depends spGetEmployeeCountByGender
--- vaatame tabeli sõltuvust
sp_depends Employees

--- sp tegemine
alter proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Name = Id, @Name = FirstName from Employees
end

execute spGetNameById 1, 'Tom'
--- annab kogu tabeli ridade arvu
create proc spTotalCount2
@TotalCount int output
as begin
	select @TotalCount = count(Id) from Employees
end

--saame teada, et mitu rida andmeid on tabelis
declare @TotalEmployees int
execute spTotalCount2 @TotalEmployees output
select @TotalEmployees

---mis id all on keegi nime järgi
create proc spGetNameById1
@Id int,
@FirstName nvarchar(50) output
as begin
	select @FirstName = FirstName from Employees where Id = @Id
end
-- annab tulemuse, kus id 1 real on keegi koos nimega
declare @FirstName nvarchar(50)
execute spGetNameById1 1, @FirstName output
print 'Name of the employee = ' + @FirstName

---
declare @FirstName nvarchar(20)
execute spGetNameById 1, @FirstName out
print 'Name = ' + @FirstName

sp_help spGetNameById

--
create proc spGetNameById2
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end

--kutsuda declare abil v'lja sp nimega spGetNameById2
-- ja öelda, et miks see ei tööta
declare @EmployeeName nvarchar(50)
execute @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName


--- sisseehitatud string funktsioonid

-- see konverteerib ASCII t'he v''rtuse numbriks
select ASCII('a')
-- kuvab A-tähte
select char(65)

--prindime välja kogu tähestiku
declare @Start int
set @Start = 97
while (@Start <= 122)
begin
	select char (@Start)
	set @Start = @Start + 1
end

---eemaldame t[hjad kohad sulgudes
select ltrim('                    Hello')

--- t[hikute eemaldamine veerust
select LTRIM(FirstName) as FirstName, MiddleName, LastName from Employees

select * from Employees

---paremalt poolt t[hjad stringid l]ikab ära
select RTRIM('     Hello                  ')
select RTRIM(FirstName) as FirstName, MiddleName, LastName from Employees
select * from Employees

---keerab kooloni sees olevad andmed vastupidiseks
---vastavalt upper ja lower-ga saan muuta m'rkide suurust
---reverse funktsioon p;;rab k]ik [mber
select REVERSE(UPPER(ltrim(FirstName))) as FirstName, MiddleName, lower(LastName),
rtrim(ltrim(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employees

--- näeb, mitu tähte on sõnal ja loeb tühikud sisse
select FirstName, len(FirstName) as [Total Characters] from Employees
--- näeb, mitu tähte on sõnal ja ei ole tühikuid
select FirstName, len(TRIM(FirstName)) as [Total Characters] from Employees

--- left , right, substring
-- vasakult poolt neli esimest tähte
select left('ABCDEF', 4)
-- paremalt poolt neli viimast tähte
select right('ABCDEF', 4)

--- kuvab @-tähemärgi asetust
select charindex('@', 'sara@aaa.com')

--- esimene nr peale komakohta n'itab, et 
--- mitmendast alustab ja siis mitu nr kaasa arvatult kuvab
select SUBSTRING('pam@bbb.com', 7,2)

--- @-m'rgist kuvab kolm t'hem'rki. Viimase nr saab määrata pikkust
select substring('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 2,
len('pam@bbb.com') - charindex('@', 'pam@bbb.com'))

---saame teada domeeninimed emailides
select substring(Email, CHARINDEX('@', Email) + 1,
len (Email) - charindex('@', Email)) as EmailDomain
from Person

alter table Employees
add Email nvarchar(20)

update Employees set Email = 'Tom@aaa.com' where Id = 1
update Employees set Email = 'Pam@bbb.com' where Id = 2
update Employees set Email = 'John@aaa.com' where Id = 3
update Employees set Email = 'Sam@bbb.com' where Id = 4
update Employees set Email = 'Todd@bbb.com' where Id = 5
update Employees set Email = 'Ben@ccc.com' where Id = 6
update Employees set Email = 'Sara@ccc.com' where Id = 7
update Employees set Email = 'Valarie@aaa.com' where Id = 8
update Employees set Email = 'James@bbb.com' where Id = 9
update Employees set Email = 'Russel@bbb.com' where Id = 10

select * from Employees

--lisame *-märgi alates teatud kohast
select FirstName, LastName,
	SUBSTRING(Email, 1, 2) + REPLICATE('*', 5) + ---peale teist t'hem'rki paneb viis tärni
	SUBSTRING(Email, charindex('@', Email), LEN(Email) - charindex('@', Email) + 1) as Email
from Employees

--kolm korda n'itab midagi
select REPLICATE('asd', 3)

--- kuidas sisestada t[hikut kahe nime vahele
select SPACE(5)

-- tühikute arv kahe nime vahel
select FirstName + SPACE(5) + LastName as FullName
from Employees

---PATINDEX
-- sama, mis CHARINDEX, aga dünaamilisem ja saab kasutada wildcardi
select Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@aaa.com', Email) > 0

--- kõik .com-d asendatakse .net-ga
select Email, REPLACE(Email, '.com', '.net') as ConvertedEmail
from Employees

--- soovin asendada peale esimest m'rki kolm t'hte viie t'rniga
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees

--rida 800

create table DateTime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTime

--konkreetse masina kellaaeg
select getdate(), 'GETDATE()'

insert into DateTime
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())

update DateTime set c_datetimeoffset = '2024-04-02 09:33:39.0033333 +11:00'
where c_datetimeoffset = '2024-04-02 09:33:39.0033333 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' --aja p'ring
select SYSDATETIME(), 'SYSDATETIME' --veel täpsem aja päring
select SYSDATETIMEOFFSET() 'SYSDATETIMEOFFSET' --täpne aeg koos ajalise nihkega UTC suhtes
select GETUTCDATE(), 'GETUTCDATE' --UTC aeg 

select ISDATE('asd') --tagastab 0 kuna string ei ole date
select ISDATE(getdate()) --TAGASTAB 1 KUNA ON kp
select ISDATE('2024-04-02 09:33:39.0033333') --- tagastab 0 kuna max kolm komakohta v]ib olla
select ISDATE('2024-04-02 09:33:39.003') --tagastab 1
select DAY(GETDATE()) -- annab t'nase p'eva nr
select DAY('04/15/2024') -- annab stringis oleva kp ja j'rjestus peab olema ]ige
select Month(GETDATE()) --annab jooksva kuu nr
select Month('04/15/2024') --annab stringis oleva kuu nr
select Year(GETDATE()) --annab jooksva aasta nr
select Year('04/15/2024') --annab stringis oleva aasta nr

select DATENAME(day, '2024-04-03 09:33:39.003') --annab stringis oleva p'eva nr
select DATENAME(weekday, '2024-04-02 09:33:39.003') --annab stringis oleva p'eva sõnana
select DATENAME(MONTH, '2024-04-03 09:33:39.003') --annab stringis oleva kuu sõnana

create table EmployeesWithDates
(
Id nvarchar(2),
Name nvarchar(20),
DateOfBirth datetime
)

INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (1, 'Sam', '1980-12-30 00:00:00.000');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (2, 'Pam', '1982-09-01 12:02:36.260');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (3, 'John', '1985-08-22 12:03:30.370');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (4, 'Sara', '1979-11-29 12:59:30.670');

select * from EmployeesWithDates

--- kuidas võtta ühest veerust andmeid ja selle abil luua uued andmed
select Name, DateOfBirth, DATENAME(WEEKDAY, DateOfBirth) as [Day], --vt DoB veerust p'eva ja kuvab p'eva nimetuse s]nana
	   Month(DateOfBirth) as MonthNumber, --vt DoB veerust kp-d ja kuvab kuu nr
	   DateName(MONTH, DateOfBirth) as [MonthName], -- vt DoB veerust kuus ja kuvab s]nana
	   YEAR(DateOfBirth) as [Year] --v]tab DoB veerust aasta
from EmployeesWithDates

select DATEPART(WEEKDAY, '2024-04-02 09:33:39.003') ---kuvab 3 kuna USA n'dal algab pühapäevaga
select DATEPART(month, '2024-04-02 09:33:39.003') -- kuvab kuu nr
select DATEADD(DAY, 20, '2024-04-02 09:33:39.003') --liidab stringis olevale kp 20 päeva juurde
select DATEADD(DAY, -20, '2024-04-02 09:33:39.003') --lahutab stringis olevale kp 20 päeva juurde
select DATEDIFF(MONTH, '10/29/2023', '04/30/2024') --kuvab kahe stringi kuudevahelist aega nr-na
select DATEDIFF(YEAR, '10/29/2023', '04/30/2024') --kuvab kahe stringi aastavahelist aega nr-na

---
create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
		select @tempdate = @DOB

		select @years = datediff(year, @tempdate, GETDATE()) - case when (month(@DOB) > MoNtH(getdate())) or (month(@DOB)
		= month (GETDATE()) and day(@DOB) > day(getdate())) then 1 else 0 end
		select @tempdate = dateadd(year, @years, @tempdate)

		select @months = datediff(MONTH, @tempdate, getdate()) - case when day(@DOB) > day(getdate()) then 1 else 0 end
		select @tempdate =  DATEADD(MONTH, @months, @tempdate)

		select @days = datediff(day, @tempdate, getdate())

	declare @Age nvarchar(50)
		set @Age = cast(@years as nvarchar(4)) + ' Years ' +cast(@months as nvarchar(2)) + ' Months ' + cast(@days as nvarchar(2)) +
		' Days old'
	return @Age
end

-- saame vaadata kasutajate vanust
select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) as Age from EmployeesWithDates

-- kui kasutame seda funktsiooni, siis saame teada t'nase p'eva vahet stringis v'lja 
-- tooduga
select dbo.fnComputeAge('11/30/2011')

-- nr peale DOB muutujat n'itab, et mismoodi kuvada DOB-d
select Id, Name, DateOfBirth,
convert(nvarchar, DateOfBirth, 126) as ConvertedDOB
from EmployeesWithDates

select Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id] from EmployeesWithDates

select cast(GETDATE() as date) --t'nane kp
select convert(date, getdate()) --tänane kp

-- matemaatilised funktsioonid

select ABS(-101.5) --abs on absoluutne nr ja tulemuseks saame ilma miinus märgita tulemuse
select CEILING(15.2) --ümardab ülesse täisarvu suunas
select CEILING(-15.2) --tagastab -15 ja suurendab suurema positiivse täisarvu suunas
select FLOOR(15.2) --ümardab negatiivsema nr poole
select FLOOR(-15.2) --ümardab negatiivsema nr poole
select power(2, 4) --hakkab korrutama 2x2x2x2, esimene nr on korrutatav
select SQUARE(9) -- antud juhul 9 ruudus
select SQRT(81) --annab vastuse 9, ruutjuur

select rand() --annab suvalise nr
select floor(rand() * 100)

--iga kord näitab 10 suvalist nr-t
declare @counter int
set @counter = 1
while (@counter <= 10)
begin
	print floor(rand() * 1000)
	set @counter = @counter + 1
end

select ROUND(850.556, 2) --[mardab kaks kohta peale komat, tulemus on 850.560
select ROUND(850.556, 2, 1) --[mardab allapoole, tulemus 850.550
select ROUND(850.556, 1) --[mardab [lespoole ja v]tab ainult esimest nr peale koma arvesse 850.600
select round(850.556, 1, 1) --[mardab allpoole
select round(850.556, -2) --[mardab t'isnr [lesse
select round(850.556, -1) --[mardab t'isnr allapoole

create function dbo.CalculateAge(@DOB date)
returns int
as begin
declare @Age int

set @Age = datediff(year, @DOB, GETDATE()) -
	case 
		when (month(@DOB) > MONTH(getdate())) or
			 (month(@DOB) > MONTH(getdate()) and day(@DOB) > day(getdate()))
		then 1 
		else 0
		end
	return @Age
end

exec CalculateAge '10/08/2022'

-- arvutab v'lja, kui vana on isik ja v]tab arvesse kuud ja p'evad
-- antud juhul n'itab k]ike, kes on [le 36 a vanad
select Id, Name, dbo.CalculateAge(DateOfBirth) as Age from EmployeesWithDates
where dbo.CalculateAge(DateOfBirth) > 42

alter table EmployeesWithDates
add DepartmentId int
alter table EmployeesWithDates
add Gender nvarchar(10)

update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 1
update EmployeesWithDates set Gender = 'Female', DepartmentId = 2
where Id = 2
update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 3
update EmployeesWithDates set Gender = 'Female', DepartmentId = 3
where Id = 4
insert into EmployeesWithDates (Id, Name, DateOfBirth, DepartmentId, Gender)
values (5, 'Todd', '1978-11-29 12:59:30.670', 1, 'Male')

--scalare function annab mingis vahemikus olevaid andmeid, aga
--inline table values ei kasuta begin ja end funktsioone
--scalar annab v''rtused ja inline annab tabeli
create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table
as
return (select Id, Name, DateOfBirth, DepartmentId, Gender
		from EmployeesWithDates
		where Gender = @Gender)

-- k]ik female t;;tajad
select * from fn_EmployeesByGender('female')

--kuidas saaks samat p'ringut t'psustada
select * from fn_EmployeesByGender('female')
where Name = 'Pam'

select * from Department

--kahest erinevast tabelist andmete v]tmine ja koos kuvamine
-- esimene on funktsioon ja teine tabel
select Name, Gender, DepartmentName
from fn_EmployeesByGender('Male') E
join Department D on D.Id = E.DepartmentId

--multi-table statment

-- inline funktsioon
create function fn_GetEmployees()
returns table as
return (select Id, Name, cast(DateOfBirth as date)
		as DOB
		from EmployeesWithDates)

--kutsume v'lja funktsiooni
select * from fn_GetEmployees()

-- multi-state puhul peab defineerima uue tabeli veerud koos muutujatega
create function fn_MS_GetEmployees()
returns @Table Table (Id int, Name nvarchar(20), DOB date)
as begin
	insert into @Table
	select Id, Name, cast(DateOfBirth as date) from EmployeesWithDates
	return
end

select * from fn_MS_GetEmployees()

--- inline tabeli funktsioonid on paremini töötamas kuna käsitletakse vaatena e view-na
--- multi puhul on pm tegemist stored proceduriga ja kulutab ressurssi rohkem

update fn_GetEmployees() set Name = 'Sam1' where Id = 1 --saab muuta andmeid
select * from fn_MS_GetEmployees()
update fn_MS_GetEmployees() set Name = 'Sam2' where Id = 1 --ei saa muuta andmeid multistate puhul

-- deterministic ja non-deterministic
select count(*) from EmployeesWithDates
select SQUARE(3) --k]ik tehtem'rgid on deterministlikud funktsioonid, sinna kuuluvad veel sum, avg j square

-- non-deterministic
select GETDATE()
select CURRENT_TIMESTAMP
select RAND() --see funktsioon saab olla m]lemas kategoorias, k]ik oleneb sellest, kas sulgudes on 1 v]i ei ole

create function fn_GetNameById(@id int)
returns nvarchar(30)
as begin
	return (select Name from EmployeesWithDates where Id = @id)
end

select dbo.fn_GetNameById(4)

drop table EmployeesWithDates


create table EmployeesWithDates
(
	Id int primary key,
	Name nvarchar(50) NULL,
	DateOfBirth datetime NULL,
	Gender nvarchar(10) NULL,
	DepartmentId int NULL
)

insert into EmployeesWithDates values(1, 'Sam', '1980-12-30 00:00:00.000', 'Male', 1)
insert into EmployeesWithDates values(2, 'Pam', '1982-09-01 12:02:36.260', 'Female', 2)
insert into EmployeesWithDates values(3, 'John', '1985-08-22 12:03:30.370', 'Male', 1)
insert into EmployeesWithDates values(4, 'Sara', '1979-11-29 12:59:30.670', 'Female', 3)
insert into EmployeesWithDates values(5, 'Todd', '1978-11-29 12:59:30.670', 'Male', 1)

create function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

sp_helptext fn_GetEmployeeNameById

-- peale seda ei n'e funktsiooni sisu
alter function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
with encryption
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end 

-- muudame [levalpool olevat funktsiooni, kindlasti tabeli ette panna dbo.TabeliNimi
alter function dbo.fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
with schemabinding
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

drop table dbo.EmployeesWithDates

--- temporary tables
--- #-m'rgi ette panemisel saame aru, et tegemist on temp tabeliga
--- seda tabelit saab ainult selles p'ringus avada
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails

select  Name from sysobjects
where Name like '#PersonDetails%'

--kustutame temp tabeli
drop table #PersonDetails

create proc spCreateLocalTempTable
as begin
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails
end

exec spCreateLocalTempTable

-- globaalse temp tabeli tegemine
create table ##PersonDetails(Id int, Name nvarchar(20))

--Erinevused lokaalse ja globaalse ajutise tabeli osas:
-- 1. Lokaalsed ajutised tabelid on ühe # märgiga, aga globaalsel on kaks tükki.
-- 2. SQL server lisab suvalisi numbreid lokaalse ajutise tabeli nimesse, 
-- aga globaalse puhul seda ei ole.
-- 3. Lokaalsed on nähtavad ainult selles sessioonis, mis on selle loonud,
-- aga globaalsed on nähtavad kõikides sessioonides.
-- 4. Lokaalsed ajutised tabelid on automaatselt kustutatud, kui selle 
-- loonud sessioon on kinni pandud, aga globaalsed ajutised tabelid 
-- lõpetatakse viimase viitava ühenduse kinni panemisel.

--- index
create table EmployeeWithSalary
(
Id int primary key,
Name nvarchar(25),
Salary int,
Gender nvarchar(10)
)

insert into EmployeeWithSalary values(1, 'Sam', 2500, 'Male')
insert into EmployeeWithSalary values(2, 'Pam', 6500, 'Female')
insert into EmployeeWithSalary values(3, 'John', 4500, 'Male')
insert into EmployeeWithSalary values(4, 'Sara', 5500, 'Female')
insert into EmployeeWithSalary values(5, 'Todd', 3100, 'Male')

select * from EmployeeWithSalary

select * from EmployeeWithSalary
where Salary > 5000 and Salary < 7000

-- loome indeksi, mis asetab palga kahanevasse j'rjestusse
create index IX_Employee_Salary
on EmployeeWithSalary(Salary asc)

-- tahan vaadata indexi tulemust
select * from EmployeeWithSalary with(Index(IX_Employee_Salary))

-- kustutab indexi tabelist
drop index dbo.EmployeeWithSalary.IX_Employee_Salary

---saame teada, et mis on selle tabeli primaarv]ti ja index
exec sys.sp_helpindex @objname = 'EmployeeWithSalary'

--- saame vaadata tabelit koos selle sisuga alates v'ga detailsest infost
select 
	TableName = t.name,
	IndexName = ind.name,
	IndexId = ind.index_id,
	ColumnId = ic.index_column_id,
	ColumnName = col.name,
	ind.*,
	ic.*,
	col.*
from
	sys.indexes ind
inner join
	sys.index_columns ic on ind.object_id = ic.object_id and ind.index_id = ic.index_id
inner join
	sys.columns col on ic.object_id = col.object_id and ic.column_id = col.column_id
inner join
	sys.tables t on ind.object_id = t.object_id
where
	ind.is_primary_key = 0
	and ind.is_unique = 0
	and ind.is_unique_constraint = 0
	and t.is_ms_shipped = 0
order by
	t.name, ind.name, ind.index_id, ic.is_included_column, ic.key_ordinal

---- indeksi tüübid:
--1. Klastrites olevad
--2. Mitte-klastris olevad
--3. Unikaalsed
--4. Filtreeritud
--5. XML
--6. Täistekst
--7. Ruumiline
--8. Veerusäilitav
--9. Veergude indeksid
--10. Välja arvatud veergudega indeksid

-- klastris olev indeks määrab ära tabelis oleva füüsilise järjestuse 
-- ja selle tulemusel saab tabelis olla ainult üks klastris olev indeks

drop table EmployeeWithSalary

create table EmployeeCity
(
Id int primary key,
Name nvarchar(25),
Salary int,
Gender nvarchar(10),
City nvarchar(50)
)

insert into EmployeeCity values(3, 'John', 4500, 'Male', 'New York')
insert into EmployeeCity values(1, 'Sam', 2500, 'Female', 'London')
insert into EmployeeCity values(4, 'Sara', 5500, 'Female', 'Tokyo')
insert into EmployeeCity values(5, 'Todd', 3100, 'Male', 'Toronto')
insert into EmployeeCity values(2, 'Pam', 6000, 'Female', 'Sydney')

select * from EmployeeCity

--klastris olevad indeksid dikteerivad s'ilitatud andmete j'rjestuse tabelis
-- ja seda saab klastrite puhul olla ainult [ks

create clustered index IX_EmployeeCity_Name
on EmployeeCity(Name)

-- annab veateate, et tabelis saab olla ainult [ks klastris olev indeks
-- kui soovid, uut indeksit luua, siis kustuta olemasolev

--- saame luua ainult ühe klastris oleva indeksi tabeli peale
--- klastris olev indeks on analoogne telefoni suunakoodile
select * from EmployeeCity
go
create clustered index IX_Employee_Gender_Salary
on EmployeeCity(Gender desc, Salary asc)
go
select * from EmployeeCity
-- kui teed select päringu sellele tabelile, siis peaksid nägema andmeid, mis on järjestatud selliselt:
-- Esimeseks võetakse aluseks Gender veerg kahanevas järjestuses ja siis Salary veerg tõusvas järjestuses

--- erinevused kahe indeksi vahel
--- 1. ainult üks klastris olev indeks saab olla tabeli peale, 
--- mitte-klastris olevaid indekseid saab olla mitu
--- 2. klastris olevad indeksid on kiiremad kuna indeks peab tagasi viitama tabelile
--- Juhul, kui selekteeritud veerg ei ole olemas indeksis
--- 3. Klastris olev indeks määratleb ära tabeli ridade slavestusjärjestuse
--- ja ei nõua kettal lisa ruumi. Samas mitte klastris olevad indeksid on 
--- salvestatud tabelist eraldi ja nõuab lisa ruumi

create table EmployeeFirstName
(
	Id int primary key,
	FirstName nvarchar(50),
	LastName nvarchar(50),
	Salary int,
	Gender nvarchar(10),
	City nvarchar(50)
)

exec sp_helpindex EmployeeFirstName

insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')

drop index EmployeeFirstName.PK__Employee__3214EC07F7C3D549
--kui k'ivitad [levalpool oleva koodi, siis tuleb veateade
--- et SQL server kasutab UNIQUE indeksit jõustamaks väärtuste unikaalsust ja primaarvõtit
--- koodiga Unikaalseid Indekseid ei saa kustutada, aga käsitsi saab

insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')

--- unikaalset indeksid kasutatakse kindlustamaks väärtuste unikaalsust (sh primaarvõtme oma)

create unique nonclustered index UIX_Employee_Firstname_Lastname
on EmployeeFirstName(FirstName, LastName)
--alguses annab veateate, et Mike Sandoz on kaks korda
-- ei saa lisada mitte-klastris olevat indeksit, kui ei ole unikaalseid andmeid
-- kustutame tabeli sisu ja sisestame andmed uuesti
truncate table EmployeeFirstName

insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(2, 'John', 'Menco', 2500, 'Male', 'London')

--lisame uue unikaalse piirangu
alter table EmployeeFirstName
add constraint UQ_EmployeeFirstName_City
unique nonclustered(City)

--ei luba tabelisse v''rtusega uut Londonit
insert into EmployeeFirstName values(3, 'John', 'Menco', 2500, 'Male', 'London')

--saab vaadata indeksite nimekirja
exec sp_helpconstraint EmployeeFirstName

---
-- 1.Vaikimisi primaarvõti loob unikaalse klastris oleva indeksi, samas unikaalne piirang
-- loob unikaalse mitte-klastris oleva indeksi
-- 2. Unikaalset indeksit või piirangut ei saa luua olemasolevasse tabelisse, kui tabel 
-- juba sisaldab väärtusi võtmeveerus
-- 3. Vaikimisi korduvaid väärtusied ei ole veerus lubatud,
-- kui peaks olema unikaalne indeks või piirang. Nt, kui tahad sisestada 10 rida andmeid,
-- millest 5 sisaldavad korduviad andmeid, siis kõik 10 lükatakse tagasi. Kui soovin ainult 5
-- rea tagasi lükkamist ja ülejäänud 5 rea sisestamist, siis selleks kasutatakse IGNORE_DUP_KEY

--koodin'ide:
create unique index IX_EmployeeFirstName
on EmployeeFirstName(City)
with ignore_dup_key

insert into EmployeeFirstName values(3, 'John', 'Menco', 5500, 'Male', 'London')
insert into EmployeeFirstName values(4, 'John', 'Menco', 6500, 'Male', 'London1')
insert into EmployeeFirstName values(4, 'John', 'Menco', 7500, 'Male', 'London1')
--enne ignore k'sku oleks k]ik kolm rida tagasi l[katud, aga
--n[[d l'ks keskmine rida l'bi kuna linna nimi oli unikaalne

select * from EmployeeFirstName

---view

-- view i=on salvestatud SQL-i p'ring. Saab k'sitleda ka virtuaalse tabelina
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

--teeme view
create view vEmployeesByDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

-- view p'ringu esile kutsumine
select * from vEmployeesByDepartment

-- view ei salvesta andmeid vaikimisi
-- seda tasub võtta, kui salvestatud virtuaalse tabelina

-- milleks vaja:
-- saab kasutada andmebaasi skeemi keerukuse lihtsutamiseks,
-- mitte IT-inimesele
-- piiratud ligipääs andmetele, ei näe kõiki veerge

-- teeme view, kus n'eb ainult IT-t;;tajaid
--kasutada tabelit Employees ja Department
create view vITEmployeesInDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id
where Department.DepartmentName = 'IT'
-- [levalpool olevat p'ringut saab liigitada reataseme turvalisuse alla
-- tahan ainult n'idata IT osakonna t;;tajaid

select * from vITEmployeesInDepartment

--veeru taseme turvalisus
--peale selecti m''ratled veergude n'itamise 'ra
create view vEmployeesInDepartmentSalaryNoShow
as
select FirstName, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

select * from vEmployeesInDepartmentSalaryNoShow

--saab kasutada esitlemaks koonsandmeid ja [ksikasjalike andmeid
--view, mis tagastab summeeritud andmeid
create view vEmployeesCountByDepartment
as
select DepartmentName, count(Employees.Id) as TotalEmployees
from Employees
join Department
on Employees.DepartmentId = Department.Id
group by DepartmentName

select * from vEmployeesCountByDepartment

--kui soovid vaadata view sisu
sp_helptext vEmployeesCountByDepartment
--mutmine
alter view vEmployeesCountByDepartment
-- kustutamine
drop view vEmployeesCountByDepartment

-- view uuendused
--kas l'bi view saab uuendada andmeid

--- teeme andmete uuenduse, aga enne teeme view
create view vEmployeesDataExceptSalary
as
select Id, FirstName, Gender, DepartmentId
from Employees

update vEmployeesDataExceptSalary
set [FirstName] = 'Tom123' where Id = 2

--kustutame ja sisestame andmeid
delete from vEmployeesDataExceptSalary where Id = 2
insert into vEmployeesDataExceptSalary (Id, Gender, DepartmentId, FirstName)
values(2, 'Female', 2, 'Pam')

--- indekseeritud view
-- MS SQL-s on indekseeritud view nime all ja
-- Oracles-s materjaliseeritud view

create table Product
(
Id int primary key,
Name nvarchar(20),
UnitPrice int
)

insert into Product values
(1, 'Books', 20),
(2, 'Pens', 14),
(3, 'Pencils', 11),
(4, 'Clips', 10)

create table ProductSales
(
Id int,
QuantitySold int
)


insert into ProductSales values
(1, 10),
(3, 23),
(4, 21),
(2, 12),
(1, 13),
(3, 12),
(4, 13),
(1, 11),
(2, 12),
(1, 14)

---loome view, mis annab meile veerud TotalSales ja TotalTransaction
create view vTotalSalesByProduct
with schemabinding
as
select Name,
sum(isnull((QuantitySold * UnitPrice), 0)) as TotalSales,
COUNT_BIG(*) as TotalTransactions
from dbo.ProductSales
join dbo.Product
on dbo.Product.Id = dbo.ProductSales.Id
group by Name

--- kui soovid luua indeksi view sisse, siis peab järgima teatud reegleid
-- 1. view tuleb luua koos schemabinding-ga
-- 2. kui lisafunktsioon select list viitab väljendile ja selle tulemuseks
-- võib olla NULL, siis asendusväärtus peaks olema täpsustatud. 
-- Antud juhul kasutasime ISNULL funktsiooni asendamaks NULL väärtust
-- 3. kui GroupBy on täpsustatud, siis view select list peab
-- sisaldama COUNT_BIG(*) väljendit
-- 4. Baastabelis peaksid view-d olema viidatud kahesosalie nimega
-- e antud juhul dbo.Product ja dbo.ProductSales.

select * from vTotalSalesByProduct

-- view piirangud
create view vEmployeeDetails
@Gender nvarchar(20)
as
select Id, FirstName, Gender, DepartmentId
from Employees
where Gender = @Gender
--viewsse ei saa kaasa panna parameetreid e antud juhul Gender

create function fnEmployeeDetails(@Gender nvarchar(20))
returns table
as return
(select Id, FirstName, Gender, DepartmentId
from Employees where Gender = @Gender)

--funktsiooni esile kutsumine koos parameetritega
select * from fnEmployeeDetails('male')

--order by kasutamine view-s
create view vEmployeeDetailsSorted
as
select Id, FirstName, Gender, DepartmentId
from Employees
order by Id

--order by-d ei saa kasutada

-- temp tabeli kasutamine
create table ##TestTempTable(Id int, FirstName nvarchar(20), Gender nvarchar(10))

insert into ##TestTempTable values
(101, 'Martin', 'Male'),
(102, 'Joe', 'Male'),
(103, 'Pam', 'Female'),
(104, 'James', 'Male')

create view vOntTempTable
as
select Id, FirstName, Gender
from ##TestTempTable

-- temp tabelit ei saa kasutada view-s

--- Triggerid

-- DML trigger
--- kokku on kolme tüüpi: DML, DDL ja LOGON

--- trigger on stored procedure eriliik, mis automaatselt käivitub, kui mingi tegevus 
--- peaks andmebaasis aset leidma

--- DML - data manipulation language
--- DML-i põhilised käsklused: insert, update ja delete

-- DML triggereid saab klasifitseerida  kahte tüüpi:
-- 1. After trigger (kutsutakse ka FOR triggeriks)
-- 2. Instead of trigger (selmet trigger e selle asemel trigger)

--- after trigger käivitub peale sündmust, kui kuskil on tehtud insert, update ja delete

--loome uue tabeli
create table EmployeeAudit
(
Id int identity(1, 1) primary key,
AuditData nvarchar(1000)
)

--peale iga t;;taja sisestamist tahame teada saada t;;taja Id-d, p'eva ning aega
--(millal sisestati). K]ik andmed l'hevad EmployeeAudit tabelisse.

create trigger trEmployeeForInsert
on Employees
for insert
as begin
declare @Id int
select @Id = Id from inserted
insert into EmployeeAudit
values ('New employee with id = ' + cast(@Id as nvarchar(5)) + ' is added at '
+ cast(getdate() as nvarchar(20)))
end

insert into Employees values 
(11, 'Bob', 'Blob', 'Bomb', 'Male', 3000, 1, 3, 'bob@bob.com')

select * from EmployeeAudit

---delete trigger
create trigger trEmployeeForDelete
on Employees
for delete
as begin
	declare @Id int
	select @Id = Id from deleted

	insert into EmployeeAudit
	values('An existing  employee with Id = ' + cast(@Id as nvarchar(5)) + 
	' is deleted at ' + cast(getdate() as nvarchar(20)))
end

delete from Employees where Id = 11

select * from EmployeeAudit

--- update trigger

create trigger trEmployeeForUpdate
on Employees
for update
as begin
	--- muutujate deklareerimine
	declare @Id int
	declare @OldGender nvarchar(20), @NewGender nvarchar(20)
	declare @OldSalary int, @NewSalary int
	declare @OldDepartmentId int, @NewDepartmentId int
	declare @OldManagerId int, @NewManagerId int
	declare @OldFirstName nvarchar(20), @NewFirstName nvarchar(20)
	declare @OldMiddleName nvarchar(20), @NewMiddleName nvarchar(20)
	declare @OldLastName nvarchar(20), @NewLastName nvarchar(20)
	declare @OldEmail nvarchar(50), @NewEmail nvarchar(50)

	--muutuja, kuhu l'heb l]pptekst
	declare @AuditString nvarchar(1000)

	--laeb l]ik uuendatud andmed temp tabeli alla
	select * into #TempTable
	from inserted

	--k'ib l'bi k]ik andmed temp tabelis
	while(exists(select Id from #TempTable))
	begin
		set @AuditString = ''
		---selekteerib esimese rea andmed temp tabelist
		select top 1 @Id = Id, @NewGender = Gender,
		@NewSalary = Salary, @NewDepartmentId = DepartmentId,
		@NewManagerId = ManagerId, @NewFirstName = FirstName,
		@NewMiddleName = MiddleName, @NewLastName = LastName,
		@NewEmail = Email
		from #TempTable
		---võtab vanad andmed kustutatud tabelist
		select @OldGender = Gender,
		@OldSalary = Salary, @OldDepartmentId = DepartmentId,
		@OldManagerId = ManagerId, @OldFirstName = FirstName,
		@OldMiddleName = MiddleName, @OldLastName = LastName,
		@OldEmail = Email
		from deleted where Id = @Id

		--loob auditi stringi dünaamiliselt
		set @AuditString = 'Employee with Id = ' + cast(@Id as nvarchar(4)) + ' changed '
		if(@OldGender <> @NewGender)
			set @AuditString = @AuditString + ' Gender from ' + @OldGender + ' to ' +
			@NewGender

		if(@OldSalary <> @NewSalary)
			set @AuditString = @AuditString + ' Salary from ' + cast(@OldSalary as nvarchar(20)) + ' to ' +
			cast(@NewSalary as nvarchar(20))

		if(@OldDepartmentId <> @NewDepartmentId)
			set @AuditString = @AuditString + ' DepartmentId from ' + cast(@OldDepartmentId as nvarchar(20)) + ' to ' +
			cast(@NewDepartmentId as nvarchar(20))

		if(@OldManagerId <> @NewManagerId)
			set @AuditString = @AuditString + ' ManagerId from ' + cast(@OldManagerId as nvarchar(20)) + ' to ' +
			cast(@NewManagerId as nvarchar(20))

		if(@OldFirstName <> @NewFirstName)
			set @AuditString = @AuditString + ' Firstname from ' + @OldFirstName + ' to ' +
			@NewFirstName

		if(@OldMiddleName <> @NewMiddleName)
			set @AuditString = @AuditString + ' Middlename from ' + @OldMiddleName + ' to ' +
			@NewMiddleName

		if(@OldLastName <> @NewLastName)
			set @AuditString = @AuditString + ' Lastname from ' + @OldLastName + ' to ' +
			@NewLastName

		if(@OldEmail <> @NewEmail)
			set @AuditString = @AuditString + ' Email from ' + @OldEmail + ' to ' +
			@NewEmail

		insert into dbo.EmployeeAudit values (@AuditString)
		--kustutab temp tabel-st rea, et saaksime liikuda uue rea juurde
		delete from #TempTable where Id = @Id 
	end
end

update Employees set 
FirstName = 'test12309', 
Salary = 4004, 
MiddleName = 'test456756',
Email = 'test12@test12.com'
where Id = 10

select * from Employees
select * from EmployeeAudit

---instead of trigger

create table Employee
(
Id int primary key,
Name nvarchar(30),
Gender nvarchar(10),
DepartmentId int 
)

create table Departments
(
Id int primary key,
DepartmentName nvarchar(20)
)

insert into Employee values(1, 'John', 'Male', 3)
insert into Employee values(2, 'Mike', 'Male', 2)
insert into Employee values(3, 'Pam', 'Female', 1)
insert into Employee values(4, 'Todd', 'Male', 4)
insert into Employee values(5, 'Sara', 'Female', 1)
insert into Employee values(6, 'Ben', 'Male', 3)

insert into Departments values
(1, 'IT'),
(2, 'Payroll'),
(3, 'HR'),
(4, 'Other Department')

---
create view vEmployeeDetails
as
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Departments
on Employee.DepartmentId = Departments.Id

insert into vEmployeeDetails values(7, 'Valarie', 'Female', 'IT')
--tuleb veateade
-- n[[d vaatame, et kuidas saab instead of triggeriga seda probleemi lahendada

create trigger tr_vEmployeeDetails_InsteadOfInsert
on vEmployeeDetails
instead of insert
as begin
	declare @DeptId int

	select @DeptId = dbo.Departments.Id
	from Departments
	join inserted
	on inserted.DepartmentName = Departments.DepartmentName

	if(@DeptId is null)
		begin
		raiserror('Invalid department name. Statement terminated', 16, 1)
		return
	end

	insert into dbo.Employee(Id, Name, Gender, DepartmentId)
	select Id, Name, Gender, @DeptId
	from inserted
end

--- raiserror funktsioon
-- selle eesmärk on tuua välja veateade, kui DepartmentName veerus ei ole väärtust
-- ja ei klapi uue sisestatud väärtusega
-- Esimene on parameeter veateate sisust. Teine on veataseme nr (nr 16 tähendab üldiseid vigu),
-- kolmas on olek

update vEmployeeDetails
set Name = 'Johny', DepartmentName = 'IT'
where Id = 1
--ei saa uuendada andmeid kuna mitu tabelit on sellest mõjutatud

update vEmployeeDetails
set DepartmentName = 'HR'
where Id = 3

select * from vEmployeeDetails


create trigger tr_vEmployeeDetails_InsteadOfUpdate
on vEmployeeDetails
instead of update
as begin

	if(update(Id))
	begin
		raiserror('Id cannot be changed', 16, 1)
		return
	end

	if(update(DepartmentName))
	begin
		declare  @DeptId int
		select @DeptId = Departments.Id
		from Departments
		join inserted
		on inserted.DepartmentName = Departments.DepartmentName

		if(@DeptId is null)
		begin
			raiserror('Id cannot be changed', 16, 1)
			return
		end

		update Employee set DepartmentId = @DeptId
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end

	if(update(Gender))
	begin
		update Employee set Gender = inserted.Gender
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end

	if(update(Name))
	begin
		update Employee set Name = inserted.Name
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end
end

update Employee set Name = 'John123567', Gender = 'Male', DepartmentId = 3
where Id = 1

select * from vEmployeeDetails
--nüüd muudab ainult Employees tabelis olevaid andmeid.

---delete trigger
create view vEmployeeCount
as
select DepartmentId, DepartmentName, count(*) as TotalEmployees
from Employee
join Departments
on Employee.DepartmentId = Departments.Id
group by DepartmentName, DepartmentId

select * from vEmployeeCount
--n'itab ära osakonnad, kus on töötajaid 2 tk või rohkem
select DepartmentName, TotalEmployees from vEmployeeCount
where TotalEmployees >= 2

select DepartmentName, DepartmentId, Count(*) as TotalEmployees
into #TempEmployeeCount
from Employee
join Departments
on Employee.DepartmentId = Departments.Id
group by DepartmentName, DepartmentId

select * from #TempEmployeeCount

alter view vEmployeeDetails
as
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Departments
on Employee.DepartmentId = Departments.Id


delete from vEmployeeDetails where Id = 2


create trigger tr_EmployeeDetails_InsteadOfDelete
on vEmployeeDetails
instead of delete
as begin
delete Employee
from Employee
join deleted
on Employee.Id = deleted.Id
end

--nüüd käivitate selle koodi uuesti
delete from vEmployeeDetails where Id = 2

--Päritud tabelid ja CTE
--CTE tähendab common table expression

select * from Employee

truncate table Employee

insert into Employee values
(1, 'John', 'Male', 3),
(2, 'Mike', 'Male', 2)

-- CTE
with EmployeeCount(DepartmentName, DepartmentId, TotalEmployees)
as
	(
	select DepartmentName, DepartmentId, count(*) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	group by DepartmentName, DepartmentId
	)
select DepartmentName, TotalEmployees
from EmployeeCount
where TotalEmployees >= 1
-- CTE-d võivad sarnaneda temp tabeliga
-- sarnane päritud tabelile ja ei ole salvestatud objektina
-- ning kestab päringu ulatuses

--päritud tabel
select DepartmentName, TotalEmployees
from 
(
select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
from Employee
join Department
on Employee.DepartmentId = Department.Id
group by DepartmentName, DepartmentId
)
as EmployeeCount
where TotalEmployees >= 1

---mitu CTE-d järjest
with EmployeeCountBy_Payroll_IT_Dept(DepartmentName, Total)
as
(
	select DepartmentName, COUNT(Employee.Id) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	where DepartmentName in('Payroll', 'IT')
	group by DepartmentName
),
-- peale koma panemist saad uue CTE juurde kirjutada
EmployeeCountBy_HR_Admin_Dept(DepartmentName, Total)
as
(
	select DepartmentName, COUNT(Employee.Id) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	group by DepartmentName
)
-- kui on kaks CTE-d, siis unioni abil [hendab p'ringu
select * from EmployeeCountBy_Payroll_IT_Dept
union
select * from EmployeeCountBy_HR_Admin_Dept

---
with EmployeeCount(DepartmentId, TotalEmployees)
as
	(
	select DepartmentId, count(*) as TotalEmployees
	from Employee
	group by DepartmentId
	)
--peale CTE-d peab kohe tulema käsklus SELECT, INSERT, UPDATE või DELETE
--kui proovid midagi muud, siis tuleb veateade

--uuendamine CTE-s

with Employees_Name_Gender
as
(
	select Id, Name, Gender from Employee
)
select * from Employees_Name_Gender


--uuendamine läbi CTE
with Employees_Name_Gender
as
(
	select Id, Name, Gender from Employee
)
update Employees_Name_Gender set Gender = 'Female' where Id = 1

select * from Employee

-- kasutame joini CTE tegemisel
with EmployeeByDepartment
as
(
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
select * from EmployeeByDepartment

-- kasutame joini ja muudme [hes tabelis andmeid
with EmployeeByDepartmentUpdate
as
(
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
update EmployeeByDepartmentUpdate set Gender = 'Male' where Id = 1

select * from Employee

--kasutame joini ja muudame mõlemas tabelis andmeid

with EmployeeByDepartmentUpdateBothTables
as
(
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
update EmployeeByDepartmentUpdateBothTables set 
Gender = 'Male123', DepartmentName = 'IT'
where Id = 1
--ei luba mitms tabelis andmeid korraga muuta

--- kokkuvõte CTE-st
-- 1. kui CTE baseerub ühel tabelil, siis uuendus töötab
-- 2. kui CTE baseerub mitmel tablil, siis tuleb veateade
-- 3. kui CTE baseerub mitmel tabelil ja tahame muuta ainult ühte tabelit, siis
-- uuendus saab tehtud

--- korduv CTE
-- CTE, mis iseendale viitab, kutsutakse korduvaks CTE-ks
-- kui tahad andmeid n'idata hierarhiliselt

truncate table Employee

insert into Employee values (1, 'Tom', 2)
insert into Employee values (2, 'Josh', null)
insert into Employee values (3, 'Mike', 2)
insert into Employee values (4, 'John', 3)
insert into Employee values (5, 'Pam', 1)
insert into Employee values (6, 'Mary', 3)
insert into Employee values (7, 'James', 1)
insert into Employee values (8, 'Sam', 5)
insert into Employee values (9, 'Simon', 1)

-- rida 2084