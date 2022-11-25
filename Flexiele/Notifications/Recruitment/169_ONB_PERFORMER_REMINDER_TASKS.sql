SELECT 
  tm.a4 AS 'task_name',
  tx_status.a4 'status' 
FROM
  fe_wft_task_group_t gt 
  JOIN fe_wfm_task_group_m gm 
    ON (
      gt.cl = gm.cl 
      AND gt.a3 = gm.a1 
      AND gm.a3 = 'BPC0000001'
    ) 
  JOIN fe_hrt_emp_employment_t emp 
    ON (gt.cl = emp.cl 
      AND gt.a2 = emp.a1) 
  JOIN fe_rec_applicant_t frat 
    ON (
      frat.cl = emp.cl 
      AND frat.a11 = emp.a1
    ) 
  JOIN fe_wft_task_t tt 
    ON (
      tt.cl = gt.cl 
      AND tt.a22 = gt.a1 
      AND tt.a4 = gt.a2
    ) 
  JOIN fe_wft_task_performer_t fwtpt 
    ON (
      fwtpt.cl = tt.cl 
      AND fwtpt.a2 = tt.a1 
      AND emp.a1 = fwtpt.a5
    ) 
  LEFT JOIN fe_wfm_task_m tm 
    ON (
      tt.cl = tm.cl 
      AND tt.a2 = tm.a1 
      AND gm.a1 = tm.a13
    ) 
  LEFT JOIN fe_cfg_lookup_m tx_status 
    ON (
      tx_status.a3 = tt.a9 
      AND tx_status.cl = tt.cl 
      AND tx_status.a2 = '4000182'
    ) 
WHERE 1 
  AND gt.cl = { session.clientId } 
 and FIND_IN_SET(tt.a1, {{task_list}})