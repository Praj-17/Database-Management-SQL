select
e.a5 as 'emp_code',
c.a3 as 'primary_phone',
CONCAT(g.a2,'( ' ,g.a9 ,' )')  AS 'Country Code'
from fe_hrt_emp_summary_t e
LEFT JOIN fe_hri_emp_contact_t c
	on (e.a2 = c.a2 and e.cl = c.cl)
LEFT join fe_glb_country_g g
	On (c.a9= g.a1 )

