
  CREATE OR REPLACE FORCE VIEW "LONTANA"."V_TARIFF_VIOLATIONS" ("ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "CELL_PLAN_CODE", "TARIFF_NAME_FROM_OPERATOR", "TARIFF_CODE", "TARIFF_NAME", "STATUS_CODE", "LAST_CHANGE_STATUS_DATE", "STATUS", "DOP_STATUS_NAME", "DOP_STATUS_DATE") AS 
  SELECT D.ACCOUNT_ID,
       D.YEAR_MONTH,
       D.PHONE_NUMBER,
       D.CELL_PLAN_CODE,
       (SELECT TARIFF_NAME
          FROM TARIFFS
         WHERE TARIFFS.TARIFF_CODE = D.CELL_PLAN_CODE
           AND ROWNUM <= 1) TARIFF_NAME_FROM_OPERATOR,
       TARIFFS.TARIFF_CODE,
       TARIFFS.TARIFF_NAME,
       BSC.STATUS_CODE,
       D.LAST_CHANGE_STATUS_DATE,
       CASE
         WHEN NVL(D.CONSERVATION, 0) = 1 THEN 'Сохр.'
         WHEN NVL(D.PHONE_IS_ACTIVE, 0) = 1 THEN 'Акт.'
         ELSE 'Блок.'
       END AS STATUS,
       CDS.DOP_STATUS_NAME,
       (SELECT MAX(L.DATE_LAST_UPDATED)
          FROM LOG_DOP_STATUS L
          WHERE L.PHONE_NUMBER = D.PHONE_NUMBER) DOP_STATUS_DATE
  FROM DB_LOADER_ACCOUNT_PHONES D, TARIFFS, CONTRACTS C, 
       BEELINE_STATUS_CODE BSC,
       CONTRACT_DOP_STATUSES CDS
 WHERE D.YEAR_MONTH = to_number(to_char(sysdate, 'YYYYMM'))
   AND C.CONTRACT_ID = GET_ID_LAST_CONTRACT_BY_PHONE(D.PHONE_NUMBER)
   AND D.STATUS_ID = BSC.STATUS_ID(+)
   AND C.DOP_STATUS = CDS.DOP_STATUS_ID(+)
   AND GET_ID_LAST_TARIFF_BY_CONTRACT(C.CONTRACT_ID, C.TARIFF_ID) = TARIFFS.TARIFF_ID
   AND TARIFFS.TARIFF_CODE <> D.CELL_PLAN_CODE
   AND D.PHONE_NUMBER IN (SELECT PHONE_NUMBER_FEDERAL
                           FROM CONTRACTS C, CONTRACT_CANCELS CC
                           WHERE C.CONTRACT_ID = CC.CONTRACT_ID(+)
                             AND CC.CONTRACT_CANCEL_DATE IS NULL) 