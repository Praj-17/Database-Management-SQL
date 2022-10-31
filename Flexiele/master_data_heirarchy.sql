select 



le.a3 'Legal Entity',
dsg.a3 'Desgination',
ba.a3 'Band',
lev.a3 'Level'

from
fe_org_unit_m dsg

left join fe_org_unit_m  le
	on (le.a1 = dsg.ou2 and le.a6 =1)
left join fe_org_unit_m  ba
	on (ba.a1 = dsg.ou12 and ba.a6 = 1)
left join fe_org_unit_m  lev
	on (lev.a1 = dsg.ou13 and lev.a6 = 1)
where 1
and dsg.a6 =1
and dsg.cl = 7
order by le.a3