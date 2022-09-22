SELECT
    cm.a2 comp_desc,
    FORMAT(sal.a5, 2) comp_rate,
    FORMAT(
        SUM(IF(cm.a5 != 4, draft.a6, 0)),
        2
    ) comp_amt,
    FORMAT(
        SUM(IF(cm.a5 = 4, draft.a6, 0)),
        2
    ) comp_amt_ar,
    '0.0' ytd
FROM `fe_pyt_emp_bt_t` bt
    JOIN `fe_pyt_emp_draft_pay_t` draft ON (
        bt.a2 = draft.a2 AND bt.a3 = draft.a5
    )
    JOIN `fe_pyt_sal_comp_m` cm ON (cm.a1 = draft.a3)
    JOIN `fe_pyt_emp_ctc_t` ctc ON (
        ctc.a2 = bt.a2 AND ctc.a7 = 1 AND LAST_DAY(
            STR_TO_DATE(
                CONCAT(bt.a3, '-01'), '%Y-%m-%d'
            )
        ) BETWEEN ctc.a3 AND ctc.a4
    )
    LEFT JOIN `fe_pyt_emp_sal_t` sal ON (
        sal.a4 = cm.a1 AND sal.a3 = ctc.a1
    )
WHERE
    1
    AND cm.a7 = 1
    AND IF(cm.a7 = 2, cm.a18 = 2, 1)
    AND bt.cl ={session.clientId}
    AND draft.a2 ={{emp_id}}
    AND draft.a5 = '{{month}}'
    AND cm.a13 = 1
GROUP BY
REPLACE(cm.a4, '_A', '');