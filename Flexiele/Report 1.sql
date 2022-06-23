
-- Doubts
-- 1. where to find state, city, region from given location
-- 2. Unable to fetch manager details(proper table not found)

select e.a4 employee_no,
e.a2 as emp_id,
t.a4 as 'Group Doj' ,


(select l.meaning from fe_core_lookup_m l
 where 1 AND `category` = 'HRT_EMPLOYMENT_STATUS' AND `active` = 1 and l.code = e.a6 
 ORDER BY `order` ) as employment_status, 
 
CONCAT(p.a5, ' ', p.a7) as Full_Name,
t.a5 as joining_date,
p.a9 as DOB,
(SELECT t1.a3 as 'meaning' FROM fe_org_unit_m t1 
JOIN DV_DAG0000002_DV dag 
ON (
       t1.cl = dag.cl 
       AND t1.a1 = dag.ou1 
       AND dag.ou_type = 'ou1'
     ) 
JOIN fe_cfg_org_unit_type_m t2 
     ON (t2.a1 = t1.a2 
       AND t2.a5 = 1) 
 WHERE 1 
   AND t2.a4 = 'OUM0000001' 
   AND t1.a6 = 1 
   and t1.a1= t.a26 ) as buisness_group,
(SELECT 
 l.a3 AS meaning
FROM fe_org_unit_m l
  WHERE 1
 AND l.a4 LIKE '%LEC%'
  AND l.a6 = 1
  and l.a1 = t.a27) as Legal_Entity,
org_dsg.a3 'Designation',
org_dp.a3 'Department',
org_sdp.a3 'Sub Department',
org_loc.a3 'Location',



(select l.a4 from fe_glb_lookup_m l where l.a2 = 1000001 and l.a3=p.a8 and l.a7=1) gender,
c.a3 as mob_no,
c.a5 as emg_no,
t.a9 as 'Resignation type',
t.a15 as 'Exit Date',
t.a15 as 'Resignation Date',
t.a11 as official_email,
(SELECT
   l.a4  FROM
   fe_cfg_lookup_m l
 WHERE 1
   AND l.a2 = 4000002
   AND l.a7 = 1
   and l.a3 = t.a9 limit 1) as exit_reason


from  fe_hrt_emp_job_t e
left join fe_hri_person_t p on (e.a2 = p.a1)
left join fe_hrt_emp_employment_t as t on (p.a1 = t.a2)
left join fe_hri_emp_contact_t as c on (p.a1 = c.a2)
LEFT JOIN fe_org_unit_m org_dp
    ON (e.ou6 = org_dp.a1)
LEFT JOIN fe_org_unit_m org_sdp
    ON (e.ou7 = org_sdp.a1)
LEFT JOIN fe_org_unit_m org_loc
    ON (e.ou9 = org_loc.a1)
LEFT JOIN fe_org_unit_m org_dsg
    ON (e.ou10 = org_dsg.a1)
LEFT JOIN fe_hri_person_t p2
    ON (p.a1 = t.a2)

 