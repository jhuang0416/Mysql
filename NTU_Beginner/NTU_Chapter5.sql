SELECT Suppliers.name FROM Suppliers
WHERE Suppliers.supplierID
NOT IN (SELECT DISTINCT supplierID FROM Products_Suppliers); 

INSERT INTO Products_Suppliers VALUES (
(SELECT productID FROM Products WHERE name = 'Pencil 6B'),
(SELECT supplierID FROM Suppliers WHERE name = 'QQ Corp')); 

DELETE FROM Products_Suppliers
WHERE supplierID = (SELECT supplierID FROM Suppliers WHERE name = 'QQ Corp'); 



CREATE TABLE Patients (
patientID  INT UNSIGNED NOT NULL AUTO_INCREMENT,
name VARCHAR(30) NOT NULL DEFAULT ' ',
dateOfBirth DATE NOT NULL,
lastVisitDate DATE NOT NULL,
nextVisitDate DATE NULL,
PRIMARY KEY (patientID)); 

INSERT INTO Patients VALUES
(1001, 'Ah Teck', '1991-12-31', '2012-01-20', NULL),
(NULL, 'Kumar', '2011-10-29', '2012-09-20', NULL),
(NULL, 'Ali', '2011-01-30', CURDATE(), NULL); 

SELECT * FROM Patients;

SELECT * FROM Patients
WHERE lastVisitDate BETWEEN '2012-09-15' AND CURDATE()
ORDER BY lastVisitDate; 

SELECT * FROM Patients
WHERE YEAR(dateOfBirth) = 2011
ORDER BY MONTH(dateofBirth), DAY(dateofBirth); 

SELECT * FROM Patients
WHERE MONTH(dateofBirth) = MONTH(CurDate())
AND DAY(dateOfBirth) = DAY(CurDate());

SELECT name, dateOfBirth, TIMESTAMPDIFF(YEAR, dateOfBirth, CURDATE()) AS Age
FROM Patients
ORDER BY Age, dateOfBirth;

SELECT name,lastVisitDate FROM Patients
WHERE TIMESTAMPDIFF(DAY, lastVisitDate, CURDATE()) > 60; 

SELECT name, lastVisitDate FROM Patients
WHERE TO_DAYS(CURDATE()) - TO_DAYS(lastVisitDate) > 60; 

SELECT * FROM Patients
WHERE dateOfBirth > DATE_SUB(CURDATE(), INTERVAL 18 YEAR); 

UPDATE Patients
SET nextVisitDate = DATE_ADD(CURDATE(), INTERVAL 6 MONTH)
WHERE name = 'Ali'; 

SELECT NOW(), CURDATE(), CURTIME();

SELECT YEAR(NOW()), MONTH(NOW()), DAY(NOW()), HOUR(NOW()), MINUTE(NOW()), SECOND(NOW()); 

SELECT DAYNAME(NOW()), MONTHNAME(NOW()), DAYOFWEEK(NOW()), DAYOFYEAR(NOW());

SELECT DATE_ADD('2012-01-31', INTERVAL 5 DAY);

SELECT DATE_SUB)'2012-01-31', INTERVAL 2 MONTH);

SELECT DATEDIFF('2012-02-01','2012-01-28');

SELECT TIMESTAMPDIFF(DAY,'2012-02-01','2012-01-28');

SELECT TO_DAYS('2012-01-31');

SELECT FROM_DAYS(734898);

SELECT DATE_FORMAT('2012-01-01 23:59:30', '%W %D %M %Y');

CREATE TABLE IF NOT EXISTS `datetime_arena`(
`description` VARCHAR(50) DEFAULT NULL,
`cDatetime` DATETIME DEFAULT '0000-00-00 00:00:00',
`cDate` DATE DEFAULT '0000-00-00',
`cTime` TIME DEFAULT '00:00:00',
`cYear` YEAR DEFAULT '0000',
`cYear2` YEAR(2) DEFAULT '00',
`cTImeStamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP); 

DESCRIBE `datetime_arena`;

INSERT INTO `datetime_arena`
(`description`,`cDateTime`,`cDate`,`cTime`,`cYear`,`cYear2`)
VALUES
('Manual Entry','2001-01-01 23:59:59','2002-02-02','12:30:30','2004', '05'); 

SELECT * FROM `datetime_arena` WHERE description = 'Manual Entry'; 

UPDATE `datetime_arena` 
SET `cYear2` = '99'
WHERE description = 'Manual Entry';

SELECT * FROM `datetime_arena` WHERE description = 'Manual Entry';

INSERT INTO `datetime_arena`
(`description`, `cDateTime`,`cDate`,`cTime`, `cYear`, `cYear2`)
VALUES
('Built-in Functions',NOW(), CURDATE(), CURTIME(), NOW(), NOW());

SELECT * FROM `datetime_arena` WHERE description = 'Built-in Functions'; 

INSERT INTO `datetime_arena` 
(`description`,`cDateTime`,`cDate`,`cTime`,`cYear`,`cYear2`)
VALUES
('Error Input','2001-13-31 23:59:59','2002-13-31','12:61:61','99999', '999'); 

SELECT * FROM `datetime_arena` WHERE name = 'Error Input';

SELECT `cDate`,`cDate` + INTERVAL 30 DAY, `cDate` + INTERVAL 1 MONTH FROM `datetime_arena`; 



CREATE VIEW Supplier_view
AS 
SELECT Suppliers.name AS `Supplier Name`, Products.name AS `Product Name`
FROM Products_Suppliers
JOIN Suppliers ON Suppliers.supplierID = Products_Suppliers.supplierID
JOIN Products ON Products.productID = Products_Suppliers.productID;

SELECT * FROM Supplier_view;

SELECT * FROM Supplier_view WHERE `Supplier Name` LIKe 'ABC%';

DROP VIEW IF EXISTS Patient_view;

CREATE VIEW Patient_view 
AS 
SELECT 
patientID AS ID,
name AS Name, 
dateOfBirth AS DOB,
TIMESTAMPDIFF(YEAR,dateOfBirth, CURDATE()) AS Age
FROM Patients
ORDER BY Age, DOB;

SELECT * FROM Patient_view WHERE name LIKE 'A%'; 

SELECT * FROM Patient_view WHERE age >= 18;



CREATE TABLE Accounts (
name VARCHAR(30),
balance DECIMAL(10, 2)); 

INSERT INTO Accounts VALUES 
('Paul', 1000),
('Peter', 2000); 

SELECT * FROM Accounts;

START TRANSACTION;
UPDATE Accounts SET balance = balance - 100 WHERE name = 'Paul';
UPDATE Accounts SET balance = balance + 100 WHERE name = 'Peter'; 
COMMIT;

SELECT * FROM Accounts;

START TRANSACTION;
UPDATE Accounts SET balance = balance - 100 WHERE name = 'Paul';
UPDATE Accounts SET balance = balance + 100 WHERe name = 'Peter'; 
ROLLBACK;

SET Autocommit = 0;
UPDATE Accounts SET balance = balance - 100 WHERE name = 'Paul';
UPDATE Accounts SET balance = balance + 100 WHERe name = 'Peter'; 
COMMIT;

SELECT * FROM Accounts;

UPDATE Accounts SET balance = balance - 100 WHERE name = 'Paul'; 
UPDATE Accounts SET balance = balance + 100 WHERE name = 'Peter';
ROLLBACK;

SELECT * FROM Accounts;

SET autocommit = 1;



SELECT @ali_dob := dateOfBirth FROM Patients WHERE name = 'Ali';

SELECT name WHERE dateOfBirth < @ali_dob;

SET @today := CURDATE();

SELECT name FROM Patients WHERE nextVisitDate = @today;






