CREATE TABLE emp1(
	-- column level constraint
    empno		DECIMAL(4)	PRIMARY KEY,
    ename		VARCHAR(30)	NOT NULL,
	hiredate	DATE		NOT NULL,
    email		varchar(30)	unique,
	deptno		DECIMAL(3)	NOT NULL,
    salary		INT,
	title		VARCHAR(20)	NOT NULL default 'engineer',
    
    -- table level constraint
    constraint	emp_deptno_fk	foreign key (deptno)
		references department (deptno)
);

drop table emp1;

insert into dept
values (600, 'Public Relations', default);

update	dept
set		cityno = default
where	deptno = 500;

insert into emp1
values (1001,'孫悟空','2013/11/10', 'abcde@yahoo.com', 100,56000,'senior engineer');

insert into emp1
values (1010,'孫悟空','2013/11/10', 'zz@qq.com', 400,56000,'senior engineer');

-- Error Code: 1062. Duplicate entry 'abcde@yahoo.com' for key 'email'
insert into emp1
values (1002,'孫悟空','2013/11/10', 'huadlerben@yahoo.com.tw', 200,56000,'senior engineer');

-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`db01`.`emp1`, CONSTRAINT `emp_deptno_fk` FOREIGN KEY (`deptno`) REFERENCES `department` (`deptno`))
delete from department where deptno = 100;

-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`db01`.`emp1`, CONSTRAINT `emp_deptno_fk` FOREIGN KEY (`deptno`) REFERENCES `department` (`deptno`))
insert into emp1
values (1003,'孫悟空','2013/11/10', 'huadlerben70@yahoo.com.tw', 600,56000,'senior engineer');

delete from department where deptno = 300;

ALTER TABLE `db01`.`emp1` 
DROP FOREIGN KEY `emp_deptno_fk`;
ALTER TABLE `db01`.`emp1` 
ADD CONSTRAINT `emp_deptno_fk`
  FOREIGN KEY (`deptno`)
  REFERENCES `db01`.`department` (`deptno`)
  ON UPDATE CASCADE;

update department set deptno = 400 where deptno = 401;

ALTER TABLE `db01`.`emp1` 
DROP FOREIGN KEY `emp_deptno_fk`;
ALTER TABLE `db01`.`emp1` 
ADD CONSTRAINT `emp_deptno_fk`
  FOREIGN KEY (`deptno`)
  REFERENCES `db01`.`department` (`deptno`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

delete from department where deptno = 201;
insert into department values (200, 'ZZ', null);


create table mem (
	memno	int	primary key auto_increment,
    mname	varchar(30)	not null
)Auto_increment = 100;

insert 	into mem (mname)
values	('David Ho'), ('Maria Wang'),('Pam pan'),('Tina Lee'),('Jean Taso');

insert 	into mem (mname) values	('David Ho');
insert 	into mem (mname) values	('Maria Wang');
insert 	into mem (mname) values	('Pam pan');
insert 	into mem (mname) values	('Tina Lee');
insert 	into mem (mname) values	('Jean Taso');


select last_insert_id();

drop table mem;
    


