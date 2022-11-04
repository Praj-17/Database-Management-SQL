select e.a4 'emp_code',
  p.a1 as 'person_id',
  e.a3 as 'emp_id',
  DATE_FORMAT(curdate(), '%d-%b-%y') as  date,
  now() as 'time_stamp',
  DATE_FORMAT(t.a5, '%d-%b-%y') 'doj',
  DATE_FORMAT(p.a9, '%d-%b-%y') 'dob',
  YEAR(CURRENT_DATE)-YEAR(p.a9) as 'age',
  summ.a4 'full_name',
  p.a5 'first_name',
  p.a6 'middle_name',
  p.a7 'last_name',

p.a13 as 'email', -- personal_email
rel.a4 as 'religion',
na.a5 'nationality',
ge.a4 'gender',
blood_group.a4 'blood_group', 
p.a3 	'adhaar',
  p.a4 	'pan',  
  elg.a3 'uan',
  elg.a5 'pf',
  elg.a6 'esic',
   gbnk.a2 'bank_name',
  ebnk.a6 as "bank_account_no",
  ebnk.a5 'ifsc',
  ebnk.a10 'bank_account_name',
  f.a3 AS 'father_name',
mother.a3 as 'mother_name',
spouse.a3 as  'spouse_name',
"" as 'spouse_profession',
"" as 'is_relative',
org_le.a3 'legal_entity', 
org_dp.a3 'department',
org_loc.a3 'location',
c.a7 'perm_address',
c.a12  'cur_adress',
c.a13 'city',
c.a3 as 'mobile_number',
c.a5 as 'emergency_number',
'' as 'emg_name_relation',
t.a11 as 'official_email',
pre.a3 as 'prev_comp',
pre.a7 as 'prev_comp_address',
pre.a15 as 'prev_comp_phone',
pre.a9 as 'industry_type',
pre.a13 as 'prev_desg',
pre.a4 as 'prev_doj',
pre.a5 as 'prev_lwd',
"" as 'prev_change_reason',
"" as 'prev_supervisor_name_dsg',
"" as 'company_name_address',
"" as 'post_held_if_any',
"" as 'appointment_date',
"" as 'village',
"" as 'thana',
"" as 'sub_div',
"" as 'post_office',
"" as 'district',
"" as 'state'



from  fe_hri_person_t p
Join fe_hrt_emp_job_t e
	on (e.a2 = p.a1 and p.cl = e.cl)
left join fe_hrt_emp_summary_t summ
 on (e.a3 = summ.a3 and e.cl = summ.cl)
 left JOIN fe_hri_emp_prev_employment_t pre
	on (pre.a2 = p.a1 and e.cl = pre.cl and pre.a6 = 1)
LEFT JOIN fe_hri_emp_family_t f 
    ON (f.a2 = e.a2 
      AND f.a5 = 2 
      AND f.cl = e.cl
      and f.a12 = 1)
LEFT JOIN fe_hri_emp_family_t mother 
    ON (mother.a2 = e.a2 
      AND mother.a5 = 3 
      AND mother.cl = e.cl
      and mother.a12 = 1) 
LEFT JOIN fe_hri_emp_family_t spouse
    ON (spouse.a2 = e.a2 
      AND spouse.a5 = 1 
      AND spouse.cl = e.cl
      and spouse.a12 = 1) 
LEFT JOIN  fe_glb_lookup_m blood_group
on ( 1
	AND blood_group.a3 = p.a21
   AND blood_group.a2 = 1000003
   AND blood_group.a7 = 1 )
LEFT join fe_glb_country_g  na
	on (p.a19 = na.a1 )
LEFT JOIN fe_glb_lookup_m ge
	on (ge.a3 = p.a8 and ge.a2  = 1000001)
left join fe_hrt_emp_employment_t as t on (p.a1 = t.a2 and p.a1 = t.a2)
left join fe_hri_emp_contact_t as c on (p.a1 = c.a2 and p.a1 = c.a2)
LEFT JOIN fe_org_unit_m org_loc
    ON (e.ou9 = org_loc.a1)
LEFT JOIN fe_org_unit_detail_m org_loc_d
    ON (org_loc_d.a2 = org_loc.a1)
LEFT JOIN fe_org_unit_m org_le
    ON (e.ou2 = org_le.a1)
LEFT JOIN fe_hrt_emp_legal_info_t elg
    ON (elg.a2 = e.a1)
  LEFT JOIN fe_hri_emp_bank_t ebnk
    ON (ebnk.a2 = p.a1 AND ebnk.a7 = 20)
  LEFT JOIN fe_cfg_bank_t bnk
    ON (bnk.a1 = ebnk.a3 )
  LEFT JOIN fe_glb_bank_g gbnk
    ON (gbnk.a1 = bnk.a3 )
 LEFT JOIN fe_glb_lookup_m rel
	ON (1 
   AND rel.a2 = 1000002
   AND rel.a7 = 1 
    and p.a20 = rel.a3 )
LEFT JOIN fe_org_unit_m org_dp
    ON (e.ou6 = org_dp.a1)
where e.cl =1
and e.a4 not in ('CRF01660', 'OTP01824', '11', '13', '1','OTP1630', 'OTPx030', 'OTP01688')
  AND t.a11 NOT LIKE '%flexiele%'
and e.a3 = 52728