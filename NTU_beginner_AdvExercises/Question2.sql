/* 2-VIEW: Create a VIEW called rental_prices on the rental_records with an additional column called price.  Show all the records of the VIEW. */

DROP VIEW IF EXISTS rental_prices;

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
AS DECIMAL(8,2)) AS price
FROM rental_records AS r
INNER JOIN Vehicles  AS v USING (veh_reg_no)
INNER JOIN Customers AS c USING (customer_id);

DESC `rental_prices`;

SHOW CREATE VIEW `rental_prices` \G

SELECT * FROM `rental_prices`;

