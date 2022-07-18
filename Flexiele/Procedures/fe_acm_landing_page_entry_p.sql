CREATE DEFINER=`prajwal.waykos`@`%` PROCEDURE `fe_acm_landing_page_entry_p`(     
	  IN p_config_id int,
      IN p_client_id int,
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
	DECLARE 
			l_id DEFAULT 0;
			l_emp_count,
            l_emp_id,
			l_start_count int(10);
	DECLARE l_is_eligible BOOLEAN;
	DECLARE c_emp_list CURSOR FOR
		SELECT
				a1 'emp_id'
			FROM
				fe_hrt_emp_employment_t
		WHERE 1
				AND ifnull(a8,'') = '' or a8 > l_start_date
				AND cl  = p_client_id;

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
		OPEN c_emp_list;
		SET l_emp_count = c_emp_list.rowcount;
		SET l_start_count = 1;
        WHILE l_start_count <= l_emp_count
        DO 
			FETCH c_emp_list into l_emp_id;
            SET l_is_eligible = fe_hrt_check_employee_elig_p(
															l_emp_id,
                                                            l_elig_id,
                                                            l_loop_end_date,
                                                            NULL,
                                                            NULL);
			IF l_is_eligible
            THEN 
				SELECT a1 INTO l_id
				FROM fe_acm_emp_landing_page_t
				WHERE 1
					AND	a2 = l_emp_id
					AND a7 = l_loop_start_date
					AND a8 = l_loop_end_date
				IF l_id = 0
				THEN
					INSERT INTO fe_acm_emp_landing_page_t(l_emp_id, p_config_id, a4=1, l_start_date, l_end_date, who_created , when_created)
				END IF;
				
            END IF;
        
        END WHILE;
	
	END WHILE;
    SET o_status = 1
END