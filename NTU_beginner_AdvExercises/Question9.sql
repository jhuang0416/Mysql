/* 9-Implement discount on weekday (Monday to Friday, except public holiday): Need to set up a new table called public_holiday with columns date and description.  Use function DAYOFWEEK(1=Sunday,...,7=Saturday) to check for weekday or weekend. 

Pseudocode for calculating rental price:

price = 0;
for each date from start_date to end_date {
if date is weekend or public_holiday, price += daily_rate;
else price += dailiy_rate*(1-discount);
}
if (duration >= 7) price *= (1-long_duration_discount);
price *= (1-perfered_customer_discount);

*/

CREATE TABLE public_holiday (
`date` DATE NOT NULL,
`description` VARCHAR(30) NOT NULL
)ENGINE=InnoDB;

INSERT INTO public_holiday VALUES 
('2014-12-25','Christmas Day');


DELIMITER //

CREATE FUNCTION rental_price_hol (start_date DATE, end_date DATE, daily_rate DECIMAL(6,2),discount DOUBLE) 
RETURNS DECIMAL(8,2) NOT DETERMINISTIC

BEGIN 
DECLARE price DECIMAL(8,2);
DECLARE test_date DATE;
DECLARE public_holiday DATE;
SET test_date = start_date;
SET price = 0;
SET @public_holiday = (SELECT date FROM public_holiday WHERE description = 'Christmas Day'); 

REPEAT

IF (DAYOFWEEK(test_date) = 1 OR 7) OR (test_date = @public_holiday)
THEN SET price = price + daily_rate;
ELSE 
SET price = price + (daily_rate*(1-discount));
END IF;

SET test_date = DATE_ADD(test_date,INTERVAL 1 DAY);
UNTIL test_date > end_date
END REPEAT;

IF (DATEDIFF(end_date,start_date)) >= 7
THEN SET price = price*(1-discount)*0.8;
ELSE
SET price = price*(1-discount);
END IF;

RETURN(price); 
END // 

DELIMITER ;

SELECT rental_price_hol('2014-10-12','2014-10-18',119.99,0.10); 
