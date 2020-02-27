# Explicit Transaction ( 外顯式交易)
# 第一次select可以看的到601,602, 如果這時別人也在看department表看不到這兩筆,rollback後這兩筆就沒有進去資料庫
start transaction;
insert into department values (601, 'RD', 1001);
insert into department values (602, 'IT', null);
select * from department;
rollback;
select * from department;

# commit 代表交易完成,所有人都看的到這兩筆
start transaction;
insert into department values (601, 'RD', 1001);
insert into department values (602, 'IT', null);
select * from department;
commit;
select * from department;

# Implicit(隱含式交易) 
set autoCommit = 0;
insert into department values (603, 'RD', 1001);
insert into department values (604, 'IT', null);
select * from department;
rollback;
select * from department;

insert into department values (603, 'RD', 1001);
insert into department values (604, 'IT', null);
select * from department;
commit;
select * from department;
set autocommit = 1;

# rollback to A 代表回到savepoint A ,所以只有savepoint A之前的指令會進資料庫
begin;
select	empno, ename, salary
from	employee
where	empno in (1001, 1002, 1003);
update	employee set salary = 60000 where empno = 1001;
savepoint A;
update	employee set salary = 40000 where empno = 1002;
savepoint B;
update	employee set salary = 60000 where empno = 1003;
rollback to A;
commit;
select	empno, ename, salary
from	employee
where	empno in (1001, 1002, 1003);

begin;
select	salary
from	employee
where	empno = 1001;

update 	employee
set		salary = 60001
where	empno = 1001;

commit;

select	salary
from	employee
where	empno = 1001;



