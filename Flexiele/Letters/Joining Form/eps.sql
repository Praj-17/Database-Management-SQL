select 
row_number() over (order by n.a2) as 'index', 
n.a2 as 'emp_id',
f.a3 as 'name',
concat_ws("-", f.a3, f.a9) as "name_and_address",
rel.a4 as 'relation',
DATE_FORMAT(f.a6, '%d-%b-%y')		as 'dob'

from 
fe_hrt_emp_nominees_t n
join fe_hri_emp_family_t f
	on (f.a1 = n.a5 and f.cl = n.cl)
left join fe_cfg_lookup_m rel
	on (rel.a3 = f.a5 and f.cl = rel.cl  AND rel.a2 = 4000008   AND rel.a7 = 1)
where
n.cl =  {session.clientId}
and n.a2 = {{emp_id}}
and n.a3 = 1
    
