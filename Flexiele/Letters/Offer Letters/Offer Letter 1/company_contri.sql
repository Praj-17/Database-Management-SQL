SELECT 
  comp.a3 component,
  FORMAT(sal.a8, 0) annual 
FROM
     fe_rec_applicant_t apl
JOIN fe_rec_candidate_offer_t offer
	ON (offer.a2 = apl.a1 AND offer.cl = apl.cl)
JOIN fe_rec_candidate_offer_ctc_t ctc
	ON (offer.a1 = ctc.a2 AND ctc.cl = offer.cl)
JOIN fe_rec_candidate_offer_sal_t sal
	ON (ctc.a1 = sal.a3 AND ctc.cl = sal.cl)
JOIN fe_pyt_sal_comp_m comp 
    ON (sal.a4 = comp.a1 AND sal.cl = comp.cl)WHERE 1 
  AND apl.cl = {session.clientId} 
  AND apl.a1 = {applicant_id} 
  AND IF(
    IFNULL(comp.a5, '') = 3,
    1,
    IFNULL(comp.a7, '') != 1
  ) 
  AND IFNULL(comp.a5, '') IN (1, 3) 
ORDER BY comp.a9 