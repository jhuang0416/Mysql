INSERT INTO `Classes/Subjects`(`C/S ID`,`Class`,`Subject`)
VALUES
('54320','A','E'),
('54321','A','R'),
('54322','A','S'),
('54323','B','E'),
('54324','B','R'),
('54325','B','S'),
('54326','D','E'),
('54327','D','R'),
('54328','D','S');

INSERT INTO `Students`(`StudentID`,`LastName`,`FirstName`,`Called`,`Line`,`Birth Date`,`Bus`,`Note`)
VALUES
('2225897','Brown','Joan','Joannie','1','1997-10-15','15','She is smart and diligent'),
('5254870','Liang','Wendy','Wind','1','2000-06-19','68','She is always late to Class'),
('6442842','Rodriguez','Bonnie','Bon Bon','1','2005-10-11','6','She disrupts her class numerous times'),
('4321584','Johnson','Vivian','Vi Vi','1','1984-05-10','8','She is quiet and detail-oriented'),
('8492436','Young','Priscilla','Prisky','1','2001-01-04','41','She does not hand in homework and assignments on time');

INSERT INTO `Assignments/Tests`(`Subject`,`Type`,`Date Assigned`,`Date Due`,`Max Score`,`Details`,`Grading Period`,`Appended`)
VALUES 
('E','B book report','2014-08-05 03:30:00','2014-08-20 03:30:00','100', 'Write a book report on one of the five books','2','Yes'),
('E','W writing','2014-09-10 02:45:00','2014-09-15 02:45:00', '100','Write an essay on your future dream','4','No'),
('R','T test','2014-09-03 03:15:00','2014-09-03 04:15:00','100','Open-book Test','5','No'),
('S','Q quiz','2014-09-15 02:45:00','2014-09-15 3:00:00','100','Unscrambling the words','2','Yes'),
('E','W writing','2014-10-20 01:30:00','2014-11-10 01:30:00','100','Write a research paper on your chosen topic','1','No'); 

INSERT INTO `Scores`(`A/T ID`,`StudentID`,`Name`,`C/S ID`,`Score`,`Details`,`Line`,`Ignore?`,`LetterGrade`, `Grading Period`)
VALUES
('1','5254870','Book report','54323','80','Write a book report on one of the five books','1','No','B','2'),
('2','6442842','Essay','54325','100','Write an essay on your future dream','2','No','A','2'),
('3','4321584','Midterm','54326','85','Midterm 2014','3','No','B','5'),
('4','8492436','Quiz#1','54328','65','Quiz #1','4','Yes','D','2'),
('5','2225897','Research','54322','85','Write a research paper on Socrates','5','No','B','1');

