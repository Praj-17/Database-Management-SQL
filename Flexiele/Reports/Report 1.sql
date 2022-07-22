
select e.a4 'Employee number',
  DATE_FORMAT(t.a4, '%d-%b-%y') 'Group Date of joining',
  DATE_FORMAT(t.a5, '%d-%b-%y') 'Joining Date',
  DATE_FORMAT(p.a9, '%d-%b-%y') 'Date Of Birth', 

 les.meaning as 'Employment Status',
 
CONCAT(p.a5, ' ', p.a7) as 'Full Name',

org_bg.a3 'Business Group',
org_le.a3 'Legal Entity', 
  e2.a4 'Manager Name',
  e2.a8 'Manager Email', 

org_dsg.a3 'Designation',
org_dp.a3 'Department',
org_sdp.a3 'Sub Department',
org_loc.a3 'Location',
  state.a3 'State',
  org_loc_d.a5 'City',
org_loc_d.a8 'Region',

l_gender.a4 as 'Gender',
c.a3 as 'mob_no',
c.a5 as 'emg_no',
t.a15 as 'Exit Date',
t.a15 as 'Resignation Date',
t.a11 as 'official_email',
fe_get_cfg_lookup_meaning_f(t.cl,'4000002',t.a9) 'Resignation Type',
t.a10 as 'Exit Reason'



from  fe_hrt_emp_job_t e
left join fe_hri_person_t p on (e.a2 = p.a1 AND e.cl = p.cl)
left join fe_hrt_emp_employment_t as t on (p.a1 = t.a2 AND e.cl = t.cl)
left join fe_hri_emp_contact_t as c on (p.a1 = c.a2 AND p.cl = c.cl)
LEFT JOIN fe_org_unit_m org_dp
    ON (e.ou6 = org_dp.a1 AND e.cl = org_dp.cl)
LEFT JOIN fe_org_unit_m org_sdp
    ON (e.ou7 = org_sdp.a1 AND e.cl = org_sdp.cl)
LEFT JOIN fe_org_unit_m org_loc
    ON (e.ou9 = org_loc.a1 AND e.cl = org_loc.cl)
LEFT JOIN fe_org_unit_detail_m org_loc_d
    ON (org_loc_d.a2 = org_loc.a1 AND org_loc_d.cl = org_loc.cl)
LEFT JOIN fe_glb_state_g state
    ON (state.a1 = org_loc_d.a4)


LEFT JOIN fe_org_unit_m org_dsg
    ON (e.ou10 = org_dsg.a1 AND e.cl = org_dsg.cl)
JOIN fe_wfm_approver_type_m apt
     ON (
       t.cl = apt.cl
       AND apt.a4 = 'APT0000001'
    
     )
LEFT JOIN fe_wft_approver_t apr
    ON (t.a1 = apr.a2 AND apr.a3 = apt.a1 AND t.cl = apr.cl)
LEFT JOIN fe_hrt_emp_summary_t e2
    ON (e2.a3 = apr.a5 and apr.cl = e2.cl)
LEFT Join fe_core_lookup_m les
	on (les.code = e.a6 and les.category = 'HRT_EMPLOYMENT_STATUS' and  `active` = 1 )
LEFT JOIN fe_org_unit_m org_bg
    ON (e.ou1 = org_bg.a1 and e.cl = org_bg.cl)
LEFT JOIN fe_org_unit_m org_le
    ON (e.ou2 = org_le.a1 and e.cl = org_le.cl)
LEFT JOIN fe_glb_lookup_m l_gender
    on (l_gender.a2 = 1000001 and l_gender.a3=p.a8 and l_gender.a7=1)
where e.cl={session.clientId}



 