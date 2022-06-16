use class_demo;
create table employe_old( emp_id int auto_increment primary key,
emp_name varchar(255), emp_join int, 
designation varchar(255), 
emp_salary int
);
insert into employe_old values
(1, "AAA", 20200101, "Intern", 6000),
(2, "BBB",20200101, "Intern",7000),
(3,"CCC",20180101, "Manager",35000),
(4,"DDD",20190101, "Employee", 15000),
 (5,"EEE", 20190101, "Employee",18000),
(6,"FFF", 20200101, "Intern", 9000);

update employe_old set designation= "Employee"
 where emp_salary <15000;
 
 select * from employe_old;
 
 delete from employe_new where emp_salary =12000;
