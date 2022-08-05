select e.a5 'Employee number',

 IF(IFNULL(t.a8,'')='' OR t.a8 >= CURDATE(), 'Employee','Ex-Employee') 'Employment Status',

 fe_get_core_lookup_meaning_f(t.cl,'3000002',t.a3) 'Employment Type',
 e.a4 as 'Full Name',
  DATE_FORMAT(t.a4, '%d-%b-%y') 'Group Date of joining',
  DATE_FORMAT(t.a5, '%d-%b-%y') 'Joining Date',
  DATE_FORMAT(p.a9, '%d-%b-%y') 'Date Of Birth', 
org_bg.a3 'Business Group',
org_le.a3 'Legal Entity',
  org_dsg.a3 'Designation',
  org_dp.a3 'Department',
  org_sdp.a3 'Sub Department',
  org_loc.a3 'Location',
  state.a3 'State',

l_gender.a4 as 'Gender',
l_ms.a4 'Marital Status', 
    p.a3 'Adhaar Number',
    p.a4 'Pan Number',
  IFNULL(c.a3,'') 'Mobile No',
  family.a3  'Father Name',
  li.a3 'UAN',
  li.a5 'PF',
  li.a6  'ESIC',
  
  (SELECT t2.a2 FROM fe_cfg_bank_t t1 JOIN fe_glb_bank_g t2 
  ON (t1.a3 = t2.a1 AND t2.a4 = 1)

 JOIN fe_hrt_emp_job_t t3
 ON (t1.cl = t3.cl AND t1.a4 = t3.ou2)
 WHERE 1  AND t3.a2 = p.a1
 	AND t3.a3 = t.a1 and t1.a1 = b.a3 )'Bank Name',
  b.a6 'Account Number',
  b.a5 'IFSC Code'
  

from  fe_hrt_emp_summary_t e
  LEFT JOIN fe_hrt_emp_job_t j ON 
  (e.a3 = j.a2 AND e.cl = j.cl)
  LEFT JOIN fe_hri_person_t p  -- for date of birth
	on (e.a2 = p.a1 and e.cl = p.cl)
  LEFT JOIN fe_hrt_emp_employment_t as t
	on (p.a1 = t.a2 and p.cl = t.cl)
  LEFT JOIN fe_org_unit_m org_bg
    ON (j.ou1 = org_bg.a1 and j.cl = org_bg.cl)
  LEFT JOIN fe_org_unit_m org_le
    ON (j.ou2 = org_le.a1 and j.cl = org_le.cl)
  LEFT JOIN fe_org_unit_m org_dsg
    ON (j.ou10 = org_dsg.a1 and j.cl = org_dsg.cl)
  LEFT JOIN fe_org_unit_m org_dp
    ON (j.ou6 = org_dp.a1 and j.cl = org_dp.cl)
  LEFT JOIN fe_org_unit_m org_sdp
    ON (j.ou7 = org_sdp.a1 and j.cl = org_sdp.cl)
  LEFT JOIN fe_org_unit_m org_loc
    ON (j.ou9 = org_loc.a1 and j.cl = org_loc.cl)
  LEFT JOIN fe_org_unit_detail_m org_loc_d
    ON (org_loc_d.a2 = org_loc.a1 and org_loc.cl = org_loc_d.cl)
  LEFT JOIN fe_glb_state_g  state
    ON (state.a1 = org_loc_d.a4)
  LEFT JOIN fe_hrt_emp_legal_info_d li
    on (t.a1 = li.a2 and t.cl = li.cl)
  LEFT JOIN fe_hri_emp_bank_t b
	ON (p.a1 = b.a2 and p.cl = b.cl and b.a7 = 20)
  LEFT JOIN fe_hri_emp_family_t family
	on (p.a1 = family.a2 and p.cl = family.cl and family.a5 = 2) -- 2 is id for Father
	
	


left join fe_hri_emp_contact_t as c on (p.a1 = c.a2  and p.cl = c.cl)
LEFT JOIN fe_glb_lookup_m l_gender
    on (l_gender.a2 = 1000001 and l_gender.a3=p.a8 and l_gender.a7=1)
LEFT JOIN fe_glb_lgs_lookup_m l_ms
    ON (l_ms.a2 = 2000002 and l_ms.a3 =p.a11 and l_ms.a7=1)
LEFT JOIN fe_cfg_bank_t t1 
    on ((SELECT t2.a2 FROM fe_cfg_bank_t t1 JOIN fe_glb_bank_g t2 
  ON (t1.a3 = t2.a1 AND t2.a4 = 1)
  
 JOIN fe_hrt_emp_job_t t3
 ON (t1.cl = t3.cl AND t1.a4 = t3.ou2)
 WHERE 1  AND t3.a2 = p.a1
 	AND t3.a3 = t.a1 and t1.a1 = b.a3 ))
WHERE e.cl={session.clientId} $filters