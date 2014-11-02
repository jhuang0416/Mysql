/* 4-Define more views. */

/*Select all customers rented the following car 'SBA1111A'. */

CREATE VIEW rental_SBA1111A
AS
SELECT 
r.rental_id AS 'Rental ID',
c.customer_id AS 'Customer ID',
c.name AS 'Customer Name',
DATEDIFF(r.end_date,r.start_date) AS 'Duration'
FROM rental_records AS r
INNER JOIN Customers as c USING(customer_id)
WHERE veh_reg_no = 'SBA1111A';

/*Select all records of rentals by 'Tan Ah Teck'. */

CREATE VIEW rentals_Tan
AS 
SELECT 
r.rental_id AS 'Rental_id',
r.start_date AS 'Start Date',
r.end_date AS 'End Date',
r.veh_reg_no AS 'Registration No'
FROM rental_records as r
INNER JOIN Customers AS c USING(customer_id)
WHERE c.name = 'Tan Ah Teck';

