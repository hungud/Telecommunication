CREATE OR REPLACE VIEW V_SUTOCHNIE_BILLS AS
  SELECT T.*,
         (SELECT V.BILL_SUM_NEW
            FROM V_BILL_FINANCE_FOR_CLIENTS V
            WHERE V.PHONE_NUMBER = T.PHONE_NUMBER AND V.YEAR_MONTH = T.YEARS * 100 + 1
              AND V.COMPLETE_BILL = 1 AND ROWNUM = 1) BILL_01,
         (SELECT V.BILL_SUM_NEW
            FROM V_BILL_FINANCE_FOR_CLIENTS V
            WHERE V.PHONE_NUMBER = T.PHONE_NUMBER AND V.YEAR_MONTH = T.YEARS * 100 + 2
              AND V.COMPLETE_BILL = 1 AND ROWNUM = 1) BILL_02,
         (SELECT V.BILL_SUM_NEW
            FROM V_BILL_FINANCE_FOR_CLIENTS V
            WHERE V.PHONE_NUMBER = T.PHONE_NUMBER AND V.YEAR_MONTH = T.YEARS * 100 + 3
              AND V.COMPLETE_BILL = 1 AND ROWNUM = 1) BILL_03,
         (SELECT V.BILL_SUM_NEW
            FROM V_BILL_FINANCE_FOR_CLIENTS V
            WHERE V.PHONE_NUMBER = T.PHONE_NUMBER AND V.YEAR_MONTH = T.YEARS * 100 + 4
              AND V.COMPLETE_BILL = 1 AND ROWNUM = 1) BILL_04,
         (SELECT V.BILL_SUM_NEW
            FROM V_BILL_FINANCE_FOR_CLIENTS V
            WHERE V.PHONE_NUMBER = T.PHONE_NUMBER AND V.YEAR_MONTH = T.YEARS * 100 + 5
              AND V.COMPLETE_BILL = 1 AND ROWNUM = 1) BILL_05,
         (SELECT V.BILL_SUM_NEW
            FROM V_BILL_FINANCE_FOR_CLIENTS V
            WHERE V.PHONE_NUMBER = T.PHONE_NUMBER AND V.YEAR_MONTH = T.YEARS * 100 + 6
              AND V.COMPLETE_BILL = 1 AND ROWNUM = 1) BILL_06,
         (SELECT V.BILL_SUM_NEW
            FROM V_BILL_FINANCE_FOR_CLIENTS V
            WHERE V.PHONE_NUMBER = T.PHONE_NUMBER AND V.YEAR_MONTH = T.YEARS * 100 + 7
              AND V.COMPLETE_BILL = 1 AND ROWNUM = 1) BILL_07,
         (SELECT V.BILL_SUM_NEW
            FROM V_BILL_FINANCE_FOR_CLIENTS V
            WHERE V.PHONE_NUMBER = T.PHONE_NUMBER AND V.YEAR_MONTH = T.YEARS * 100 + 8
              AND V.COMPLETE_BILL = 1 AND ROWNUM = 1) BILL_08,
         (SELECT V.BILL_SUM_NEW
            FROM V_BILL_FINANCE_FOR_CLIENTS V
            WHERE V.PHONE_NUMBER = T.PHONE_NUMBER AND V.YEAR_MONTH = T.YEARS * 100 + 9
              AND V.COMPLETE_BILL = 1 AND ROWNUM = 1) BILL_09,
         (SELECT V.BILL_SUM_NEW
            FROM V_BILL_FINANCE_FOR_CLIENTS V
            WHERE V.PHONE_NUMBER = T.PHONE_NUMBER AND V.YEAR_MONTH = T.YEARS * 100 + 10
              AND V.COMPLETE_BILL = 1 AND ROWNUM = 1) BILL_10,
         (SELECT V.BILL_SUM_NEW
            FROM V_BILL_FINANCE_FOR_CLIENTS V
            WHERE V.PHONE_NUMBER = T.PHONE_NUMBER AND V.YEAR_MONTH = T.YEARS * 100 + 11
              AND V.COMPLETE_BILL = 1 AND ROWNUM = 1) BILL_11,
         (SELECT V.BILL_SUM_NEW
            FROM V_BILL_FINANCE_FOR_CLIENTS V
            WHERE V.PHONE_NUMBER = T.PHONE_NUMBER AND V.YEAR_MONTH = T.YEARS * 100 + 12
              AND V.COMPLETE_BILL = 1 AND ROWNUM = 1) BILL_12,
         CASE
           WHEN EXISTS (SELECT 1
                          FROM PHONE_NUMBER_WITH_DAILY_ABON
                          WHERE PHONE_NUMBER_WITH_DAILY_ABON.PHONE_NUMBER = T.PHONE_NUMBER) THEN 1
           WHEN (SELECT NVL(TARIFFS.TARIFF_ABON_DAILY_PAY, 0)
                   FROM TARIFFS
                   WHERE TARIFF_ID = GET_PHONE_TARIFF_ID (T.PHONE_NUMBER,
                                                          (select P1.CELL_PLAN_CODE
                                                             from DB_LOADER_ACCOUNT_PHONES P1
                                                             WHERE P1.PHONE_NUMBER=T.PHONE_NUMBER
                                                               AND P1.LAST_CHECK_DATE_TIME= (select MAX(P2.LAST_CHECK_DATE_TIME)
                                                                                               from DB_LOADER_ACCOUNT_PHONES P2
                                                                                               WHERE P2.PHONE_NUMBER=P1.PHONE_NUMBER
                                                                                               )
                                                          ), SYSDATE)) = 1 THEN 1
           ELSE 0  
         END SUTOCHN_ABON                                                             
    FROM (SELECT TRUNC(B.YEAR_MONTH/100) YEARS,
                 B.PHONE_NUMBER
            FROM V_BILL_FINANCE_FOR_CLIENTS B
            GROUP BY PHONE_NUMBER, TRUNC(B.YEAR_MONTH/100)) T;
            
            
GRANT SELECT ON V_SUTOCHNIE_BILLS TO LONTANA_ROLE;          