select curdate() as 'offer.created_at',
apl.a1 as 'applicant_id',
can.a9 as 'applicant.name',
jt.a3 'job.title',
can.a19 'offer.date_of_joining',
FORMAT(ctc.a16,0) 'offer.annual_amount',
ctc.a14 'offer.cf_fixed'
from fe_rec_applicant_t apl
LEFT JOIN fe_rec_candidate_info_t can
on (can.a2 = apl.a3 and apl.cl = can.cl)
LEFT JOIN fe_rec_candidate_job_t job
	ON (can.a1 = job.a2 and can.cl = job.cl)
LEFT JOIN fe_rec_candidate_offer_t offer
	on (apl.a1 = offer.a2 and  apl.cl = offer.cl)
LEFT JOIN fe_rec_candidate_offer_ctc_t ctc
	on (offer.a2 = ctc.a2 and offer.cl = ctc.cl )
LEFT JOIN fe_rec_requisition_t  jt
	on (jt.a1 = apl.a2 and jt.cl = apl.cl)
where apl.cl = 1
-- and apl.a1 = {applicant_id}




