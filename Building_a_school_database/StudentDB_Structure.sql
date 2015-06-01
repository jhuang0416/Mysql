-- Need to enter this statement "CREATE DATABASE StudentDB;" before loading the database structure into database

CREATE TABLE IF NOT EXISTS `Classes/Subjects`
( 
  `C/S ID` INT NOT NULL AUTO_INCREMENT,
  `Class` ENUM('A','B','D') NOT NULL,
  `Subject` ENUM('E','R','S') NOT NULL,
  `Note` TEXT,
  PRIMARY KEY(`C/S ID`),
  INDEX (`Subject`)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS `Students`
(
 `StudentID` INT NOT NULL AUTO_INCREMENT,
 `LastName` TEXT NOT NULL,
 `FirstName` TEXT NOT NULL,
 `Called` TEXT NOT NULL,
 `Line` INT NOT NULL,
 `Birth Date` DATETIME NOT NULL,
 `Bus` INT NOT NULL,
 `Note` TEXT NULL,
 PRIMARY KEY (`StudentID`)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS `Assignments/Tests`
(
 `A/T ID` INT NOT NULL AUTO_INCREMENT,
 `Subject` ENUM('E','R','S') NOT NULL,
 `Type` ENUM('D daily','Q quiz','T test','B book report','W writing') NOT NULL,
 `Date Assigned` DATETIME NOT NULL,
 `Date Due` DATETIME NOT NULL,
 `Max Score` INT NOT NULL,
 `Details` TEXT NULL,
 `Grading Period` INT NOT NULL,
 `Appended` ENUM('Yes','No') NOT NULL,
 PRIMARY KEY(`A/T ID`),
 FOREIGN KEY(`Subject`) REFERENCES `Classes/Subjects`(`Subject`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = INNODB;


CREATE TABLE IF NOT EXISTS `Scores`
(
 `ScoreID` INT NOT NULL AUTO_INCREMENT,
 `A/T ID` INT NOT NULL,
 `StudentID` INT NOT NULL,
 `Name` TEXT NOT NULL,
 `C/S ID` INT NOT NULL,
 `Note` TEXT NULL,
 `Score` INT NOT NULL,
 `Details` LONGTEXT NULL,
 `Line` TEXT NOT NULL,
 `IGNORE?` TEXT NOT NULL,
 `LetterGrade` ENUM('A', 'B','C','D','F') NULL,
 `Grading Period` ENUM('1','2','3','4','5','6') NOT NULL,
 PRIMARY KEY(`ScoreID`),
 FOREIGN KEY(`A/T ID`) REFERENCES `Assignments/Tests`(`A/T ID`) ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY(`StudentID`) REFERENCES `Students`(`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY(`C/S ID`) REFERENCES `Classes/Subjects`(`C/S ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = INNODB;

DELIMITER //


/* 
A trigger in field "Note", in which contain an automatic concatenation of "<Class Type>" + " " + "<If Subject = E, put 'English' else if Subject = R, put 
'Reading' else Subject = S, put 'Spelling'>. Example: "A English". or "B Reading" or "B Spelling". 
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

SET NEW.Note = CONCAT_WS(' ',NEW.Class, S);  

END //  


/* 
A trigger to ensure or verify the due date is later than assigned date.  If Date Due is earlier than assigned, then it will return all zeroes for the field 
"Date Due" and "Date Assigned".
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

END //

DELIMITER ;


