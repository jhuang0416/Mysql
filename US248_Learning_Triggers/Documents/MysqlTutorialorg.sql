/* Mysql Tutorial- Create Trigger in MySQL

Note: Before you start this tutorial, you must load the sample database "mysqlsampledatabase.sql".  */


CREATE TABLE employees_audit (
id INT(11) NOT NULL AUTO_INCREMENT,
employeeNumber INT(11) NOT NULL,
changedon DATETIME DEFAULT NULL,
action VARCHAR(50) DEFAULT NULL,
PRIMARY KEY(id)
); 

DELIMITER $$

CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employees_audit
FOR EACH ROW
BEGIN
INSERT INTO employees_audit
SET action = 'update',
employeeNumber = OLD.employeeNumber,
lastname = OLD.lastname, 
changedon = NOW();
END$$

DELIMITER ;

UPDATE employees 
SET lastName = 'Phan'
WHERE employeeNumber = 1056; 

SELECT * FROM employees_audit;

