CREATE DEFINER=`root`@`localhost` TRIGGER `employe_old_BEFORE_DELETE` BEFORE DELETE ON `employe_old` FOR EACH ROW BEGIN
insert into employe_old(emp_id,emp_name, emp_join,designation,emp_salary)
values(old.emp_id, old.emp_name, old.emp_join,old.designation,emp_salary);
END