/* 8-Define more triggers. */

DELIMITER //

CREATE TRIGGER staff_handled BEFORE INSERT ON rental_records
FOR EACH ROW
BEGIN
SET NEW.staff_id = (SELECT staff_id FROM staff WHERE User = (SELECT Current_user()));
END //

CREATE TRIGGER staff_handled_Updated BEFORE UPDATE ON rental_records
FOR EACH ROW
BEGIN
SET NEW.staff_id = (SELECT staff_id FROM staff WHERE SELECT Current_user()));
END //

DELIMITER ;

INSERT INTO rental_records (veh_reg_no,customer_id,start_date,end_date,lastUpdated) VALUES ('SBC3333C','1004','2014-12-20','2014-12-30',NOW()); 

UPDATE rental_records SET end_date = ('2015-11-31') WHERE rental_id = 7;

SELECT * FROM rental_records WHERE rental_id = 7 \G
