/* 3-List all rental_records (start_date, end_date) with vehicle's registration number, brand, and customer name, sorted by vehicle's categories followed by start date. */

SELECT rr.start_date,rr.end_date, v.veh_reg_no,v.brand,c.name
FROM rental_records as rr
INNER JOIN Vehicles as v ON rr.veh_reg_no = v.veh_reg_no
INNER JOIN Customers as c ON rr.customer_id = c.customer_id
ORDER BY v.category, rr.start_date; 
