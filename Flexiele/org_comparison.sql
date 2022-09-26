select 
t1.a1	id,
t1.a2	ou_type,
t1.a3	name,
t1.a4	code,
t1.a5	short_code,
t1.a6	active,
bg.a3 as 'Buisness Group',
t1.ou2 as 'Legal Entity',
t1.ou6 as 'Department',
t1.ou7 as 'Sub-Department',
t1.ou13	level,
t1.ou12	band,
t1.ou7	division,
t1.ou8	zone

 from 
fe_org_unit_m t1
LEFT JOIN fe_cfg_org_unit_type_m bg
on (t1.ou1 = bg.a1  AND t1.a4='OUM0000001')
where t1.cl = 7