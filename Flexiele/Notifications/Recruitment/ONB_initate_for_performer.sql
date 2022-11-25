SELECT 
  tx_per.a1 AS 'performer_id',
  tx_per.a5 as  'performer_emp_id',
  tx_per.a6 as 'request_id',
  tx.a22 as 'task_group_id',
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
  des.a3 job_title,
  DATE_FORMAT(cand.a19, "%d-%b-%Y") 'doj',
  CONCAT("+", country.a9, con.a4) 'can_phone',
  re.a8 'recruiter_email',
  re.a4 'recruiter_name',
  "https://apps.apple.com/lk/app/flexiele-hrms/id1629205261" AS 'link_ios',
  "https://play.google.com/store/apps/details?id=com.flexielehrms&hl=en_SG" AS 'link_android' 
FROM
  fe_wft_task_performer_t tx_per 
  JOIN fe_wfm_task_performer_m per_m 
    ON (
      per_m.cl = tx_per.cl 
      AND per_m.a1 = tx_per.a2
    ) 
  JOIN fe_wft_task_t tx 
    ON (
      tx_per.cl = tx.cl 
      AND tx_per.a2 = tx.a1
    ) 
  JOIN fe_rec_applicant_t appl 
    ON (
      tx.a6 = appl.a1 #tx.a5 ->tx.a6
      AND tx.cl = appl.cl
    ) 
  JOIN fe_rec_candidate_t cand 
    ON (
      cand.a1 = appl.a3 
      AND cand.cl = appl.cl
    ) 
  LEFT JOIN fe_rec_candidate_contact_t con 
    ON (con.a2 = cand.a1 
      AND con.a6 = 1) 
  LEFT JOIN fe_glb_country_g country 
    ON (country.a1 = con.a3) 
  JOIN fe_rec_candidate_offer_t ofr 
    ON (
      ofr.a2 = appl.a1 
      AND ofr.cl = appl.cl 
      and ifnull(ofr.a20,0) = 0 #add condition ifnull(ofr.a20,0) = 0
    ) 
  JOIN fe_rec_candidate_offer_job_t job 
    ON (job.a2 = ofr.a1) 
  JOIN fe_org_unit_m des 
    ON (des.a1 = job.ou10) 
  LEFT JOIN fe_rec_requisition_t jt 
    ON (jt.a1 = appl.a2 
      AND jt.cl = appl.cl) 
  LEFT JOIN fe_hrt_emp_summary_t re 
    ON (appl.a14 = re.a3) 
WHERE 1 
  AND tx_per.cl = {{session.clientId}} 
  AND tx_per.a5 = {{performer_id}}
   AND tx_per.a6 = {{request_id}}
     AND tx.a22 = {{task_group_id}} 
GROUP BY  tx_per.a5 
