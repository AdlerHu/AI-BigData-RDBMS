# Single-Row Subquery
SELECT	ename, salary
FROM	employee
WHERE	salary > (	SELECT 	salary
					FROM	employee
					WHERE	ename = '潘麗珍');
                    
				
SELECT	ename, title, salary
FROM	employee
WHERE	title = (	SELECT	title
					FROM	employee
					WHERE	empno = 1002)
AND		salary > (	SELECT	salary
					FROM	employee
                    WHERE	empno = 1005);
                                        
# having 要跟 group by 搭配使用
SELECT		deptno, MIN(salary) AS 'Min Salary'
FROM		employee
GROUP BY	deptno
HAVING		MIN(salary) > (	SELECT	MIN(salary)
							FROM	employee
                            WHERE	deptno = 200);

# 31行的1表示4捨5入只取1位小數 
SELECT ename, title, salary,
		ROUND(salary *100 / 
				(	SELECT	SUM(salary)
					FROM	employee
                    WHERE	deptno = 100),1) AS '%'
FROM	employee
WHERE	deptno = 100;

# 上一個例子，其實加總應該放在from 這樣算總薪資只算一次
SELECT ename, title, salary,
		ROUND(salary *100 / t.total,1) AS '%'
FROM	employee,(	SELECT	SUM(salary) AS 'total'
					FROM	employee
                    WHERE	deptno = 100) AS t
WHERE	deptno = 100;

# Error Code: 1242. Subquery returns more than 1 row
# 右鍵點選錯誤訊息 -> Copy Response 
SELECT	empno, ename
FROM	employee
WHERE	salary = (	SELECT 	MIN(salary)
					FROM 	employee
					GROUP BY	deptno);


SELECT	empno, ename
FROM	employee
WHERE	salary IN (	SELECT 	MIN(salary)
					FROM 	employee
					GROUP BY	deptno);

# < ANY 就是比最大值小，直接用max()函數就好
SELECT 	ename, title, salary
FROM	employee
WHERE	salary < (	SELECT	MAX(salary)
					FROM	employee
					WHERE	title = 'senior engineer')
AND 	title != 'senior engineer'; 

# < ALL 就是比最小值小，直接用min()函數就好
SELECT 	ename, title, salary
FROM	employee
WHERE	salary < (	SELECT	MIN(salary)
					FROM	employee
					WHERE	title = 'senior engineer')
AND 	title != 'senior engineer'; 

# 
SELECT 	ename
FROM	emp
WHERE	empno IN (	SELECT 	DISTINCT mgrno
					FROM	emp);
                    
# 涉及到null的運算結果就會是null,不能用直覺解
SELECT 	ename
FROM	emp
WHERE	empno NOT IN (	SELECT 	DISTINCT mgrno
						FROM	emp
                        WHERE	mgrno IS NOT NULL);
											
# Correlated Subquery , 這樣寫程式端連接資料庫時，通配佔位符只用給一個不是兩個
# 可惜這個用法Subquery不能用在from
SELECT ename, title, salary,
		ROUND(salary *100 / 
				(	SELECT	SUM(salary)
					FROM	employee
                    WHERE	deptno = e.deptno),1) AS '%'
FROM	employee e
WHERE	e.deptno = 100;

#  
SELECT 	ename, salary, deptno
FROM	employee e
WHERE	salary IN (	SELECT 		MIN(salary)
					FROM		employee
					GROUP BY	deptno
                    HAVING		deptno = e.deptno);

# 
SELECT 	ename, salary, deptno
FROM	employee e
WHERE	salary = (	SELECT	MIN(salary)
					FROM	employee
                    WHERE	deptno = e.deptno);

# 
CREATE	TABLE	emp100
SELECT	empno, ename, salary*12 AS 'annualSalary', hiredate
FROM	employee
WHERE	deptno = 100;









                    
                    
