create table emp_info (emp_id int auto_increment primary key, 
					emp_name varchar(255), joining_date int , 
                    designition varchar(255), salary  int );
insert into emp_info value
(1,"AAA", 20200101, "Intern", 8000),
(2,"BBB", 20200801, "Intern", 5000),
(3,"CCC",20180101, "Manager", 35000),
(4,"DDD", 20190101, "Employee", 20000),
(5,"EEE",20190801, "Employee",18000),
(6,"FFF", 20200101, "Intern" ,9000),
 (7,"GGG",20190101, "Employee", 25000);
use class_demo;
call class_demo.cursor_1();

create table employee_cursor (empno int , emp_name varchar(20), emp_sal int);
select distinct  * from employee_cursor;
delete from employee_cursor where emp_name = NULL;