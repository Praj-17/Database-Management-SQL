SELECT 
info.a9 as 'candidate name',
can.a19 'tentative_doj',
org_loc.a3 'location',
org_dp.a3 'Department',
org_dsg.a3 'Designation'
FROM fe_rec_candidate_t can
LEFT JOIN fe_rec_candidate_job_t job
	ON (can.a1 = job.a2 and can.cl = job.cl)
LEFT JOIN fe_rec_candidate_info_t info
	on (can.a1 = info.a2 and can.cl = info.cl)
LEFT JOIN fe_org_unit_m org_loc
    ON (job.a31= org_loc.a1)
 LEFT JOIN fe_org_unit_m org_dp
    ON (job.a32 = org_dp.a1)
LEFT JOIN fe_org_unit_m org_dsg
    ON (job.a34 = org_dsg.a1)
