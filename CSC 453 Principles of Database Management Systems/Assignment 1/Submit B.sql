
Create Table Location (
latitude float, 

       longitude float,

       name varchar(50)
);

INSERT INTO LOCATION VALUES (41.881832, -87.623177, 'Chicago');

INSERT INTO LOCATION VALUES (42.881832, -87.623177,'Chicago');

INSERT INTO LOCATION VALUES (41.881832, -86.623177,'Chicago');

//1. Location has two primary keys here which are unique and they create query for both 
lalitude and longitude and this is the relation of the primary key.

//Create Table Location (
//latitude float,
//longitude float,
//name varchar(50),
//PRIMARY KEY (latitude, longitude)
//);


//2.To insert the given following values we specify them as follows :

//INSERT INTO LOCATION VALUES (41.881832, -87.623177, 'Chicago');

//INSERT INTO LOCATION VALUES (42.881832, -87.623177,'Chicago');

//INSERT INTO LOCATION VALUES (41.881832, -86.623177,'Chicago');


//3. No, they do not lead to any kind of violation as the primary key is been specified
and the insert values statements are been inserted into location so it dosent 
lead to any kind of violation.
Create Table Location (
latitude float,
longitude float,
name varchar(50),
PRIMARY KEY (latitude, longitude)
);

INSERT INTO LOCATION VALUES (41.881832, -87.623177, 'Chicago');

INSERT INTO LOCATION VALUES (42.881832, -87.623177,'Chicago');

INSERT INTO LOCATION VALUES (41.881832, -86.623177,'Chicago');

