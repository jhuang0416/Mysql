/* 6-Define more procedures and functions. */

/*This view includes the outstanding balance computation for a rental without needing to create a function or procedure. */

CREATE VIEW rental_prices
AS
SELECT
   v.veh_reg_no    AS `Vehicle No`,
   v.daily_rate    AS `Daily Rate`,
   c.name          AS `Customer Name`,
   c.discount*100  AS `Customer Discount (%)`,
   r.start_date    AS `Start Date`,
   r.end_date      AS `End Date`,
   DATEDIFF(r.end_date, r.start_date) AS `Duration`,
   -- Compute the rental price
   -- Preferred customer has discount, 20% discount for 7 or more days
   -- CAST the result from DOUBLE to DECIMAL(8,2)
   CAST(
      IF (DATEDIFF(r.end_date, r.start_date) < 7,
          DATEDIFF(r.end_date, r.start_date)*daily_rate*(1-discount),
          DATEDIFF(r.end_date, r.start_date)*daily_rate*(1-discount)*0.8)
      AS DECIMAL(8,2)) AS price,
(SELECT rental_price(r.start_date, r.end_date, v.daily_rate, c.discount)) As 'Rental Price',
   SUM(p.amount) AS 'Total Paid Amount',
(SELECT rental_price(r.start_date, r.end_date, v.daily_rate, c.discount)-SUM(p.amount)) AS 'Outstanding Balance'
FROM rental_records AS r
   INNER JOIN Vehicles  AS v USING (veh_reg_no)
   INNER JOIN Customers AS c USING (customer_id)
   INNER JOIN Payments AS p USING (rental_id)
   GROUP BY rental_id; 



/*Create a procedure to calculate the total amount paid per rental. */

DELIMITER //

CREATE PROCEDURE Sum_Payments ()
BEGIN
SELECT rental_id, SUM(amount) FROM `Payments` GROUP BY rental_id;
END //

DELIMITER ;

CALL Sum_Payments();



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


