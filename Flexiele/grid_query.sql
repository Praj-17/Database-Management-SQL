SELECT
    taskPerformer.a1 as id,
    IFNULL(can.a24,concat_ws(" ",can.a5,can.a6,can.a7) )'applicant_name',
    can.a4 as emp_code,
	ctc.a16 as annual_ctc,
    ctc.a13 as monthly_gross,
    cfg.a4 as change_reason,
    DATE_FORMAT(ctc.a3, "%d-%M-%Y") as effective_from,
     offer.a1 as offer_id,
    ctc.a1 as ctc_id
FROM
    fe_wft_task_performer_t AS taskPerformer
JOIN fe_wft_task_t AS taskT ON
    (taskT.cl = taskPerformer.cl
        AND taskT.a1 = taskPerformer.a2
        AND taskT.a21 = 'WTM0000030')
JOIN fe_wfm_task_m AS taskM ON
    (taskM.cl = taskT.cl
        AND taskM.a1 = taskT.a2)
JOIN fe_rec_candidate_offer_ctc_t AS ctc ON
    (ctc.cl = taskT.cl
        AND ctc.a1 = taskT.a6) -- request_id/ctc_id
JOIN fe_rec_candidate_offer_t AS offer ON -- 
    (ctc.cl = offer.cl
        AND ctc.a2 = offer.a1)
JOIN fe_rec_candidate_t AS can ON
   (ctc.cl = can.cl
     AND offer.a4 = can.a1)
JOIN fe_rec_candidate_offer_job_t AS job ON
    (job.cl = ctc.cl
        AND job.a2 = offer.a1)
JOIN fe_wft_approver_t AS appr ON
    (taskPerformer.cl = appr.cl
        AND job.a10 = appr.a4
        AND taskPerformer.a10 = appr.a3
        AND appr.a2 = ctc.a2)
-- JOIN fe_acm_user_t AS usr ON
--     (usr.cl = appr.cl
--         AND usr.a2 = appr.a5)
JOIN fe_cfg_lookup_m AS cfg ON
    (cfg.a3 = ctc.a6
        AND cfg.a2 = 4000036
        AND taskPerformer.cl = cfg.cl)
WHERE
    1
    AND 1
    AND taskT.a9 = 1
    AND taskPerformer.a7 = 1
	AND ctc.a7 = 3
    AND taskPerformer.cl = 1
LIMIT 50001