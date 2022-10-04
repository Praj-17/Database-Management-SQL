SELECT * FROM (SELECT
  j.a4 'Employee Number',
  p.a5 'First Name',
  p.a6 'Middle Name',
  p.a7 'Last Name',
  DATE_FORMAT(e.a5, '%d-%b-%y') 'Joining date',
  DATE_FORMAT(p.a9, '%d-%b-%y') 'Date Of Birth',
  p.a3 'Aadhar',
  p.a4 'PAN',
  p.a13 'Personal Email',
  e.a11 'Official Email',
  org_bg.a3 'Business Group',
  org_le.a3 'Legal Entity', -- Change this to "Legal Entity"
  org_bu.a3 'Brand',
  org_div.a3 'Sub-Brand',
  org_cc.a3 'Cost Center',
  org_dp.a3 'Department',
  org_sdp.a3 'Sub Department',
  org_loc.a3 'Location',
  org_dsg.a3 'Designation',
  org_level.a3 'Level',
   j.a5 'Lion Id',
   j.c3 as 'CS ID',
   org_cds.a3 'C Designation',
  CONCAT(p2.a5, ' ', p2.a7) 'Manager Name'
FROM
  fe_hri_person_t p
  JOIN fe_hrt_emp_employment_t e
    ON (p.a1 = e.a2)
  JOIN fe_hrt_emp_job_t j
    ON (j.a3 = e.a1)
  LEFT JOIN fe_wft_approver_t apr
    ON (e.a1 = apr.a2 AND apr.a3 = 1)
  -- JOIN fe_wfm_approver_type_m apt
--     ON (
--       apr.a3 = apt.a1
--       AND apt.a4 = 'APT0000001'
--     )
  LEFT JOIN fe_hrt_emp_employment_t e2
    ON (e2.a1 = apr.a5)
  LEFT JOIN fe_hri_person_t p2
    ON (p2.a1 = e2.a2)
  LEFT JOIN fe_org_unit_m org_bg
    ON (j.ou1 = org_bg.a1)
  LEFT JOIN fe_org_unit_m org_le
    ON (j.ou2 = org_le.a1)
  LEFT JOIN fe_org_unit_m org_cc
    ON (j.ou4 = org_cc.a1)
  LEFT JOIN fe_org_unit_m org_bu
    ON (j.ou5 = org_bu.a1)
  LEFT JOIN fe_org_unit_m org_dp
    ON (j.ou6 = org_dp.a1)
  LEFT JOIN fe_org_unit_m org_sdp
    ON (j.ou7 = org_sdp.a1)
  LEFT JOIN fe_org_unit_m org_loc
    ON (j.ou9 = org_loc.a1)
  LEFT JOIN fe_org_unit_m org_dsg
    ON (j.ou10 = org_dsg.a1)
  LEFT JOIN fe_org_unit_m org_level
    ON (j.ou13 = org_level.a1)
  LEFT JOIN fe_org_unit_m org_cds
    ON (j.c1 = org_level.a1)
  LEFT JOIN fe_org_unit_m org_div
     ON (j.ou14 = org_level.a1)
WHERE 1 = 1
    AND p.cl = 8
ORDER BY CAST(j.a4 AS SIGNED) ) AS `t`