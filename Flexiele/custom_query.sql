SELECT
    t4.a4 letterHeadId
    FROM
    fe_cfg_org_unit_type_m t1
    JOIN fe_org_unit_m t2 ON(t1.a1 = t2.a2)
    JOIN fe_rec_candidate_offer_job_t t3 ON(t3.ou2 = t2.a1)
    JOIN fe_rec_candidate_offer_t t6 ON (t6.a1 = t3.a2 )
    JOIN fe_org_unit_property_d t4 ON(t4.a2 = t2.a1)
    JOIN fe_cfg_org_unit_property_m  t5 ON(t5.a1 = t4.a3)
    WHERE 1
    AND t2.cl  = {session.clientId}
    AND CURDATE() BETWEEN t4.from AND t4.to
    AND t6.a2 = {applicant_id}
    AND t5.a4 = 'letter_head'