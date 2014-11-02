/* 5-FUNCTION: Write a function to compute the rental price. */

DELIMITER //

CREATE FUNCTION rental_prices(end_date DATE, start_date DATE, daily_rate DECIMAL(6,2),discount DOUBLE) 
RETURNS DECIMAL(8,2) NOT DETERMINISTIC

BEGIN
DECLARE Price DECIMAL(8,2);
IF DATEDIFF(end_date,start_date) < 7 THEN
SET Price = DATEDIFF(end_date,start_date)*daily_rate*(1-discount);
ELSE
SET Price = DATEDIFF(end_date,start_date)*daily_rate*(1-discount)*0.8;
END IF;
RETURN (Price);
END //

DELIMITER ; 

Select rental_price('2014-09-23', '2014-09-13', 99.99, 0.1);

Select * from rental_prices \G 
