DELIMITER $$
CREATE PROCEDURE select_employees(INOUT name_LIST VARCHAR(10000))
BIGIN
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
set name_LIST = name_LIST || e_name || ",";
end loop cursorloop;
close c;
END$$
