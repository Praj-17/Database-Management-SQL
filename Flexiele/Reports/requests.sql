SELECT 
  t5.a4 `Name`,
  t5.a5 `Emp Code`,
  org_bg.a3 'Business Group',
  ou2.a3 `Brand`,
  t12.a5 `Brand DOJ`,
  ou10.a3 `Designation`,
  ou6.a3 `Department`,
  ou9.a3 `Location`,
  DATE_FORMAT(t1.a3, '%d-%m-%y') `Date`,
  t3.a2 `Shift`,
  t1.a7 `Worked Hours`,
  t1.a4 `Check In Time`,
  t13.c3 'CS ID',
  IFNULL(t1.a21, '') `Check In Location`,
  t1.a5 `Check Out Time`,
  IFNULL(t1.a33, '') `Check Out Location`,
  CONCAT(t8.a4, '(', t8.a5, ')') `RM`,
  CONCAT(t11.a4, '(', t11.a5, ')') `HOD` 
FROM
  `fe_alm_emp_attendance_t` t1 
  JOIN `fe_alm_shift_timing_t` t2 
    ON (t2.a1 = t1.a6) 
  JOIN `fe_alm_shift_m` t3 
    ON (t3.a1 = t2.a2) 
  JOIN `fe_hrt_emp_summary_t` t5 
    ON (t5.a3 = t1.a2) 
  JOIN DV_DAG0000001_DV dag 
    ON (
	  dag.eId = t5.a3 
	  AND dag.pId = t5.a2
	)
  JOIN `fe_wfm_approver_type_m` t6 
    ON (
      t6.cl = t1.cl 
      AND t6.a4 = 'APT0000001'
    ) 
  LEFT JOIN `fe_wft_approver_t` t7 
    ON (t7.a2 = t1.a2 
      AND t7.a3 = t6.a1) 
  LEFT JOIN `fe_hrt_emp_summary_t` t8 
    ON (t8.a3 = t7.a5) 
  JOIN `fe_wfm_approver_type_m` t9 
    ON (
      t9.cl = t1.cl 
      AND t9.a4 = 'APT0000005'
    ) 
  LEFT JOIN `fe_wft_approver_t` t10 
    ON (t10.a2 = t1.a2 
      AND t10.a3 = t9.a1) 
  LEFT JOIN `fe_hrt_emp_summary_t` t11 
    ON (t11.a3 = t10.a5) 
  JOIN `fe_hrt_emp_employment_t` t12 
    ON (t12.a1 = t1.a2) 
  JOIN `fe_hrt_emp_job_t` t13 
    ON (t13.a3 = t1.a2)
  LEFT JOIN fe_org_unit_m org_bg
    ON (t13.ou1 = org_bg.a1) 
  JOIN `fe_org_unit_m` ou2 
    ON (ou2.a1 = t13.ou2) 
  LEFT JOIN `fe_org_unit_m` ou9 
    ON (ou9.a1 = t13.ou9) 
  LEFT JOIN `fe_org_unit_m` ou10 
    ON (ou10.a1 = t13.ou10) 
  LEFT JOIN `fe_org_unit_m` ou6 
    ON (ou6.a1 = t13.ou6)
WHERE 1 
  AND t1.cl = 1   
AND t1.a3 BETWEEN '2022-01-15'  AND '2022-03-23'
  AND (
    IFNULL(UNIX_TIMESTAMP(t1.a4), 0) > 0 
    OR IFNULL(UNIX_TIMESTAMP(t1.a5), 0) > 0
  )
ORDER BY  t5.a5,  t1.a3