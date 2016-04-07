
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_TARIFF_VIOLATIONS" ("ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "CELL_PLAN_CODE", "TARIFF_NAME_FROM_OPERATOR", "TARIFF_CODE", "TARIFF_NAME", "STATUS_CODE", "LAST_CHANGE_STATUS_DATE", "STATUS", "DOP_STATUS_NAME", "DOP_STATUS_DATE") AS 
  SELECT -- 23.06.2015 - Матюнин И. Насколько я понял, здесь показываются номера, у которых код тарифа по справочнкиу
 --           не совпадает с тем кодом тарифа, который приходит из билайна при прогрузке статусов.
         D.ACCOUNT_ID,
         D.YEAR_MONTH,
         D.PHONE_NUMBER,
         D.CELL_PLAN_CODE,
         (SELECT TARIFF_NAME
            FROM TARIFFS
            WHERE TARIFFS.TARIFF_ID =C.CURR_TARIFF_ID)
         TARIFF_NAME_FROM_OPERATOR,
         TARIFFS.TARIFF_CODE,
         TARIFFS.TARIFF_NAME,
         BSC.STATUS_CODE,
         D.LAST_CHANGE_STATUS_DATE,
         CASE
            WHEN NVL (D.CONSERVATION, 0) = 1 THEN 'Сохр.'
            WHEN NVL (D.PHONE_IS_ACTIVE, 0) = 1 THEN 'Акт.'
            ELSE 'Блок.'
         END
            AS STATUS,
         CDS.DOP_STATUS_NAME,
         (SELECT MAX (L.DATE_LAST_UPDATED)
            FROM LOG_DOP_STATUS L
           WHERE L.PHONE_NUMBER = D.PHONE_NUMBER)
            DOP_STATUS_DATE
    FROM DB_LOADER_ACCOUNT_PHONES D,
         TARIFFS,
         CONTRACTS C,
         BEELINE_STATUS_CODE BSC,
         CONTRACT_DOP_STATUSES CDS
   WHERE     D.YEAR_MONTH = TO_NUMBER (TO_CHAR (SYSDATE, 'YYYYMM'))
         AND GET_ID_LAST_CONTRACT_BY_PHONE (D.PHONE_NUMBER) =
                C.CONTRACT_ID(+)
         AND D.STATUS_ID = BSC.STATUS_ID(+)
         AND C.DOP_STATUS = CDS.DOP_STATUS_ID(+)
         AND NOT EXISTS
                (SELECT 1
                   FROM CONTRACT_CANCELS
                  WHERE CONTRACT_CANCELS.CONTRACT_ID = C.CONTRACT_ID)
         AND GET_ID_LAST_TARIFF_BY_CONTRACT (C.CONTRACT_ID, C.TARIFF_ID) =
                TARIFFS.TARIFF_ID(+)
         AND TARIFFS.TARIFF_CODE <> D.CELL_PLAN_CODE
         AND NVL (D.SYSTEM_BLOCK, 0) <> 1
         AND (   (    D.Phone_Is_Active = 0
                  AND (NOT EXISTS
                              (SELECT 1
                                 FROM fraud_blocked_phone fb,
                                      AUTO_BLOCKED_PHONE
                                WHERE     fb.phone_number =
                                             AUTO_BLOCKED_PHONE.PHONE_NUMBER
                                      AND fb.status = 1
                                      AND AUTO_BLOCKED_PHONE.PHONE_NUMBER =
                                             D.PHONE_NUMBER
                                      AND TO_NUMBER (
                                             TO_CHAR (
                                                AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME,
                                                'YYYYMM')) = D.YEAR_MONTH
                                      AND fb.date_block BETWEEN AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME
                                                            AND NVL (
                                                                   (SELECT MIN (
                                                                              abp.block_date_time)
                                                                      FROM AUTO_BLOCKED_PHONE abp
                                                                     WHERE     abp.phone_number =
                                                                                  AUTO_BLOCKED_PHONE.PHONE_NUMBER
                                                                           AND abp.block_date_time >
                                                                                  AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME),
                                                                   SYSDATE))))
              OR (D.Phone_Is_Active = 1))