INSERT INTO department (deptno, dname, mgrno)
VALUES (400,'Research',1001);

INSERT INTO department
VALUES (500,'Personnel',1001);

INSERT INTO department (deptno, dname)
VALUES (601,'IT');

INSERT INTO department
VALUES (602,'IT',NULL);

INSERT INTO department (deptno, dname, mgrno)
VALUES (603,'HRD',1003),(604,'STK',NULL);

INSERT INTO employee
VALUES (1009,'孫悟空','2013/11/10',56000,100,'senior engineer');

INSERT INTO employee
VALUES (1010,'李大文',CURDATE(),89000,200,'manager');

CREATE TABLE emp_copy LIKE employee;
INSERT INTO emp_copy SELECT * FROM employee;
CREATE TABLE emp_copy1 LIKE employee;

ALTER TABLE emp_copy1 DROP title;
ALTER TABLE emp_copy1 CHANGE empno empid DECIMAL(4);
INSERT INTO emp_copy1 (empid, ename, deptno, hiredate, salary)
SELECT	empno, ename, deptno, hiredate, salary
FROM	employee
WHERE title NOT LIKE '%SA%';


UPDATE 	emp_copy
SET		salary = 45000
WHERE	empno = 1008;


-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
UPDATE 	emp_copy1
SET		hiredate = CURDATE();

SET sql_safe_updates = 0;
SET sql_safe_updates = 1;

-- Error Code: 1093. You can't specify target table 'emp_copy' for update in FROM clause 
# 沒什麼理由，就是不行
UPDATE emp_copy
SET salary = (	SELECT 	salary
				FROM	emp_copy 
                WHERE	empno = 1006)
WHERE empno = 1007;

# 沒什理由，這樣就可以
UPDATE emp_copy
SET salary = (	SELECT 	salary
				FROM	(SELECT * FROM emp_copy) e
                WHERE	empno = 1006)
WHERE empno = 1007;

# update 結合 subquery
UPDATE	emp_copy
SET		deptno = (	SELECT	deptno
					FROM	employee
                    WHERE	empno = 1003)
WHERE	salary = (	SELECT	salary
					FROM	employee
					WHERE	empno = 1001);
                    
DELETE FROM emp_copy WHERE empno = 1007;
DELETE FROM emp_copy1;
DELETE FROM department
WHERE deptno BETWEEN 601 AND 604 ;

DELETE FROM emp_copy
WHERE deptno = (SELECT 	deptno
				FROM	department
                WHERE	dname = 'Accounting');
TRUNCATE emp_copy;
                







