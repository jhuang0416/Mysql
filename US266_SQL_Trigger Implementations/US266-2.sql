/* 
Revisit the code implementation of the following user stories, and implement SQL triggers.

       *Build a MYSQL Database - US103, US96, US114, US104, US58, US115
    	-Verify that the acceptance criteria has been met in the above stories.
    	-Implement Triggers. 
*/

CREATE DATABASE StudentDB;

USE StudentDB;

CREATE TABLE IF NOT EXISTS `Classes/Subjects` (
`C/S ID` INT AUTO_INCREMENT,
`Class` ENUM('A','B','D') NOT NULL,
`Subject` ENUM('E','R','S') NOT NULL,
`Note` TEXT,
PRIMARY KEY(`C/S ID`),
INDEX(`Subject`)
)ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS `Students` (
`StudentID` INT AUTO_INCREMENT,
`LastName` TEXT NOT NULL,
`FirstName` TEXT NOT NULL,
`Called` TEXT NOT NULL,
`Line` INT NOT NULL,
`Birth Date` DATETIME NOT NULL,
`Bus` INT NOT NULL,
`Note` TEXT DEFAULT NULL,
PRIMARY KEY(`StudentID`)
)ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS `Assignments/Tests` (
`A/T ID` INT AUTO_INCREMENT,
`Subject` ENUM('E','R','S') NOT NULL,
`Type` ENUM('D daily','Q quiz','T test','B book report','W writing') NOT NULL,
`Date Assigned` DATETIME NOT NULL,
`Date Due` DATETIME NOT NULL,
`Max Score` INT NOT NULL,
`Details` TEXT DEFAULT NULL,
`Grading Period` INT NOT NULL,
`Appended` ENUM('Yes','No') DEFAULT 'Yes',
PRIMARY KEY(`A/T ID`),
FOREIGN KEY(`Subject`) REFERENCES `Classes/Subjects`(`Subject`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS `Scores` (
`ScoreID` INT NOT NULL AUTO_INCREMENT,
`A/T ID` INT,
`StudentID` INT,
`Name` TEXT DEFAULT NULL,
`C/S ID` INT,
`Note` TEXT DEFAULT NULL,
`Score` INT DEFAULT NULL,
`Details` LONGTEXT DEFAULT NULL,
`Line` TEXT DEFAULT NULL,
`Ignore?` TEXT DEFAULT NULL,
`LetterGrade` ENUM('A','B','C','D','F') DEFAULT NULL,
`GradingPeriod` ENUM('1','2','3','4','5','6') DEFAULT NULL,
PRIMARY KEY(`ScoreID`),
FOREIGN KEY(`A/T ID`) REFERENCES `Assignments/Tests`(`A/T ID`) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(`StudentID`) REFERENCES `Students`(`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(`C/S ID`) REFERENCES `Classes/Subjects`(`C/S ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = INNODB;

--------------------- TRIGGERS-------------------------

DELIMITER //

/* 
A trigger in field "Note", in which contain an automatic concatenation of "<Class Type>" + " " + "<If Subject = E, put 'English' else if Subject = R, put 
'Reading' else Subject = S, put 'Spelling'>. Example: "A English". or "B Reading" or "B Spelling".  Additionally, automatic capitalization of the input in 
the "Subject" field.
*/

CREATE TRIGGER CS_Note BEFORE INSERT ON `Classes/Subjects`
FOR EACH ROW
BEGIN

DECLARE S VARCHAR(15);
DECLARE Sub VARCHAR(1);

SET Sub = NEW.Subject;

IF (Sub = 'E')
THEN SET S = 'English';
ELSEIF (Sub = 'R')
THEN SET S = 'Reading';
ELSE
SET S = 'Spelling';
END IF;

SET NEW.`Note` = CONCAT_WS(' ',UPPER(NEW.Class), S);  
SET NEW.`Subject` = UPPER(NEW.`Subject`);

END //  


/* 
A trigger to ensure or verify the due date is later than assigned date.  If Date Due is earlier than assigned, then it will return all zeroes for the field 
"Date Due" and "Date Assigned".  Additionally, automatic capitalization of the input for the "Subject" field.  
*/


CREATE TRIGGER Date_Verification BEFORE INSERT ON `Assignments/Tests`
FOR EACH ROW
BEGIN

IF ((NEW.`Date Due`) < (NEW.`Date Assigned`))
THEN
SET NEW.`Date Assigned` = '0000-00-00 00:00:00';
SET NEW.`Date Due` = '0000-00-00 00:00:00';
ELSE
SET NEW.`Date Assigned` = NEW.`Date Assigned`;
SET NEW.`Date Due` = NEW.`Date Due`;
END IF;

SET NEW.`Subject` = UPPER(NEW.`Subject`);

END //

/* 
A trigger for inserting a record automatically in the "Scores" table after inserting a record in the "Students" table.
*/

CREATE 
DEFINER = `root`@`127.0.0.1`
TRIGGER After_Insert_Students AFTER INSERT ON `Students` FOR EACH ROW
BEGIN
INSERT INTO `Scores`(`StudentID`) VALUES (NEW.`StudentID`);
END //


/*
A trigger for updating the "Line","LetterGrade",and "Note" fields automatically based on the "score" value.
*/

CREATE TRIGGER BEFORE_UPDATE_Scores BEFORE UPDATE ON `Scores`
FOR EACH ROW
BEGIN

IF(NEW.`Score` >= 90) THEN 
SET NEW.`Line` = "Congrulations!  You did an excellent job."; 
SET NEW.`LetterGrade` = "A";
SET NEW.`Note` = "Advanced, Exceed Standards";
ELSEIF((NEW.`Score` >= 80) && (NEW.`Score` < 90)) THEN 
SET NEW.`Line` = "Congrulations!  You did a satisfactory job.";
SET NEW.`LetterGrade` = "B";
SET NEW.`Note` = "Meets Standards";
ELSEIF((NEW.`Score` >= 70) && (NEW.`Score` < 80)) THEN
SET NEW.`Line` = "You did Mediocre job.";
SET NEW.`LetterGrade` = "C";
SET NEW.`Note` = "Partially Proficient";
ELSEIF((NEW.`Score` >= 60) && (NEW.`Score` < 70)) THEN 
SET NEW.`Line` = "You did an insufficient job.";
SET NEW.`LetterGrade` = "D";
SET NEW.`Note` = "Not Proficient";
ELSE
SET NEW. `Line` = "You have failed the assignment or test.  You need to redo or retake the assignment or test.";
SET NEW.`LetterGrade` = "F";
SET NEW.`Note` = "Failure";
END IF;
END //

DELIMITER ;

-- ---------Records----------------------------

INSERT INTO `Classes/Subjects`(`C/S ID`,`Class`,`Subject`) VALUES
('54320','A','E');

INSERT INTO `Classes/Subjects`(`C/S ID`,`Class`,`Subject`) VALUES
('54321','A','R');

INSERT INTO `Classes/Subjects`(`C/S ID`,`Class`,`Subject`) VALUES
('54322','A','S');

INSERT INTO `Classes/Subjects`(`C/S ID`,`Class`,`Subject`) VALUES
('54323','B','E');

INSERT INTO `Classes/Subjects`(`C/S ID`,`Class`,`Subject`) VALUES
('54324','B','R');

INSERT INTO `Classes/Subjects`(`C/S ID`,`Class`,`Subject`) VALUES
('54325','B','S');

INSERT INTO `Classes/Subjects`(`C/S ID`,`Class`,`Subject`) VALUES
('54326','D','E');

INSERT INTO `Classes/Subjects`(`C/S ID`,`Class`,`Subject`) VALUES
('54327','D','R');


INSERT INTO `Students`(`StudentID`,`LastName`,`FirstName`,`Called`,`Line`,`Birth Date`,`Bus`,`Note`) VALUES
('2225897','Brown','Joan','Joannie','1','1997-10-15','15','She is smart and diligent');

INSERT INTO `Students`(`StudentID`,`LastName`,`FirstName`,`Called`,`Line`,`Birth Date`,`Bus`,`Note`) VALUES
('5254870','Liang','Wendy','Wind','1','2000-06-19','68','She is always late to Class');

INSERT INTO `Students`(`StudentID`,`LastName`,`FirstName`,`Called`,`Line`,`Birth Date`,`Bus`,`Note`) VALUES
('6442842','Rodriguez','Bonnie','Bon Bon','1','2005-10-11','6','She disrupts her class numerous times');

INSERT INTO `Students`(`StudentID`,`LastName`,`FirstName`,`Called`,`Line`,`Birth Date`,`Bus`,`Note`) VALUES
('4321584','Johnson','Vivian','Vi Vi','1','1984-05-10','8','She is quiet and detail-oriented');



INSERT INTO `Assignments/Tests`(`Subject`,`Type`,`Date Assigned`,`Date Due`,`Max Score`,`Details`,`Grading Period`,`Appended`) VALUES 
('e','B book report','2014-08-05 03:30:00','2014-08-20 03:30:00','100', 'Write a book report on one of the five books','2','Yes');

INSERT INTO `Assignments/Tests`(`Subject`,`Type`,`Date Assigned`,`Date Due`,`Max Score`,`Details`,`Grading Period`,`Appended`) VALUES 
('E','W writing','2014-09-10 02:45:00','2014-09-15 02:45:00', '100','Write an essay on your future dream','4','No');

INSERT INTO `Assignments/Tests`(`Subject`,`Type`,`Date Assigned`,`Date Due`,`Max Score`,`Details`,`Grading Period`,`Appended`) VALUES 
('R','T test','2014-09-03 03:15:00','2014-09-03 04:15:00','100','Open-book Test','5','No');

INSERT INTO `Assignments/Tests`(`Subject`,`Type`,`Date Assigned`,`Date Due`,`Max Score`,`Details`,`Grading Period`,`Appended`) VALUES 
('S','Q quiz','2014-09-15 02:45:00','2014-09-15 3:00:00','100','Unscrambling the words','2','Yes');

INSERT INTO `Assignments/Tests`(`Subject`,`Type`,`Date Assigned`,`Date Due`,`Max Score`,`Details`,`Grading Period`,`Appended`) VALUES 
('e','Q quiz','2014-09-15 02:45:00','2014-08-15 3:00:00','100','Spell the word','2','Yes');


UPDATE `Scores` SET `A/T ID` = 1, `Name` = CONCAT('Liang',',','Wendy'), `C/S ID` = '54323', `Score` = 80, 
`Details` = 'Book report-Write a book report on one of the five books', `Ignore?` = 'No', `GradingPeriod` = 2 WHERE `StudentID` = 5254870;

UPDATE `Scores` SET `A/T ID` = 2, `Name` = CONCAT('Rodriguez',',','Bonnie'), `C/S ID` = '54325', `Score` = 100, 
`Details` = 'Essay-Write an essay on your future dream', `Ignore?` = 'No', `GradingPeriod` = 2 WHERE `StudentID` = 6442842;

UPDATE `Scores` SET `A/T ID` = 3, `Name` = CONCAT('Johnson',',','Vivian'), `C/S ID` = '54326', `Score` = 85, 
`Details` = 'Midterm 2014', `Ignore?` = 'No', `GradingPeriod` = 5 WHERE `StudentID` = 4321584;

UPDATE `Scores` SET `A/T ID` = 4, `Name` = CONCAT('Brown', ',','Joan'), `C/S ID` = '54322', `Score` = 65, 
`Details` = 'Research-Write a research paper on Socrates', `Ignore?` = 'No', `GradingPeriod` = 1 WHERE `StudentID` = 2225897;


-- ---------------------- MySQL Tests For Demo-----------------------------------------------

-- Trigger Before_Insert_CS

INSERT INTO `Classes/Subjects`(`C/S ID`,`Class`,`Subject`) VALUES
('54328','d','s');

SELECT * FROM `Classes/Subjects`;

-- Trigger After_Insert_Students

INSERT INTO `Students`(`StudentID`,`LastName`,`FirstName`,`Called`,`Line`,`Birth Date`,`Bus`,`Note`) VALUES
('8492436','Young','Priscilla','Prisky','1','2001-01-04','41','She does not hand in homework and assignments on time');

SELECT * FROM `Students`\G

SELECT * FROM `Scores`\G

-- Trigger Date_Verification

INSERT INTO `Assignments/Tests`(`Subject`,`Type`,`Date Assigned`,`Date Due`,`Max Score`,`Details`,`Grading Period`,`Appended`) VALUES 
('e','W writing','2014-09-20 01:30:00','2014-08-10 01:30:00','100','Write a research paper on your chosen topic','1','No'); 

SELECT * FROM `Assignments/Tests`\G

-- Trigger Before_UPdate_Scores

UPDATE `Scores` SET `A/T ID` = 5, `Name` = CONCAT('Young',',', 'Priscilla'), `C/S ID` = '54328', `Score` = 59, 
`Details` = 'Quiz #1', `Ignore?` = 'No', `GradingPeriod` = 2 WHERE `StudentID` = 8492436;

SELECT * FROM `Scores`\G








