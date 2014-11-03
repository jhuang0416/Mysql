/* 4-List all the expired rental_records (end_date before CURDATE()). */

SELECT rental_id,veh_reg_no,customer_id,start_date,end_date,lastUpdated FROM rental_records WHERE end_date < CURDATE();

--or

SELECT * FROM rental_records WHERE end_date < CURDATE();
