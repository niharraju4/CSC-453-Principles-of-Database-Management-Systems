DROP TABLE managers_tblCASCADE CONSTRAINTS;
DROP TABLE emps CASCADE CONSTRAINTS;

CREATE TABLE managers_tbl
(
mgrID int NOT NULL PRIMARY KEY,
role varchar(255)
);
CREATE TABLE emps
(
empID  number(9),
ssNo number(9),
empName varchar(15),
mgrID number(1),
PRIMARY KEY (empID,ssNo),
FOREIGN KEY (mgrID) REFERENCES managers_tbl(mgrID)
);

