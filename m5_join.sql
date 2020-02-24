# 說到 Join 絕大部分指的是 Equal join
select emp.ename, dept.dname
	from emp, dept
    where emp.deptno = dept.deptno;

# Equal join 的 ANSI 寫法
select emp.ename, dept.dname
	from emp join dept
    on emp.deptno = dept.deptno;
    
# ()一定要加 
select emp.ename, dept.dname
	from emp join dept
	using (deptno);
    
# 語法允許，不建議
select emp.ename, dept.dname
	from emp natural join dept;
    
# 對要顯示的數據添加篩選條件
select emp.ename, emp.deptno, dept.dname
from emp, dept
where emp.deptno = dept.deptno
and title = 'manager';

# 將上面的例子改寫成ANSI寫法
select emp.ename, emp.deptno, dept.dname
from emp join dept
on emp.deptno = dept.deptno
where title = 'manager';

# 使用表格別名更好閱讀,別名只作用在敘述中
select e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno
and title = 'manager';

# 三個表格的Join
select	e.ename, d.dname, c.cname
from	emp e, dept d, city c
where	e.deptno = d.deptno
and d.cityno = c.cityno;
 
# 上面例子改寫成ANSI寫法
select	e.ename, d.dname, c.cname
from 	emp e 
join 	dept d
on 		e.deptno = d.deptno 
join 	city c
on 		d.cityno = c.cityno;

# Non-equal join
select 	e.ename, e.salary, g.level
from	emp e, grade g
where	e.salary between g.lowest and g.highest;

# equal join 跟 non-equal join 可以混搭 
select 	e.ename, d.dname, e.salary, g.level
from	emp e, grade g, dept d
where		e.deptno = d.deptno
and	e.salary between g.lowest and g.highest;

# 感覺ANSI規範寫法比較好懂
select e.ename, d.dname, e.salary, g.level
from emp e
join dept d
on	e.deptno = d.deptno
join grade g
on e.salary between g.lowest and g.highest;

# left outer join
select 	e.ename, e.deptno, d.dname
from	emp e left join dept d
on		e.deptno = d.deptno;

# right outer join
select 	e.ename, d.deptno, d.dname
from	emp e right join dept d
on e.deptno = d.deptno;

# 使用union 關鍵字進行 full outer join
select	e.ename, e.deptno, d.dname
from	emp e left join dept d
on		e.deptno = d.deptno
union
select	e.ename, d.deptno, d.dname
from	emp e right join dept d
on		e.deptno = d.deptno;

# self-join, 一定要有別名
select	worker.ename as 'worker name',
		manager.ename as 'manager name'
from	emp worker, emp manager
where	worker.mgrno = manager.empno;



