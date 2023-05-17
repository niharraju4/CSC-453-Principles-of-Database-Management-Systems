-- drop tables

DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENT CASCADE CONSTRAINTS;
DROP TABLE DEPT_LOCATIONS CASCADE CONSTRAINTS;
DROP TABLE PROJECT CASCADE CONSTRAINTS;
DROP TABLE WORKS_ON CASCADE CONSTRAINTS;
DROP TABLE DEPENDENT CASCADE CONSTRAINTS;

-- create and populate tables

CREATE TABLE EMPLOYEE
(
	Fname		VARCHAR(20),
	Minit		CHAR(1),
	Lname		VARCHAR(20),
	Ssn		CHAR(9),
	Bdate		DATE,
	Address		VARCHAR(30),
	Sex		CHAR(1),
	Salary		NUMBER(5),
	Super_Ssn	CHAR(9),
	Dno		NUMBER(1),

	PRIMARY KEY (Ssn),
		
	FOREIGN KEY (Super_ssn)
		REFERENCES EMPLOYEE (Ssn)
);

INSERT INTO EMPLOYEE VALUES ('James', 'E', 'Borg', '888665555', DATE '1937-11-10', '450 Stone, Houston, TX', 'M', 55000, NULL, 1);
INSERT INTO EMPLOYEE VALUES ('Jennifer', 'S', 'Wallace', '987654321', DATE '1941-06-20', '291 Berry, Bellaire, Tx', 'F', 37000, '888665555', 4);
INSERT INTO EMPLOYEE VALUES ('Franklin', 'T', 'Wong', '333445555', DATE '1955-12-08', '638 Voss, Houston, TX', 'M', 40000, '888665555', 5);
INSERT INTO EMPLOYEE VALUES ('John', 'B', 'Smith', '123456789', DATE '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, '333445555', 5);
INSERT INTO EMPLOYEE VALUES ('Alicia', 'J', 'Zelaya', '999887777', DATE '1968-01-19', '3321 castle, Spring, TX', 'F', 25000, '987654321', 4);
INSERT INTO EMPLOYEE VALUES ('Ramesh', 'K', 'Narayan', '666884444', DATE '1920-09-15', '975 Fire Oak, Humble, TX', 'M', 38000, '333445555', 5);
INSERT INTO EMPLOYEE VALUES ('Joyce', 'A', 'English', '453453453', DATE '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000, '333445555', 5);
INSERT INTO EMPLOYEE VALUES ('Ahmad', 'V', 'Jabbar', '987987987', DATE '1969-03-29', '980 Dallas, Houston, TX', 'M', 22000, '987654321', 4);
INSERT INTO EMPLOYEE VALUES ('Melissa', 'M', 'Jones', '808080808', DATE '1970-07-10', '1001 Western, Houston, TX', 'F', 27500, '333445555', 5);

CREATE TABLE DEPARTMENT
(
	Dname		VARCHAR(20),
	Dnumber		NUMBER(1),
	Mgr_ssn		CHAR(9),
	Mgr_start_date	DATE,
	
	PRIMARY KEY (Dnumber),

	FOREIGN KEY (Mgr_ssn)
		REFERENCES EMPLOYEE (Ssn)
);

INSERT INTO DEPARTMENT VALUES ('Research', 5, '333445555', DATE '1988-05-22');
INSERT INTO DEPARTMENT VALUES ('Administration', 4, '987654321', DATE '1995-01-01');
INSERT INTO DEPARTMENT VALUES ('Headquarters', 1, '888665555', DATE '1981-06-19');

-- this alter is needed to allow PROJECT and DEPARTMENT to reference each other

ALTER TABLE EMPLOYEE ADD FOREIGN KEY (Dno) REFERENCES DEPARTMENT (Dnumber);

CREATE TABLE DEPT_LOCATIONS
(
	Dnumber		NUMBER(1),
	Dlocation	VARCHAR(20),
	
	PRIMARY KEY (Dnumber, Dlocation),

	FOREIGN KEY (Dnumber)
		REFERENCES DEPARTMENT (Dnumber)
);

INSERT INTO DEPT_LOCATIONS VALUES (1, 'Houston');
INSERT INTO DEPT_LOCATIONS VALUES (4, 'Stafford');
INSERT INTO DEPT_LOCATIONS VALUES (5, 'Bellaire');
INSERT INTO DEPT_LOCATIONS VALUES (5, 'Sugarland');
INSERT INTO DEPT_LOCATIONS VALUES (5, 'Austin');

CREATE TABLE PROJECT
(
	Pname		VARCHAR(20),
	Pnumber		NUMBER(2),
	Plocation	VARCHAR(20),
	Dnum		NUMBER(1),

	PRIMARY KEY (Pnumber),
	
	FOREIGN KEY (Dnum)
		REFERENCES DEPARTMENT (Dnumber)
);

INSERT INTO PROJECT VALUES ('ProductX', 1, 'Bellaire', 5);
INSERT INTO PROJECT VALUES ('ProductY', 2, 'Sugarland', 5);
INSERT INTO PROJECT VALUES ('ProductZ', 3, 'Houston', 5);
INSERT INTO PROJECT VALUES ('Computerization', 10, 'Stafford', 4);
INSERT INTO PROJECT VALUES ('Reorganization', 20, 'Houston', 1);
INSERT INTO PROJECT VALUES ('Newbenefits', 30, 'Stafford', 4);

CREATE TABLE WORKS_ON
(
	Essn		CHAR(9),
	Pno		NUMBER(2),
	Hours		NUMBER(3,1),
	
	PRIMARY KEY (Essn, Pno),

	FOREIGN KEY (Essn)
		REFERENCES EMPLOYEE (Ssn),

	FOREIGN KEY (Pno)
		REFERENCES PROJECT(Pnumber)
);

INSERT INTO WORKS_ON VALUES ('123456789', 1, 32.0);
INSERT INTO WORKS_ON VALUES ('123456789', 2, 8.0);
INSERT INTO WORKS_ON VALUES ('453453453', 1, 20.0);
INSERT INTO WORKS_ON VALUES ('453453453', 2, 20.0);
INSERT INTO WORKS_ON VALUES ('333445555', 1, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 2, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 3, 5.0);
INSERT INTO WORKS_ON VALUES ('333445555', 10, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 20, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 30, 5.0);
INSERT INTO WORKS_ON VALUES ('999887777', 30, 30.0);
INSERT INTO WORKS_ON VALUES ('999887777', 10, 10.0);
INSERT INTO WORKS_ON VALUES ('987987987', 10, 35.0);
INSERT INTO WORKS_ON VALUES ('987987987', 30, 5.0);
INSERT INTO WORKS_ON VALUES ('987654321', 30, 20.0);
INSERT INTO WORKS_ON VALUES ('987654321', 20, 15.0);
INSERT INTO WORKS_ON VALUES ('888665555', 20, 10.0);

CREATE TABLE DEPENDENT
(
	Essn		CHAR(9),
	Dependent_name	VARCHAR(20),
	Sex		CHAR(1),
	Bdate		DATE,
	Relationship 	VARCHAR(10),

	PRIMARY KEY (Essn, Dependent_name),

	FOREIGN KEY (Essn)
		REFERENCES EMPLOYEE (Ssn)
);

INSERT INTO DEPENDENT VALUES ('333445555', 'Alice', 'F', DATE '1986-04-05', 'Daughter');
INSERT INTO DEPENDENT VALUES ('333445555', 'Theodore', 'M', DATE '1983-10-25', 'Son');
INSERT INTO DEPENDENT VALUES ('333445555', 'Joy', 'F', DATE '1958-05-03', 'Spouse');
INSERT INTO DEPENDENT VALUES ('987654321', 'Abner', 'M', DATE '1988-01-04', 'Son');
INSERT INTO DEPENDENT VALUES ('987654321', 'Jennifer', 'F', DATE '1988-01-04', 'Daughter');
INSERT INTO DEPENDENT VALUES ('123456789', 'John', 'M', DATE '1988-02-28', 'Son');
INSERT INTO DEPENDENT VALUES ('123456789', 'Alice', 'F', DATE '1988-12-30', 'Daughter');
INSERT INTO DEPENDENT VALUES ('123456789', 'Elizabeth', 'F', DATE '1967-05-05', 'Spouse');
INSERT INTO DEPENDENT VALUES ('453453453', 'Joyce', 'F', DATE '1990-04-05', 'Daughter');

-- display contents of tables

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM DEPT_LOCATIONS;
SELECT * FROM PROJECT;
SELECT * FROM WORKS_ON;
SELECT * FROM DEPENDENT;

-- 1. Retrieve the names of all employees who work on at least one of the projects. (In other words, look at the list of projects given in the PROJECT table, and retrieve the names of all employees who work on at least one of them.)

select Fname from EMPLOYEE
where ssn in(Select Essn from works_on);

-- 2.  For each department, retrieve the department number, department name, and the average salary of all employees working in that department.  Order the output by department number in ascending order.

select Department.Dnumber,avg(salary) as Sal_Avg from Employee,Department
where Employee.Dno=Department.Dnumber
group by(Department.Dnumber);

--3.  List the last names of all department managers who have no dependents.

select Lname from Employee
where ssn not in(select Essn from Dependent);

-- 4. Determine the department that has the employee with the lowest salary among all employees. For this department retrieve the names of all employees. Write one query for this question using subquery.


Select fname, minit, Lname

from EMPLOYEE

where Dno = (Select Dno

from EMPLOYEE

where salary = (Select min(Salary) from EMPLOYEE) );

-- 5. Find the total number of employees and the total number of dependents for every department (the number of dependents for a department is the sum of the number of dependents for each employee working for that department). Return the result as department name, total number of employees, and total number of dependents.

select dname, count (distinct fname) As EMPLOYEECount, count (Essn) As DependentCount
from (select *

from (EMPLOYEE E left outer join Dependent D on E.ssn = D.Essn)

inner join Department Dp on dp.dnumber = dno)

group by dname;

-- 6. Determine if, in the company, male employees earn more than female employees.

select (select sum(SALARY)  from EMPLOYEE where sex='M') "Total of Male Salaries",
(select sum(SALARY) from EMPLOYEE where sex='F') "Total of Female Salaries",
case 
when (select sum(SALARY)  from EMPLOYEE where sex='M')>(select sum(SALARY) from EMPLOYEE where sex='F')
    then 'Male Salary is greater than Female Salary'
    Else 'Female Salary is greater than Male Salary' 
end "salary Comparision"
from employee group by sex Fetch next 1 ROWS ONLY;

--7. Retrieve the names of employees whose salary is within $20,000 of the salary of the employee who is paid the most in the company (e.g., if the highest salary in the company is $80,000, retrieve the names of all employees that make at least $60,000).

SELECT Fname,Lname FROM EMPLOYEE WHERE Salary >=((Select max(Salary) from EMPLOYEE)-20000);

--8.  Find the names and addresses of all employees whose departments have no location in Houston (that is, whose departments do not have a Dlocation of Houston) but who work on at least one project that is located in Houston (that is, who work on at least one project that has a Plocation of Houston). Note that the first condition is not equivalent to the employee's department having some Dlocation that is not in Houston -- the department must not have any Dlocation that is in Houston in order to be included in the result.

select fname,minit,lname,address
from employee
where ssn in (select essn
              from works_on,project
              where pno = pnumber and
                    plocation = 'Houston') and
      dno not in (select dnumber
                  from   dept_locations
                  where  dlocation = 'Houston');