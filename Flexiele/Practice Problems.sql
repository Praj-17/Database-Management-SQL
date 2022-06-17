use training_db;
select * from fe_wft_task_t;
select * from emp;
select * from dept;
select * from emp where to_char(hiredate,’mon’) like '_a_';
select * from emp where to_char(hiredate, mon) like  '_a%';
select * from emp where to_char(hiredate,’yy’) like '8%'; 
 select * from emp where deptno not in (20); 
 Select * from emp where job not in ('PRESIDENT','MANAGER') order 
by sal asc;
select e.ename || 'works for'  || m.ename from emp e ,emp m where e.mgr = 
m.empno ;
 select e.ename || ' has an employee '|| m.ename from emp e , emp m where 
e.empno = m.mgr;
`dev_sat.fe_lmm_letter_m` select * from emp where empno not like '78%';
select * from emp e,dept d where e.deptno = d.deptno; 
select * from emp where hiredate in (select min(hiredate) from 
emp where to_char( hiredate,’YYYY’) = '1981');
select sum (sal) from emp where job = 'MANAGER'; 
select deptno ,count(*) from emp group by deptno ;

 select * from emp where ename like '%A%'; 
  select * from emp where '%%';
select max(avg(sal)) from emp where job =! 'PRESIDENT' group by job;
SELECT max(myavg);
select * from emp where sal = (select max(sal) from emp where mgr in (select empno from emp where ename = 'KING'));
select * from emp where empno in (select mgr from emp);
select empno, ename,sal,sal/30,12*sal as annasal from emp order by annasal asc;
-- select empno, ename, job, hiredate, months_between(hirdate, curdate()) as EXP from emp;
select * from emp where comm > sal;
select * from emp where job not in ('MANAGER', 'PRESIDENT') order by sal asc;
select * from emp e , dept d where d.dname in ('ACCOUNTING', 'RESEARCH') and e.deptno = d.deptno order by e.deptno 
asc;

 List the Empno, Ename, Sal, Dname of all the ‘MGRS’ and ‘ANALYST’ 
working in New York, Dallas with an exp more than 7 years without receiving the 
Comm asc order of Loc.
select e.empno, e.ename, e.sal, d.dname from emp e , dept d where e.deptno = d.deptno and  e.job in ('MANAGER', 'ANALYST') 
and d.loc in ('NEW YORK', 'DALLAS') and e.comm is NULL order by d.loc asc;

Display the Empno, Ename, Sal, Dname, Loc, Deptno, Job of all emps working at 
CJICAGO or working for ACCOUNTING dept with Ann Sal>28000, but the Sal 
should not be=3000 or 2800 who doesn’t belongs to the Mgr and whose no is 
having a digit ‘7’ or ‘8’ in 3rd position in the asc order of Deptno and desc order 
of job
select E.empno,E.ename,E.sal,D.dname,D.loc,E.deptno,E.job 
from emp E,dept D 
where (D.loc = 'CJICAGO' or D.dname = 'ACCOUNTING') and 
E.deptno=D.deptno and E.empno in 
(select E.empno from emp E where (12*E.sal) > 28000 and E.sal not in 
(3000,2800) and E.job !='MANAGER' 
and ( E.empno like '__7%' or E.empno like '__8%')) 
order by E.deptno asc , E.job desc;
select * from emp where emp.sal > (select sal from emp where ename= 'BLAKE') ;
select * from emp where emp.job = (select job from emp where ename= 'ALLEN');
select * from emp where hiredate < (select hiredate from emp where ename= 'KING');
select * from emp w,emp m where w.mgr = m.empno and 
w.hiredate < m.hiredate ; 
select * from emp e, emp m where e.hiredate > m.hiredate and e.mgr = m.empno; 
use training_db;
select * from emp where sal in (select sal from emp where ename = 'SMITH' or ename = 'FORD') order by sal desc;

List the emps Whose Jobs are same as MILLER or Sal is more than ALLEN.
select * from emp where job in (select job from emp where ename = 'MILLER') 
or sal in  (select * from emp where ename = 'SMITH') 

. List the Emps whose Sal is > the total remuneration of the SALESMAN. 
select * from emp where sal > (select sum(nvl2(comm,sal+comm,sal)) as remuneration from emp where job = 'SALESMAN' )
select * from emp where sal >(select sum(nvl2(comm,sal+comm,sal)) from 
emp where job = ‘SALESMAN’);
---------------------------------------------------------------- 
nvl2 means that if first expression is not null return second expression and if 
it is null returm third expression.
----------------------------------------------------------------
 List the emps who are senior to BLAKE working at CHICAGO & BOSTON. 
 
 select * from emp e, dept d where e.deptno = d.deptno and e.hiredate < 
 (select e.hiredate from emp e, dept d where 
 e.deptno = d.deptno and d.loc = 'CHICAGO' and d.loc = 'BOSTON');
 
 select * from emp e ,dept d where d.loc in 
('CHICAGO','BOSTON') and e.deptno = d.deptno and 
e.hiredate <(select e.hiredate from emp e where e.ename = 
'BLAKE') ;

 Any jobs of deptno 10 those that are not found in deptno 20. 
select e.job from emp e , dept d where e.deptno = d.deptno and d.deptno = 10 and d.deptno !=20;
select e.job from emp e where e.deptno =10 and e.job not in (select job from emp e where deptno = 20);
select max(sal) from emp; 
select * from emp where sal in (select max(sal) from emp);
Find the highest paid employee of sales department.
select * from emp e, dept d where e.deptno = d.deptno and d.dname = 'SALES' and e.sal in (select max(sal) from emp)
select * from emp where sal in (select max(sal) from emp where deptno in 
(select d.deptno from 
dept d where d.dname = 'SALES'));
select * from emp where sal in (select max(sal) from emp where deptno in (select d.deptno from dept d where d.dname = 'SALES')) 

 List the employees who are senior to most recently hired employee working 
under king
select * from emp where hiredate < (select max(hiredate) 
from emp e where mgr in (select empno from emp where ename = 'KING'))
select * from emp where hiredate < (select max(hiredate) from emp where mgr 
in 
(select empno from emp where ename = 'KING')) ;
Find the total sal given to the MGR.
SELECT SUM(SAL) as Total FROM emp WHERE JOB = 'MANAGER' ;
select avg(convert(sal, decimal)) from emp where job = 'CLERK'
List the employee in dept 20 whose sal is >the average sal 0f dept 10 emps
select * from emp e where e.deptno =20 and e.sal > (select avg(sal) from emp where deptno = 10)
 Display the number of employee for each job group deptno wise. 
 select count(select job from emp group by deptno) from emp
 select deptno ,job ,count(*) from emp group by deptno,job; 
 
 List the manage rno and the number of employees working for those mgrs in the 
ascending Mgrno. 
 select w.mgr ,count(*) from emp w,emp m 
 where w.mgr = m.empno 
group by w.mgr 
order by w.mgr asc; 