SELECT * FROM Products_Suppliers;

DELETE FROM Suppliers WHERE supplierID = 501; 



CREATE TABLE Employees (
emp_no INT UNSIGNED NOT NULL AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
gender ENUM ('M', 'F') NOT NULL,
birth_date DATE	NOT NULL,
hire_date DATE NOT NULL,
PRIMARY KEY (emp_no));

DESCRIBE Employees;

SHOW INDEX FROM Employees \G

CREATE TABLE Departments (
dept_no CHAR(4) NOT NULL,
dept_name VARCHAR(40) NOT NULL,
PRIMARY KEY (dept_no),
UNIQUE KEY (dept_name)); 

DESCRIBE Departments;

SHOW INDEX FROM Departments \G

CREATE TABLE Dept_Emp (
emp_no INT UNSIGNED NOT NULL,
dept_no CHAR(4) NOT NULL,
from_date DATE NOT NULL,
to_date DATE NOT NULL,
INDEX (emp_no),
INDEX (dept_no),
FOREIGN KEY (emp_no) REFERENCES Employees (emp_no) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (dept_no) REFERENCES Departments (dept_no) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (emp_no, dept_no)); 

DESCRIBE Dept_Emp;

SHOW INDEX FROM Dept_Emp \G



