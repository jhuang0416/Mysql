/* 3-From the payments table, create a view to show the outstanding balance. */

CREATE VIEW Outstanding_Balance
AS
SELECT
(CAST(
IF (DATEDIFF(r.end_date, r.start_date) < 7,
DATEDIFF(r.end_date, r.start_date)*daily_rate*(1-discount),
DATEDIFF(r.end_date, r.start_date)*daily_rate*(1-discount)*0.8)
AS DECIMAL(8,2)) - p.amount) AS 'Out_Bal'
FROM rental_records as r
INNER JOIN Vehicles as v USING(veh_reg_no)
INNER JOIN Customers as c USING(customer_id)
INNER JOIN Payments as p USING(rental_id); 
