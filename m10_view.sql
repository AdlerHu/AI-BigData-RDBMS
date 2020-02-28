# view 可以用來限制同一張表,不同人能看到的欄位
# 也可以把複雜的查詢語句封裝提供給別人用
CREATE VIEW empvu100
AS SELECT empno, ename, salary
FROM employee
WHERE deptno = 100;


CREATE VIEW empvu200
AS SELECT empno, ename, salary
FROM employee
WHERE deptno = 200;

SELECT * FROM empvu100;

# 有包含運算、join等的view 不能修改
CREATE VIEW salvu100
AS SELECT empno AS id, ename AS name, salary*12 AS 'Annual_Salary'
FROM employee
WHERE deptno = 100;

SELECT * FROM salvu100;

CREATE VIEW salvu100_1 (id, name, Annual_Salary)
AS SELECT empno, ename, salary*12 
FROM employee
WHERE deptno = 100;

SELECT * FROM salvu100_1;

CREATE VIEW 	dept_sum_vw (name, minsal, maxsal, avgsal)
AS SELECT		d.dname, MIN(e.salary), MAX(e.salary), AVG(e.salary)
FROM 			employee e JOIN department d
ON				e.deptno = d.deptno
GROUP BY		d.dname;

SELECT * FROM dept_sum_vw;


UPDATE 	empvu100
SET		ename = '孫悟飯'
WHERE	empno = 1009;

# view 不能查詢的資料不能改
UPDATE 	empvu100
SET		ename = '孫悟飯'
WHERE	empno = 1003;

-- Error Code: 1054. Unknown column 'title' in 'field list' 
UPDATE 	empvu100
SET		title = 'SA'
WHERE	empno = 1003;

DELETE 	FROM empvu100
WHERE	empno = 1008;


CREATE VIEW	emp_sal_vw
AS SELECT	e.empno, ename, e.salary
FROM 		employee e
WHERE		salary <= 40000
WITH CHECK OPTION;

-- Error Code: 1369. CHECK OPTION failed 'db01.emp_sal_vw' 
UPDATE	emp_sal_vw
SET		salary = 40001
WHERE	empno = 1002;

# 用 alter 修改 view
ALTER VIEW 	empvu100
AS SELECT empno, ename, salary, hiredate
FROM employee
WHERE deptno = 100;

# drop view
DROP VIEW empvu200;

