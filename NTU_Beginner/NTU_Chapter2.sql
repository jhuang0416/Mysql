SHOW DATABASES;



CREATE DATABASE Southwind; 

DROP DATABASE Southwind;

CREATE DATABASE IF NOT EXISTS Southwind;

DROP DATABASE IF EXISTS Southwind;



CREATE DATABASE Southwind;

SHOW DATABASES;

USE Southwind;

SELECT DATABASE();

SHOW TABLES;

DESCRIBE Products;

SHOW CREATE TABLE Products \G 



INSERT INTO Products VALUES (1001,'PEN','Pen Red',5000,1.23);

INSERT INTO Products VALUES (NULL,'PEN','Pen Blue',8000,1.25), 
(NULL,'PEN','Pen Black',2000,1.25);

INSERT INTO Products (productCode,name,quantity,price) VALUES
('PEC','Pencil 2B',10000,0.48),
('PEC','Pencil 2H',8000,0.49); 

INSERT INTO Products (productCode,name) VALUES ('PEC','Pencil HB');

INSERT INTO Products (NULL, NULL, NUll, NUll, NULL);

DELETE FROM Products WHERE productID = 1006;



SELECT name, price FROM Products;

SELECT * FROM Products;

SELECT 1+1;

SELECT NOW();

SELECT 1+1, NOW();

SELECT name, price FROM Products WHERE price < 1.0;

SELECT name, quantity FROM Products WHERE quantity <= 2000;

SElECT name, price FROM Products WHERE productCode = 'PEN';

SELECT name, price FROM Products WHERE name LIKE 'Pencil%';

SELECT name, price FROM Products WHERE name LIKE 'P__ %';

SELECT * FROM Products WHERE quantity >= 5000 AND name LIKE 'Pen %'

SELECT * FROM Products WHERE quantity >= 5000 AND price < 1.24 AND name LIKE 'Pen %';

SELECT * FROM Products WHERE NOT (quantity >= 5000 AND name LIKE 'Pen %');

SELECT * FROM Products WHERE name IN ('Pen Red', 'Pen Black');

SELECT * FROM Products
WHERE (price BETWEEN 1.0 AND 2.0) AND (quantity BETWEEN 1000 AND 2000);

SELECT * FROM Products WHERE productCode IS NULL;

SELECT * FROM Products WHERE name LIKE 'Pen %' ORDER BY price DESC;

SELECT * FROM Products WHERE name LIKE 'Pen %' ORDER BY price DESC, quanity;

SELECT * FROM Products ORDER BY RAND();

SELECT * FROM Products ORDER BY price LIMIT 2;

SELECT * FROM Products ORDER BY price LIMIT 2,1;

SELECT productID AS ID, productCode AS Code, name AS Description, price AS `Unit Price` FROM Products ORDER BY ID;

SELECT CONCAT(productCode,'-',name) AS `Product Description`,price FROM Products;


SELECT price FROM Products;

SELECT DISTINCT price AS `Distinct Price` FROM Products;

SELECT DISTINCT price, name FROM Products;

SELECT * FROM Products ORDER BY productCode, productID;

SELECT * FROM Products GROUP BY productCode, productID;

SELECT * FROM Products GROUP BY productCode; 

SELECT COUNT(*) AS `Count` FROM Products;

SELECT productCode, COUNT(*) AS `Count` FROM Products GROUP BY productCode;

SELECT productCode, COUNT(*) AS count 
FROM Products
GROUP BY productCode
ORDER BY count DESC;

SELECT MAX(price), MIN(price), AVG(price), STD(price), SUM(quantity)
FROM Products;

SELECT productCode, MAX(price) AS `Highest Price`, MIN(price) AS `Lowest Price` 
FROM Products
GROUP BY productCode; 

SELECT productCode, MAX(price), MIN(price),
CAST(AVG(price) AS DECIMAL(7,2)) AS `Average`,
CAST(STD(price) AS DECIMAL(7,2)) AS `Std Dev`,
SUM(quantity) 
FROM Products
GROUP BY ProductCode;

SELECT
productCode AS `Product Code`,
COUNT(*) AS `Count`,
CAST(AVG(price) AS DECIMAL(7,2)) AS `Average`
FROM Products
GROUP BY ProductCode
HAVING Count >=3; 

SELECT
productCode,
MAX(price),
MIN(price),
CAST(AVG(price) AS DECIMAL(7,2)) AS `Average`,
SUM(quantity)
FROM Products
GROUP BY productCode
WITH ROLLUP;



UPDATE Products SET price = price * 1.1;

SELECT * FROM Products;

UPDATE Products SET quantity = quantity - 100 WHERE name = 'Pen Red';

SELECT * FROM Products WHERE name = 'Pen Red';

UPDATE Products SET quantity = quantity + 50, price = 1.23 WHERE name = 'Pen Red'; 

SELECT * FROM Products WHERE name = 'Pen Red'; 



DELETE FROM Products WHERE name LIKE 'Pencil%';

SELECT * FROM Products;

DELETE FROM Products;

SELECT * FROM Products;



LOAD DATA LOCAL INFILE '/home/jenny/Desktop/products_in.csv' INTO TABLE Products FIELDS TERMINATED BY ',' ;

SELECT * FROM Products;

Mysqlimport -u root -p --local Southwind /home/jenny/Desktop/Product.tsv


























































