
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_BILLS_VIOL_REPORT_DATA" ("YEAR_MONTH", "PHONE_NUMBER", "DETAIL_SUM", "ACCOUNT_NUMBER") AS 
  SELECT R.YEAR_MONTH,
         R.PHONE_NUMBER,
         R.DETAIL_SUM,
         A.ACCOUNT_NUMBER
    FROM DB_LOADER_REPORT_DATA R, ACCOUNTS A
    WHERE R.DETAIL_SUM > 0
      AND GET_ACCOUNT_ID_BY_PHONE(R.PHONE_NUMBER) = A.ACCOUNT_ID
      AND R.YEAR_MONTH = (SELECT MAX(R2.YEAR_MONTH)
                            FROM DB_LOADER_REPORT_DATA R2)
      AND (NOT EXISTS (SELECT 1
                         FROM DB_LOADER_ACCOUNT_PHONE_HISTS H
                         WHERE H.PHONE_NUMBER = R.PHONE_NUMBER
                           AND H.PHONE_IS_ACTIVE = 1
                           AND H.END_DATE >= TO_DATE(TO_CHAR(R.YEAR_MONTH)||'01', 'YYYYMMDD')
                           AND H.BEGIN_DATE <= SYSDATE)
           OR NOT EXISTS (SELECT 1
                            FROM CONTRACTS C,
                                 CONTRACT_CANCELS CC
                            WHERE C.PHONE_NUMBER_FEDERAL = R.PHONE_NUMBER
                              AND C.CONTRACT_ID = CC.CONTRACT_ID(+)
                              AND C.CONTRACT_DATE < SYSDATE
                              AND CC.CONTRACT_CANCEL_DATE IS NULL))
