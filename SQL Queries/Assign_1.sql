-- --Class codes-
create database Class_Demo;
use Class_Demo;
CREATE TABLE identity (
EMP_id INT AUTO_INCREMENT PRIMARY KEY, EMP_name VARCHAR(255) NOT NULL,
EMP_salary int
);
INSERT into identity (EMP_id, EMP_name, EMP_salary) values
(1, 'prajwal', 50000);
INSERT into identity (EMP_name, EMP_salary) values
( 'rahul', 50000),
('vivek', 35000),
('Ashish', 7500 ),
('Sakshi', 80000);

delete from class_demo.identity where EMP_id = 1;

select * from identity;


CREATE VIEW view_1 AS SELECT EMP_id, EMP_name, EMP_salary FROM identity

WHERE EMP_salary >=50000;

CREATE INDEX Serial_no ON identity (EMP_id);

call sys.create_synonym_db('class_demo', 'Synonym_1');