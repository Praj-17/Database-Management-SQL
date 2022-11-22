SELECT
	tx_per.a5 AS `performer_emp_id`,
	txm.a4 AS `task_name`,
	emps.a4 AS `performer_name`,
	emps.a8 AS `performer_email`,
	empsc.a4 AS `candidate_name`,
	empc.a5 AS `doj`,
	tx_per.a14 AS `comments_given_by_checker`,
	fe_wft_get_emp_approver_f(empc.a1,'APT0000018','1','','') AS `onboarding_admin_name`,
	fe_wft_get_emp_approver_f(empc.a1,'APT0000018','2','','') AS `onboarding_admin_email`,
	empsr.a8 AS `recruiter_email`,
	orgdesg.a3 AS `job_title`
FROM
	fe_wft_task_performer_t tx_per 
	JOIN fe_wft_task_t tx ON (tx_per.cl = tx.cl AND tx_per.a2 = tx.a1)
	JOIN fe_wfm_task_m txm ON (tx.cl = txm.cl AND tx.a2 = txm.a1)
	JOIN fe_hrt_emp_summary_t emps ON(tx_per.cl = emps.cl AND tx_per.a5 = emps.a3)
	JOIN fe_hrt_emp_employment_t empc ON(tx.cl = empc.cl AND tx.a4 = empc.a1)
	JOIN fe_hrt_emp_summary_t empsc ON(tx.cl = empsc.cl AND tx.a4 = empsc.a3)
	JOIN fe_rec_applicant_t frat ON (frat.cl = empc.cl AND frat.a11 = empc.a1)
	JOIN fe_hrt_emp_summary_t empsr ON(frat.cl = empsr.cl AND frat.a14 = empsr.a3)
	JOIN fe_hrt_emp_job_t jobc ON (empc.cl = jobc.cl AND empc.a1 = jobc.a3)
	JOIN fe_org_unit_m orgdesg ON (orgdesg.cl = jobc.cl AND orgdesg.a1 = jobc.ou10)
WHERE 1
AND tx_per.cl = {session.clientId}
AND tx_per.a1 = {{performer_id}}