/* 6-Define more procedures and functions. */

/*Create a function, you can compute the outstanding balance and name it 'Outstanding Balance'.  */

DELIMITER //

CREATE FUNCTION Outstanding_Balance(Price DECIMAL(8,2), Amount DECIMAL(8,2))
RETURNS DECIMAL(8,2) DETERMINISTIC
BEGIN
DECLARE Out_Bal DECIMAL(8,2);
SET Out_Bal = Price - Amount;
RETURN (Out_Bal);
END //

DELIMITER ;

SELECT Outstanding_Balance(719.63,119.63) AS Outstanding_Balance;

/*Create a procedure to calculate the total amount paid per rental. */

DELIMITER //

CREATE PROCEDURE Sum_Payments(IN Amount1 DECIMAL(6,2), IN Amount2 DECIMAL(6,2), IN Amount3 DECIMAL(6,2))
BEGIN
DECLARE Sum_Payments DECIMAL(6,2);
SET Sum_Payments = Amount1 + Amount2 + Amount3;
SELECT Sum_Payments;
END //

DELIMITER ;

CALL Sum_Payments(100, 200, 250);

/* Create a procedure where you can check the amount of times vehicle 'SBA1111A' was rented out. */

DELIMITER //

CREATE PROCEDURE SBA1111A_count (veh_no VARCHAR(8))
BEGIN
SELECT COUNT(*) AS S_count FROM rental_records 
WHERE rental_records.veh_reg_no = veh_no;
END //

DELIMITER ;

CALL SBA1111A_count('SBA1111A');

SELECT * FROM rental_records WHERE veh_reg_no = 'SBA1111A' \G

