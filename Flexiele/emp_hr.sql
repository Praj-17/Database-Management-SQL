 select
e.a5 as 'Employee',
e2.a5 as 'RM',
apr2.from as 'effective from'
from fe_hrt_emp_summary_t e
 JOIN fe_wfm_approver_type_m apt
     ON (
       e.cl = apt.cl
       AND apt.a4 = 'APT0000001' -- change this to APT0000005 to get HOD
     )
  LEFT JOIN fe_wft_approver_t apr
    ON (e.a1 = apr.a2 AND apr.a3 = apt.a1)
  LEFT JOIN fe_hrt_emp_summary_t e2
    ON (e2.a3 = apr.a5)
  LEFT JOIN fe_wft_approver_d apr2
    on (e.a1 = apr2.a2 AND apr2.a3 = apt.a1)