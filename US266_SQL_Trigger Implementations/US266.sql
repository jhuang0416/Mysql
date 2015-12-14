/* 
Revisit the code implementation of the following user stories, and implement SQL triggers.

    *Build a school database - US116, US209, US229, US236, US93, US215, US237, US230, US210, US216, US117
        -Verify that the acceptance criteria has been met in the above stories.
        -Implement Triggers.
*/

CREATE DATABASE StudentFeeder;

USE StudentFeeder;

CREATE TABLE IF NOT EXISTS Member (
username VARCHAR(15) NOT NULL,
email VARCHAR(30) NOT NULL,
password VARCHAR(64) NOT NULL,
datecreated DATETIME NOT NULL,
lastlogindate DATETIME NOT NULL,
`password question` ENUM('What is your favorite hobby?','What is your favorite band?','Who is your best friend?','Which high school did you graduated from?','What is your pet name?'),
`password answer` VARCHAR(30) NOT NULL,
PRIMARY KEY(username),
UNIQUE INDEX(email)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS School (
ID INT NOT NULL AUTO_INCREMENT,
`short name` VARCHAR(30) NOT NULL,
`long name` VARCHAR(50) NOT NULL,
`website URL` VARCHAR(100) NOT NULL,
PRIMARY KEY(ID),
UNIQUE KEY(`short name`),
UNIQUE INDEX(`long name`)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS Profile (
`first name` VARCHAR(30) DEFAULT NULL,
`last name` VARCHAR(30) DEFAULT NULL,
interest VARCHAR(150) DEFAULT NULL,
dob DATE DEFAULT '0000-00-00',
hobbies VARCHAR(150) DEFAULT NULL,
imageurl VARCHAR(100) DEFAULT NULL,
city VARCHAR(25) DEFAULT NULL,
state CHAR(3) DEFAULT NULL,
school VARCHAR(50) DEFAULT NULL,
username VARCHAR(15) NOT NULL,
FOREIGN KEY(username) REFERENCES Member(username) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS Category (
ID INT NOT NULL AUTO_INCREMENT,
name VARCHAR(25) NOT NULL,
description TINYTEXT NOT NULL,
imageurl VARCHAR(100) DEFAULT NULL,
PRIMARY KEY(ID),
UNIQUE INDEX(name)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS Article (
`article ID` INT NOT NULL AUTO_INCREMENT,
datecreated DATETIME NOT NULL,
createdby VARCHAR(30) NOT NULL,
`IP address` VARCHAR(39) NOT NULL,
title VARCHAR(250) NOT NULL,
teaser TINYTEXT DEFAULT NULL,
content LONGTEXT NOT NULL,
tags VARCHAR(150) NOT NULL,
viewed DATETIME DEFAULT NULL,
category VARCHAR(25) NOT NULL,
visible ENUM('Yes', 'No') DEFAULT 'No',
`public view` ENUM('Yes','No') DEFAULT 'No',
`post date` DATETIME NOT NULL,
PRIMARY KEY(`article ID`),
FOREIGN KEY(category) REFERENCES Category(name) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS Comments (
ID INT NOT NULL AUTO_INCREMENT,
`article ID` INT NOT NULL,
datecreated DATETIME NOT NULL,
createdby VARCHAR(30) NOT NULL,
body MEDIUMTEXT NOT NULL,
PRIMARY KEY(ID),
FOREIGN KEY(`article ID`) REFERENCES Article(`article ID`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = INNODB;

-------------------------------TRIGGERS----------------------------------------

DELIMITER $$

/* A trigger for inserting input into "datecreated" and "lastlogindate" fields automatically. */

CREATE
DEFINER = `root`@`127.0.0.1`
TRIGGER before_insert_Member
BEFORE INSERT ON `StudentFeeder2`.`Member` FOR EACH ROW
BEGIN
SET NEW.datecreated = NOW();
SET NEW.lastlogindate = NOW();
END$$

/* A trigger for inserting a record automatically in the "Profile" table after inserting a record in the "Member" table. */

CREATE
DEFINER = `root`@`127.0.0.1`
TRIGGER after_insert_Member
AFTER INSERT ON `StudentFeeder2`.`Member` FOR EACH ROW
BEGIN
INSERT INTO `StudentFeeder2`.`Profile`(username) VALUES (NEW.username);
END$$

/* A trigger for automatic capitalization of new inputs in the "short name" and "long name" fields on "School" table. */

CREATE
DEFINER = `root`@`127.0.0.1`
TRIGGER before_insert_School
BEFORE INSERT ON `StudentFeeder2`.`School` FOR EACH ROW
BEGIN
SET NEW.`short name` = UPPER(NEW.`short name`);
SET NEW.`long name` = UPPER(NEW.`long name`);
END$$

/* A trigger for automatic capitalization of new input in the "state" field on "Profile" table. */

CREATE
DEFINER = `root`@`127.0.0.1`
TRIGGER before_update_Profile
BEFORE UPDATE ON `StudentFeeder2`.`Profile` FOR EACH ROW
BEGIN
SET NEW.state = UPPER(NEW.state);
END$$

/* A trigger for automatic capitalization of new input in the "name" field on "Category" table. */

CREATE
DEFINER = `root`@`127.0.0.1`
TRIGGER before_insert_Category
BEFORE INSERT ON `StudentFeeder2`.`Category` FOR EACH ROW
BEGIN
SET NEW.name = UPPER(NEW.name);
END$$

/* A trigger for automatic insertion in "datecreated", "createdby", and "post date" fields on "Article" table. */

CREATE
DEFINER = `root`@`127.0.0.1`
TRIGGER before_insert_Article
BEFORE INSERT ON `StudentFeeder2`.`Article` FOR EACH ROW
BEGIN
SET NEW.datecreated = NOW();
SET NEW.createdby = CURRENT_USER();
SET NEW.`post date` = NOW();
END$$

/* A trigger for automatic insertion in "datecreated" and "createdby" fields on "Comments" table. */

CREATE
DEFINER = `root`@`127.0.0.1`
TRIGGER before_insert_Comments
BEFORE INSERT ON `StudentFeeder2`.`Comments` FOR EACH ROW
BEGIN
SET NEW.datecreated = NOW();
SET NEW.createdby = CURRENT_USER();
END$$

DELIMITER ;

--------------------------------- Records-----------------------------------------------

INSERT INTO Member (username, email, password, `password question`, `password answer`) VALUES
('Happy123','Looney@yahoo.com',md5('crazy'),'What is your favorite hobby?','writing stories'); 

INSERT INTO Member (username, email, password, `password question`, `password answer`) VALUES
('Sunshine686','charming@gmail.com',md5('beautiful'),'What is your favorite band?','lollipop');

INSERT INTO Member (username, email, password, `password question`, `password answer`) VALUES
('Bonnie241','Bonnie241@netscape.com', md5('Bonita'),'Which high school did you graduated from?','Pace High school');

INSERT INTO Member (username, email, password, `password question`, `password answer`) VALUES
('Bryan481','BNg481@gmail.com', md5('damsome1'),'Who is your best friend?','Shirley');

INSERT INTO Member (username, email, password, `password question`, `password answer`) VALUES
('gloomy1114','Lunessa@aol.com', md5('Jewelry'),'What is your pet name?','Straweberry');

INSERT INTO School (`short name`, `long name`, `website URL`) VALUES
('NYIT','New York Institute of Technology','www.nyit.edu');

INSERT INTO School (`short name`, `long name`, `website URL`) VALUES
('NYU','New York University','www.nyu.edu');

INSERT INTO School (`short name`, `long name`, `website URL`) VALUES
('Columbia','Columbia University','www.columbia.edu');

UPDATE Profile SET `first name` = 'Happy', `last name` = 'Lewis', interest = 'Writing', dob = '1995-08-01', hobbies = 'writing journal entries and stories', city = 'Queens', state = 'NY', school = 'Hunter College' WHERE username = 'Happy123';
UPDATE Profile SET `first name` = 'Sunny', `last name` = 'Johnson', interest = 'Drawing', dob = '1984-05-07', hobbies = 'drawing and painting', city = 'Brooklyn', state = 'NY', school = 'Columbia University' WHERE username = 'Sunshine686';
UPDATE Profile SET `first name` = 'Bonnie', `last name` = 'Ng', interest = 'Reading', dob = '2000-05-10', hobbies = 'Writing stories and reading books', city = 'Rego Park', state = 'NY', school = 'Columbia University' WHERE username = 'Bonnie241';
UPDATE Profile SET `first name` = 'Bryan', `last name` = 'Lee', interest = 'Reading', dob = '1985-07-05', hobbies = 'reading books and mangas', city = 'Rego Park', state = 'NY', school = 'New York Institute of Technology' WHERE username = 'Bryan481';
UPDATE Profile SET `first name` = 'Iris', `last name` = 'Simmons', interest = 'Dancing and Singing', dob = '2005-09-06', hobbies = 'Performing on stage', city = 'Bronx', state = 'NY', school = 'New York University' WHERE username = 'gloomy1114';

INSERT INTO Category (name, description) VALUES
('NYC Crime','Crimes happened around the world'); 

INSERT INTO Category (name, description) VALUES
('Entertainment','Celebritites and gossips');

INSERT INTO Category (name, description) VALUES
('Politics','Government events and information');

INSERT INTO Category (name, description) VALUES
('Sports','Sports around world, such as baskeball, baseball, etc');

INSERT INTO Category (name, description) VALUES
('Travels', 'Traveling around the world');

INSERT INTO Article (`IP address`, title, teaser, content, tags, category) VALUES
('52.256.64.51','Bellevue Ebola patient upgraded to stable conditions: officials','Dr. Craig Spencer is now in stable condition after being in serious condition.  He is still being quarantined and receiving full treatment.','The condition of the doctor being treated for Ebola at Bellevue Hospital has been upgraded to stable\, city officials said Saturday.  Dr. Craig Spencer\, a 33-year-old Doctors Without Borders physician who contracted the disease during a mission in West Africa\, will still be quarantined\, officials said.  Based on our patient\’s clinical progress and response to treatment\, today HHC is updating his condition to \‘stable\’ from \‘serious but stable\,read a statement from New York City Health and Hospitals Corporation. The patient will remain in isolation and continue to receive full treatment.','Ebola','Travels');

INSERT INTO Comments (`article ID`, body) VALUES
('1','I am happy for Dr. Craig Spencer.');

------------------------ MySQL Tests For Demo-----------------------------------------------

INSERT INTO Member (username, email, password, `password question`, `password answer`) VALUES
('Bunny1234', 'Hopping24@yahoo.com', md5('Cute_White'), 'Who is your best friend?', 'Erica'); 

SELECT * FROM Member\G

SELECT * FROM Profile\G

INSERT INTO School (`short name`, `long name`, `website URL`) VALUES
('fit','Fashion Institute of Technology','www.fitnyc.edu');

SELECT * FROM School;

UPDATE Profile SET state = 'ny' WHERE username = 'gloomy1114';

SELECT * FROM  Profile\G

INSERT INTO Category (name, description) VALUES
('Investment','Stocks and Funding Tips');

SELECT * FROM Category\G

INSERT INTO Article (`IP address`, title, teaser, content, tags, category) VALUES
('34.458.26.58','Woman hit-killed by Bronx subway car','The woman apparently peered over the edge of the platform and was struck in the head.','A 63-year-old woman was clipped by a Bronx subway car and killed Friday after she peered over the platform to see if tdhe train was coming\, authorities said.  The unidentified woman suffered a massive head injury when the northbound 4 train smacked into her at the 167th Street station near River Avenue in Highbridge just after 7:45 p.m.  Paramedics were called\, but the woman died at the station\, officials said. Her name wasn\'t immediately released.  Witnesses said the woman was staggering along the edge of the platform before she was hit\, according to police sources.','train accidents', 'Travels');

SELECT * FROM Article\G

INSERT INTO Comments (`article ID`, body) VALUES
('2','It was not MTA\'s fault.  The woman was supposed to stand behind the platform and wait for the train.');

SELECT * FROM Comments\G


