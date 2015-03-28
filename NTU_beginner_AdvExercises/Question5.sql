DROP VIEW rental_prices;

DELIMITER //

CREATE FUNCTION rental_price(start_date DATE, end_date DATE, daily_rate DECIMAL(6,2), discount DOUBLE)
RETURNS DECIMAL(8,2) NOT DETERMINISTIC
BEGIN

DECLARE Price DECIMAL(8,2);

IF DATEDIFF(end_date, start_date) < 7 THEN
	SET Price = DATEDIFF(end_date, start_date)*daily_rate*(1-discount);
ELSE 
	SET Price = DATEDIFF(end_date, start_date)*daily_rate*((1-discount)*0.8);
END IF;

RETURN(Price);

END//


/* Reconstruction of rental_price view to accomodate the rental_prices function. */

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
(SELECT rental_price(r.start_date, r.end_date, v.daily_rate, c.discount)) As 'Rental Price'
FROM rental_records AS r
   INNER JOIN Vehicles  AS v USING (veh_reg_no)
   INNER JOIN Customers AS c USING (customer_id);
