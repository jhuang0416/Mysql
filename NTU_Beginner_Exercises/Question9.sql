/* 9-Similarly, list the vehicles available for rental for the period from '2012-01-03' to '2012-01-18'. */

SELECT 
rr.veh_reg_no AS 'Registration No',
v.brand AS 'Vehicle Brand',
v.`desc` AS 'Vehicle Description'
FROM rental_records as rr
INNER JOIN Vehicles as v USING(veh_reg_no)
WHERE NOT ((rr.start_date BETWEEN '2012-01-03' AND '2012-01-18') OR
(rr.end_date BETWEEN '2012-01-03' AND '2012-01-18') OR 
((rr.start_date < '2012-01-03') AND (rr.end_date > '2012-01-18')));

