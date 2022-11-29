select 
summ.a4 'Full Name',
e.a4 'Employee number',
t.a11 as 'official_email',
hfm.a3 `Cost Centre`,
org_bg.a3 'Brand',
org_le.a3 'Sub-Brand', 
GROUP_CONCAT(role.a5 
    ORDER BY role.a8) as 'role'
from  fe_hrt_emp_job_t e
join fe_acm_user_t us
on(e.a3 = us.a2 and us.cl = e.cl)
left join fe_hrt_emp_summary_t summ
 on (e.a3 = summ.a3 and e.cl = summ.cl)
left join fe_hrt_emp_employment_t as t on (summ.a3 = t.a1)
LEFT JOIN fe_org_unit_m hfm 
    ON (hfm.cl = e.cl 
      AND e.ou4 = hfm.a1) 

LEFT JOIN fe_org_unit_m org_bg
    ON (e.ou1 = org_bg.a1)
LEFT JOIN fe_org_unit_m org_le
    ON (e.ou5 = org_le.a1)
LEFT JOIN fe_acm_role_m role
	on (find_in_set(role.a1, us.a7) and role.cl = us.cl)
where e.cl ={session.clientId}
and e.ou4 = {cost_center}
GROUP BY us.a1 
order by e.a4 
