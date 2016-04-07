
  CREATE OR REPLACE FORCE VIEW "LONTANA"."V_PHONE_FOR_REBLOCK" ("PHONE_NUMBER", "STATUS_CODE") AS 
  SELECT D.PHONE_NUMBER, 
         B.STATUS_CODE
    FROM DB_LOADER_ACCOUNT_PHONES D,
         BEELINE_STATUS_CODE B
    WHERE D.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
      AND D.STATUS_ID = B.STATUS_ID
      AND B.IS_ACTIVE = 0
      AND B.IS_CONSERVATION = 0
      /*AND NOT EXISTS (SELECT 1
                        FROM QUEUE_PHONE_REBLOCK H
                        WHERE H.PHONE_NUMBER = D.PHONE_NUMBER)*/
      AND (EXISTS (SELECT 1
                    FROM DB_LOADER_ACCOUNT_PHONE_HISTS H
                    WHERE H.PHONE_NUMBER = D.PHONE_NUMBER
                      AND H.PHONE_IS_ACTIVE = 0
                      AND H.END_DATE > SYSDATE
                      AND H.BEGIN_DATE < SYSDATE - 1)
          OR EXISTS (SELECT 1
                      FROM QUEUE_PHONE_REBLOCK_LOG L
                      WHERE L.PHONE_NUMBER = D.PHONE_NUMBER
                        AND L.DATE_CREATED > SYSDATE -360/60/24    --За посл 6ч была попытка переблока
                        AND L.DATE_CREATED < SYSDATE -30/60/24)   --За посл 30мин не было попыток переблока
          ) 