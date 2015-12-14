CREATE DATABASE EmployeeDB;

USE EmployeeDB;

CREATE TABLE IF NOT EXISTS Employee (
emp_no INT AUTO_INCREMENT,
birth_date DATE DEFAULT '0000-00-00',
first_name TEXT NOT NULL,
last_name TEXT NOT NULL,
gender ENUM('M','F') NOT NULL,
hire_date DATE NOT NULL,
PRIMARY KEY(emp_no)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS Departments (
dept_no INT AUTO_INCREMENT,
dept_name TEXT NOT NULL,
PRIMARY KEY(dept_no)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS Dept_emp (
emp_no INT,
dept_no INT,
from_date DATE DEFAULT NULL,
to_date DATE DEFAULT NULL,
FOREIGN KEY(emp_no) REFERENCES Employee(emp_no) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(dept_no) REFERENCES Departments(dept_no) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS Dept_manager (
dept_no INT,
emp_no INT,
from_date DATE DEFAULT NULL,
to_date DATE DEFAULT NULL,
FOREIGN KEY(dept_no) REFERENCES Departments(dept_no) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(emp_no) REFERENCES Employee(emp_no) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS Titles (
emp_no INT,
title TEXT DEFAULT NULL,
from_date DATE DEFAULT NULL,
to_date DATE DEFAULT NULL,
FOREIGN KEY(emp_no) REFERENCES Employee(emp_no) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS Salaries (
emp_no INT,
Salary INT,
from_date DATE DEFAULT NULL,
to_date DATE DEFAULT NULL,
FOREIGN KEY(emp_no) REFERENCES Employee(emp_no) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = INNODB;


-- ----------------Triggers----------------------

DELIMITER //

/* A trigger in which it does the following things before inserting records on "Employee" table:
    1. Auto-capitalization of input in the "gender" field on "Employee" table
    2. Auto-trimming of white spaces of input in the "first_name" and "last_name" fields on "Employee" table
    3. Auto-capitalization of input in the "first_name" and "last_name fields on "Employee" table after auto-trimming.
    4. Auto-trimming of white spaces of input in the "first_name" and "last_name" fields on "Employee" table
    5. Auto-capitalization of input in the "first_name" and "last_name" field on "Employee" table after auto-trimming.
*/

CREATE DEFINER = `root`@`127.0.0.1`
TRIGGER Before_Insert_Employee BEFORE INSERT ON Employee
FOR EACH ROW
BEGIN
SET NEW.gender = UPPER(NEW.gender);

SET @temp := TRIM(NEW.first_name);
SET @FN := SUBSTRING(@temp, 1,1);
SET @FN := UPPER(@FN);
SET NEW.first_name = CONCAT(@FN, SUBSTRING(@temp,2));
SET @temp := TRIM(NEW.last_name);
SET @LN := SUBSTRING(@temp,1,1);
SET @LN := UPPER(@LN);
SET NEW.last_name = CONCAT(@LN, SUBSTRING(@temp,2));
END//

-- A trigger in which it inserts records into "Titles" and "Salaries" tables automatically after insert on "Employee" table

CREATE DEFINER = `root`@`127.0.0.1`
TRIGGER After_Insert_Employee AFTER INSERT ON Employee
FOR EACH ROW
BEGIN
INSERT INTO Titles(emp_no) VALUES (NEW.emp_no);
INSERT INTO Salaries(emp_no) VALUES (NEW.emp_no);
END //

--  A trigger in which it auto-capitalizes the input of "dept_name" field on "Departments" table before inserting the input.

CREATE DEFINER = `root`@`127.0.0.1`
TRIGGER Before_Insert_Departments BEFORE INSERT ON Departments
FOR EACH ROW
BEGIN

SET NEW.dept_name := UPPER(NEW.dept_name);

END //

/* A procedure to ensure and verify "to_date" field is after "from_date" field. 
If "to_date" field input is before "from_date", then set both fields to '0000-00-00'.
*/

CREATE PROCEDURE Date_Verification (INOUT from_date DATE, INOUT to_date DATE)
COMMENT 'This is a procedure for ensuring and verifying "to_date" field is after "from_date" field.'
BEGIN
IF (to_date > from_date) THEN
SET to_date = to_date;
SET from_date = from_date;
ELSE
SET to_date = '0000-00-00';
SET from_date = '0000-00-00';
END IF;
END//

/* This trigger will verify or insure the input for "to_date" field is after "from_date" by invoking the "Date_Verification" procedure before updating on "Titles" table.  Then enter the inputs into their corresponding fields according to the result of the procedure invocation. */

CREATE DEFINER = `root`@`127.0.0.1`
TRIGGER BEFORE_UPDATE_Titles BEFORE UPDATE ON Titles
FOR EACH ROW
BEGIN

SET @ft := NEW.from_date;
SET @tt := NEW.to_date;

CALL Date_Verification(@ft, @tt);

SET NEW.from_date := @ft;
SET NEW.to_date := @tt;

END //

/* This trigger will insert inputs into the "emp_no", "start date" and "end date" fields into either "Dept_emp" or "Dept_manager" tables based on the input of the "title" field after the update on "Titles" table. Then update the employee's start date and end date in the "Salaries" table. */

CREATE DEFINER = `root`@`127.0.0.1`
TRIGGER AFTER_UPDATE_Titles AFTER UPDATE ON Titles
FOR EACH ROW
BEGIN
IF (NEW.title LIKE '%Manager%') THEN
INSERT INTO Dept_manager(emp_no, from_date, to_date) VALUES(OLD.emp_no, @ft, @tt);
UPDATE Salaries SET from_date = NEW.from_date, to_date = NEW.to_date WHERE emp_no = OLD.emp_no;
ELSE
INSERT INTO Dept_emp(emp_no, from_date, to_date) VALUES(OLD.emp_no, @ft, @tt);
UPDATE Salaries SET from_date = NEW.from_date, to_date = NEW.to_date WHERE emp_no = OLD.emp_no;
END IF;
END //

DElIMITER ;

-- ----------------Records For the Database---------------------------

INSERT INTO Employee (birth_date, first_name, last_name, gender, hire_date)
VALUES ('1984-04-19', ' britney', ' spear', 'f', '2015-08-20');

INSERT INTO Employee (birth_date, first_name, last_name, gender, hire_date)
VALUES ('1949-05-18', 'michael',  'Brown', 'm', '2002-07-07');

INSERT INTO Employee (birth_date, first_name, last_name, gender, hire_date)
VALUES ('1986-01-15', 'Lisa', 'Chang', 'F', '2008-05-07');

INSERT INTO Employee (birth_date, first_name, last_name, gender, hire_date)
VALUES ('1982-10-25', 'Charles', 'Howell', 'M', '2010-08-08');

INSERT INTO Employee (birth_date, first_name, last_name, gender, hire_date)
VALUES ('1950-07-09', '  louisa', 'chan  ', 'f', '2005-10-10');


INSERT INTO Departments (dept_name) VALUES ('Information and Technology');

INSERT INTO Departments (dept_name) VALUES ('Accounting and Finance');

INSERT INTO Departments (dept_name) VALUES ('Advertising and Marketing');

INSERT INTO Departments (dept_name) VALUES ('Human Resources');

INSERT INTO Departments (dept_name) VALUES ('Productions');


UPDATE Titles SET title = 'IT Manager', from_date = '2015-08-20', to_date = '2015-10-25' WHERE emp_no = 1;

UPDATE Titles SET title = 'HR Manager', from_date = '2002-07-07', to_date = '2002-01-07' WHERE emp_no = 2;

UPDATE Titles SET title = 'Accountant Manager', from_date = '2008-05-07', to_date = '2008-06-07' WHERE emp_no = 3;

UPDATE Titles SET title = 'Accountant', from_date = '2010-08-08', to_date = '2010-10-08' WHERE emp_no = 4;

UPDATE Titles SET title = 'Intake Specialist', from_date = '2005-10-10', to_date = '2005-12-07' WHERE emp_no = 5;


-- Updating Salaries without any triggers implemented

UPDATE Salaries SET Salary = 123950 WHERE emp_no = 1;

UPDATE Salaries SET Salary = 135030 WHERE emp_no = 2;

UPDATE Salaries SET Salary = 112219 WHERE emp_no = 3;

UPDATE Salaries SET Salary = 63550 WHERE emp_no = 4;

UPDATE Salaries SET Salary = 35294 WHERE emp_no = 5;


-- Updating Dept_manager or Dept_emp without any triggers implemented

UPDATE Dept_emp SET dept_no = 2 WHERE emp_no = 4;

UPDATE Dept_emp SET dept_no = 5 WHERE emp_no = 5;

UPDATE Dept_manager SET dept_no = 1 WHERE emp_no = 1;

UPDATE Dept_manager SET dept_no = 4 WHERE emp_no = 2;

UPDATE Dept_manager SET dept_no = 2 WHERE emp_no = 3;

-- --------------------Demo For the Database--------------------------------

-- For Triggers Before_Insert_Employee and After_Insert_Employee

INSERT INTO Employee (birth_date, first_name, last_name, gender, hire_date)
VALUES ('1985-01-08', '   christine', '  chow', 'f', '2008-06-30');

INSERT INTO Employee (birth_date, first_name, last_name, gender, hire_date)
VALUES ('1949-10-20', 'andrea   ', '   Leung', 'm', '2001-05-10');

SELECT * FROM Employee;

SELECT * FROM Titles;

SELECT * FROM Salaries;

-- For Trigger Before_Insert_Departments

INSERT INTO Departments (dept_name) VALUES ('Planning');

SELECT * FROM Departments;

-- For Trigger BEFORE_UPDATE_Titles

UPDATE Titles SET title = 'Site Coordinator', from_date = '2002-07-07', to_date = '2002-01-07' WHERE emp_no = 6;

UPDATE Titles SET title = 'Planning Manager', from_date = '2001-05-10', to_date = '2015-12-11' WHERE emp_no = 7;

-- For Trigger AFTER_UPDATE_Titles

SELECT * FROM Titles;

SELECT * FROM Salaries;

SELECT * FROM Dept_emp;

SELECT * FROM Dept_manager;

--Complete entering all information in the databases

UPDATE Dept_emp SET dept_no = 6 WHERE emp_no = 6; 

UPDATE Salaries SET Salary = 50000 WHERE emp_no = 6;

UPDATE Dept_manager SET dept_no = 6 WHERE emp_no = 7; 

UPDATE Salaries SET Salary = 122560 WHERE emp_no = 7;





