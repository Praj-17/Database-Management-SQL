SELECT
	t2.a2,
	t1.*
FROM
	fe_pyt_emp_sal_t t1
JOIN fe_pyt_sal_comp_m t2
ON (t1.cl = t2.cl
	AND t1.a4 = t2.a1)
WHERE
	t1.a2 = 50318