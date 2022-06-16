-- Assignments--
use dev;
select * from fe_glb_lookup_m ;
SELECT
	a3 AS code,
	a4 AS meaning,
	'' AS tip
FROM
	fe_glb_lookup_m
WHERE
	1
	AND a2 = 1000129
	AND a7 = 1
ORDER BY
	a8 ASC;
    
SELECT
	a3 AS code,
	a4 AS meaning,
	'' AS tip
FROM
	fe_glb_lookup_m
WHERE
	1
	AND a2 = 1000129
	AND a7 = 1
ORDER BY
	a8 ASC;
-- Task 1  
-- wthout meanings
select p.a1 person_id , p.a2 title, p.a3 Adhaar_Number,
	CONCAT(p.a5," ",p.a6,"",p.a7) Full_Name,
    p.a8 gender, p.a9 DOB, p.a11  marital_status,
    p.a13 personal_email, p.a18 place_of_birth,
    p.a19 nationality , p.a20 religion, p.a21 blood_group,
    p.c1 employee_number from fe_hri_person_d p where p.a3 = 408916678367;
-- with meanings
select p.a1 person_id , 
	(select l.a4 from fe_glb_lgs_lookup_m l where l.a2 = 2000001 and l.a3=p.a2 and l.a7=1 ) as title, 
    p.a3 Adhaar_Number,
	CONCAT(p.a5," ",p.a6,"",p.a7) Full_Name,
    (select l.a4 from fe_glb_lookup_m l where l.a2 = 1000001 and l.a3=p.a2 and l.a7=1) gender,
    p.a9 DOB,
    (select l.a4 from fe_glb_lgs_lookup_m  l where l.a2 = 2000002 and l.a3 =p.a11 and l.a7=1)  marital_status,
    p.a13 personal_email, p.a18 place_of_birth,
    (select l.a5 from fe_glb_country_g  l where  l.a1 =p.a19 )  nationality ,
    (select l.a4 from fe_glb_lookup_m  l where l.a2 = 1000002 and  l.a3 =p.a20 ) religion,
    (select l.a4 from fe_glb_lookup_m  l where l.a2 = 1000003 and  l.a3 =p.a21 and l.a7=1) blood_group
    from fe_hri_person_t p where p.a3 = 408916678367;

-- Task 2
select * from fe_hrt_emp_employment_t;
select * from fe_core_lookup_m;
select * from fe_cfg_lookup_m;
 
select a4 from fe_core_lookup_m l where l.a7=1 and l.a2 = 3000002 and l.a3 = e.a3;


--------------------------------------------------------------
use dev;
select e.a2    person_id,
 (select a4 from fe_core_lookup_m l where l.a7=1 and l.a2 = 3000002 and l.a3 = e.a3) person_type,
  e.a4 original_doj, e.a5 joining_date,
e.a6 hiring_source, e.a11 off_email,   
 (select a4 from fe_core_lookup_m l where l.a7=1 and l.a2 = 3000002 and l.a3 = e.a26) legal_entity
 from fe_hrt_emp_employment_t e where e.a2 = 94749;
--------------------------------------------------------------
 
-- Task 3


select j.a2 person_id, j.a3 emp_id,j.a4 employee_no,
(select a4 from fe_core_lookup_m l where l.a7 =1 and l.a2 = 4000004 and l.a3 = e.a5) employement_status, j.a7 job_type, 
ou1 business_group, j.ou2 legal_entity,  j.ou4 cost_center, j.ou5 business_unit, j.ou6 dept, 
j.ou9 location, j.ou10 designation, j.ou12 role_band, ou13 level
from fe_hrt_emp_job_t j where a2 = 94749;







  
SELECT
   a3 AS `code`,
   a4 AS `meaning`,
   a5 AS `tip`
 FROM
   fe_core_lookup_m
  WHERE 1 
   AND a2 = 3000002
   AND a7 = 1
   AND a3 NOT IN(3)
 ORDER BY a8;
 SELECT
   a3 AS `code`,
   a4 AS `meaning`,
   a5 AS `tip`
 FROM
   fe_cfg_lookup_m
 WHERE 1
 and cl={session.clientId}
     AND a2 = 4000004
   AND a7 = 1
 ORDER BY a4;
 
 

