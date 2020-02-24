# if(condition , true, false)
SELECT empno, ename, salary,
	salary * IF(salary >=50000, 2, 1.5) AS 'bonus'
FROM employee;

# case 語法結尾要end  
SELECT empno, ename, salary,
	CASE
		WHEN salary > 100000 THEN 'A'
        WHEN salary BETWEEN 70000 AND 100000 THEN 'B'
		WHEN salary BETWEEN 50000 AND 69999 THEN 'C'
		WHEN salary BETWEEN 30000 AND 49999 THEN 'D'
		ELSE 'E'
	END 'Grade'
FROM employee;

# 使用distinct關鍵字剔除重複資料
SELECT DISTINCT deptno FROM employee;

# distinct 兩個欄位，表示兩個欄位都重複才會剔除 
SELECT DISTINCT deptno,title FROM employee;

# Where 代表條件搜尋
SELECT * FROM employee WHERE deptno = 100;
SELECT * FROM employee WHERE title = 'engineer';
SELECT * FROM employee WHERE hiredate = '2007/07/06';
SELECT * FROM employee WHERE salary >= 50000;
SELECT * FROM employee WHERE salary BETWEEN 30000 AND 40000;
SELECT * FROM employee WHERE title IN ('manager','engineer');
SELECT * FROM department WHERE mgrno IS NULL;

# LIKE 就是關鍵字搜尋
SELECT * FROM employee WHERE ename LIKE '林%';
SELECT * FROM employee WHERE ename LIKE '%生';
SELECT * FROM employee WHERE ename LIKE '%麗%';
SELECT * FROM employee WHERE ename LIKE '_麗%';

# mysql 裡的跳脫字元預設用 \ 
SELECT * FROM employee WHERE title LIKE '%SA\_%';
SELECT * FROM employee WHERE title LIKE '%SA/_%' ESCAPE '/';

# and or not 條件判斷
SELECT * FROM employee WHERE salary > 45000 AND ename LIKE '林%';
SELECT * FROM employee WHERE salary > 45000 OR ename LIKE '林%';
SELECT * FROM employee WHERE title NOT IN ('manager','engineer');
SELECT * FROM department WHERE mgrno IS NOT NULL;
SELECT * FROM employee WHERE salary NOT BETWEEN 30000 AND 40000;
SELECT * FROM employee WHERE ename  NOT LIKE '林%';

# 排序方法預設 ASC 表示升冪排序, DESC 表示降冪排序
# 多個欄位排序，如果排序方法不一樣要分別寫
SELECT * FROM employee ORDER BY hiredate DESC ;
SELECT ename, deptno, salary FROM employee ORDER BY deptno, salary DESC ;
SELECT ename, deptno, salary FROM employee ORDER BY deptno DESC, salary DESC ;
SELECT ename, salary*12 AS 'Annual' FROM employee ORDER BY Annual;
SELECT ename, salary*12 AS 'Annual' FROM employee ORDER BY salary*12;
SELECT ename, deptno, salary FROM employee ORDER BY 3;
SELECT * FROM employee ORDER BY 3;

# limit 4,3 表示傳回5,6,7筆 ，可以用在計算分頁
SELECT * FROM employee LIMIT 3;
SELECT * FROM employee LIMIT 4,3;
SELECT * FROM employee ORDER BY hiredate LIMIT 3;
SELECT * FROM employee ORDER BY salary DESC LIMIT 3;

# sum, avg, count 這些函數計算時會剔除null
# 
SELECT SUM(salary), AVG(salary), MAX(salary), MIN(salary) FROM employee;
select count(*) from employee;
select count(distinct deptno) from employee;

# rollup 關鍵字表示小計
select deptno, avg(salary) as 'Average' from employee group by deptno;
select deptno, avg(salary) as 'Average' from employee group by deptno order by AVG(salary);
select deptno, avg(salary) as 'Average' from employee group by deptno order by Average;
select deptno, count(*) as 'Count' from employee group by deptno;
select deptno, title, sum(salary) as 'Total' from employee group by deptno, title;
select deptno, title, sum(salary) as 'Total' from employee group by deptno, title with rollup;

select	title, sum(salary) as 'Total'
from	employee
where	title not like '%SA%'
group by	title
having	sum(salary) > 10000
order by sum(salary) desc;

