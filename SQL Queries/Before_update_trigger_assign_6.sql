CREATE DEFINER=`root`@`localhost` TRIGGER `employe_old_BEFORE_UPDATE` BEFORE UPDATE ON `employe_old` FOR EACH ROW BEGIN
if(new.emp_salary<10000)
then
set new.emp_salary =12000 ;
end if;

END