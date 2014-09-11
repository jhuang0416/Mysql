DROP TABLE IF EXISTS t1, t2;

CREATE TABLE t1 (
id INT PRIMARY KEY,
`desc` VARCHAR(30)); 

CREATE TABLE t2 (
id INT PRIMARY KEY,
`desc` VARCHAR(30));

INSERT INTO t1 VALUES 
(1,'ID 1 in t1'),
(2,'ID 2 in t1'),
(3,'ID 3 in t1');

INSERT INTO t2 VALUES
(2,'ID 2 in t2'),
(3,'ID 3 in t2'),
(4,'ID 4 in t2');

SELECT * FROM t1;

SELECT * FROM t2;

SELECT * FROM t1 INNER JOIN t2; 

SELECT * FROM t1 INNER JOIN t2 ON t1.id = t2.id;

SELECT * FROM t1 JOIN t2 ON t1.id = t2.id;

SELECT * FROM t1 CROSS JOIN t2 ON t1.id = t2.id;

SELECT * FROM t1 INNER JOIN t2 USING (id);

SELECT * FROM t1,t2 WHERE t1.id = t2.id;



SELECT * FROM t1 LEFT JOIN t2 ON t1.id = t2.id;

SELECT * FROM t1 LEFT JOIN t2 USING (id);

SELECT * FROM t1 RIGHT JOIN t2 ON t1.id = t2.id;

SELECT * FROM t1 RIGHT JOIN t2 USING (id); 

SELECT t1.id, t1.desc
FROM t1 LEFT JOIN t2 USING (id)
WHERE t2.id IS NULL;

SELECT * FROM t1 LEFT JOIN t2 ON t1.id = t2.id;

SELECT * FROM t1 LEFT OUTER JOIN t2 ON t1.id = t2.id;

SELECT * FROM t1 LEFT JOIN t2 USING (id);

SELECT * FROM t1 LEFT JOIN t2 WHERE t1.id = t2.id;
--Returns an error: Not allowed to use a 'Where' clause. 
--'Where' clause are allowed to be used in 'INNER JOIN'














