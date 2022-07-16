CREATE PROCEDURE `fe_acm_landing_page_entry_p` 
(     IN p_config_id int,
	  IN p_flexi1 varchar(10),
	  IN p_flexi2 varchar(10),
	  out o_status varchar(10))
BEGIN
	DECLARE l_config_id,
			l_freq,
			l_interval,
			l_elig_id INT(10);
	DECLARE l_start_date,
			l_end_date VARCHAR(10);
	DECLARE
			l_loop_date,
			l_loop_start_date, 
			l_loop_end_date VARCHAR(10);
	SELECT 
			a1,
			a9,
			a10,
			a7,
			a8,
			a15
		INTO 	l_config_id,
				l_start_date,
				l_end_date,
				l_freq,
				l_interval,
				l_elig_id 
		FROM `fe_cfg_landing_page_t`
 		WHERE a1 = p_config_id;

	SET l_loop_date = l_start_date;
	WHILE l_loop_date <= l_end_date
	DO 
		SET l_loop_start_date = NULL;
		SET l_loop_end_date = NULL;
		IF freq = "Daily" THEN
			SET l_loop_start_date = p_start_date;
			SET l_loop_end_date = p_end_date;
			SET l_loop_date = l_end_date + l_interval;
		ELSEIF l_freq = 'Weekly'
        THEN
			IF l_loop_date = l_start_date or dayname(l_loop_date) = 'Monday'
            THEN
				 SET l_loop_start_date = l_loop_date;
				 SET l_loop_end_date = weekend date(loop_date) #week start date will be monday and end date will sunday
				 SET l_loop_date = week start day of next weekly interval  #e.g if interval is 2, then next to next monday 
			ELSE
				SET l_loop_date = l_loop_date +1;
			END IF;
		ELSEIF l_freq = 'Monthly'
        THEN
			IF l_loop_date = l_start_date or day(loop_date) = 1 
            THEN 
				SET l_loop_start_date = l_loop_date;
				SET loop_end_date = last day of monthly;
				SET loop_date = first day of next monthly interval; #e.g. if current month is jan  and interval 2 then next month will be mar
			ELSE
				SET l_loop_date = l_loop_date + 1;
			END IF;
        END IF;
	END WHILE;
END
