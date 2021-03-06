/* 7-TRIGGER: Write a trigger for the created_date and created_by columns of the payments table. */

DELIMITER //

CREATE TRIGGER Created BEFORE INSERT ON Payments
FOR EACH ROW
BEGIN
SET NEW.created_by = (SELECT staff_id FROM staff WHERE User = (SELECT Current_user()));
SET NEW.created_date = NOW();
SET NEW.staff_id = (SELECT staff_id FROM staff WHERE User = (SELECT Current_user()));
END //

CREATE TRIGGER Created_Update BEFORE UPDATE ON Payments
FOR EACH ROW
BEGIN
SET NEW.last_updated_by = (SELECT staff_id FROM staff WHERE User = (SELECT Current_user()));
SET NEW.staff_id = (SELECT staff_id FROM staff WHERE User = (SELECT Current_user()));
END //

DELIMITER ;

INSERT INTO Payments(rental_id, amount, `mode`, type, remark)
VALUES (8, 50.00, 'cash','partial', 'balance 43.27'); 

SELECT * FROM Payments \G

UPDATE Payments SET amount= '53.27' WHERE payment_id = 8; 

SELECT * FROM Payments \G

