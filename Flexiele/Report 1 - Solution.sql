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
  org_loc_d.a5 'City',
  '' 'Region',
  e2.a4 'Manager Name',
  e2.a8 'Manager Email',
  IFNULL(cont.a3,'') 'Mobile No',
  e.a11 'Official Email',
  fe_get_global_lookup_meaning_f(e.cl,'1000001',p.a8)  'Gender',
  IFNULL(icont.a7,'') 'Emergency Contact Number',
  fe_get_cfg_lookup_meaning_f(e.cl,'4000002',e.a9) 'Resignation Type',
  IFNULL(DATE_FORMAT(e.a15, '%d-%b-%y'),'') 'Date of Resignation',
  IFNULL(DATE_FORMAT(e.a8, '%d-%b-%y'),'') 'LWD',
  fe_get_cfg_lookup_meaning_f(e.cl,'4000003',e.a10) 'Exit Reason'
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
  LEFT JOIN fe_hri_emp_family_t icont
    ON (icont.a2 = p.a1 AND icont.a10 = 1)
  JOIN fe_wfm_approver_type_m apt
     ON (
       e.cl = apt.cl
       AND apt.a4 = 'APT0000001'
     )
  LEFT JOIN fe_wft_approver_t apr
    ON (e.a1 = apr.a2 AND apr.a3 = apt.a1)
  LEFT JOIN fe_hrt_emp_summary_t e2
    ON (e2.a3 = apr.a5)
  /*LEFT JOIN fe_hri_person_t p2
    ON (p2.a1 = e2.a2)*/
  LEFT JOIN fe_org_unit_m org_bg
    ON (j.ou1 = org_bg.a1)
  LEFT JOIN fe_org_unit_m org_le
    ON (j.ou2 = org_le.a1)
  /*LEFT JOIN fe_org_unit_m org_cc
    ON (j.ou4 = org_cc.a1)
  LEFT JOIN fe_org_unit_m org_bu
    ON (j.ou5 = org_bu.a1)*/
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
  /*LEFT JOIN fe_org_unit_m org_band
    ON (j.ou12 = org_band.a1)
  LEFT JOIN fe_org_unit_m org_level
    ON (j.ou13 = org_level.a1)*/
WHERE 1 = 1
    AND p.cl = 7
    AND e.a11 NOT LIKE '%flexiele.com%'
ORDER BY j.a4