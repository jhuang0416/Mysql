/* 11-Foreign Key Test:
(a) Try deleting a parent row with matching row(s) in child table(s) e.g., delete 'GA6666F' from vehicles table (ON DELETE RESTRICT).
(b) Try updating a parent row with matching row(s) in child table(s)
e.g., rename 'GA6666F' to 'GA9999F'in vehicles table.  Check the effects on the child table rental_records (ON UPDATE CASCADE)
(c)Remove 'GA6666F' from the database (Hints:Remove it from child table rental_records; then parent table Vehicles.) */

/* (a) ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`rental_db`.`rental_records`, CONSTRAINT `rental_records_ibfk_1` FOREIGN KEY (`veh_reg_no`) REFERENCES `Vehicles` (`veh_reg_no`) ON UPDATE CASCADE) */

/* (b) */
UPDATE Vehicles SET veh_reg_no = 'GA9999F' WHERE veh_reg_no = 'GA6666F'; 

/*(c) */
UPDATE Vehicles SET veh_reg_no = 'GA6666F' WHERE veh_reg_no = 'GA9999F'; 

DELETE FROM rental_records WHERE rental_id = 4;

SELECT * FROM rental_records;

SELECT * FROM Vehicles \G

DELETE FROM Vehicles WHERE veh_reg_no = 'GA6666F';

SELECT * FROM Vehicles \G

