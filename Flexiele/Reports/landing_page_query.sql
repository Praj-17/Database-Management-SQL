SELECT
  es.a5 'Employee Number',
  es.a4 'Full Name',
  DATE_FORMAT(e.a5, '%d-%b-%y') 'Joining Date',
  org_bg.a3 'Business Group',
  org_le.a3 'Legal Entity',
  org_dsg.a3 'Designation',
  org_dp.a3 'Department',
   lp.a6 'Number of Visits',
   lp.a9 'Date of Visit',
  IF(lp_a.a5 =1, 'Yes','No') as 'Appointment Letter',
   IF(lp_p.a5 =1, 'Yes','No') as 'Personal Information',
    IF(lp_b.a5 =1, 'Yes','No') as 'Bank Details',
     IF(lp_c.a5 =1, 'Yes','No') as 'Contact Details',
      IF(lp_f.a5 =1, 'Yes','No') as 'Family Details',
       IF(lp_i.a5 =1, 'Yes','No') as 'Employee Insurance'
          
  
  FROM
	fe_acm_emp_landing_page_t lp
  JOIN fe_hrt_emp_employment_t e
    ON (lp.a2 = e.a2)
  JOIN fe_hrt_emp_summary_t es
    ON (es.a3 = e.a1)
  left Join fe_hrt_emp_job_t j
  on (j.a3 = es.a3 and j.cl= es.cl)
LEFT JOIN fe_acm_emp_landing_page_t lp_a
 on (lp.a1 = lp_a.a1 and lp_a.a3 = 32 )
 LEFT JOIN fe_acm_emp_landing_page_t lp_p
 on (lp.a1 = lp_p.a1 and lp_p.a3 = 29 )
 LEFT JOIN fe_acm_emp_landing_page_t lp_b
 on (lp.a1 = lp_b.a1 and lp_b.a3 = 30 )
 LEFT JOIN fe_acm_emp_landing_page_t lp_c
 on (lp.a1 = lp_c.a1 and lp_c.a3 = 31 )
 LEFT JOIN fe_acm_emp_landing_page_t lp_f
 on (lp.a1 = lp_f.a1 and lp_f.a3 = 33 )
 LEFT JOIN fe_acm_emp_landing_page_t lp_i
 on (lp.a1 = lp_i.a1 and lp_i.a3 = 34 )
 LEFT JOIn fe_cfg_landing_page_t cfg
 on (cfg.a1 = lp.a3 and cfg.a22 = 1)
  LEFT JOIN fe_org_unit_m org_bg
    ON (j.ou1 = org_bg.a1)
  LEFT JOIN fe_org_unit_m org_le
    ON (j.ou2 = org_le.a1)
  LEFT JOIN fe_org_unit_m org_dp
    ON (j.ou6 = org_dp.a1)
	LEFT JOIN fe_org_unit_m org_dsg
    ON (j.ou10 = org_dsg.a1)
 where 
 lp.a4 = 1
 and  es.cl = 7
 

