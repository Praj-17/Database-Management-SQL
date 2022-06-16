CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor`()
BEGIN
declare empno, sal int;
declare name varchar(20);
declare done int default 0;
declare c cursor for select 
emp_id, emp_name, salary from emp_info
a where 5>= (select count(distinct salary) from emp_info b where b.salary >= a.salary) 
order by a.salary DESC;
declare continue handler for not found set done  = True;
open c;
cursorloop:loop
if done = true then leave cursorloop;
end if ;
Fetch c into empno, name, sal;
select empno, name, sal;
end loop cursorloop;
close C;
END