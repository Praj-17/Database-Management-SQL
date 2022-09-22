SELECT CURDATE() AS 'offer.created_at',
can.a9 AS 'applicant.name',
jt.a3 'job.title',
can.a19 'offer.date_of_joining',
FORMAT(ctc.a16,0) 'total_ctc' 
FROM fe_rec_applicant_t apl
LEFT JOIN fe_rec_candidate_info_t can
ON (can.a2 = apl.a3 AND apl.cl = can.cl)
LEFT JOIN fe_rec_candidate_job_t job
	ON (can.a1 = job.a2 AND can.cl = job.cl)
LEFT JOIN fe_rec_candidate_offer_t offer
	ON (apl.a1 = offer.a2 AND  apl.cl = offer.cl)
LEFT JOIN fe_rec_candidate_offer_ctc_t ctc
	ON (offer.a2 = ctc.a2 AND offer.cl = ctc.cl )
LEFT JOIN fe_rec_requisition_t  jt
	ON (jt.a1 = apl.a2 AND jt.cl = apl.cl)
WHERE apl.cl = {session.clientId}
AND apl.a1 = {applicant_id}