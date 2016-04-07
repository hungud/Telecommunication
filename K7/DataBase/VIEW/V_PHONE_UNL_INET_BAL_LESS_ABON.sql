CREATE OR REPLACE FORCE VIEW V_PHONE_UNL_INET_BAL_LESS_ABON
AS
SELECT 
    C.PHONE_NUMBER_FEDERAL, 
    R.MONTHLY_PAYMENT
FROM CONTRACTS C, 
         CONTRACT_CANCELS CC, 
         TARIFFS R
WHERE C.CONTRACT_ID = CC.CONTRACT_ID(+)
     AND CC.CONTRACT_CANCEL_DATE IS NULL
     AND C.CURR_TARIFF_ID = R.TARIFF_ID(+)
     AND NVL(R.IS_AUTO_INTERNET, 0) = 1
     AND NVL(R.DISCR_SPISANIE, 0) = 1
     AND EXISTS
                         (
                          SELECT 1
                            FROM DB_LOADER_ACCOUNT_PHONE_HISTS H
                           WHERE H.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
                                AND NVL(H.PHONE_IS_ACTIVE, -1) = 1
                                AND H.END_DATE >= TO_DATE ('01' || TO_CHAR (SYSDATE, 'MMYYYY'), 'DDMMYYYY')
                         )
      AND EXISTS
                         (
                          SELECT 1
                             FROM DB_LOADER_ACCOUNT_PHONES DB
                           WHERE DB.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
                                AND DB.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
                                AND NVL(DB.CONSERVATION, 0) <> 1
                                AND (
                                           (NVL(DB.PHONE_IS_ACTIVE, 0) = 1) 
                                        OR 
                                           ( (NVL(DB.PHONE_IS_ACTIVE, 0) <> 1) AND (NVL(DB.STATUS_ID, 0) = 37) )
                                       )
                         )
      AND GET_ABONENT_BALANCE (C.PHONE_NUMBER_FEDERAL) < R.MONTHLY_PAYMENT;


GRANT SELECT ON V_PHONE_UNL_INET_BAL_LESS_ABON TO CORP_MOBILE_ROLE;

GRANT SELECT ON V_PHONE_UNL_INET_BAL_LESS_ABON TO CORP_MOBILE_ROLE_RO;