/* 1-Adding Photo: We could store photo in MySQL using data type of BLOB (Binary Large Object)(up to 64KB), MEDIUMBLOB (up to 16MBytes), LONGBOLB(up to 4GBytes).  For example, you can conveniently load and view the photo via graphical tools such as MYSQL Workbench.  To load a image in MySQL Workbench => right click on the cell => Load Value From File => Select the image file.  To view the image => right click on the BLOB cell => Open Value in Editor => choose "image" pane. */

UPDATE Vehicles SET photo=LOAD_FILE('/var/lib/mysql/images/Car2.jpg') WHERE veh_reg_no = 'SBA1111A';

SELECT * FROM Vehicles WHERE veh_reg_no = 'SBA1111A' \G
