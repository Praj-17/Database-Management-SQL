CREATE DEFINER=`prajwal.waykos`@`%` PROCEDURE `fe_acm_landing_page_entry_p`(     
	  IN p_config_id int,
	  IN p_flexi1 varchar(10),
	  IN p_flexi2 varchar(10),
	  OUT o_status varchar(10))
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
			t.a1,
			t.a9,
			t.a10,
			freq.a4,
			t.a8,
			t.a15
		INTO 	l_config_id,
				l_start_date,
				l_end_date,
				l_freq,
				l_interval,
				l_elig_id 
		FROM `fe_cfg_landing_page_t` t
		LEFT JOIN `fe_glb_lookup_m`freq
			ON (t.a7 =freq.a3  AND freq.a2 = 1000128 AND freq.a7 = 1)
 		WHERE a1 = p_config_id;

	SET l_loop_date = l_start_date;
	WHILE l_loop_date <= l_end_date
	DO 
		SET l_loop_start_date = NULL;
		SET l_loop_end_date = NULL;
		IF l_freq = "Daily" THEN
			SET l_loop_start_date = p_start_date;
			SET l_loop_end_date = p_end_date;
			SET l_loop_date = DATE_ADD(DATE_FORMAT(l_end_date, '%Y/%m/%d') , INTERVAL l_interval DAY);
		ELSEIF l_freq = 'Weekly'
        THEN
			IF l_loop_date = l_start_date or dayname(l_loop_date) = 'Monday'
            THEN
				 SET l_loop_start_date = l_loop_date;
				 SET l_loop_end_date = DATE_ADD(DATE_FORMAT(l_loop_date, '%Y/%m/%d'), INTERVAL ((l_interval *7)-1) DAY); #week start date will be monday and end date will sunday
				 SET l_loop_date = DATE_ADD(DATE_FORMAT(l_loop_date, '%Y/%m/%d') , INTERVAL (l_interval *7) DAY) ; #e.g if interval is 2, then next to next monday 
			ELSE
				SET l_loop_date = DATE_ADD(DATE_FORMAT(l_loop_date, '%Y/%m/%d') , INTERVAL 1 DAY);
			END IF;
		ELSEIF l_freq = 'Monthly'
        THEN
			IF l_loop_date = l_start_date or day(l_loop_date) = 1 
            THEN 
				SET l_loop_start_date = l_loop_date;
				SET l_loop_end_date = last_day(DATE_FORMAT(l_loop_date, '%Y/%m/%d'));
				SET l_loop_date = DATE_ADD(last_day(DATE_FORMAT(l_loop_date, '%Y/%m/%d')), INTERVAL 1  DAY) ; #e.g. if current month is jan  and interval 2 then next month will be mar
			ELSE
				SET l_loop_date = DATE_ADD(DATE_FORMAT(l_loop_date, '%Y/%m/%d') , INTERVAL  1 DAY);
			END IF;
        END IF;
	END WHILE;
END