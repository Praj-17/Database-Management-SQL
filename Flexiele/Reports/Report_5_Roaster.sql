select e.a5 'Employee Code',
CONCAT(p.a5, ' ', p.a7) as 'Full Name',
org_dp.a3 'Department',
e3.a3 'Manager employee id',
t1.a4 'Date',
df.a4 'Day Flag',
t2.a2 'Shift',
wf.a4 'Work From'

from fe_hrt_emp_summary_t  e
left join fe_hri_person_t p on (e.a3 = p.a1)
left join fe_hrt_emp_job_t j on (e.a3 = j.a2)
LEFT JOIN fe_hrt_emp_employment_t e2
    ON (p.a1 = e2.a2)
LEFT JOIN fe_wfm_approver_type_m apt
     ON (
       e2.cl = apt.cl
       AND apt.a4 = 'APT0000001'
     )
  LEFT JOIN fe_wft_approver_t apr
    ON (e2.a1 = apr.a2 AND apr.a3 = apt.a1)
  LEFT JOIN fe_hrt_emp_summary_t e3
    ON (e3.a3 = apr.a5)
LEFT JOIN fe_org_unit_m org_dp
    ON (j.ou6 = org_dp.a1)
LEFT JOIN fe_alm_emp_roster_plan_t t1 on (e.a3 = t1.a2)
LEFT JOIN fe_glb_lookup_m  df on (t1.a5 = df.a3 AND df.a2=1000031 AND df.a7=1)
LEFT JOIN fe_glb_lookup_m  wf on (t1.a6 = wf.a3 AND wf.a2= 1000117 AND wf.a7=1)
LEFT JOIN fe_alm_shift_m  t2 on (t1.a3 = t2.a3)



