select e.a4 'Employee number',

 IF(IFNULL(t.a8,'')='' OR t.a8 >= CURDATE(), 'Employee','Ex-Employee') 'Employment Status',

 fe_get_core_lookup_meaning_f(t.cl,'3000002',t.a3) 'Employment Type',

 CONCAT(p.a5, ' ', p.a7) as 'Full Name',
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
  org_loc_d.a5 'City',
 org_loc_d.a8 'Region',
  e2.a4 'Manager Name',
  e2.a8 'Manager Email',
  IFNULL(c.a3,'') 'Mobile No',
  t.a11 'Official Email',
  p.a13 'Personal Email',
  p.a6 'Father Name',
  t.a15 as 'Exit Date',
  c.a7 'Address_P',
  c.a8 'City_P',
  cntry_p.a2 'Country_P',
  state_p.a3 'State_P',
  c.a11 'ZipCode_p',
  c.a12 'Address_C',
  c.a13 'City_C',
  cntry_c.a2 'Country_C',
  state_c.a3 'State_C',
  c.a16 'ZipCode_C' 


from  fe_hrt_emp_job_t e
  LEFT JOIN fe_org_unit_m org_bg
    ON (e.ou1 = org_bg.a1)
  LEFT JOIN fe_org_unit_m org_le
    ON (e.ou2 = org_le.a1)
  LEFT JOIN fe_org_unit_m org_dsg
    ON (e.ou10 = org_dsg.a1)
  LEFT JOIN fe_org_unit_m org_dp
    ON (e.ou6 = org_dp.a1)
  LEFT JOIN fe_org_unit_m org_sdp
    ON (e.ou7 = org_sdp.a1)
  LEFT JOIN fe_org_unit_m org_loc
    ON (e.ou9 = org_loc.a1)
  LEFT JOIN fe_org_unit_detail_m org_loc_d
    ON (org_loc_d.a2 = org_loc.a1)
  LEFT JOIN fe_glb_state_g state
    ON (state.a1 = org_loc_d.a4)
    
left join fe_hri_person_t p on (e.a2 = p.a1)
left join fe_hrt_emp_employment_t as t on (p.a1 = t.a2)
left join fe_hri_emp_contact_t as c on (p.a1 = c.a2)
JOIN fe_wfm_approver_type_m apt
     ON (
       t.cl = apt.cl
       AND apt.a4 = 'APT0000001'
     )
LEFT JOIN fe_wft_approver_t apr
    ON (t.a1 = apr.a2 AND apr.a3 = apt.a1)
LEFT JOIN fe_hrt_emp_summary_t e2
    ON (e2.a3 = apr.a5)
LEFT JOIN fe_glb_country_g cntry_p
    ON (cntry_p.a1 = c.a9)
LEFT JOIN fe_glb_country_g cntry_c
    ON (cntry_c.a1 = c.a14)
LEFT JOIN fe_glb_state_g state_p
    ON (state_p.a1 = c.a10)
LEFT JOIN fe_glb_state_g state_c
    ON (state_c.a1 = c.a15)