/* 2-Customer 'Kumar' has rented 'GA5555E' from tomorrow for 3 months */

SET @tomorrow := DATE_ADD(CURDATE(), INTERVAL 1 DAY);

INSERT INTO rental_records VALUES
(NULL,'GA5555E',(SELECT customer_id FROM Customers WHERE name = 'Kumar'),@tomorrow,DATE_ADD(@tomorrow,INTERVAL 3 MONTH), NULL); 
