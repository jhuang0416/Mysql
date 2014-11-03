/* 5-List the vehicles rented out on '2012-01-10'(not available for rental), in columns of vehicle registration no, customer name, start date, and end date. (Hint: the given date is in between the start_date and end_date) */

SELECT 
rr.veh_reg_no AS 'Vehicle No',
c.name AS 'Customer Name',
rr.start_date AS 'Start Date', 
rr.end_date AS 'End Date' 
FROM rental_records as rr 
INNER JOIN Vehicles As v USING(veh_reg_no)
INNER JOIN Customers As c USING(customer_id)
WHERE ('2012-01-10' BETWEEN rr.start_date and rr.end_date); 

