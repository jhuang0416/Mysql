/* 12-Payments: A rental could be paid over a number of payments (e.g.,deposit, installments,full payment).  Each payment is for one rental.  Create a new table called payments.  Need to create columns to facilitate proper audit check (such as create_date, create_by, last_update_date, last_update_by,etc). */

DROP TABLE IF EXISTS `payments`;

CREATE TABLE Payments (
`payment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
`rental_id` INT UNSIGNED NOT NULL,
`amount` DECIMAL(8,2) NOT NULL DEFAULT 0,
`mode` ENUM('cash', 'credit card', 'check'),
`type` ENUM('deposit', 'partial', 'full') NOT NULL DEFAULT 'full',
`remark` VARCHAR(255),
`created_date` DATETIME NOT NULL,
`created_by` INT UNSIGNED NOT NULL,  
`last_updated_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
`last_updated_by` INT UNSIGNED NOT NULL,
PRIMARY KEY(`payment_id`),
INDEX (`rental_id`),
FOREIGN KEY (`rental_id`) REFERENCES rental_records(`rental_id`)
) ENGINE = InnoDB;

DESC `payments`;

SHOW CREATE TABLE `payments` \G

SHOW INDEX FROM `payments` \G
