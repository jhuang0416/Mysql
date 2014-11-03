/* 6-List all vehicles rented out today, in columns registration number, customer name, start date, and end date. */

SELECT 
rr.veh_reg_no AS 'Registration No',
c.name AS 'Customer Name',
rr.start_date AS 'Start Date',
rr.end_date AS 'End Date'
FROM rental_records as rr
INNER JOIN Vehicles as v Using(veh_reg_no)
INNER JOIN Customers as c Using(customer_id)
WHERE (CURDATE() BETWEEN rr.start_date AND rr.End_date);

