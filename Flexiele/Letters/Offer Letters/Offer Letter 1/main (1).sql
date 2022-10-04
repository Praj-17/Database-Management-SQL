SELECT CURDATE() AS 'offer_created_at',
apl.a1 AS 'applicant_id',
IFNULL(can.a24,concat_ws(" ",can.a5,can.a6,can.a7) )'applicant_name',
jt.a3 'job_title',
can.a19 'offer_date_of_joining',
FORMAT(ctc.a16,0) 'offer_annual_amount',
ifnull(ctc.a14,0) 'offer_cf_fixed',
ifnull(ctc.a16,0) 'offer_cf_ctc',
ifnull(ctc.a15,0) 'offer_cf_variable_amount',
ctc.c1 'offer_variable_pay_frequency',
 IFNULL(nj.a5,0) 'offer_cf_joining_bonus_amount',
 IFNULL(ctc.a25,0) 'offer_esop_value_in_inr',
 IFNULL(ctc.a26,'') 'offer_esop_series',
IF( IFNULL(nj.a5,0),1,0) as jb1,
IF( IFNULL(nj.a5,0),1,0) as jb2,
IF( IFNULL(ctc.a15,0),1,0) as vp1,
IF( IFNULL(ctc.a15,0),1,0) as vp2,
IF( IFNULL(ctc.a26,0),1,0) as esop
 
FROM fe_rec_applicant_t apl
JOIN fe_rec_candidate_t can
	on (apl.a3 = can.a1 and apl.cl = can.cl)
LEFT JOIN fe_rec_candidate_offer_t offer
	ON (apl.a1 = offer.a2 AND  apl.cl = offer.cl)
LEFT JOIN fe_rec_candidate_offer_ctc_t ctc
	ON (offer.a2 = ctc.a2 AND offer.cl = ctc.cl )
LEFT JOIN fe_rec_requisition_t  jt
	ON (jt.a1 = apl.a2 AND jt.cl = apl.cl)
LEFT JOIN fe_pyt_new_joiner_benefit_t nj
	ON (offer.a1 = nj.a3 AND nj.cl = offer.cl)
LEFT JOIN fe_pyt_sal_comp_m jb
	ON (nj.a4 = jb.a1  AND jb.cl = apl.cl
        AND jb.a5 = 9)
LEFT JOIN fe_pyt_sal_comp_m comp 
	ON(nj.a4 = comp.a1 AND comp.a4 = 'JOIN_BONUS')
where apl.cl = {session.clientId}
 and apl.a1 = {applicant_id}
