use Class_demo;

select * from identity;

update identity set EMP_salary = 55000 where EMP_salary=5000;

delete from identity where EMP_name = 'Saumya'; select max(EMP_salary) from identity;

Select avg(EMP_salary) from identity; 
select * from identity where EMP_salary between 30000 and 50000; 

select* from identity where EMP_SALARY> 50000;

create table experience (years int, months int, days int);

insert into experience (years, months, days) values

(10,10, 10),

(20, 20, 20),

(30, 30, 30),

(40, 40, 40);

select * from identity union

select * from experience; 
select * from identity union all select * from experience;