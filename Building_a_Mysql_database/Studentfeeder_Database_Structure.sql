CREATE DATABASE StudentFeeder;

CREATE TABLE Member(
username VARCHAR(15) NOT NULL,
email VARCHAR(30) NOT NULL,
password CHAR(64) NOT NULL, 
datecreated DATETIME NOT NULL,
lastlogindate TIMESTAMP NOT NULL DEFAULT Current_Timestamp ON UPDATE Current_Timestamp,
password_question ENUM('What is your favorite hobby?','What is your favorite band?','Who is your best friend?', 'Which high school did you graduated from?','What is your pet name?'),
password_answer VARCHAR(30) NOT NULL,
PRIMARY KEY(username)
) Engine=InnoDB; 

CREATE TABLE School (
id INT NOT NULL AUTO_INCREMENT,
short_name VARCHAR(30) NULL,
long_name VARCHAR(50) NOT NULL,
websiteURL VARCHAR(100) NOT NULL,
PRIMARY KEY (id)
)ENGINE=InnoDB;

CREATE TABLE Profile (
first_name CHAR(30) NOT NULL,
last_name CHAR(30) NOT NULL,
interest VARCHAR(150) NULL,
DOB DATE NOT NULL,
hobbies VARCHAR(150) NULL,
imageURL VARCHAR(100) NULL,
city CHAR(25) NOT NULL,
state CHAR(3) NOT NULL,
schoolname VARCHAR(50) NOT NULL,
username VARCHAR(15) NOT NULL,
FOREIGN KEY (username) REFERENCES Member(username) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE Category (
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(25) NOT NULL,
description VARCHAR(200) NOT NULL,
imageURL VARCHAR(100) NULL,
PRIMARY KEY(id),
UNIQUE INDEX(name)
)ENGINE=InnoDB;

CREATE TABLE Article (
article_id INT NOT NULL AUTO_INCREMENT,
datecreated DATETIME NOT NULL,
createdby VARCHAR(10) NOT NULL,
ip_address VARCHAR(39) NOT NULL,
title MEDIUMTEXT NOT NULL,
teaser VARCHAR(600) NULL,
content LONGTEXT NOT NULL,
tags VARCHAR(150) NOT NULL,
viewed TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
category VARCHAR(25) NOT NULL,
visible ENUM('Yes','No'),
public_view ENUM('Yes','No'),
post_date DATE NOT NULL,
PRIMARY KEY(article_id),
FOREIGN KEY(category) REFERENCES Category(name) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE Comments (
id INT NOT NULL AUTO_INCREMENT,
article_id INT NOT NULL,
datecreated DATETIME NOT NULL,
createdby VARCHAR(15) NOT NULL, 
body TEXT NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(article_id) REFERENCES Article(article_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB;

INSERT INTO Member (username, email, password, datecreated, password_question, password_answer) VALUES
('Happy123','Looney@yahoo.com',md5('crazy'),'2014-06-08','What is your favorite hobby?','writing stories'),
('Sunshine686','charming@gmail.com',
md5('beautiful'),'2014-10-08','What is your favorite band?','lollipop'),
('Bonnie241','Bonnie241@netscape.com', md5('Bonita'), '2014-09-05', 'Which high school did you graduated from?','Pace High school'),
('Bryan481','BNg481@gmail.com', md5('damsome1'),'2014-05-08','Who is your best friend?','Shirley'),
('gloomy1114','Lunessa@aol.com', md5('Jewelry'),'2014-01-05','What is your pet name?','Straweberry');

INSERT INTO School (short_name, long_name, websiteURL) VALUES 
('NYIT','New York Institute of Technology','www.nyit.edu'),
('NYU','New York University','www.nyu.edu'),
('Columbia','Columbia University','www.columbia.edu'),
('FIT','Fashion Institute of Technology','www.fitnyc.edu'),
('Hunter College','Hunter College','www.hunter.cuny.edu');

INSERT INTO Profile (first_name,last_name,interest, DOB, hobbies, city, state, schoolname, username) VALUES
('Happy','Lewis','Writing','1995-08-01', 'writing journal entries and stories', 'Queens','NY', 'Hunter College','Happy123'),
('Sunny','Johnson','Drawing','1984-05-07','drawing and painting','Brooklyn','NY', 'Columbia University','Sunshine686'),
('Bonnie', 'Ng','Reading', '2000-05-10', 'Writing stories and reading books', 'Rego Park', 'NY', 'Columbia University','Bonnie241'),
('Bryan','Lee','Reading', '1985-07-05','reading books and mangas', 'Rego Park','NY','New York Institute of Technology','Bryan481'),
('Iris','Simmons', 'Dancing and Singing','2005-09-06','Performing on stage','Bronx', 'NY', 'New York University', 'gloomy1114');

INSERT INTO Category (name,description) VALUES
('NYC Crime','Crimes happened around the world'),
('Entertainment','Celebritites and gossips'),
('Politics','Government events and information'),
('Sports','Sports around world, such as baskeball, baseball, etc'),
('Travels', 'Traveling around the world');

INSERT INTO Article (datecreated, createdby, ip_address, title, teaser, content,tags, category, visible, public_view, post_date) VALUES
('2014-11-01','Happy123','52.256.64.51','Bellevue Ebola patient upgraded to stable conditions: officials','Dr. Craig Spencer is now in stable condition after being in serious condition.  He is still being quarantined and receiving full treatment.','The condition of the doctor being treated for Ebola at Bellevue Hospital has been upgraded to stable\, city officials said Saturday.  Dr. Craig Spencer\, a 33-year-old Doctors Without Borders physician who contracted the disease during a mission in West Africa\, will still be quarantined\, officials said.  Based on our patient\’s clinical progress and response to treatment\, today HHC is updating his condition to \‘stable\’ from \‘serious but stable\,read a statement from New York City Health and Hospitals Corporation. The patient will remain in isolation and continue to receive full treatment.','Ebola','Travels','Yes', 'Yes', '2014-11-01'),
('2014-11-01','Bonnie241','34.458.26.58','Woman hit-killed by Bronx subway car','The woman apparently peered over the edge of the platform and was struck in the head.','A 63-year-old woman was clipped by a Bronx subway car and killed Friday after she peered over the platform to see if tdhe train was coming\, authorities said.  The unidentified woman suffered a massive head injury when the northbound 4 train smacked into her at the 167th Street station near River Avenue in Highbridge just after 7:45 p.m.  Paramedics were called\, but the woman died at the station\, officials said. Her name wasn\'t immediately released.  Witnesses said the woman was staggering along the edge of the platform before she was hit\, according to police sources.','train accidents', 'Travels','Yes','Yes', '2014-11-01'); 

INSERT INTO Comments (article_id, datecreated, createdby, body) VALUES
('2',NOW(), 'Bryan481', 'It was not MTA\'s fault.  The woman was supposed to stand behind the platform and wait for the train.'),
('1',NOW(), 'Sunshine686', 'I am happy for Dr. Craig Spencer.');














