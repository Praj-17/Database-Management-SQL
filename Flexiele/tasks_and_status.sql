SELECT
apl.a1 AS 'applicant_id',
IFNULL(can.a24,concat_ws(" ",can.a5,can.a6,can.a7) )'cand_name',
can.a5 as 'first_name',
can.a7 as 'last_name', 
can.a6 as 'middle_name',
IFNULL(apl.a13,jt.a3) 'job_title',
concat("+", country.a9, con.a4) 'can_phone',
apl.a14 'recruiter',
re.a8    'recruiter_email',
re.a4 'recruiter_name',
can.a23 'cand_email',
date_format(can.a19, "%d-%b-%Y") 'doj',
"https://apps.apple.com/lk/app/flexiele-hrms/id1629205261" as 'link_ios',
"https://play.google.com/store/apps/details?id=com.flexielehrms&hl=en_SG" as 'link_android'

FROM fe_rec_applicant_t apl
JOIN fe_rec_candidate_t can
	on (apl.a3 = can.a1 and apl.cl = can.cl)
LEFT JOIN fe_rec_candidate_offer_t offer
	ON (apl.a1 = offer.a2 AND  apl.cl = offer.cl)
LEFT JOIN fe_rec_requisition_t  jt
	ON (jt.a1 = apl.a2 AND jt.cl = apl.cl)
LEFT JOIN fe_rec_candidate_contact_t con
	on (con.a2 = can.a1 )
LEFT JOIN fe_hrt_emp_summary_t re
 on (apl.a14 = re.a3)
LEFT JOIN  fe_glb_country_g  country
 on (country.a1 = con.a3)
where apl.cl = {session.clientId}
and apl.a1 = {{applicant_id}}