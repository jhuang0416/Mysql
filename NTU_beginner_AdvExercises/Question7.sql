/* 7-TRIGGER: Write a trigger for the created_date and created_by columns of the payments table. */

DELIMITER //

CREATE TRIGGER Created BEFORE INSERT ON Payments
FOR EACH ROW
BEGIN
SET NEW.created_by = (SELECT staff_id FROM staff WHERE staff.name = 'Peter Johns');
SET NEW.created_date = NOW();
END //

CREATE TRIGGER Created_Update BEFORE UPDATE ON Payments
FOR EACH ROW
BEGIN
SET NEW.created_by = (SELECT staff_id FROM staff WHERE staff.name = 'Christine Wu');  
SET NEW.created_date = NOW();
END //

DELIMITER ;

INSERT INTO Payments (rental_id, amount, mode, type, remark, last_updated_date, last_updated_by, staff_id)
VALUES (7, 2000.27,'credit card','full','It is great!',
NOW(),8001,8001); 

SELECT * FROM Payments \G

UPDATE Payments SET amount= '2000.50' WHERE payment_id = 12; 

SELECT * FROM Payments \G

