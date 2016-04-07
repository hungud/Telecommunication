
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."BLOCK_DRAVE_INET_PHONES" (
  pSTREAM_ID IN INTEGER
  ) IS
  COUNT_STREAM INTEGER:=20;
  NOW_MONTH INTEGER;
  V VARCHAR2(500 CHAR);
BEGIN
  NOW_MONTH:=TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'));
  IF TO_CHAR(SYSDATE, 'YYYYMM') <> TO_CHAR(SYSDATE+3/24, 'YYYYMM') THEN  -- НАЧАЛО РАБОТЫ ТОЛЬКО В ПОСЛ 3 ЧАСА МЕСЯЦА
    FOR rec IN (SELECT C.CONTRACT_ID,
                       C.PHONE_NUMBER_FEDERAL, 
                       TR.MONTHLY_PAYMENT
                  FROM CONTRACTS C, 
                       TARIFFS TR, 
                       DB_LOADER_ACCOUNT_PHONES D
                  WHERE MOD(TO_NUMBER(C.PHONE_NUMBER_FEDERAL), COUNT_STREAM) = pSTREAM_ID
                    AND C.CURR_TARIFF_ID = TR.TARIFF_ID(+)
                    AND NVL(TR.DISCR_SPISANIE, 0) = 1                    
                    AND NVL(C.DOP_STATUS, -1) = 302
                    AND D.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
                    AND D.YEAR_MONTH = NOW_MONTH
                    AND NVL(D.PHONE_IS_ACTIVE, -1) = 1
                    AND NOT EXISTS (SELECT 1
                                      FROM BEELINE_TICKETS B
                                      WHERE B.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
                                        AND B.TICKET_TYPE = 9
                                        AND B.DATE_CREATE > SYSDATE - 30/24/60
                                        AND ((B.ANSWER IS NULL) OR (B.ANSWER = 1)))
                )
    LOOP
      V:=BEELINE_API_PCKG.LOCK_PHONE(rec.PHONE_NUMBER_FEDERAL,0, 'S1B');
    END LOOP;    
  END IF;
  NULL;
END; 