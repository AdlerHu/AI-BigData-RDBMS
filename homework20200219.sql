CREATE TABLE food(
	id 	CHAR(5)	PRIMARY KEY, 
    name	VARCHAR(30),
    expiredate	DATETIME, 
    placeid	CHAR(2), 
    price	INT UNSIGNED, 
    catalog	VARCHAR(20)
); 

CREATE TABLE place(
	id	CHAR(2)	PRIMARY KEY, 
    name	VARCHAR(20)
);

CREATE TABLE food1 LIKE food;

ALTER TABLE food1 ADD newColumn VARCHAR(30);
ALTER TABLE food1 CHANGE newColumn newColumn1 INT;
ALTER TABLE food1 MODIFY newColumn1 VARCHAR(30);
ALTER TABLE food1 DROP newColumn1;

ALTER TABLE food1 RENAME food2;
DROP TABLE food2;