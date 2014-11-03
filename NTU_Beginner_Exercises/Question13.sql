/* 13-Staff:Keeping track of staff serving the customers.  Create a new staff table.  Assume that each transaction is handled by one staff, we can add a new column called staff_id in the rental_records table. */

DROP TABLE IF EXISTS `staff`;

CREATE TABLE `staff` (
`staff_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL DEFAULT ' ',
`title` VARCHAR(30) NOT NULL DEFAULT ' ',
`address` VARCHAR(80) NOT NULL DEFAULT ' ',
`phone` VARCHAR(15) NOT NULL DEFAULT ' ',
`report_to` INT UNSIGNED NOT NULL,
PRIMARY KEY (`staff_id`),
UNIQUE INDEX (`phone`),
INDEX (`name`),
FOREIGN KEY (`report_to`) REFERENCES `staff`(`staff_id`)
) ENGINE = InnoDB;

DESC `staff`;

SHOW INDEX FROM `staff` \G

INSERT INTO staff VALUE 
(8001, 'Peter Johns', 'Managing Director', '1 Happy Ave', '12345678', 8001);

SELECT * FROM staff;

ALTER TABLE `rental_records` ADD COLUMN `staff_id` INT UNSIGNED NOT NULL;

UPDATE `rental_records` SET `staff_id` = 8001;

ALTER TABLE `rental_records` ADD FOREIGN KEY (`staff_id`) REFERENCES staff (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

SHOW CREATE TABLE `rental_records` \G

SHOW INDEX FROM `rental_records` \G

--ALTER TABLE `Payments` ADD COLUMN `staff_id` INT UNSIGNED NOT NULL;

--INSERT INTO `Payments`
(payment_id, rental_id,amount,mode,type,remark,created_date, created_by, last_updated_date,last_updated_by,staff_id)
VALUES
(1,2,'50.00','cash','deposit','client deposited',NOW(),8001,NOW(), 8001, 8001);

--UPDATE `Payments` SET `staff_id` = 8001;

ALTER TABLE `Payments` ADD FOREIGN KEY (`staff_id`) REFERENCES staff (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

SHOW CREATE TABLE `Payments` \G

SHOW INDEX FROM `Payments` \G
