SELECT 
appl.a1 applicant_id,
job.a2 request_id,
tsp.a1 performer_id,
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
  FORMAT(IFNULL(ctc.a7, 0), 2) current_ctc,
  FORMAT(IFNULL(ctc.a14, 0), 2) offered_fixed_ctc,
  FORMAT(IFNULL(ctc.a15, 0), 2) offered_var_pay,
  FORMAT(IFNULL(ctc.a28, 0), 2) retention_bonus,
  FORMAT(IFNULL(ctc.a19,0),0) 'esop_value_in_inr',
  FORMAT(IFNULL(join_bonus.a5, 0), 2) joining_bonus,
   if(ctc.a30, 'Yes', 'No') notice_pay_buy_out,
   FORMAT(IFNULL(ctc.a8,0),0)'hike',
   IF( IFNULL(join_bonus.a5,0),1,0) as jb,
	IF( IFNULL(ctc.a15,0),1,0) as vp,
	IF( IFNULL(ctc.a28,0),1,0) as rb,
    IF( IFNULL(ctc.a19,0),1,0) as esop,
  DATE_FORMAT(ofr.a6, '%d-%b-%Y') doj,
FORMAT(IFNULL(ctc.a7,0),0) 'prev_ctc',
FORMAT(IFNULL(ctc.a25,0),0) 'prev_fixed',
 FORMAT(IFNULL(ctc.a26,0),0) 'prev_var',
  IFNULL(ofr.a17, '') curr_designation,
  des.a3 offered_designation,
  loc.a3 location,
  org_dp.a3 as 'department',
  mgr.a4  mgr_name, 
  IFNULL(aprs2.a4,aprs1.a4) apr_name,
  IFNULL(aprs2.a8,aprs1.a8) apr_email,
  ctc.a12 'comment',
  appl.a14 'recruiter',
  re.a8    'recruiter_email'
FROM
  fe_rec_candidate_offer_t ofr 
  JOIN fe_rec_applicant_t appl 
    ON (appl.a1 = ofr.a2) 
  JOIN fe_rec_candidate_t cand 
    ON (cand.a1 = appl.a3) 
  JOIN fe_rec_candidate_offer_job_t job 
    ON (job.a2 = ofr.a1) 
  JOIN fe_org_unit_m loc 
    ON (loc.a1 = job.ou9) 
  JOIN fe_org_unit_m des 
    ON (des.a1 = job.ou10) 
  JOIN fe_rec_candidate_offer_ctc_t ctc 
    ON (ctc.a2 = ofr.a1) 
  JOIN fe_wfm_task_m tsm 
    ON (
      tsm.cl = job.cl 
      AND tsm.a2 = 'WTM0000082'
    ) 
  JOIN `fe_wft_task_t` tsk 
    ON (tsk.a6 = job.a2 
      AND tsk.a2 = tsm.a1) 
  JOIN `fe_wft_task_performer_t` tsp
  LEFT JOIN fe_hrt_emp_summary_t aprs1 
    ON (aprs1.a3 = tsp.a5) 
  LEFT JOIN fe_hrt_emp_summary_t re
	on (appl.a14 = re.a3)
  LEFT JOIN fe_wft_approver_t apr 
    ON (
      apr.a3 = tsp.a10 
      AND apr.a4 = job.a10 
      AND (apr.a2 IS NULL 
        OR apr.a2 = ofr.a2)
    ) 
  LEFT JOIN fe_hrt_emp_summary_t aprs2 
    ON (aprs2.a3 = apr.a5) 
  JOIN fe_pyt_sal_comp_m compj 
    ON (
      compj.cl = ofr.cl 
      AND compj.a4 = 'JOIN_BONUS'
    ) 
  LEFT JOIN fe_pyt_new_joiner_benefit_t join_bonus 
    ON (
      join_bonus.a3 = ofr.a1 
      AND join_bonus.a4 = compj.a1
    ) 
  JOIN fe_hrt_emp_summary_t mgr 
    ON (mgr.a3 = ofr.a11) 
LEFT JOIN fe_org_unit_m org_dp
	on(org_dp.a1 = job.ou6 and  org_dp.cl = job.cl)
  where 1
	AND ofr.cl = {session.clientId}
   AND job.a2 = {{request_id}}
   AND tsp.a1 = {{performer_id}}
   and appl.a1 ={{applicant_id}}