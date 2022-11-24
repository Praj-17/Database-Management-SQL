SELECT 
  tx_per.a1 AS 'performer_id',
  tx.a6 as 'request_id',
  tx.a22 as 'task_group_id',
  tx_per.a5 as 'performer_emp_id',
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
  IFNULL(appl.a13, jt.a3) 'job_title',#till pre offer
  re.a8 'recruiter_email',
  re.a4 'recruiter_name',
  "https://apps.apple.com/lk/app/flexiele-hrms/id1629205261" AS 'link_ios',
  "https://play.google.com/store/apps/details?id=com.flexielehrms&hl=en_SG" AS 'link_android' 
FROM
  fe_wft_task_performer_t tx_per 
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
  LEFT JOIN fe_rec_requisition_t jt 
    ON (jt.a1 = appl.a2 
      AND jt.cl = appl.cl) 
  LEFT JOIN fe_hrt_emp_summary_t re 
    ON (appl.a14 = re.a3) 
WHERE 1 
  AND tx_per.cl = {session.clientId} 
  AND tx_per.a5 = {{performer_id}}
   AND tx.a6 = {{request_id}}
  and tx.a22 = {{task_group_id}}    #add this in case of pre offer initiate and onboarding initiate mails
GROUP BY  tx_per.a5  #add this in case of pre offer initiate and onboarding initiate mail