DELIMITER $$

USE `femean`$$

DROP FUNCTION IF EXISTS `fe_get_table_code_f`$$

CREATE DEFINER=`prashant.joshi`@`%` FUNCTION `fe_get_table_code_f`(
        p_cl INT,
		p_table_name VARCHAR(1000),
		p_code VARCHAR(500), 
		p_length INT,
		p_workspace VARCHAR(100),
		p_flexi2 VARCHAR(500)
	) RETURNS VARCHAR(100) CHARSET utf8mb4
BEGIN
		DECLARE l_seq VARCHAR(100);
		DECLARE l_max_seq INT;
		DECLARE l_l3_prefix VARCHAR(100);
		DECLARE l_code VARCHAR(100) DEFAULT '';
		DECLARE l_l3_flag BOOLEAN DEFAULT FALSE;
		DECLARE l_append_xx_flag VARCHAR(10) DEFAULT '';
		
		SET l_max_seq = 0;
		SET l_seq = '';
		SET l_l3_prefix = 'XX';
		SET l_code = p_code;
		
		IF DATABASE() NOT IN ('femean', 'femean_test', 'femean_tst', 'femean_bkp') THEN
			
			SELECT IFNULL(append_xx,'') INTO l_append_xx_flag
			FROM fe_core_table_m
			WHERE 1
				AND cl = p_cl
				
				AND `name` = p_table_name;
		
			IF l_append_xx_flag = 'Y' THEN
				SET l_code = CONCAT(l_l3_prefix, l_code);
			END IF;
			SET l_l3_flag = TRUE;
		END IF;
		
		CASE
			WHEN p_table_name = 'fe_wft_process_t' THEN
				SELECT MAX(CAST(REPLACE(a6, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wft_process_t
					WHERE SUBSTR(a6 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			WHEN p_table_name = 'fe_wft_process_activity_t' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wft_process_t
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			WHEN p_table_name = 'fe_wft_process_transition_t' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wft_process_transition_t
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wft_process_parameter_t' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wft_process_parameter_t
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_core_action_m' THEN
				SELECT MAX(CAST(REPLACE(act_code, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_action_m
					WHERE SUBSTR(act_code FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
				
			
			WHEN p_table_name = 'fe_core_action_rel_m' THEN
				SELECT MAX(CAST(REPLACE(acr_code, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_action_rel_m
					WHERE SUBSTR(acr_code FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
                    
			
			WHEN p_table_name = 'fe_wfm_notification_m' THEN
				SELECT MAX(CAST(REPLACE(a2, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_notification_m
					WHERE SUBSTR(a2 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
                    
                    
			WHEN p_table_name = 'fe_wfm_notification_param_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_notification_param_m
					WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wfm_mail_template_m' THEN
				SELECT MAX(CAST(REPLACE(a5, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_mail_template_m
					WHERE SUBSTR(a5 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
                    
                    WHEN p_table_name = 'fe_wfm_sms_template_m' THEN
				SELECT MAX(CAST(REPLACE(a5, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_sms_template_m
					WHERE SUBSTR(a5 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
		    WHEN p_table_name = 'fe_wfm_not_att_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_notification_attachment_m
					WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl,
						1
					);
                    
			
			WHEN p_table_name = 'fe_core_form_table_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_form_table_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_core_form_order_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_form_order_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
                    
			WHEN p_table_name = 'fe_core_form_where_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_form_where_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wfm_function_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_function_m
					WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wfm_function_param_m' THEN
				SELECT MAX(CAST(REPLACE(`a4`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_function_param_m
					WHERE SUBSTR(`a4` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
                    
                    
			WHEN p_table_name = 'fe_wfm_notification_attachment_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_notification_attachment_m
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
            
			
			WHEN p_table_name = 'fe_core_dag_m' THEN
				SELECT MAX(CAST(REPLACE(dag_code, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_dag_m
					WHERE SUBSTR(dag_code FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			WHEN p_table_name = 'fe_core_field_function_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_field_function_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			WHEN p_table_name = 'fe_core_field_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_field_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wfm_message_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_message_m
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wft_process_t' THEN
				SELECT MAX(CAST(REPLACE(a6, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wft_process_t
					WHERE SUBSTR(a6 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
				
			WHEN p_table_name = 'fe_lmm_letter_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_lmm_letter_m
					WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_lmm_letter_param_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_lmm_letter_param_m
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);			
			
			WHEN p_table_name = 'fe_lmm_letter_head_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_lmm_letter_head_m
					WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl,
						1
					);
					
			WHEN p_table_name = 'fe_lmm_letter_head_param_m' THEN
				SELECT MAX(CAST(REPLACE(a5, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_lmm_letter_head_param_m
					WHERE SUBSTR(a5 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl,
						1
					);
			
			WHEN p_table_name = 'fe_lmm_letter_variable_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_lmm_letter_variable_m
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl,
						1
					);
					
			WHEN p_table_name = 'fe_lmm_signatory_m' THEN
				SELECT MAX(CAST(REPLACE(a6, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_lmm_signatory_m
					WHERE SUBSTR(a6 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl,
						1
					);
					
			WHEN p_table_name = 'fe_lmm_signatory_param_m' THEN
				SELECT MAX(CAST(REPLACE(a5, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_lmm_signatory_param_m
					WHERE SUBSTR(a5 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl,
						1
					);
					
			WHEN p_table_name = 'fe_wfm_rule_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_rule_m
					WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wfm_rule_parameter_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_rule_parameter_m
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wfm_rule_parameter_map_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_rule_parameter_map_m
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wfm_rule_activity_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_rule_activity_m
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wfm_rule_transition_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_rule_transition_m
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_core_field_rel_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_field_rel_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
                    
			WHEN p_table_name = 'fe_core_form_relation_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_form_relation_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			WHEN p_table_name = 'fe_core_form_rel_map_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_form_rel_map_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);		
			WHEN p_table_name = 'fe_core_form_hook_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_form_hook_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			WHEN p_table_name = 'fe_core_table_hook_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_table_hook_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			WHEN p_table_name = 'fe_core_field_validation_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_field_validation_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			
			WHEN p_table_name = 'fe_core_form_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_form_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			WHEN p_table_name = 'fe_core_form_rel_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_form_rel_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			WHEN p_table_name = 'fe_core_grid_field_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_grid_field_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			WHEN p_table_name = 'fe_core_grid_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_grid_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			WHEN p_table_name = 'fe_core_lookup_m' THEN
				SELECT MAX(CAST(REPLACE(luk_code, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_lookup_m
					WHERE SUBSTR(luk_code FROM 1 FOR LENGTH(l_code)) = l_code;
			
			WHEN p_table_name = 'fe_core_module_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_module_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
						
			WHEN p_table_name = 'fe_core_controller_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_controller_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_core_grid_table_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_grid_table_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			WHEN p_table_name = 'fe_core_grid_where_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_grid_where_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_core_grid_sort_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_grid_sort_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_core_grid_group_by_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_grid_group_by_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			WHEN p_table_name = 'fe_core_grid_button_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_grid_button_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);		
				
			WHEN p_table_name = 'fe_core_table_relation_m' THEN
				SELECT MAX(CAST(REPLACE(rel_code, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_table_relation_m
					WHERE SUBSTR(rel_code FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);			
			WHEN p_table_name = 'fe_core_db_function_m' THEN
				SELECT MAX(CAST(REPLACE(fnx_code, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_db_function_m
					WHERE SUBSTR(fnx_code FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);	
			
			WHEN p_table_name = 'fe_core_db_function_param_m' THEN
				SELECT MAX(CAST(REPLACE(fnp_code, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_db_function_param_m
					WHERE SUBSTR(fnp_code FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);	
			
			WHEN p_table_name = 'fe_core_layout_m' THEN
				SELECT MAX(CAST(REPLACE(lay_code, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_layout_m
					WHERE SUBSTR(lay_code FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			WHEN p_table_name = 'fe_dmm_file_m' THEN
				SELECT MAX(CAST(REPLACE(a9, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_dmm_file_m
					WHERE SUBSTR(a9 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1 
					);	
					
			WHEN p_table_name = 'fe_wfm_process_activity_m' THEN
				SELECT MAX(CAST(REPLACE(a5, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_process_activity_m
					WHERE SUBSTR(a5 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			WHEN p_table_name = 'fe_wfm_business_profile_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_business_profile_m
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			WHEN p_table_name = 'fe_wfm_process_transition_m' THEN
				SELECT MAX(CAST(REPLACE(a5, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_process_transition_m
					WHERE SUBSTR(a5 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);	
			
			WHEN p_table_name = 'fe_wfm_process_parameter_m	' THEN
				SELECT MAX(CAST(REPLACE(a5, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_process_parameter_m
					WHERE SUBSTR(a5 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			WHEN p_table_name = 'fe_wfm_process_activity_param_m' THEN
				SELECT MAX(CAST(REPLACE(a5, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_process_activity_param_m
					WHERE SUBSTR(a5 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wfm_process_parameter_map_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_process_parameter_map_m
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wfm_task_m' THEN
				SELECT MAX(CAST(REPLACE(a2, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_task_m
					WHERE SUBSTR(a2 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wfm_task_performer_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_task_performer_m
					WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wfm_task_notification_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_task_notification_m
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wfm_task_timeout_action_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_task_timeout_action_m
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_wfm_process_version_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_process_version_m
					WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			WHEN p_table_name = 'fe_wft_task_t' THEN
				SELECT MAX(CAST(REPLACE(a7, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wft_task_t
					WHERE SUBSTR(a7 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
			);
			WHEN p_table_name = 'fe_wft_task_performer_t' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wft_task_performer_t
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
			);
			WHEN p_table_name = 'fe_wft_task_timeout_action_t' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wft_task_timeout_action_t
					WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
			);
					
			WHEN p_table_name = 'fe_wfm_process_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_wfm_process_m
					WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
					
			WHEN p_table_name = 'fe_dmm_tag_t' THEN
				SELECT MAX(CAST(REPLACE(a6, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_dmm_tag_t
					WHERE SUBSTR(a6 FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
							
			WHEN p_table_name = 'fe_core_theme_m' THEN
				SELECT MAX(CAST(REPLACE(thm_code, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_theme_m
					WHERE SUBSTR(thm_code FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			
			WHEN p_table_name = 'fe_core_form_button_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED))  INTO l_max_seq FROM fe_core_form_button_m
					WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
					AND IF(
						l_l3_flag, 
						cl = p_cl ,
						1
					);
			 WHEN p_table_name = 'fe_core_dtt_change_reason_m' THEN
				SELECT MAX(CAST(REPLACE(dtt_code, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_dtt_change_reason_m 
				WHERE SUBSTR(dtt_code FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl ,
					1
				);
			WHEN p_table_name = 'fe_core_table_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_table_m 
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl ,
					1
				);
			WHEN p_table_name = 'fe_core_table_col_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_table_col_m 
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl ,
					1
				);
			WHEN p_table_name = 'fe_core_form_condition_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_form_condition_m 
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					,
					1
				);
			WHEN p_table_name = 'fe_core_field_condition_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_field_condition_m 
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					,
					1
				);
			WHEN p_table_name = 'fe_core_field_layout_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_field_layout_m 
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					,
					1
				);
			WHEN p_table_name = 'fe_core_controller_component_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_controller_component_m 
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					,
					1
				);
                
			WHEN p_table_name = 'fe_core_controller_item_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_controller_item_m 
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					,
					1
				);
			WHEN p_table_name = 'fe_wfm_task_m' THEN
				SELECT MAX(CAST(REPLACE(`a2`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_wfm_task_m 
				WHERE SUBSTR(`a2` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
			
			WHEN p_table_name = 'fe_core_controller_action_map_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_controller_action_map_m 
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					,
					1
				);
                
			WHEN p_table_name = 'fe_core_controller_component_rel_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_controller_component_rel_m 
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					,
					1
				);
		
			WHEN p_table_name = 'fe_core_form_section_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_form_section_m 
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					,
					1
				);
				
			WHEN p_table_name = 'fe_cfg_org_unit_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_cfg_org_unit_m 
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					,
					1
				);
				
			WHEN p_table_name = 'fe_cfg_org_unit_property_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_cfg_org_unit_property_m 
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
                
			WHEN p_table_name = 'fe_core_controller_api_endpoint_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_controller_api_endpoint_m 
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					,
					1
				);
				
				
			WHEN p_table_name = 'fe_core_controller_api_param_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_controller_api_param_m 
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					,
					1
				);
				
			WHEN p_table_name = 'fe_tst_location_m' THEN
				SELECT MAX(CAST(REPLACE(`a9`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_tst_location_m 
				WHERE SUBSTR(`a9` FROM 1 FOR LENGTH(l_code)) = l_code;
				
			WHEN p_table_name = 'fe_core_form_section_item_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_form_section_item_m 
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					,
					1
				);  
				
			WHEN p_table_name = 'fe_cfg_org_unit_rel_m' THEN
				SELECT MAX(CAST(REPLACE(`a2`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_cfg_org_unit_rel_m 
				WHERE SUBSTR(`a2` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					,
					1
				);  
				
			WHEN p_table_name = 'fe_hrm_business_group_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_business_group_m 
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_hrm_legal_entity_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_legal_entity_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_hrm_pay_group_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_pay_group_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_hrm_business_unit_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_business_unit_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
					
			WHEN p_table_name = 'fe_hrm_zone_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_zone_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);			
			
			WHEN p_table_name = 'fe_hrm_location_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_location_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
			
			WHEN p_table_name = 'fe_hrm_department_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_department_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
			
			WHEN p_table_name = 'fe_hrm_division_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_division_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
			
			WHEN p_table_name = 'fe_hrm_designation_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_designation_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);	
			
			WHEN p_table_name = 'fe_hrm_salary_grade_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_salary_grade_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_hrm_cost_center_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_cost_center_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
			
			WHEN p_table_name = 'fe_hrm_band_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_band_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
			
			WHEN p_table_name = 'fe_hrm_level_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_level_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_wfm_global_variable_m' THEN
				SELECT MAX(CAST(REPLACE(`a9`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_wfm_global_variable_m
				WHERE SUBSTR(`a9` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_acm_role_m' THEN
				SELECT MAX(CAST(REPLACE(`a4`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_acm_role_m
				WHERE SUBSTR(`a4` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_acm_role_type_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_acm_role_type_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);	
			
			WHEN p_table_name = 'fe_fdk_faq_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_fdk_faq_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_core_selection_header_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_selection_header_m
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_hrm_qualification_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_qualification_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);	
				
			WHEN p_table_name = 'fe_hrm_degree_m' THEN
				SELECT MAX(CAST(REPLACE(`a4`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_degree_m
				WHERE SUBSTR(`a4` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_hrm_specialization_m' THEN
				SELECT MAX(CAST(REPLACE(`a5`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hrm_specialization_m
				WHERE SUBSTR(`a5` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_core_form_group_by_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_form_group_by_m
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			
			WHEN p_table_name = 'fe_wfm_eligibility_filter_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_wfm_eligibility_filter_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_wfm_emp_eligibility_group_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_wfm_emp_eligibility_group_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_cron_process_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_cron_process_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_cron_process_job_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_cron_process_job_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_int_gallery_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_int_gallery_m
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
			
			WHEN p_table_name = 'fe_int_external_link_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_int_external_link_m
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_wgt_block_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_wgt_block_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);	
			
			WHEN p_table_name = 'fe_int_global_comm_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_int_global_comm_m
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_wgt_hover_card_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_wgt_hover_card_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_wgt_dashboard_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_wgt_dashboard_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_grc_compliance_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_grc_compliance_m
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);	
				
			WHEN p_table_name = 'fe_alm_leave_type_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_alm_leave_type_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_fmt_file_bucket_g' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_fmt_file_bucket_g
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					-- cl = p_cl 
					-- AND lg  = fe_get_legislation_id_f(),
					1,
					1
				);
				
			WHEN p_table_name = 'fe_fmt_file_folder_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_fmt_file_folder_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_acm_dag_m' THEN
				SELECT MAX(CAST(REPLACE(a2, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_acm_dag_m
				WHERE SUBSTR(a2 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_acm_profile_m' THEN
				SELECT MAX(CAST(REPLACE(a2, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_acm_profile_m
				WHERE SUBSTR(a2 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_acm_profile_rule_m' THEN
				SELECT MAX(CAST(REPLACE(a5, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_acm_profile_rule_m
				WHERE SUBSTR(a5 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_fmt_media_format_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_fmt_media_format_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_cfg_org_unit_type_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_cfg_org_unit_type_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_cfg_org_unit_type_rel_m' THEN
				SELECT MAX(CAST(REPLACE(a2, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_cfg_org_unit_type_rel_m
				WHERE SUBSTR(a2 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_wfm_approver_type_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_wfm_approver_type_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
			
			WHEN p_table_name = 'fe_org_unit_m' THEN
				SELECT MAX(CAST(REPLACE(`a4`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_org_unit_m
				WHERE SUBSTR(`a4` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl 
					AND lg  = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_rpt_report_m' THEN
				SELECT MAX(CAST(REPLACE(`a4`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_rpt_report_m
				WHERE SUBSTR(`a4` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_alm_shift_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_alm_shift_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_alm_calender_m' THEN
				SELECT MAX(CAST(REPLACE(`a4`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_alm_calender_m
				WHERE SUBSTR(`a4` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);		
				
			WHEN p_table_name = 'fe_rpt_report_filter_m' THEN
				SELECT MAX(CAST(REPLACE(`a7`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_rpt_report_filter_m
				WHERE SUBSTR(`a7` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_core_business_process_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_business_process_m
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_core_business_process_param_m' THEN
				SELECT MAX(CAST(REPLACE(`code`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_core_business_process_param_m
				WHERE SUBSTR(`code` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_prj_issue_tracker_t' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_prj_issue_tracker_t
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_prj_project_m' THEN
				SELECT MAX(CAST(REPLACE(`a4`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_prj_project_m
				WHERE SUBSTR(`a4` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_alm_roster_plan_t' THEN
				SELECT MAX(CAST(REPLACE(`a2`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_alm_roster_plan_t
				WHERE SUBSTR(`a2` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_glb_country_g' THEN
				SELECT MAX(CAST(REPLACE(`a5`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_glb_country_g
				WHERE SUBSTR(`a5` FROM 1 FOR LENGTH(l_code)) = l_code;
				
			WHEN p_table_name = 'fe_glb_state_g' THEN
				SELECT MAX(CAST(REPLACE(`a5`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_glb_state_g
				WHERE SUBSTR(`a5` FROM 1 FOR LENGTH(l_code)) = l_code;
				
			WHEN p_table_name = 'fe_cfg_country_m' THEN
				SELECT MAX(CAST(REPLACE(`a6`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_cfg_country_m
				WHERE SUBSTR(`a6` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_cfg_state_m' THEN
				SELECT MAX(CAST(REPLACE(`a6`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_cfg_state_m
				WHERE SUBSTR(`a6` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
			
			WHEN p_table_name = 'fe_int_event_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_int_event_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_fmt_file_def_m' THEN
				SELECT MAX(CAST(REPLACE(`a4`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_fmt_file_def_m
				WHERE SUBSTR(`a4` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_fmt_file_param_m' THEN
				SELECT MAX(CAST(REPLACE(`a5`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_fmt_file_param_m
				WHERE SUBSTR(`a5` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_wfm_notification_action_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_wfm_notification_action_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_alm_attendance_cycle_rule_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_alm_attendance_cycle_rule_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
			
			WHEN p_table_name = 'fe_alm_workhour_rule_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_alm_workhour_rule_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
			
			WHEN p_table_name = 'fe_alm_overtime_rule_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_alm_overtime_rule_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_alm_absconding_rule_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_alm_absconding_rule_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_cron_process_recurrence_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_cron_process_recurrence_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
			
			WHEN p_table_name = 'fe_pyt_salary_prism_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_pyt_salary_prism_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
					
			
			WHEN p_table_name = 'fe_pyt_pt_region_g' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_pyt_pt_region_g
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					lg = fe_get_legislation_id_f(),
					1
				);
				
			WHEN p_table_name = 'fe_org_ndc_dept_m' THEN
				SELECT MAX(CAST(REPLACE(`a3`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_org_ndc_dept_m
				WHERE SUBSTR(`a3` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);	
				
			WHEN p_table_name = 'fe_snf_qnr_m' THEN
				SELECT MAX(CAST(REPLACE(`a5`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_snf_qnr_m
				WHERE SUBSTR(`a5` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_snf_qnr_section_m' THEN
				SELECT MAX(CAST(REPLACE(`a4`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_snf_qnr_section_m
				WHERE SUBSTR(`a4` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_snf_qnr_block_m' THEN
				SELECT MAX(CAST(REPLACE(`a5`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_snf_qnr_block_m
				WHERE SUBSTR(`a5` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_snf_qnr_ques_m' THEN
				SELECT MAX(CAST(REPLACE(`a6`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_snf_qnr_ques_m
				WHERE SUBSTR(`a6` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);	
				
			WHEN p_table_name = 'fe_snf_qnr_ques_option_m' THEN
				SELECT MAX(CAST(REPLACE(`a6`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_snf_qnr_ques_option_m
				WHERE SUBSTR(`a6` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_cng_chart_m' THEN
				SELECT MAX(CAST(REPLACE(`a6`, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_cng_chart_m
				WHERE SUBSTR(`a6` FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag, 
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_rec_resume_parser_name_g' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_rec_resume_parser_name_g
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					1,
					1
				);
				
			WHEN p_table_name = 'fe_rec_resume_parser_company_g' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_rec_resume_parser_company_g
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					1,
					1
				);
				
			WHEN p_table_name = 'fe_rec_resume_parser_designation_g' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_rec_resume_parser_designation_g
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					1,
					1
				);
				
			WHEN p_table_name = 'fe_rec_resume_parser_language_g' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_rec_resume_parser_language_g
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					1,
					1
				);
				
			WHEN p_table_name = 'fe_rec_resume_parser_skill_g' THEN
				SELECT MAX(CAST(REPLACE(a5, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_rec_resume_parser_skill_g
				WHERE SUBSTR(a5 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					1,
					1
				);
			WHEN p_table_name = 'fe_cng_data_file_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_cng_data_file_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					1,
					1
				);
			WHEN p_table_name = 'fe_cng_data_file_col_m' THEN
				SELECT MAX(CAST(REPLACE(a5, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_cng_data_file_col_m
				WHERE SUBSTR(a5 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					1,
					1
				);
			WHEN p_table_name = 'fe_wgt_cng_dashboard_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_wgt_cng_dashboard_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					1,
					1
				);
			WHEN p_table_name = 'fe_wgt_cng_dashboard_panel_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_wgt_cng_dashboard_panel_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					1,
					1
				);
			WHEN p_table_name = 'fe_rec_jd_m' THEN
				SELECT MAX(CAST(REPLACE(a2, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_rec_jd_m
				WHERE SUBSTR(a2 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_rec_requisition_template_m' THEN
				SELECT MAX(CAST(REPLACE(a2, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_rec_requisition_template_m
				WHERE SUBSTR(a2 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_rec_requisition_t' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_rec_requisition_t
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_fap_vendor_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_fap_vendor_m
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_lnd_course_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_lnd_course_m
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_lnd_venue_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_lnd_venue_m
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_lnd_trainer_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_lnd_trainer_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
				
			WHEN p_table_name = 'fe_lnd_emp_nomination_t' THEN
				SELECT MAX(CAST(REPLACE(a9, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_lnd_emp_nomination_t
				WHERE SUBSTR(a9 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_pms_section_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_pms_section_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_pms_template_m' THEN
				SELECT MAX(CAST(REPLACE(a5, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_pms_template_m
				WHERE SUBSTR(a5 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_pms_template_section_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_pms_template_section_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_pms_template_stage_m' THEN
				SELECT MAX(CAST(REPLACE(a6, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_pms_template_stage_m
				WHERE SUBSTR(a6 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);	
			WHEN p_table_name = 'fe_pms_template_section_access_m' THEN
				SELECT MAX(CAST(REPLACE(a6, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_pms_template_section_access_m
				WHERE SUBSTR(a6 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_pms_template_section_access_m' THEN
				SELECT MAX(CAST(REPLACE(a6, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_pms_template_section_access_m
				WHERE SUBSTR(a6 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_pms_round_t' THEN
				SELECT MAX(CAST(REPLACE(a5, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_pms_round_t
				WHERE SUBSTR(a5 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_pms_round_section_t' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_pms_round_section_t
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_pms_round_stage_t' THEN
				SELECT MAX(CAST(REPLACE(a6, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_pms_round_stage_t
				WHERE SUBSTR(a6 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_pms_goal_category_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_pms_goal_category_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_pms_goal_m' THEN
				SELECT MAX(CAST(REPLACE(a6, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_pms_goal_m
				WHERE SUBSTR(a6 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_pms_stage_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_pms_stage_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);	
			WHEN p_table_name = 'fe_pms_goal_perspective_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_pms_goal_perspective_m
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_cfg_rating_scale_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_cfg_rating_scale_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);							
			WHEN p_table_name = 'fe_alm_att_bulk_action_t' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_alm_att_bulk_action_t
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_lnd_session_t' THEN
				SELECT MAX(CAST(REPLACE(a5, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_lnd_session_t
				WHERE SUBSTR(a5 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_hdm_ticket_cat_m' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hdm_ticket_cat_m
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_hdm_support_group_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hdm_support_group_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_hdm_ticket_t' THEN
				SELECT MAX(CAST(REPLACE(a13, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_hdm_ticket_t
				WHERE SUBSTR(a13 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_tne_item_type_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_tne_item_type_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_tne_items_m' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_tne_items_m
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_tne_emp_report_detail_t' THEN
				SELECT MAX(CAST(REPLACE(a6, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_tne_emp_report_detail_t
				WHERE SUBSTR(a6 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_tne_emp_report_t' THEN
				SELECT MAX(CAST(REPLACE(a4, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_tne_emp_report_t
				WHERE SUBSTR(a4 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_int_game_board_t' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_int_game_board_t
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);
			WHEN p_table_name = 'fe_int_badge_t' THEN
				SELECT MAX(CAST(REPLACE(a3, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_int_badge_t
				WHERE SUBSTR(a3 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
					l_l3_flag,
					cl = p_cl,
					1
				);	
			 WHEN p_table_name = 'fe_tne_emp_travel_detail_t' THEN
				SELECT MAX(CAST(REPLACE(a9, l_code, '') AS SIGNED)) INTO l_max_seq FROM fe_tne_emp_travel_detail_t
				WHERE SUBSTR(a9 FROM 1 FOR LENGTH(l_code)) = l_code
				AND IF(
				l_l3_flag,
				cl = p_cl,
					1
				);
			ELSE
				SET l_seq = 'ERR';
		END CASE;
		IF l_seq != 'ERR' THEN
			SET l_max_seq = IFNULL(l_max_seq, 0) + 1;
			SET l_seq = CONCAT(l_code, LPAD(l_max_seq, p_length, 0));
		END IF;
		RETURN l_seq;
	END$$

DELIMITER ;