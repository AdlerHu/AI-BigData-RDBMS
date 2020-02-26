insert into department (deptno, dname, mgrno)
values (400,'Research',1001);

insert into department
values (500,'Personnel',1001);

insert into department (deptno, dname)
values (601,'IT');

insert into department
values (602,'IT',null);

insert into department (deptno, dname, mgrno)
values (603,'HRD',1003),(604,'STK',null);

insert into employee
values (1009,'孫悟空','2013/11/10',56000,100,'senior engineer');

insert into employee
values (1010,'李大文',curdate(),89000,200,'manager');

create table emp_copy like employee;
insert into emp_copy select * from employee;
create table emp_copy1 like employee;

alter table emp_copy1 drop title;
alter table emp_copy1 change empno empid decimal(4);
insert into emp_copy1 (empid, ename, deptno, hiredate, salary)
select	empno, ename, deptno, hiredate, salary
from	employee
where title not like '%SA%';


update 	emp_copy
set		salary = 45000
where	empno = 1008;


-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
update 	emp_copy1
set		hiredate = curdate();

set sql_safe_updates = 0;
set sql_safe_updates = 1;

-- Error Code: 1093. You can't specify target table 'emp_copy' for update in FROM clause 
# 沒什麼理由，就是不行
update emp_copy
set salary = (	select 	salary
				from	emp_copy 
                where	empno = 1006)
where empno = 1007;

# 沒什理由，這樣就可以
update emp_copy
set salary = (	select 	salary
				from	(select * from emp_copy) e
                where	empno = 1006)
where empno = 1007;

# update 結合 subquery
update	emp_copy
set		deptno = (	select	deptno
					from	employee
                    where	empno = 1003)
where	salary = (	select	salary
					from	employee
					where	empno = 1001);
                    
delete from emp_copy where empno = 1007;
delete from emp_copy1;
delete from department
where deptno between 601 and 604 ;

delete from emp_copy
where deptno = (select 	deptno
				from	department
                where	dname = 'Accounting');
truncate emp_copy;
                







