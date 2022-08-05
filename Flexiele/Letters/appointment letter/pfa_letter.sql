select e.a4 'full_name',
DATE_FORMAT(p.a9, '%d-%b-%y') 'dob', 
b.a6 'account_no',
l_gender.a4 as 'gender',
l_ms.a4 as 'marital_status',
c.a7 as 'address',
org_le.a3 'legal_entity',
c.a12 'address_c',
currdate() as 'date'
from fe_hrt_emp_summary_t e
LEFT JOIN fe_hri_person_t p  -- for date of birth
    on (e.a2 = p.a1 and e.cl = p.cl)
LEFT JOIN fe_hri_emp_bank_t b
	ON (p.a1 = b.a2 and b.cl = p.cl)
LEFT JOIN fe_glb_lookup_m l_gender
    on (l_gender.a2 = 1000001 and l_gender.a3=p.a8 and l_gender.a7=1 and l_gender.cl = p.cl)
LEFT JOIN fe_glb_lgs_lookup_m l_ms
    on (l_ms.a2 =2000002 AND l_ms.a7 = 1 and l_ms.a3 = p.a11 and l_ms.cl = p.cl)
left join fe_hri_emp_contact_t as c on (p.a1 = c.a2 and p.cl = c.cl)
LEFT JOIN fe_org_unit_m org_le ON (e.ou2 = org_le.a1 and e.cl = org_le.cl)
WHERE e.cl={session.clientId}
