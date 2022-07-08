select e.a5 'Employee Code',
e.a4 'Full Name',
tr.a4 'Tax Regime',
fy.a4 'Financial Year',
t1.a6 'From',
t1.a7 'Till',
t1.a5 as 'VPF Amount',
t1.a8 as 'Status'
 FROM fe_hrt_emp_summary_t e
 LEFT JOIN fe_pyt_emp_vpf_t t1
    ON (e.a3 = t1.a2 )
 LEFT JOIN fe_pyt_emp_tax_declaration_t t2
    ON (e.a3 = t2.a2 )
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

   