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

CREATE FUNCTION Public_holiday_prices(start_date DATE, end_date DATE, daily_rate DECIMAL(6,2), discount DOUBLE)
RETURNS DECIMAL(8,2) NOT DETERMINISTIC
BEGIN

DECLARE Price DECIMAL(8,2) DEFAULT 0.00;
DECLARE Offset_Row INT DEFAULT 0;

SET @Test_date := start_date;
SET @Public_holiday := (SELECT `date` FROM public_holiday LIMIT Offset_Row, 1); --get one record at a time from the public_holiday table
SET @Count1 := (SELECT COUNT(*) FROM public_holiday);  --The total rows in the public_holiday table

Comparing_Computing: LOOP

--Calculating the total rental price while determining each rental date landed on weekdays, weekends, or public holiday
IF ((DAYOFWEEK(date(@Test_date))) = 1 OR 7) OR ((EXTRACT(MONTH FROM date(@Test_date)) = EXTRACT(MONTH FROM date(@Public_holiday))) 
	AND (EXTRACT(DAY FROM date(@Test_date)) = EXTRACT(DAY FROM date(@Public_holiday)))) 
THEN 
SET Price = Price + daily_rate;
ELSE
SET Price = Price + (daily_rate * (1 - discount));
END IF;
SET Offset_Row = Offset_Row + 1;
--Testing whether there is more records for public_holiday table
IF (Offset_Row != @Count1)
THEN 
ITERATE Comparing_Computing;
END IF;
SET Offset_Row = 0; --Return to the beginning of the public_holiday table
SET @Test_date := DATE_ADD(date(@Test_date), INTERVAL 1 DAY); --Proceed to the next date to be compared
--Determining whether the next date is within the range of the rental period
IF (date(@Test_date) BETWEEN start_date AND end_date)
THEN
ITERATE Comparing_Computing;
END IF;
LEAVE Comparing_Computing; --Leave the loop once done 
END LOOP Comparing_Computing;

--Computing the total rental price with discount based on the duration of the rental period
IF (DATEDIFF(end_date,start_date)) >= 7
THEN SET price = price * (1 - discount) * 0.8;
ELSE
SET price = price * (1 - discount);
END IF;

RETURN Price;
END // 


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
   CAST(
      IF (DATEDIFF(r.end_date, r.start_date) < 7,
          DATEDIFF(r.end_date, r.start_date)*daily_rate*(1-discount),
          DATEDIFF(r.end_date, r.start_date)*daily_rate*(1-discount)*0.8)
      AS DECIMAL(8,2)) AS price,
(SELECT rental_price(r.start_date, r.end_date, v.daily_rate, c.discount)) As 'Rental Price',
   SUM(p.amount) AS 'Total Paid Amount',
(SELECT rental_price(r.start_date, r.end_date, v.daily_rate, c.discount)-SUM(p.amount)) AS 'Outstanding Balance',
(SELECT Public_holiday_prices(start_date, end_date, daily_rate, discount))AS 'Public_holiday_Wkend'
FROM rental_records AS r
   INNER JOIN Vehicles  AS v USING (veh_reg_no)
   INNER JOIN Customers AS c USING (customer_id)
   INNER JOIN Payments AS p USING (rental_id)
   GROUP BY rental_id; 

