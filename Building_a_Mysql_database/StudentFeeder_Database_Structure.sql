CREATE TABLE IF NOT EXISTS Member(
username VARCHAR(15) NOT NULL,
email VARCHAR(30) NOT NULL,
password CHAR(32) NOT NULL, 
datecreated DATETIME NOT NULL,
lastlogindate TIMESTAMP NOT NULL DEFAULT Current_Timestamp ON UPDATE Current_Timestamp,
password_question ENUM('What is your favorite hobby','What is your favorite band?','Who is your best friend?', 'Which high school did you graduated from?','What is your pet name?'),
password_answer VARCHAR(30) NOT NULL,
PRIMARY KEY(username)
) Engine=InnoDB; 

CREATE TABLE IF NOT EXISTS School (
id INT NOT NULL AUTO_INCREMENT,
short_name VARCHAR(30) NULL,
long_name VARCHAR(50) NOT NULL,
websiteURL VARCHAR(100) NOT NULL,
PRIMARY KEY (id)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Profile (
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

CREATE TABLE IF NOT EXISTS Category (
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(25) NOT NULL,
description VARCHAR(200) NOT NULL,
imageURL VARCHAR(100) NOT NULL,
PRIMARY KEY(id),
UNIQUE INDEX(name)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Article (
article_id INT NOT NULL AUTO_INCREMENT,
datecreated DATE NOT NULL,
createdby VARCHAR(10) NOT NULL,
ip_address VARCHAR(39) NOT NULL,
title VARCHAR(50) NOT NULL,
teaser VARCHAR(600) NULL,
content TEXT NOT NULL,
tags VARCHAR(150) NOT NULL,
viewed TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
category VARCHAR(25) NOT NULL,
visible ENUM('Yes','No'),
public_view ENUM('Yes','No'),
post_date DATE NOT NULL,
PRIMARY KEY(article_id),
FOREIGN KEY(category) REFERENCES Category(name) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Comments (
id INT NOT NULL AUTO_INCREMENT,
article_id INT NOT NULL,
datecreated DATE NOT NULL,
createdby VARCHAR(15) NOT NULL, 
body TEXT NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(article_id) REFERENCES Article(article_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB;











