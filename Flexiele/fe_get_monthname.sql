CREATE FUNCTION `fe_glb_get_monthname` (month_number integer)
RETURNS varchar(10)
BEGIN
if month_number = 1 then return 'January';
elseif month_number = 2 then return 'February';
elseif month_number = 3 then return 'March';
elseif month_number = 4 then return 'April';
elseif month_number = 5 then return 'May';
elseif month_number = 6 then return 'June';
elseif month_number = 7 then return 'July';
elseif month_number = 8 then return 'August';
elseif month_number = 9 then return 'September';
elseif month_number = 10 then return 'October';
elseif month_number = 11 then return 'November';
elseif month_number = 12 then return 'December';
else return 'Unknown';
end if;
END;