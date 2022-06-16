use dev_test;
SELECT 
        t4.cl, t4.lg,   t2.label, t3.col_name, t1.name, t1.lov, t3.key_type,t3.fk_table,t3.fk_column
FROM    
                `fe_core_field_m` t1
                 JOIN `fe_core_form_g` t2 ON(t1.form_id = t2.id)
                JOIN `fe_core_table_col_g` t3 ON(t3.id = t1.db_col_id)
                JOIN `fe_core_table_g` t4 ON(t4.id = t3.table_id)
WHERE 1
    AND t4.name =  'fe_hrt_emp_job_t'
#change table name
    AND t1.cl = 1
     -- AND t4.lg = 2
ORDER BY t2.id,
CASE SUBSTR(col_name, 1, 1)
WHEN 'a' THEN 1
WHEN 'c' THEN 2
ELSE 3
END, REPLACE(REPLACE(col_name, 'a', ''), 'c', '')*1 ;