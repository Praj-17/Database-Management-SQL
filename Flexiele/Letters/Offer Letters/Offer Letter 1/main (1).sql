SELECT CURDATE() AS 'offer_created_at',
apl.a1 AS 'applicant_id',
can.a9 AS 'applicant_name',
jt.a3 'job_title',
can.a19 'offer_date_of_joining',
FORMAT(ctc.a16,0) 'offer_annual_amount',
ctc.a14 'offer_cf_fixed',
ctc.a16 'offer_cf_ctc',
ctc.a15 'offer_cf_variable_amount',
ctc.c1 'offer_variable_pay_frequency',
nj.a5 'offer_cf_joining_bonus_amount'
FROM fe_rec_applicant_t apl
LEFT JOIN fe_rec_candidate_info_t can
ON   (can.a2 = apl.a3 AND apl.cl = can.cl)
LEFT JOIN fe_rec_candidate_job_t job
	ON (can.a1 = job.a2 AND can.cl = job.cl)
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
WHERE apl.cl = {session.clientId}
AND apl.a1 = {applicant_id}