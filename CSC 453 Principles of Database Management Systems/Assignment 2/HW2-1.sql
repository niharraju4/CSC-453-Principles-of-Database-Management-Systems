DROP TABLE Customer CASCADE CONSTRAINTS;
DROP TABLE cusOrder CASCADE CONSTRAINTS;


create table Customer(

cID number primary key,

cName varchar(30),

cCreditPoint number

);

-- create table cusOrder with below attributes, respective data types, primary and foreign key

create table cusOrder(

oID number primary key,

c_ID number,

oTotal number(10,2),

foreign key(c_ID) references Customer(cID)

);

-- insert given values into Customer table

insert into Customer values (110, 'Phil', 10);

insert into Customer values (111, 'Louis', 21);

insert into Customer values (112, 'John', 90);

insert into Customer values (113, 'Tom', 6);

insert into Customer values (114, 'Yay', 80);

insert into Customer values (115, 'Maria', 110);

insert into Customer values (116, 'Ana', 30);

insert into Customer values (117, 'Antonio', 90);

insert into Customer values (118, 'Andrew', 15);

insert into Customer values (119, 'Shawn', 10);

--insert given values into cusOrder table

insert into cusOrder values (1000, 115, 126.55);

insert into cusOrder values (1001, 114, 26.50);

insert into cusOrder values (1002, 117, 106.45);

insert into cusOrder values (1003, 118, 90.74);

insert into cusOrder values (1004, 112, 6.35);

insert into cusOrder values (1005, 114, 305.92);

insert into cusOrder values (1006, 111, 3.15);

insert into cusOrder values (1007, 110, 80.60);

insert into cusOrder values (1008, 115, 66.29);

insert into cusOrder values (1009, 117, 226.45);       


--cCredit*2
select cID, cName, cCreditPoint*2

from Customer;


--select columns c_ID, sum of ototal for each c_ID value in cusOrder 

select *

from Customer

order by cCreditPoint asc, cID asc;

using group by to aggregate per c_ID

select c_ID, SUM(oTotal) as Total

from cusOrder

group by c_ID;


--Join Customer and cusOrder and compute the max value of oTotal for each cID

select c.cID, MAX(o.oTotal) as MaxTotal

from Customer c 

left join cusOrder o 

on c.cID = o.c_ID 

group by c.cID;


--Find tuples of Customer which match and unmatch with cusOrder

select * 

from Customer c 

left join cusOrder o 

on c.cID = o.c_ID;


--Find tuples of cusOrder which match and unmatch with Customer

select * 

from cusOrder o 

left join Customer c 

on o.c_ID = c.cID;


--Find tuples of customer which match and unmatch with cusOder in which cCreditpoint is larger than oTotal.

select *

from Customer c 

left join cusOrder o 

on c.cID = o.c_ID 

where c.cCreditpoint > o.oTotal;