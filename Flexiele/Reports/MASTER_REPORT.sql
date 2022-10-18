select e.a4 'Employee number',
  DATE_FORMAT(t.a4, '%d-%b-%y') 'Group Date of joining',
  DATE_FORMAT(t.a5, '%d-%b-%y') 'Joining Date',
  DATE_FORMAT(p.a9, '%d-%b-%y') 'Date Of Birth',
  if(ifnull(t.a8,1) = 1, 'Active', if(curdate()>t.a8,'Inactive', 'Active') )as 'status',
 les.meaning as 'Employment Status',
summ.a4 'Full Name',
p.a13 as 'Personal Email',
org_loc2.a4 as 'Job Location',
org_bg.a3 'Business Group',
org_le.a3 'Legal Entity', 
  e2.a4 'Manager Name',
  e2.a8 'Manager Email', 

org_dsg.a3 'Designation',
org_dp.a3 'Department',
org_sdp.a3 'Sub Department',
org_loc.a3 'Location',
org_ba.a3 'Level',
org_gr.a3 'Band',
  state.a3 'State',
  org_loc_d.a5 'City',

l_gender.a4 as 'Gender',
c.a3 as 'mob_no',
c.a5 as 'emg_no',
t.a8 as 'Exit Date',
t.a15 as 'Resignation Date',
t.a11 as 'official_email',
fe_get_cfg_lookup_meaning_f(t.cl,'4000002',t.a9) 'Resignation Type',
fe_get_cfg_lookup_meaning_f(t.cl,'4000003',t.a10) 'Exit Reason'



from  fe_hrt_emp_job_t e
left join fe_hrt_emp_summary_t summ
 on (e.a3 = summ.a3 and e.cl = summ.cl)
join  fe_hrt_emp_job_d j
	on (e.a2 = j.a2 and e.cl =j.cl)
left join fe_hri_person_t p on (e.a2 = p.a1 and p.cl = e.cl)
left join fe_hrt_emp_employment_t as t on (p.a1 = t.a2 and p.a1 = t.a2)
left join fe_hri_emp_contact_t as c on (p.a1 = c.a2 and p.a1 = c.a2)
LEFT JOIN fe_org_unit_m org_dp
    ON (e.ou6 = org_dp.a1)
LEFT JOIN fe_org_unit_m org_sdp
    ON (e.ou7 = org_sdp.a1)
LEFT JOIN fe_org_unit_m org_loc
    ON (e.ou9 = org_loc.a1)
LEFT JOIN fe_cfg_lookup_m org_loc2
    ON (j.c1 = org_loc2.a3
		and org_loc2.a2 = '5000001'
        and org_loc2.cl = 7)
LEFT JOIN fe_org_unit_detail_m org_loc_d
    ON (org_loc_d.a2 = org_loc.a1)
LEFT JOIN fe_glb_state_g state
    ON (state.a1 = org_loc_d.a4)
LEFT JOIN fe_org_unit_m org_ba
	on (j.ou13 = org_ba.a1)
LEFT JOIN fe_org_unit_m org_gr
	on (e.ou12 = org_gr.a1)


LEFT JOIN fe_org_unit_m org_dsg
    ON (e.ou10 = org_dsg.a1)
JOIN fe_wfm_approver_type_m apt
     ON (
       t.cl = apt.cl
       AND apt.a4 = 'APT0000001'
     )
LEFT JOIN fe_wft_approver_t apr
    ON (t.a1 = apr.a2 AND apr.a3 = apt.a1)
LEFT JOIN fe_hrt_emp_summary_t e2
    ON (e2.a3 = apr.a5)
LEFT Join fe_core_lookup_m les
	on (les.code = e.a6 and les.category = 'HRT_EMPLOYMENT_STATUS' and  `active` = 1)
LEFT JOIN fe_org_unit_m org_bg
    ON (e.ou1 = org_bg.a1)
LEFT JOIN fe_org_unit_m org_le
    ON (e.ou2 = org_le.a1)
LEFT JOIN fe_glb_lookup_m l_gender
    on (l_gender.a2 = 1000001 and l_gender.a3=p.a8 and l_gender.a7=1)
where e.cl ={session.clientId}
and e.a4 not in ('CRF01660', 'OTP01824', '11', '13', '1','OTP1630', 'OTPx030', 'OTP01688')
  AND t.a11 NOT LIKE '%flexiele%'
--  and e.ou2 = {legal_entity}
and  curdate() between j.from and j.to