CREATE TABLE emp1(
	-- column level constraint
    empno		DECIMAL(4)	PRIMARY KEY,
    ename		VARCHAR(30)	NOT NULL,
	hiredate	DATE		NOT NULL,
    email		VARCHAR(30)	UNIQUE,
	deptno		DECIMAL(3)	NOT NULL,
    salary		INT,
	title		VARCHAR(20)	NOT NULL DEFAULT 'engineer',
    
    -- table level constraint
    CONSTRAINT	emp_deptno_fk	FOREIGN KEY (deptno)
		REFERENCES department (deptno)
);

INSERT INTO dept
VALUES (600, 'Public Relations', DEFAULT);

UPDATE	dept
SET		cityno = DEFAULT
WHERE	deptno = 500;

INSERT INTO emp1
VALUES (1001,'孫悟空','2013/11/10', 'abcde@yahoo.com', 100,56000,'senior engineer');

-- Error Code: 1062. Duplicate entry 'abcde@yahoo.com' for key 'email'
INSERT INTO emp1
VALUES (1002,'孫悟空','2013/11/10', 'huadlerben@yahoo.com.tw', 200,56000,'senior engineer');

-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`db01`.`emp1`, CONSTRAINT `emp_deptno_fk` FOREIGN KEY (`deptno`) REFERENCES `department` (`deptno`))
DELETE FROM department WHERE deptno = 100;

-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`db01`.`emp1`, CONSTRAINT `emp_deptno_fk` FOREIGN KEY (`deptno`) REFERENCES `department` (`deptno`))
INSERT INTO emp1
VALUES (1003,'孫悟空','2013/11/10', 'huadlerben70@yahoo.com.tw', 600,56000,'senior engineer');

DELETE FROM department WHERE deptno = 300;
