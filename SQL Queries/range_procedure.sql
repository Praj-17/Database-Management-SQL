CREATE DEFINER=`root`@`localhost` PROCEDURE `range`(
in sr int, in er int, out stud int)
BEGIN
select count(*) into stud from students
where Percentage between sr and er;

END