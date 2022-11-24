SELECT 
es.a5 'emp_code', IF(t4.a1 IS NOT NULL, 'Downloaded', 'Not Downloaded') 'status' 
FROM 
	fe_acm_emp_landing_page_t t1
	JOIN fe_cfg_landing_page_t t2 ON(t2.a1 = t1.a3)
	JOIN `fe_cfg_emp_doc_m` t3 ON(t3.cl = t1.cl AND t3.a15 = 'DOC0000003')
	LEFT JOIN `fe_hrt_emp_doc_t` t4 ON(t4.a2 = t1.a2 AND t4.a3 = t3.a1)
	JOIN fe_hrt_emp_summary_t es ON(es.a3 = t1.a2)
WHERE 1
	AND t1.cl = 7
	AND t2.a4 =  'LDP0000004'
;