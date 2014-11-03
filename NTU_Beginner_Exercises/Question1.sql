/* 1-Customer 'Tan Ah Teck' has rented 'SBA1111A' from today for 10 days. (Hint: You need to insert a rental record.  Use a SELECT subquery to get the customer_id.  Use CURDATE() (or NOW()) for today; and DATE_ADD(CURDATE(), InTERVAL x UNIT) to compute a future. */

INSERT INTO rental_records VALUES
(NULL,'SBA1111A',(SELECT customer_id FROM Customers WHERE name = 'Tan Ah Teck'),CURDATE(),DATE_ADD(CURDATE(), INTERVAL 10 DAY), NULL); 

