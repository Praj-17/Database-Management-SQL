CREATE DEFINER=`prajwal.waykos`@`%` 
FUNCTION `fe_date_to_financial_year_f`(my_date varchar(10))
 RETURNS varchar(10) CHARSET utf8
BEGIN
DECLARE my_financial_year varchar(10);
set my_date = convert(my_date, date);
set my_financial_year = concat(year(my_date), '-', year(my_date) + 1);
RETURN my_financial_year; 
END