/* 7-Similarly, list the vehicles rented out (not available for rental) for the period from '2012-01-03' to '2012-01-18'. (Hint: start_date is inside the range; or end_date is inside the range; or start_date is before the range; or start_date is before the range and end_date is beyond the range.) */

SELECT 
rr.veh_reg_no AS 'Registration No',
c.name AS 'Customer Name',
rr.start_date AS 'Start Date',
rr.end_date AS 'End Date'
FROM rental_records as rr
WHERE (rr.start_date BETWEEN '2012-01-03' AND '2012-01-18') OR
(rr.end_date BETWEEN '2012-01-03' AND '2012-01-18') OR 
((rr.start_date < '2012-01-03') AND (rr.end_date > '2012-01-18'));
