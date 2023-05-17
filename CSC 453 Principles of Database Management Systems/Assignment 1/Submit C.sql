DROP TABLE Models CASCADE CONSTRAINTS;
DROP TABLE Cars CASCADE CONSTRAINTS;

CREATE TABLE Models (

model_id number(5) primary key,

modelBrand varchar(15),

modelName varchar(15) );
 
 
CREATE TABLE Cars (

CarID number(5) primary key,

VIN number(10) UNIQUE,

Color char(15),

YearofMake number(4),

Model_id number(5),

foreign key (model_id) references Models(model_id)

);

ALTER TABLE Cars MODIFY VIN number(10);
INSERT INTO Cars VALUES (235, 3456783412, 'Silver', 2010, 1);
ALTER TABLE Cars DROP COLUMN Model_id;
ALTER TABLE Models DROP CONSTRAINT SYS_C00233775;
DELETE FROM Models; 

1. When a user trying to insert above into a cars table the unique constraint violated error message, because for VIN column of Cars table we have defined UNIQUE constraint (VIN number(10) UNIQUE), and we are trying to insert same VIN number into a cars table.

Foreign key is being used to relate two link two tables.
It will not allow the user to insert a row into a chaild or foreign key table if that value is not present in the column of primary key column of the parent table.
and also it would not allow the user to delete a row from parent table when it is referenced another relation.

2.When the user trying to delete from the model it will throws the integrity constraint violated error message, because it it will not allow to delete from parent table(Models).

3.if we drop the constraints on cars table then the user can execute the insert and delete statements without gettting any error.
ALTER TABLE Cars MODIFY VIN number(10);
INSERT INTO Cars VALUES (235, 3456783412, 'Silver', 2010, 1);
ALTER TABLE Cars DROP COLUMN Model_id;
ALTER TABLE Models DROP CONSTRAINT SYS_C00233588;
DELETE FROM Models; 