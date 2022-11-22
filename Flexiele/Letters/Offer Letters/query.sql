SELECT Date_format(curdate(), "%d-%b-%Y")  AS 'offer_created_at',
now() as 'time_stamp',
apl.a1 AS 'applicant_id',
IFNULL(can.a24,concat_ws(" ",can.a5,can.a6,can.a7) )'applicant_name',
IFNULL(apl.a13,jt.a3) 'job_title',
Date_format(offer.a6, "%d-%b-%Y") 'offer_date_of_joining',
FORMAT(ctc.a16,0) 'offer_annual_amount',
FORMAT(ifnull(ctc.a14,0),0) 'offer_cf_fixed',
Format(ifnull(ctc.a15,0),0) 'offer_cf_variable_amount',
freq.a4 'offer_variable_pay_frequency',
FORMAT(IFNULL(nj.a5,0),0) 'offer_cf_joining_bonus_amount',
 FORMAT(IFNULL(ctc.a19,0),0) 'offer_esop_value_in_inr',
 IFNULL(ctc.a21,'') 'offer_esop_series',
IF( IFNULL(nj.a5,0),1,0) as jb,
IF( IFNULL(ctc.a15,0),1,0) as vp,
IF( IFNULL(ctc.a19,0),1,0) as esop
 
FROM fe_rec_applicant_t apl
JOIN fe_rec_candidate_t can
	on (apl.a3 = can.a1 and apl.cl = can.cl)
LEFT JOIN fe_rec_candidate_offer_t offer
	ON (apl.a1 = offer.a2 AND  apl.cl = offer.cl)
LEFT JOIN fe_rec_candidate_offer_ctc_t ctc
	ON (offer.a1 = ctc.a2 AND offer.cl = ctc.cl )
LEFT JOIN fe_rec_requisition_t  jt
	ON (jt.a1 = apl.a2 AND jt.cl = apl.cl)
LEFT JOIN fe_pyt_new_joiner_benefit_t nj
	ON (offer.a1 = nj.a3 AND nj.cl = offer.cl)
LEFT JOIN fe_pyt_sal_comp_m jb
	ON (nj.a4 = jb.a1  AND jb.cl = apl.cl
        AND jb.a5 = 9)
LEFT JOIN fe_pyt_sal_comp_m comp 
	ON(nj.a4 = comp.a1 AND comp.a4 = 'JOIN_BONUS')

LEFT JOIN fe_cfg_lookup_m freq
 on (ctc.a27 = freq.a3
	and freq.a2 = 4000192
    and freq.cl = apl.cl)
where apl.cl ={session.clientId}
and apl.a1 = {applicant_id}