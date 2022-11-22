SELECT
	tx_per.a1 as 'performer_id',
      CONCAT(
    IFNULL(cand.a5, ''),
    IF(
      IFNULL(cand.a6, '') = '',
      '',
      CONCAT(' ', IFNULL(cand.a6, ''))
    ),
    IF(
      IFNULL(cand.a7, '') = '',
      '',
      CONCAT(' ', IFNULL(cand.a7, ''))
    )
  ) cand_name,
  cand.a23 'cand_email',
	tx_per.a5 AS `performer_emp_id`,
	txm.a4 AS `task_name`,
	emps.a4 AS `performer_name`,
	emps.a8 AS `performer_email`,
      IFNULL(appl.a13,jt.a3) 'job_title',
	date_format(cand.a19, "%d-%b-%Y") 'doj',
      concat("+", country.a9, con.a4) 'cand_phone',
        re.a8    'recruiter_email',
		re.a4 'recruiter_name',
        IFNULL(aprs2.a4,aprs1.a4) apr_name,
		IFNULL(aprs2.a8,aprs1.a8) apr_email,
"https://apps.apple.com/lk/app/flexiele-hrms/id1629205261" as 'link_ios',
"https://play.google.com/store/apps/details?id=com.flexielehrms&hl=en_SG" as 'link_android'
FROM
	fe_wft_task_performer_t tx_per 
	JOIN fe_wft_task_t tx ON (tx_per.cl = tx.cl AND tx_per.a2 = tx.a1)
	JOIN fe_wfm_task_m txm ON (tx.cl = txm.cl AND tx.a2 = txm.a1)
	JOIN fe_hrt_emp_summary_t emps ON(tx_per.cl = emps.cl AND tx_per.a5 = emps.a3)
    JOIN fe_rec_applicant_t appl on (tx.a5 = appl.a1 and tx.cl = appl.cl)
	JOIN fe_rec_candidate_t cand ON (cand.a1 = appl.a3 and cand.cl = appl.cl) 
    LEFT JOIN fe_rec_candidate_contact_t con on (con.a2 = cand.a1 and con.a6 = 1)
    LEFT JOIN  fe_glb_country_g  country on (country.a1 = con.a3)
	JOIN fe_rec_candidate_offer_t ofr on(ofr.a2 = appl.a1 and ofr.cl = appl.cl)
	JOIN fe_rec_candidate_offer_job_t job    ON (job.a2 = ofr.a1) 
    LEFT JOIN fe_rec_requisition_t  jt ON (jt.a1 = appl.a2 AND jt.cl = appl.cl)
	LEFT JOIN fe_hrt_emp_summary_t re on (appl.a14 = re.a3)
    LEFT JOIN fe_hrt_emp_summary_t aprs1 
 		ON (aprs1.a3 = tx_per.a5) 
    LEFT JOIN fe_wft_approver_t apr 
    ON (
      apr.a3 = tx_per.a10 
      AND apr.a4 = job.a10 
      AND (apr.a2 IS NULL 
        OR apr.a2 = ofr.a2)
    ) 
  LEFT JOIN fe_hrt_emp_summary_t aprs2 
    ON (aprs2.a3 = apr.a5) 
WHERE 1
AND tx_per.cl = 1
AND tx_per.a1 = {{performer_id}}