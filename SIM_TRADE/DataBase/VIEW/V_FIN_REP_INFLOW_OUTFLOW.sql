CREATE OR REPLACE VIEW V_FIN_REP_INFLOW_OUTFLOW AS
  select B.YEAR_MONTH,
         B.PREV_YEAR_MONTH,
         (SELECT count (*)
            FROM PHONE_ACTIV_LOG L
            WHERE L.YEAR_MONTH = B.YEAR_MONTH
              AND NOT EXISTS (SELECT 1
                                FROM PHONE_ACTIV_LOG L1
                                WHERE L1.PHONE_NUMBER = L.PHONE_NUMBER
                                  AND L1.YEAR_MONTH = B.PREV_YEAR_MONTH)) INFLOW,
         (SELECT count (*)
            FROM PHONE_ACTIV_LOG L
            WHERE L.YEAR_MONTH = B.PREV_YEAR_MONTH
              AND NOT EXISTS (SELECT 1
                                FROM PHONE_ACTIV_LOG L1
                                WHERE L1.PHONE_NUMBER = L.PHONE_NUMBER
                                  AND L1.YEAR_MONTH = B.YEAR_MONTH)) OUTFLOW
    FROM (SELECT YEAR_MONTH, 
                 CASE 
                   WHEN YEAR_MONTH - 1 = TRUNC(YEAR_MONTH/100)*100 THEN YEAR_MONTH - 100 + 12 - 1
                   ELSE YEAR_MONTH - 1
                 END PREV_YEAR_MONTH 
          FROM PHONE_ACTIV_LOG
          GROUP BY YEAR_MONTH) B
    ORDER BY YEAR_MONTH DESC;
  
GRANT SELECT ON V_FIN_REP_INFLOW_OUTFLOW TO CORP_MOBILE_ROLE;  
              
                    