DELIMITER $$
CREATE FUNCTION addition_f(num1 int,num2 int ) RETURNS INTEGER
BEGIN
    RETURN num1+num2;
END;

$$
DELIMITER ;
 
SELECT hello_world();
