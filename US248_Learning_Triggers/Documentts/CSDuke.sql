CREATE DATABASE CSDuke;

/* Create Trigger Syntax */

CREATE TABLE test1 (
a1 INT);

CREATE TABLE test2 (
a2 INT);

CREATE TABLE test3 (
a3 INT NOT NULL AUTO_INCREMENT,
PRIMARY KEY(a3));

CREATE TABLE test4 (
a4 INT NOT NULL AUTO_INCREMENT,
b4 INT DEFAULT 0,
PRIMARY KEY(a4));

DELIMITER |

CREATE TRIGGER testref 
BEFORE INSERT ON test1
FOR EACH ROW
BEGIN
INSERT INTO test2 SET a2 = NEW.a1;
DELETE FROM test3 WHERE a3 = NEW.a1;
UpDATE test4 SET b4 = b4 + 1 WHERE a4 = NEW.a1;
END|

DELIMITER ;

INSERT INTO test3 (a3) VALUES
(NULL), (NULL), (NULL), (NULL), (NULL), 
(NULL), (NULL), (NULL), (NULL), (NULL);

INSERT INTO test4 (a4) VALUES
(0), (0), (0), (0), (0), 
(0), (0), (0), (0), (0);


INSERT INTO test1 VALUES
(1), (3), (1), (7), (1), (8), (4), (4); 

SELECT * FROM test1; 

SELECT * FROM test2; 

SELECT * FROM test3; 

SELECT * FROM test4; 

/* Dropping Triggers */

CREATE TABLE account (
acct_num INT,
amount DECIMAL(10,2));

CREATE TRIGGER ins_sum 
BEFORE INSERT ON account FOR EACH ROW
SET @sum = @sum + NEW.amount;


SET @sum = 0;

INSERT INTO account VALUES
(137, 14.98),
(141, 1937.50),
(97, -100.00);

SELECT @sum AS 'Total amount inserted'; 

DROP TRIGGER in_sum; 

DELIMITER //

CREATE TRIGGER upd_check
BEFORE UPDATE ON account FOR EACH ROW
BEGIN
IF NEW.amount < 0 THEN
SET NEW.amount = 0;
ELSEIF NEW.amount > 100 THEN
SET NEW.amount = 100;
END IF;
END//

DELIMITER ;




