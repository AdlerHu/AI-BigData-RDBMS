# view 可以用來限制同一張表,不同人能看到的欄位
# 也可以把複雜的查詢語句封裝提供給別人用
create view empvu100
as select empno, ename, salary
from employee
where deptno = 100;


create view empvu200
as select empno, ename, salary
from employee
where deptno = 200;

select * from empvu100;

# 有包含運算、join等的view 不能修改
create view salvu100
as select empno as id, ename as name, salary*12 as 'Annual_Salary'
from employee
where deptno = 100;

select * from salvu100;

create view salvu100_1 (id, name, Annual_Salary)
as select empno, ename, salary*12 
from employee
where deptno = 100;

select * from salvu100_1;

create view 	dept_sum_vw (name, minsal, maxsal, avgsal)
as select		d.dname, min(e.salary), max(e.salary), avg(e.salary)
from 			employee e join department d
on				e.deptno = d.deptno
group by		d.dname;

select * from dept_sum_vw;


update 	empvu100
set		ename = '孫悟飯'
where	empno = 1009;

# view 不能查詢的資料不能改
update 	empvu100
set		ename = '孫悟飯'
where	empno = 1003;

-- Error Code: 1054. Unknown column 'title' in 'field list' 
update 	empvu100
set		title = 'SA'
where	empno = 1003;

delete 	from empvu100
where	empno = 1008;


create view	emp_sal_vw
as select	e.empno, ename, e.salary
from 		employee e
where		salary <= 40000
with check option;

-- Error Code: 1369. CHECK OPTION failed 'db01.emp_sal_vw' 
update	emp_sal_vw
set		salary = 40001
where	empno = 1002;

# 用 alter 修改 view
alter view 	empvu100
as select empno, ename, salary, hiredate
from employee
where deptno = 100;

# drop view
drop view empvu200;

