select e.a5 'Employee Code',
e.a4 'Full Name',
tr.a4 'Tax Regime',
fy.a4 'Financial Year',
p_type.a4 'Property Type',
t1.a11 'Lender Name',
t1.a12 'Lender Address',
t1.a13 'Lender PAN',
t1.a14 'Property Address',
t1.a15 'Posession Date',
t1.a29 'Declared amount',
t1.a16 'Interest Paid',
t1.a17 'Previous EMI',
t1.a18 'Annual Rent Amount',
t1.a19 'Property Tax',
t1.a20 'Net Rent Amount',
t1.a21 'Maintenance Cost',
t1.a7 'Actual Amount',
t1.a8 'Approved amount',
t1.a9 'Rejection Comments',
t1.a10 'Status'

FROM fe_hrt_emp_summary_t e
 LEFT JOIN fe_pyt_emp_investment_detail_t t1
    ON (e.a3 = t1.a2 )
 LEFT JOIN fe_pyt_emp_tax_declaration_t t2
    ON (e.a3 = t2.a2 )
 LEFT JOIN fe_glb_lookup_m tr
    ON (
     t2.a3 = tr.a3 
    AND tr.a2 = 1000057
    AND tr.a7 = 1 
    AND t1.a24 = 15)
 LEFT JOIN  fe_glb_lgs_lookup_m fy
    ON (
     t2.a4 = fy.a3 
    AND fy.a2 = 2000010
    AND fy.a7 = 1
    AND t1.a24 = 15 )
 LEFT JOIN  fe_glb_lgs_lookup_m p_type
    ON (
     t1.a3 = p_type.a3 
    AND p_type.a2 = 2000022
    AND p_type.a7 = 1
    AND t1.a24 = 15 )
