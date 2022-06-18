CREATE DEFINER=`prajwal.waykos`@`%` PROCEDURE `CREATE_TEMP`()
BEGIN
create table temp as
select concat(ename," ", job) as Full_name, period_diff(date_format(now(), '%Y%m'), date_format(hiredate, '%Y%m')) as exp,

END
