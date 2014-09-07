USE Southwind;

DROP TABLE IF EXISTS Suppliers;

CREATE TABLE Suppliers (
supplierID INT UNSIGNED NOT NULL AUTO_INCREMENT,
name VARCHAR(30) NOT NULL DEFAULT ' ',
phone CHAR(8) NOT NULL DEFAULT ' ',
PRIMARY KEY (supplierID)
);

DESCRIBE Suppliers;

INSERT INTO Suppliers VALUES
(501, 'ABC Traders', '88881111'),
(502, 'XYZ Company', '88882222'),
(503, 'QQ Corp', '88883333'); 

SELECT * FROM Suppliers;

ALTER TABLE Products
ADDCOLUMN supplierID INT UNSIGNED NOT NULL; 

DESCRIBE Products;

UPDATE Products SET supplierID = 501;

ALTER TABLE Products
ADD FOREIGN KEY (supplierID) REFERENCES Supplier (supplierID); 

DESCRIBE Products;

UPDATE Products SET supplierID = 502 WHERE productID = 2004; 

SELECT * FROM Products;

SELECT Products.name, price, Suppliers.name 
FROM Products
JOIN Suppliers ON Products.supplierID = Supplier.supplierID
WHERE price < 0.6; 

SELECT Products.name, price, Suppliers.name
FROM Products, Suppliers
WHERE Products.supplierID = Suppliers.supplierID 
AND price < 0.6; 

SELECT Products.name AS `Product Name`, price, Suppliers.name AS `Supplier Name` FROM Products
JOIN Suppliers ON Products.supplierID = Suppliers.supplierID
WHERE price < 0.6; 

SELECT p.name AS `Product Name`, p.price, s.name AS `Supplier Name`
FROM Products AS p
JOIN Suppliers AS s ON p.supplierID = s.supplierID
WHERE p.price < 0.6; 



CREATE TABLE Products_Suppliers (
productID INT UNSIGNED NOT NULL,
supplierID INT UNSIGNED NOT NULL,
PRIMARY KEY (productID, supplierID),
FOREIGN KEY (productID) REFERENCES Products(productID),
FOREIGN KEY (supplierID) REFERENCES Suppliers(supplierID)); 

DESCRIBE Products_Suppliers; 

INSERT INTO Products_Suppliers VALUES
(2001, 501),
(2002, 501),
(2003, 501),
(2004, 502),
(2001, 503); 

SELECT * FROM Products_Suppliers;

SHOW CREATE TABLE Products \G

ALTER TABLE Products DROP FOREIGN KEY Products_ibfk_1;

SHOW CREATE TABLE Products \G

ALTER TABLE Products DROP supplierID;

DESC Products;

SELECT Products.name AS `Product Name`, price, Suppliers.name AS `Supplier Name`
FROM Products_Suppliers
JOIN Products ON Products_Suppliers.productID = Products.productID
JOIN Suppliers ON Products_Suppliers.supplierID = Suppliers.supplierID
WHERE price < 0.6; 

SELECT p.name AS `Product Name` s.name AS `Supplier Name`
FROM Products_Suppliers AS ps
JOIN Products AS p ON ps.productID = p.productID
JOIN Suppliers AS s ON ps.supplierID = s.supplierID
WHERE p.name = 'Pencil 3B'; 

SELECT p.name AS `Product Name`, s.name AS `Supplier Name`
FROM Products AS p, Products_Suppliers AS ps, Suppliers AS s
WHERE p.productID = ps.productID
AND s.supplierID = ps.supplierID
AND s.name = 'ABC Traders'; 



CREATE TABLE Product_Details (
productID INT UNSIGNED NOT NULL,
Comment TEXT NULL,
PRIMARY KEY (productID),
FOREIGN KEY (productID) REFERENCES Products (productID));

DESCRIBE Product_Details;

SHOW CREATE TABLE Product_Details \G



mysqldump -u root -p Southwind > '/home/jenny/Desktop/backup_southwind.sql

source '/home/jenny/Desktop/backup_southwind.sql

mysql -u root -p Southwind < /home/jenny/Desktop/backup_southwind.sql
--via batch mode














