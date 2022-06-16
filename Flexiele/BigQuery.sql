-- *----To Check For Whom the Request is pending with for Regularization —*


SELECT
	taskPerformer.a1 as `id`,
	CONCAT(apr_summary.a4,'[',apr_summary.a5,']') AS `task_perfomer_name`,
	CONCAT(IFNULL(TRIM(per.a5), ''), IF(IFNULL(TRIM(per.a6), '')= '', '', CONCAT(' ', TRIM(per.a6))), IF(IFNULL(TRIM(per.a7), '')= '', '', CONCAT(' ', TRIM(per.a7)))) as `emp_name`,
	job.a4 AS `emp_code`,
	CASE
		WHEN IFNULL(shfm.a17, 0) != 1    
     THEN CONCAT(DATE_FORMAT(IFNULL(lr.a6, ''), '%d-%b-%y'), ', In Time - ', DATE_FORMAT(lr.a17, '%H:%i'), ', Out Time - ',
                    DATE_FORMAT(lr.a18, '%H:%i'))
		WHEN shfm.a17 = 1 THEN CONCAT(DATE_FORMAT(IFNULL(lr.a6, ''), '%d-%b-%y'), IFNULL(CONCAT(', First Half In Time - ', DATE_FORMAT(IFNULL(lr.a17, ''), '%H:%i')), ''),  
                   IFNULL(CONCAT(', First Half Out Time - ', DATE_FORMAT(IFNULL(lr.a18, ''), '%H:%i')), ''), '<br />', IFNULL(CONCAT('Second Half In Time - ', DATE_FORMAT(IFNULL(lr.a24, ''), '%H:%i')), ''), IFNULL(CONCAT(', Second Half Out Time - ', DATE_FORMAT(IFNULL(lr.a25, ''), '%H:%i')), ''))
	END as `desc`,
	CONCAT( IFNULL( CONCAT('Late Coming-', fe_get_cfg_lookup_meaning_f(taskT.cl, 4000013, lr.a21), ', '), '' ), IFNULL( CONCAT('Early Leaving-', fe_get_cfg_lookup_meaning_f(taskT.cl, 4000014, lr.a22), ', '), '' ),
  IFNULL(CONCAT('Comments-', lr.a23), '') ) as `change_reason`,
	lr.a1 as `request_id`,
	lr.a23 as `comment`,
	fe_get_cfg_lookup_meaning_f(taskT.cl,
	4000013,
	lr.a21) as `late_coming_reason`,
	fe_get_cfg_lookup_meaning_f(taskT.cl,
	4000014,
	lr.a22) as `early_leaving_reason`,
	DATE_FORMAT(IFNULL(lr.a6, ''), '%d-%b-%y') as `reg_day`,
	DATE_FORMAT(IFNULL(lr.when_created, ''), '%d-%b-%y') as `req_date`,
	CONCAT('In Time-', DATE_FORMAT(IFNULL(att.a4, ''), '%H:%i'), ', Out Time-', DATE_FORMAT(IFNULL(att.a5, ''), '%H:%i')) as `orig_time`,
	per.a23 as `profile_photo`,
	per.a8 as `gender`,
	lr.a15 as `status`,
	DATE_FORMAT(IFNULL(lr.a6, ''), '%d-%b-%y') as `date`,
	DATE_FORMAT(IFNULL(att.a4, ''), '%H:%i') as `in_time`,
	DATE_FORMAT(IFNULL(att.a5, ''), '%H:%i') as `out_time`,
	DATE_FORMAT(IFNULL(lr.a31, ''), '%H:%i') as `out_time_fh`,
	DATE_FORMAT(IFNULL(lr.a32, ''), '%H:%i') as `in_time_sh`,
	DATE_FORMAT(IFNULL(lr.a17, ''), '%H:%i') as `edited_in_time`,
	DATE_FORMAT(IFNULL(lr.a18, ''), '%H:%i') as `edited_out_time`,
	DATE_FORMAT(IFNULL(lr.a24, ''), '%H:%i') as `edited_in_time_sh`,
	DATE_FORMAT(IFNULL(lr.a25, ''), '%H:%i') as `edited_out_time_sh`,
	fe_get_cfg_lookup_meaning_f(taskT.cl,
	4000013,
	lr.a26) as `late_coming_reason_sh`,
	fe_get_cfg_lookup_meaning_f(taskT.cl,
	4000014,
	lr.a27) as `early_leaving_reason_sh`,
	IFNULL(shfm.a17, 0) as `is_break_shift`,
	emp.a1 as `emp_id`,
	IF(IFNULL(lr.a15, 0) BETWEEN 10 AND 19,
	1,
	0) as `approve`,
	IF(IFNULL(lr.a15, 0) BETWEEN 10 AND 19,
	1,
	0) as `reject`,
	IF(IFNULL(lr.a15, 0) BETWEEN 10 AND 19,
	1,
	0) as `past-regularization`,
	IF(IFNULL(lr.a15, 0) BETWEEN 10 AND 19,
	1,
	0) as `show-location`
FROM
	fe_wft_task_performer_t AS `taskPerformer`
JOIN fe_wft_task_t AS `taskT` ON
	(taskT.cl = taskPerformer.cl
		AND taskT.a1 = taskPerformer.a2)
JOIN fe_wfm_task_m AS `taskM` ON
	(taskM.cl = taskT.cl
		AND taskM.a1 = taskT.a2)
JOIN fe_alm_emp_attendance_request_t AS `lr` ON
	(lr.cl = taskT.cl
		AND lr.a1 =taskT.a6)
JOIN fe_hrt_emp_employment_t AS `emp` ON
	(lr.cl = emp.cl
		AND lr.a2 = emp.a1)
JOIN fe_hri_person_t AS `per` ON
	(emp.cl = per.cl
		AND emp.a2 = per.a1)
JOIN fe_hrt_emp_job_t AS `job`  
ON
	(job.a3 = emp.a1)
JOIN fe_wft_approver_t AS `appr` ON
	(taskPerformer.cl = appr.cl
		AND job.a10 = appr.a4
		AND taskPerformer.a10 = appr.a3
		AND (appr.a2 = lr.a2
			OR appr.a2 IS NULL))
JOIN fe_hrt_emp_job_t AS `apr_job` ON(apr_job.a3 = appr.a5 AND apr_job.cl = appr.cl)
JOIN fe_hrt_emp_summary_t `apr_summary` ON 
(apr_summary.cl = apr_job.cl AND apr_job.a3 = apr_summary.a3)
JOIN fe_alm_emp_attendance_t AS `att` ON
	(att.cl = lr.cl
		AND att.a2 = lr.a2
		AND att.a3 = lr.a6)
LEFT JOIN fe_alm_shift_timing_t AS `shft` ON
	(lr.a28 = shft.a1)
LEFT
JOIN fe_alm_shift_m AS `shfm` ON
	(shft.a2 = shfm.a1)
WHERE
	1
	AND taskPerformer.cl = 1
	AND taskPerformer.a7 = 1
	-- AND job.a4 IN ('1013659') # based on employee  code
	AND apr_job.a4 IN ('1011826') # based on approver employee code
	AND taskT.a9 = 1
	AND lr.a3 = 2
	AND ((IFNULL(lr.a15, '')= '10'))














*To Check If entries in attendance table exist for so employee could be able to raise Regularization OR Not *

SELECT
job.a4,
	att.*
FROM
	fe_alm_emp_attendance_t att
JOIN fe_hrt_emp_job_t job ON
	(att.a2 = job.a3 AND att.cl = job.cl)
JOIN fe_hrt_emp_employment_t emp ON
	(job.a3 = emp.a1 AND job.cl = emp.cl)
WHERE 1
AND att.cl = 1
AND job.a4 IN ('22663520','22663417','22663519') # Can be comma seprated for multiple employees
AND att.a3 = '2022-06-01' # From Date in attendace table. 




*For Instance if employee raised a request but  it shows it is pending with approval but you could not find the request then use this query to verify record in request table or you can use this query to select request for a range of tables*

SELECT
job.a4 emp_code,attr.a3 request_type,	
attr.*
FROM
	fe_alm_emp_attendance_request_t attr
JOIN fe_hrt_emp_job_t job ON
	(attr.a2 = job.a3 AND attr.cl = job.cl)
JOIN fe_hrt_emp_employment_t emp ON
	(job.a3 = emp.a1 AND job.cl = emp.cl)
WHERE 1
AND attr.cl = 1
AND job.a4 IN ('22663520') # Can be comma separated for multiple employees
-- AND attr.a6 = 'YYYY-MM-DD' # From Date in attendance table. 
-- AND (attr.a6 BETWEEN 'YYYY-MM-DD' AND 'YYYY-MM-DD')
AND attr.a3 = 2 # Form Regularization
/*
1->	Leave
2->	Attendance Correction
3->	On Site Visit
4->	Work from Home
5->	Leave Cancellation
6->	Comp Off Accumulation
 */


*To Check If entries in task table exist or not for that particular task at that particular date. *
# Task Table Entry exist or not
SELECT
	CONCAT(apr_summary.a4,'[',apr_summary.a5,']') AS `task_perfomer_name`,
	taskT.*
FROM
	fe_wft_task_t taskT
JOIN fe_wfm_task_m taskM ON(taskT.cl = taskM.cl AND taskT.a2 = taskM.a1)
JOIN fe_hrt_emp_job_t jobE ON(jobE.cl=taskT.cl AND jobE.a3 = taskT.a4)
JOIN fe_hrt_emp_employment_t empE ON(jobE.a3 = empE.a1 AND jobE.cl = empE.cl)
JOIN fe_wft_task_performer_t AS taskPerformer ON(taskT.cl = taskPerformer.cl AND taskT.a1 = taskPerformer.a2)
JOIN fe_wft_approver_t AS `appr` ON
	(taskPerformer.cl = appr.cl
		AND jobE.a10 = appr.a4
		AND taskPerformer.a10 = appr.a3
		AND (appr.a2 = taskT.a4
			OR appr.a2 IS NULL))
JOIN fe_hrt_emp_job_t AS `apr_job` ON(apr_job.a3 = appr.a5 AND apr_job.cl = appr.cl)
JOIN fe_hrt_emp_summary_t `apr_summary` ON 
(apr_summary.cl = apr_job.cl AND apr_job.a3 = apr_summary.a3)
WHERE 1
AND taskT.cl = 1
AND jobE.a4 IN ('1013659')#<emp_code>
-- AND apr_job.a4 IN ('1011826')# <approver_code>
AND taskM.a2 ='WTM0000027' 
/*
 * WTM0000027 for regularization
 * WTM0000026 for leave
 * WTM0000028 for cancel leave
 */
AND taskPerformer.a7 = 1 # pending request
AND taskT.a9 = 1 # pending task
-- AND taskT = <request_Id>
-- AND taskT.when_created BETWEEN DATE('2022-04-01') AND DATE('2022-06-30')


*To Check The Lapsed Value of employee for that year*
SELECT
	bal.*
FROM
	fe_alm_emp_leave_balance_t bal
JOIN fe_hrt_emp_job_t job ON
	(bal.a2 = job.a3 AND bal.cl = job.cl)
JOIN fe_hrt_emp_employment_t emp ON
	(job.a3 = emp.a1 AND job.cl = emp.cl)
WHERE 1
AND bal.cl = 1
AND job.a4 IN ('1013659') # Can be comma separated for multiple employees
AND bal.a11 Like '%2022%' # year
AND bal.a7 IS NOT NULL #to check lapsed value
AND bal.a3 = 1 # Leave Type
/*
 * Leave Types
1	Earned Leave
2	Sick Leave
3	Maternity Leave
4	Leave Without Pay
6	My Leave
7	Paternity Leave
8	Bereavement Leave
9	Special Covid Leave
10	Study Leave
15	WFH Covid-19
17	Wedding Leave
18	Work From Home
19	Maternity Leave
20	Earned Leave Srilanka
21	Casual Leave Srilanka
22	Sick Leave Srilanka
23	Holiday
24	Earned Leaves Interns
26	Special Medical Leave
27	Tubectomy Leave
28	Adoption Leave
*/




*To Fetch the job  details from and to date (which are not updated correctly which causes problem in attendance regularization approval process)and will also be helpful to check what is the change in org unit which caused the change in from and to dates*
# ORG Units Based on employee code
SELECT job.a3 AS `emp_id`,
job.a4 AS `employee_code`,
job.`from`,
job.`to`,
CONCAT(orgU1.a3,' : ',orgU1.a4,' : ',orgU1.a5) AS `Business Group`,
CONCAT(orgU2.a3,' : ',orgU2.a4,' : ',orgU2.a5) `Legal Entity`,
CONCAT(orgU3.a3,' : ',orgU3.a4,' : ',orgU3.a5) `Pay Group`,
CONCAT(orgU4.a3,' : ',orgU4.a4,' : ',orgU4.a5) `Cost Center`,
CONCAT(orgU5.a3,' : ',orgU5.a4,' : ',orgU5.a5) `Business Unit`,
CONCAT(orgU6.a3,' : ',orgU6.a4,' : ',orgU6.a5) `Department`,
CONCAT(orgU7.a3,' : ',orgU7.a4,' : ',orgU7.a5) `Sub Department`,
CONCAT(orgU8.a3,' : ',orgU8.a4,' : ',orgU8.a5) `zone`,
CONCAT(orgU9.a3,' : ',orgU9.a4,' : ',orgU9.a5) `Location`,
CONCAT(orgU10.a3,' : ',orgU10.a4,' : ',orgU10.a5) `Designation`,
CONCAT(orgU11.a3,' : ',orgU11.a4,' : ',orgU11.a5) `Salary Grade`,
CONCAT(orgU12.a3,' : ',orgU12.a4,' : ',orgU12.a5) `Band`,
CONCAT(orgU13.a3,' : ',orgU13.a4,' : ',orgU13.a5) `Level`,
job.*
FROM 
fe_hrt_emp_job_d job 
LEFT JOIN fe_org_unit_m  orgU1 ON(orgU1.a1 = job.ou1 AND orgU1.cl = job.cl)
LEFT JOIN fe_org_unit_m  orgU2 ON(orgU2.a1 = job.ou2 AND orgU2.cl = job.cl)
LEFT JOIN fe_org_unit_m  orgU3 ON(orgU3.a1 = job.ou3 AND orgU3.cl = job.cl)
LEFT JOIN fe_org_unit_m  orgU4 ON(orgU4.a1 = job.ou4 AND orgU4.cl = job.cl)
LEFT JOIN fe_org_unit_m  orgU5 ON(orgU5.a1 = job.ou5 AND orgU5.cl = job.cl)
LEFT JOIN fe_org_unit_m  orgU6 ON(orgU6.a1 = job.ou6 AND orgU6.cl = job.cl)
LEFT JOIN fe_org_unit_m  orgU7 ON(orgU7.a7 = job.ou7 AND orgU7.cl = job.cl)
LEFT JOIN fe_org_unit_m  orgU8 ON(orgU8.a1 = job.ou8 AND orgU8.cl = job.cl)
LEFT JOIN fe_org_unit_m  orgU9 ON(orgU9.a1 = job.ou9 AND orgU9.cl = job.cl)
LEFT JOIN fe_org_unit_m  orgU10 ON(orgU10.a1 = job.ou10 AND orgU10.cl = job.cl)
LEFT JOIN fe_org_unit_m  orgU11 ON(orgU11.a1 = job.ou11 AND orgU11.cl = job.cl)
LEFT JOIN fe_org_unit_m  orgU12 ON(orgU1.a12 = job.ou12 AND orgU12.cl = job.cl)
LEFT JOIN fe_org_unit_m  orgU13 ON(orgU1.a13 = job.ou13 AND orgU13.cl = job.cl)
WHERE 1
AND
job.a4 IN('22869')
AND job.cl = 1
*To Fetch the table definition mapping or table description.*
SELECT
    t3.col_name,
    t1.name,
    t1.lov
FROM
    `fe_core_field_m` t1
    JOIN `fe_core_table_col_m` t3
        ON (t3.id = t1.db_col_id)
    JOIN `fe_core_table_m` t4
        ON (t4.id = t3.table_id)
WHERE 1
    AND t4.name = 'fe_wft_task_t' #change table name
ORDER BY REPLACE(col_name, 'a', '') * 1 



