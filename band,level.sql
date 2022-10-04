SELECT 
    e.a5 'Emp Code', org_ba.a3 AS 'Band', org_lev.a3 AS 'Level'
FROM
    fe_hrt_emp_summary_t e
        JOIN
    fe_hrt_emp_job_d j ON (j.a3 = e.a3 AND e.cl = j.cl)
        LEFT JOIN
    fe_org_unit_m org_lev ON (j.ou13 = org_lev.a1)
        LEFT JOIN
    fe_org_unit_m org_ba ON (j.ou12 = org_ba.a1)
WHERE
    1 AND CURDATE() BETWEEN j.from AND j.to
        AND e.cl = 7
        AND e.a5 IN ('CRF01088' , 'CRF01091',
        'CRF01092',
        'CRF01095',
        'CRF01104',
        'CRF01111',
        'CRF01114',
        'CRF01115',
        'CRF01116',
        'CRF01124',
        'CRF01132',
        'CRF01134',
        'CRF01136',
        'CRF01142',
        'CRF01147',
        'CRF01171',
        'CRF01310',
        'CRF01311',
        'CRF01312',
        'CRF01313',
        'CRF01314',
        'CRF01315',
        'CRF01316',
        'CRF01319',
        'CRF01321',
        'CRF01326',
        'CRF01364',
        'CRF01368',
        'CRF01369',
        'CRF01375',
        'CRF01393',
        'CRF01404',
        'CRF01413',
        'CRF01421',
        'CRF01422',
        'CRF01441',
        'OTP00072',
        'OTP01106',
        'OTP01131',
        'OTP01348',
        'OTP01350',
        'OTP01355',
        'OTP01430',
        'OTP01434',
        'OTP01455',
        'OTP01499',
        'CRF01604',
        'OTP01505',
        'CRF01563',
        'CRF01138',
        'CRF01245',
        'CRF01266',
        'CRF01303',
        'CRF01573')