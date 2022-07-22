select  e.a5 'Employee Code',
e.a4 'Full Name',
tr.a4 'Tax Regime',
fy.a4 'Financial Year',
i_cat.a4 'Category',
i_subcat.a4 'Sub Category',
t1.a4 'Policy Number',
t1.a29 'Declared Amount',
t1.a7 'Actual Amount',
t1.a8 'Approved  Amount',
t1.a9 'Rejection Comments'

 FROM fe_pyt_emp_investment_detail_t t1  
LEFT JOIN fe_pyt_emp_tax_declaration_t t2
    ON (t1.a23 = t2.a1 and t1.cl =  t2.cl)
LEFT JOIN fe_hrt_emp_summary_t e
    ON (t2.a2 =e.a3 and t2.cl = e.cl)
LEFT JOIN fe_glb_lookup_m tr
    ON (
     t2.a3 = tr.a3 
    AND tr.a2 = 1000057
    AND tr.a7 = 1 
    )
 LEFT JOIN  fe_glb_lgs_lookup_m fy
    ON (
     t2.a4 = fy.a3 
    AND fy.a2 = 2000010
    AND fy.a7 = 1
     )

 LEFT JOIN  fe_glb_lgs_lookup_m i_cat
    ON (
     i_cat.a2 = 2000008
   AND i_cat.a7 = 1
 AND  t1.a24 = i_cat.a3 
 )
 LEFT JOIN  fe_glb_lgs_lookup_m i_subcat
    ON (
     i_subcat.a2 = 2000009
   AND i_subcat.a7 = 1
 AND  t1.a25 = i_subcat.a3 
 )
 WHERE t1.a24 not in (15,17)
    and t1.cl = {session.clientId}