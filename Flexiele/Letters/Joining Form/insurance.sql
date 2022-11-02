select 
i.a2 as 'emp_id',
f.a3 as 'name',
rel.a4 as 'relation',
f.a6		as 'dob',
YEAR(curdate())-YEAR(f.a6) as 'age',
gen.a4 as 'gender',
if(f.a11 =1, 'Yes', 'No') as 'is_dependant'

from fe_hrt_emp_insurance_t i
join fe_hri_emp_family_t f
	on (i.a11 = f.a1 and f.cl = i.cl and f.a12 = 1)
left join fe_cfg_lookup_m rel
	on (rel.a3 = f.a5 and f.cl = rel.cl  AND rel.a2 = 4000008   AND rel.a7 = 1)
left join fe_glb_lookup_m gen
	on (gen.a3 = f.a4  AND gen.a2 = 1000001
   AND gen.a7 = 1 )
where
i.cl = {{session.clientId}}
and i.a10 = 1
and i.a2 = {{emp_id}}
