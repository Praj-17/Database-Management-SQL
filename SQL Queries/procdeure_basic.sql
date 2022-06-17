-- MySQL

-- example
DELIMITER $$ -- Changes delimiter to $$ so can use ; within the procedure
CREATE PROCEDURE select_employees()
BEGIN
	select * 
	from employees 
	limit 1000; -- Use the ; symbol within the procedure
END$$ 
DELIMITER ; -- Resets the delimiter

/* syntax:
DELIMITER $$ -- Changes delimiter to $$ so can use ; within the procedure
CREATE PROCEDURE <Your-procedure-name>(<argument1><argument2>...<argumentN>)
BEGIN
	<Code-that-stored-procedure-executes>; -- Use the ; symbol within the procedure
END$$
DELIMITER ; -- Resets the delimiter
*/