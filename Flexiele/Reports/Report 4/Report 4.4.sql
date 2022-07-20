select e.a5 'Employee Code',
e.a4 'Full Name',
tr.a4 'Tax Regime',
fy.a4 'Financial Year',
previous_income.a3 'Employer Name',
-- Declared
t1.a4 'Total Income',
t1.a3 'Tax Deducted',
t1.a5 'PT Deducted',
t1.a6 'PF Deducted',
dec_availed.a4 'ITA Last Availed',

-- Actual
t1.a9 'Total Income',
t1.a10 'Tax Deducted',
t1.a11 'PT Deducted',
t1.a12 'PF Deducted',
act_availed.a4 'ITA Last Availed'


FROM fe_pyt_emp_previous_income_t t1 
 LEFT JOIN fe_hrt_emp_summary_t e
    ON (t1.a1 = e.a3 )
 LEFT JOIN fe_pyt_emp_tax_declaration_t t2
    ON (t1.a3= t2.a1 )
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
 LEFT JOIN  fe_glb_lgs_lookup_m dec_availed
    ON (
     t1.a8 = dec_availed.a3 
    AND dec_availed.a2 = 2000010
    AND dec_availed.a7 = 1 )
 LEFT JOIN  fe_glb_lgs_lookup_m act_availed
    ON (
     t1.a13 = act_availed.a3 
    AND act_availed.a2 = 2000010
    AND act_availed.a7 = 1 )
 LEFT JOIN fe_hri_emp_prev_employment_t employer_name
 on (e.a3 = employer_name.a2)
LEFT JOIN fe_pyt_emp_previous_income_t previous_income
on (employer_name.a1 = previous_income.a2)
