select e.a5 'Employee Code',
e.a4 'Full Name',
tr.a4 'Tax Regime',
fy.a4 'Financial Year',
t1.a6 'From',
t1.a7 'Till',
t1.a5 as 'VPF Amount',
t1.a8 as 'Status'
 FROM fe_pyt_emp_vpf_t t1
 LEFT JOIN fe_pyt_emp_tax_declaration_t t2
    ON (t1.a3 = t2.a1 and t1.cl = t2.cl)
LEFT JOIN fe_hrt_emp_summary_t e
    ON (t2.a2 = e.a3 and t2.cl = e.cl) 
 LEFT JOIN fe_glb_lookup_m tr
    ON (
     t2.a3 = tr.a3 
    AND tr.a2 = 1000057
    AND tr.a7 = 1 )
 LEFT JOIN  fe_glb_lgs_lookup_m fy
    ON (
     t2.a4 = fy.a3 
    AND fy.a2 = 2000010
    AND fy.a7 = 1 )
    
 LEFT JOIN  fe_glb_lgs_lookup_m status
    ON (
     t1.a8 = status.a3 
    AND status.a2 = 2000014
    AND status.a7 = 1 )
   WHERE t1.cl = {session.clientId}