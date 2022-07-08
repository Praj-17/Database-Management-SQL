select e.a5 'Employee Code',
e.a3 as 'Employee Id',
e.a4 'Full Name',
tr.a4 'Tax Regime',
fy.a4 'Financial Year',
city_type.a4 'City Type',
from_month.a6 'From Month',
to_month.a6 'To Month',
t1.a11 'Owner',
t1.a13 'Owner PAN',
t1.a14 'Address',
t1.a29 'Declared amount',
t1.a7 'Actual Amount',
t1.a8 'Approved amount',
t1.a9 'Rejection Comments'
FROM fe_hrt_emp_summary_t e
 LEFT JOIN fe_pyt_emp_investment_detail_t t1
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
    
 LEFT JOIN  fe_glb_lgs_lookup_m city_type
    ON (
    t1.a3 = city_type.a3 
    AND city_type.a2 = 2000023
    AND city_type.a7 = 1 )

 LEFT JOIN fe_glb_lookup_m from_month
    ON (
    t1.a26 = from_month.a3 
    AND from_month.a2 = 1000007
    AND from_month.a7 = 1 )
 LEFT JOIN fe_glb_lookup_m to_month
    ON (
    t1.a30 = to_month.a3 
    AND to_month.a2 = 1000007
    AND to_month.a7 = 1 )
    
-- jwpaj[ab



