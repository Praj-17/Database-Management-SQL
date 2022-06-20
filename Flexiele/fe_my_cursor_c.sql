# Declaring a cursor
use training_db;
DELIMITER $$
CREATE PROCEDURE select_employees3(INOUT name_LIST VARCHAR(1000))
BEGIN
DECLARE is_done int default 0;
DECLARE e_name varchar(20) default "";

declare c cursor for 
select ename from emp;
declare continue handler for not found set is_done = 1;
open c;
cursorloop:loop
fetch c into e_name;
if is_done = 1 then leave cursorloop;
end if ;
set name_LIST = concat(e_name,"," ,name_LIST);
end loop cursorloop;
close c;
END$$


#Calling a Cursor;
Set @Name_List = "";
call select_employees3(@Name_List);
select @Name_List;