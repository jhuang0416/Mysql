/* 8-List the vehicles (registration number,brand, and description) available for rental(not rented out) on '2012-01-10' (Hint: You can use a subquery based on a earlier query). */

SELECT 
rr.veh_reg_no AS 'Registration No',
v.brand AS 'Vehicle Brand',
v.`desc` AS 'Vehicle Description'
FROM rental_records AS rr
INNER JOIN Vehicles as v Using(veh_reg_no)
WHERE NOT ('2012-01-10' BETWEEN rr.start_date AND rr.end_date); 
