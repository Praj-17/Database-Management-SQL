SELECT
DATE_FORMAT('{{month}}', '%M %Y') as 'month2',
  es.a5 'emp_code',
  es.a4 'emp_name',
  es.a3 'emp_id',
  DATE_FORMAT(e.a5, '%d-%b-%y') 'doj',
  org_dsg.a3 'designation',
  org_dp.a3 'department',
  org_loc.a3 'location',
  p.a4 	'pan_no',  
  elg.a3 'pf_uan',
  elg.a5 'pf_number',
  gbnk.a2 'bank_account',
  ebnk.a6 'bank_account_no',
  ifnull(ps.a15,0)  'effective_work_days',
  ifnull(ps.a10,0)  'lop',
  FORMAT(bt.a8/12,2) 'net_pay',
  FORMAT(bt.a6/12,2) 'total_earning_f',
  FORMAT(bt.a14/12,2) 'total_earning_a',
  FORMAT(bt.a7/12,2) 'total_deduction',

  date_format(CURRENT_TIMESTAMP(), '%M %d, %l:%i %p') 'date_time',
  fe_sys_amount_to_word_f(FORMAT(bt.a8/12,2)) as net_pay_in_words
FROM
  fe_hri_person_t p
  JOIN fe_hrt_emp_employment_t e
    ON (p.a1 = e.a2 AND e.cl = p.cl)
  JOIN fe_hrt_emp_summary_t es
    ON (es.a3 = e.a1 AND es.cl = e.cl)
  JOIN fe_hrt_emp_job_d j
    ON (j.a3 = e.a1 and j.cl = e.cl)
    JOIN fe_pyt_emp_bt_t bt
        ON (bt.a2 = e.a1 AND bt.a3 = '{{month}}')
JOIN fe_pyt_emp_payday_summary_t ps
        ON (ps.a2 = j.a3
            AND bt.a3 = ps.a4)
  LEFT JOIN fe_hrt_emp_legal_info_t elg
    ON (elg.a2 = e.a1)
  LEFT JOIN fe_hri_emp_bank_t ebnk
    ON (ebnk.a2 = p.a1 AND ebnk.a7 = 20)
  LEFT JOIN fe_cfg_bank_t bnk
    ON (bnk.a1 = ebnk.a3 )
  LEFT JOIN fe_glb_bank_g gbnk
    ON (gbnk.a1 = bnk.a3 )
  LEFT JOIN fe_org_unit_m org_dp
    ON (j.ou6 = org_dp.a1)
  LEFT JOIN fe_org_unit_m org_loc
    ON (j.ou9 = org_loc.a1)
  LEFT JOIN fe_org_unit_m org_dsg
    ON (j.ou10 = org_dsg.a1)
WHERE 1 = 1 
    AND p.cl = {session.clientId}
    and e.a1  = {{emp_id}}
    AND bt.a3 = '{{month}}'
   --  AND e.a11 NOT LIKE '%flexiele%'
    AND LAST_DAY(
        STR_TO_DATE(CONCAT(bt.a3, '-01'), '%Y-%m-%d')
    ) BETWEEN j.from
    AND j.to
ORDER BY j.a4