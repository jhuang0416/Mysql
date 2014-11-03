/* 10-Similarly, list the vehicles available for rental from today for 10 days. */

SET @Future := DATE_ADD(CURDATE(), INTERVAL 10 DAY);

SELECT 
rr.veh_reg_no AS 'Registration No',
v.brand AS 'Vehicle Brand',
v.`desc` AS 'Vehicle Description'
FROM rental_records AS rr
INNER JOIN Vehicles AS v USING(veh_reg_no)
WHERE (rr.start_date BETWEEN CURDATE() AND @Future) OR 
(rr.end_date BETWEEN CURDATE() AND @Future) OR
((rr.start_date < CURDATE()) AND (rr.end_date > @Future)); 
