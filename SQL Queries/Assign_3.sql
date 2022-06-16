use class_demo;
create table Teaching_Faculty_information(Faculty_id int auto_increment primary key,

Faculty_name varchar(255),

Dept_name varchar (255));

insert into Teaching_Faculty_information (Faculty_id, Faculty_name, Dept_name) values

 (1, "Vivek", "Ai and Ds");


insert into Teaching_Faculty_information (Faculty_name, Dept_name) values

("prajwal", "Ai and Ds"),

("Prachi", "CS"), ("Santosh", "Electronics"),

("Suvarna", "IT"),

( "Varsha", "Mechanical");


create table Subject_information (Subject_id int auto_increment primary key, 
Subject_name varchar(255), Faculty_id int); 
insert into Subject_information (Subject_id, Subject_name, Faculty_id) values
(1,"DBMS", 1);
insert into Subject_information (Subject_name, Faculty_id) values
("AI",2),
("DV",3),
("MP",4),
("UHV",5),
("DM",6);



-- ----Joins-
-- inner join-
SELECT *
FROM Teaching_Faculty_information
INNER JOIN Subject_information ON Teaching_Faculty_information.Faculty_id
= Subject_information.Faculty_id;

-- left join 
SELECT *
FROM Teaching_Faculty_information
left JOIN Subject_information ON Teaching_Faculty_information.Faculty_id

= Subject_information.Faculty_id;
-- --right join 
SELECT * FROM Teaching_Faculty_information 
Right join  Subject_information on Teaching_Faculty_information.Faculty_id
= Subject_information.Faculty_id;
SELECT * FROM Teaching_Faculty_information right JOIN Subject_information
ON Teaching_Faculty_information.Faculty_id
= Subject_information.Faculty_id;

-- Cross Join
SELECT * FROM Teaching_Faculty_information 
cross join  Subject_information on Teaching_Faculty_information.Faculty_id
= Subject_information.Faculty_id;
SELECT * FROM Teaching_Faculty_information cross JOIN Subject_information
ON Teaching_Faculty_information.Faculty_id
= Subject_information.Faculty_id;

-- VIEWS ---- 
CREATE VIEW view_assign_3 AS
SELECT *
FROM Teaching_Faculty_information; 
CREATE VIEW view_2 AS
SELECT * FROM Teaching_Faculty_information;
-- Sub-Query
select* from Teaching_Faculty_information where Faculty_name =
(select Subject_name
from Subject_information where
subject_name = "DBMS" );