

select
    DATE_FORMAT(CURDATE(), '%d-%b-%y')as 'date',
    e.a2 'employee_id',
    DATE_FORMAT(t.a5, '%d-%b-%y') 'joining_date',
    CONCAT(p.a5, ' ', p.a7) as 'employee_name',
    CONCAT(p.a6, ' ', p.a7) as 'father_name',
    org_le.a3 'legal_entity', 
    org_dsg.a3 'designation',
    org_sdp.a3 'sub_department',
    org_loc.a3 'location',
    ctc.a13 'gross_m',
    ctc.a13*12 'gross_y',
    ctc.a14 'fixed_y',
FROM fe_hrt_emp_job_t e
LEFT JOIN fe_hri_person_t p 
    ON (e.a2 = p.a1 AND e.cl = p.cl)
LEFT JOIN fe_hrt_emp_employment_t as t 
    ON (p.a1 = t.a2 AND e.cl = t.cl)
LEFT JOIN fe_hri_emp_contact_t as c
    ON (p.a1 = c.a2 AND p.cl = c.cl)
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
    ON (t.cl = apt.cl AND apt.a4 = 'APT0000001')
LEFT JOIN fe_wft_approver_t apr
    ON (t.a1 = apr.a2 AND apr.a3 = apt.a1 AND t.cl = apr.cl)
LEFT JOIN fe_hrt_emp_summary_t e2
    ON (e2.a3 = apr.a5 and apr.cl = e2.cl)
LEFT Join fe_core_lookup_m les
	ON (les.code = e.a6 and les.category = 'HRT_EMPLOYMENT_STATUS' and  `active` = 1 )
LEFT JOIN fe_org_unit_m org_bg
    ON (e.ou1 = org_bg.a1 and e.cl = org_bg.cl)
LEFT JOIN fe_org_unit_m org_le
    ON (e.ou2 = org_le.a1 and e.cl = org_le.cl)
LEFT JOIN fe_glb_lookup_m l_gender
    ON (l_gender.a2 = 1000001 and l_gender.a3=p.a8 and l_gender.a7=1)
LEFT JOIN fe_pyt_emp_ctc_t ctc 
    ON (ctc.a2 = e.a2)
WHERE e.cl={session.clientId}



 