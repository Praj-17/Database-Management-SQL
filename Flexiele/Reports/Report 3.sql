SELECT
  es.a5 'Employee Number',
  IF(IFNULL(e.a8,'')='' OR e.a8 >= CURDATE(), 'Active','In Active') 'Employment Status',
  fe_get_core_lookup_meaning_f(e.cl,'3000002',e.a3) 'Employment Type',
  es.a4 'Full Name',
  DATE_FORMAT(e.a4, '%d-%b-%y') 'Group Date of joining',
  DATE_FORMAT(e.a5, '%d-%b-%y') 'Joining Date',
  DATE_FORMAT(p.a9, '%d-%b-%y') 'Date Of Birth',  
  org_bg.a3 'Business Group',
  org_le.a3 'Legal Entity',
  org_dsg.a3 'Designation',
  org_dp.a3 'Department',
  org_sdp.a3 'Sub Department',
  org_loc.a3 'Location',
  state.a3 'State',
  IFNULL(cont.a3,'') 'Mobile No',
  fe_get_global_lookup_meaning_f(e.cl,'1000001',p.a8)  'Gender',
  fe_get_legislation_lookup_meaning_f(e.cl,'2000002',p.a11) 'Marital Status',
  fcont.a3 'Father Name',
  p.a3 	'Aadhar',
  p.a4 	'PAN',  
  elg.a3 'UAN',
  elg.a5 'PF',
  elg.a6 'ESIC',
  bnk.a2 'Bank Name',
  ebnk.a6 'Bank Account No',
  ebnk.a5 'IFSC code'
FROM
  fe_hri_person_t p
  JOIN fe_hrt_emp_employment_t e
    ON (p.a1 = e.a2)
  JOIN fe_hrt_emp_summary_t es
    ON (es.a3 = e.a1)
  JOIN fe_hrt_emp_job_t j
    ON (j.a3 = e.a1)
  LEFT JOIN fe_hri_emp_contact_t cont
    ON (cont.a2 = p.a1)
  LEFT JOIN fe_hrt_emp_legal_info_t elg
    ON (elg.a2 = e.a1)
  LEFT JOIN fe_hri_emp_bank_t ebnk
    ON (ebnk.a2 = p.a1)
  LEFT JOIN fe_glb_bank_g bnk
    ON (bnk.a1 = ebnk.a3)
  LEFT JOIN fe_hri_emp_family_t fcont
    ON (fcont.a2 = p.a1 AND fcont.a5 = 2)
  LEFT JOIN fe_org_unit_m org_bg
    ON (j.ou1 = org_bg.a1)
  LEFT JOIN fe_org_unit_m org_le
    ON (j.ou2 = org_le.a1)
  LEFT JOIN fe_org_unit_m org_dp
    ON (j.ou6 = org_dp.a1)
  LEFT JOIN fe_org_unit_m org_sdp
    ON (j.ou7 = org_sdp.a1)
  LEFT JOIN fe_org_unit_m org_loc
    ON (j.ou9 = org_loc.a1)
  LEFT JOIN fe_org_unit_detail_m org_loc_d
    ON (org_loc_d.a2 = org_loc.a1)
  LEFT JOIN fe_glb_country_g country
    ON (country.a1 = org_loc_d.a3)
  LEFT JOIN fe_glb_state_g state
    ON (state.a1 = org_loc_d.a4)
  LEFT JOIN fe_org_unit_m org_dsg
    ON (j.ou10 = org_dsg.a1)
WHERE 1 = 1 
    AND p.cl = {session.clientId} $filters
    AND e.a11 NOT LIKE '%flexiele%'
ORDER BY j.a4