use class_demo;

create table students(roll_no int auto_increment primary key,
course varchar(255), Course_code int, Semester int, 
Total_marks int, Percentage int);
insert into students values
(1, "DBMS", 10,1,98,98),
(2, "DM", 11,1,75,75),
(3, "ML", 12,1,95,95),
(4, "DL", 13,2,55,55),
(5, "NLP", 14,2,65,65),
(6, "CV", 15,2,85,85),
(7, "DST", 16,1,78,78),
(8, "MP", 17,1,95,95),
(9, "DV", 18,1,88,88);

set stud = 0;
call class_demo.range(80, 100, stud);
select  stud;




