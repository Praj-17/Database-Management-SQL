

SELECT 
        t4.cl, t4.lg,   t2.label, t3.col_name, t1.name, t1.lov, t3.key_type,t3.fk_table,t3.fk_column
FROM    
                `fe_core_field_m` t1
                 JOIN `fe_core_form_g` t2 ON(t1.form_id = t2.id)
                JOIN `fe_core_table_col_g` t3 ON(t3.id = t1.db_col_id)
                JOIN `fe_core_table_g` t4 ON(t4.id = t3.table_id)
WHERE 1
    AND t4.name =  'fe_hrt_emp_summary_t'
#change table name
    AND t1.cl = 1
     -- AND t4.lg = 2
ORDER BY t2.id,
CASE SUBSTR(col_name, 1, 1)
WHEN 'a' THEN 1
WHEN 'c' THEN 2
ELSE 3
END, REPLACE(REPLACE(col_name, 'a', ''), 'c', '')*1 ;


SELECT 
    a1, a2, a3, a4, AES_DECRYPT(a4, 'Wm4sJLmTSvttCWhD'), a7
FROM
    fe_acm_user_t
LIMIT 10;


/************* Org Unit ************************************/
    
select * from fe_org_unit_m where cl = 7 order by a1 desc limit 10
        
select * from fe_org_unit_detail_m order by a1 desc limit 10



use dev;
select * from fe_hri_person_d where a5 = 'Prajwal';

select CONCAT(p.a5,' ',p.a6,p.a7) from fe_hri_person_d p;
select * from fe_hri_person_t where a1 = 92405;

select * from fe_hrt_emp_summary_t where a3 = 518; -- a. Two records, b. who_cols

select a2 person_id, a3 person_type, a4 original_doj, a5 joining_date, a6 hiring_source, a8 lwd, a9 primary_exit_reason, a10 sec_exit_reason,
a11 off_email, a12 active, a16 pay_start_month, a26 business_group, a26 legal_entity
from fe_hrt_emp_employment_t where a2 = 92405; -- what goes in a38?, 

select * from fe_hrt_emp_employment_t where a2 = 92319;


select * from fe_hrt_emp_job_d where a2 = 92405;

select a2 person_id, a3 emp_id,a4 employee_no, a5 legacy_employee_number, a6 employement_status, a7 job_type, 
ou1 business_group, ou2 legal_entity, ou3 payroll_group, ou4 cost_center, ou5 business_unit, ou6 dept, ou7 sub_department, ou8 zone,
ou9 location, ou10 designation, ou11 salary_grade, ou12 role_band, ou13 level
from fe_hrt_emp_job_t where a2 = 92405; -- why a10 and a25 both?

select a2 emp_id, a3 user_name, a5 pwd_last_changed, a6 profile, a7 roles, a8 active, a9 switch_as_user, 
a10 is_power_user, a11 is_developer, a12 is_blocked, a13 locked_till, a14 last_login
from fe_acm_user_t where a2 = 50303; -- value in user_name is null

select * from fe_acm_user_t order by a1 desc limit 100 where a2 = 50249;

select a3, AES_DECRYPT(a4, 'Wm4sJLmTSvttCWhD') from 	fe_acm_user_t ;

select * from fe_alm_leave_type_m





FET_105@flexiele.com / sxlaaalsnj

select a2 emp_id, a3 leave_type_id, a4 carry_forward, a5 accrued, a6 additional_availed, a7 lapsed, a8 encashed, 
a9 leave_cal_start_date, a10 leave_cal_end_date, a11 month
from fe_alm_emp_leave_balance_t where a2 = 50249

/********** Test Data *****************************/

select * from fe_wft_approver_t where a2 = 518

select * from fe_hrt_emp_employment_t where a1 in (518,67,494,519) -- 519 sandeep

select * from fe_hrt_emp_summary_t where a3 in (518,67,494,519)

select * from fe_acm_user_t where a2 in (67,519) -- 6,1,2,3,5,8,17

Emp -- CRF01532 Nikhil Soni  518
Mgr -- CRF01059 Harsh Mittal  67
Emp -- CRF01508 Kevin Rahul  494
Mgr -- CRF01533 Sandeep Kumar 519

/********** Attendance *****************************/

select a2 emp_id, a3 date, a4 in_time, a5 out_time, a6 shift_time_id, a7 total_time, a12 fh_status, a13 sh_status
 from fe_alm_emp_attendance_t 
 where 1  and a2 = 518
 -- and a5 is not null
 order by a3 desc limit 1000



select a2 emp_id, a3 biometric_id, a4 fetched_timestamp, a5 punch_cat, a6 timestamp, a7 timestamp_unedited, a8 mahcine_timestamp_id,
a9 date, a10 date_timestamp, a11 time_timestamp, a12 date_seq , a13 month_seq, a14 process_status , a15 process_code, a16 shift_time_id,
a17 correction_reason , a18 origin, a19 lat_long, a20 location_name
from fe_alm_emp_punch_t where a2 = 494 order by a4 desc


select a2 title, a3 ref_code, a4 cycle_type, a5 start_day, a6 cut_off_day, a7 grace_period_adm, a8 recall_limit_adm,
a9 manual_edit_adm, a10 grace_period_mss, a11 recall_limit_mss, a12 manual_edit_mss, a13 grace_period_ess, a14 recall_limit_ess,a15 manual_edit_ess,
a16 is_active, a17 elig_criteria
from fe_alm_attendance_cycle_rule_m

select a2 title, a3 sys_ref_code, a4 per_day_grace_late, a5 exempted_late_count, a6 exempted_late_per_day, a7 per_month_grace_late,
a8 combine_late_with_early, a9 per_day_grace_early, a10 exempted_early_count, a11 exempted_early_out_per_day, a12 per_month_grace_early,
a13 absent_min_hour, a14 half_day_absent_min_hour, a15 absent_after_intime, a16 absent_before_out_time, a17 absent_adavance_criteria,
a18 short_hour_flag, a19 timebreak_flag, a20 elig_rules, a21 short_hour_advance_criteria, a22 min_swipes_to_mark_present, a23 adjust_rule,
a24 time_tracking_flag, a25 process_type
from fe_alm_workhour_rule_m

select a2 title, a3 sys_ref_code, a4 adjust_time_flag, a5 ot_flag_intime, a6 ot_flag_out_time, a7 ot_per_day_limit, 
a8 ot_per_month_limit , a9 additional_ot_hour_flag , a10 additional_ot_time_flag, a11 weekly_off_ot_flag, a12 ot_payment_type, 
a13 elig_criteria, a14 trim_grace_period, a15 out_time_limit ,  a16  trim_grace_period_wo, a17 min_ot_hours_wo , 
a18 trim_range, a19 , a20
from fe_alm_overtime_rule_m

a2 , a3 , a4 , a5 , a6 , a7 , a8 , a9 , a10 , a11 , a12 , a13 , a14 , a15 ,  a16 , a17 , a18 , a19 , a20


select a2 emp_id, a3 time_tracking, a4 default_attendance, a5 on_roster, a6 applicable_shifts, a8 shift_group, a9 holiday_calender, a10 weeklyoff_calendar,
a11 attendance_cycle, a12 work_hour_policy_id, a13 appl_absconding_policies, a14 overtime_policy, a15 appl_client_locations, c1 loss_of_leave_ts
from fe_alm_emp_att_config_d where a2 = 50249


/********** Probation *****************************/
select a2 emp_id, a3 doc, a4 actual_doc, a4 new_confirmation_date, a5 status, a6 comments, a7 development_areas, a8 strengths, a9 expectation_discussed,
a10 feedback_count, a11 guidance_provided, a12 param_one, a13 param_two, a14 param_three, a21 action, a23 score
from fe_hrt_emp_probation_t where a2 in ( 50249, 20746)

-- Probation Status Lookup
SELECT a3 as `code`, a4 as `meaning`, a4 as `tip` from fe_cfg_lookup_m WHERE a7 = 1 AND cl = 1 AND a2 = 4000025 ORDER BY a8;

select * from fe_hrt_emp_probation_t where a2 in ( 50249, 20746)


/********** Shift *****************************/

select a2 shift_name, a3 shift_ref_code, a4 shift_group, a5 is_active, a6 start_time , a7 end_time, a8 earliest_in, a9 latest_out, a10 lunch_start_time,
a11 lunch_end_time, a12 shift_auto_selection_window, a13 eligibility_rule, a14 cond_eligibility_rule, a15 is_roster_shift, a16 roster_holiday_sync,
a17 has_time_break, a18 time_break_start_time, a19 time_break_end_time, a20 legal_entity
from fe_alm_shift_m order by a1 desc limit 10


/********** whatsapp *****************************/

select a1,a2 emp_id,a3 document_id,a4 status,a5 uploaded_by,a6 uploaded_when,a7 verified_by,a8 verified_when,a9 upload_file_id,a10 file_def_id
from fe_hrt_emp_doc_t ;

select * from fe_hrt_emp_doc_t;

select * from fe_hri_emp_contact_t where a2 = 5;

select * from fe_hrt_emp_summary_t where a3 in ( 494,519)

select a1,a2 title, a3 type,a4 file_id, a5 letter_id, a6 folder_name,a7 eligibility_criteria, a8 show_condition, a9 is_new_hire_document,
a10 is_mandatory_document, a11 status, a12 employee_download_access, a13 employee_upload_access
from fe_cfg_emp_doc_m;

SELECT
	a3 AS code,
	a4 AS meaning,
	'' AS tip
FROM
	fe_glb_lookup_m
WHERE
	1
	AND a2 = 1000129
	AND a7 = 1
ORDER BY
	a8 ASC;



SELECT `a1` `code`,
  CONCAT(`a3`, ' (', `a2`, ' - ', `a4`, ')') `meaning`,
  CONCAT(`a3`, ' (', `a2`, ' - ', `a4`, ')') `tip`  
FROM
  `fe_wfm_emp_eligibility_group_m`
WHERE 1
 AND cl = {session.clientId}
 AND a5 = 1;



select *
from fe_hrt_emp_probation_t order by when_updated desc limit 10


SELECT * --  `a1` `code`, CONCAT(`a4`, ' (', `a2`, ' - ', `a3`, ')') `meaning`, CONCAT(`a4`, ' (', `a2`, ' - ', `a3`, ')') `tip`  
FROM
  `fe_wfm_function_m`
WHERE 1
 AND cl = 1
 AND a11 = 1
 AND a6 = 4; 
 
 SELECT 
  `code`,
  `meaning`,
  `tip` 
FROM
  `fe_core_lookup_m` 
WHERE 1  
  AND `category` = 'CORE_FUNCTION_TYPE' 
  AND `active` = 1 
ORDER BY `order`











