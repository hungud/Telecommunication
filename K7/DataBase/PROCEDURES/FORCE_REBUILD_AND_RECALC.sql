CREATE OR REPLACE PROCEDURE FORCE_REBUILD_AND_RECALC IS 
BEGIN
  IF TRUNC(SYSDATE) <> TRUNC(SYSDATE - 8/24) THEN
    INSERT INTO QUEUE_ABONENT_PER_REBILD(YEAR_MONTH, PHONE_NUMBER)
      SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM')), C.PHONE_NUMBER_FEDERAL
        FROM V_CONTRACTS C
        WHERE C.CONTRACT_CANCEL_DATE IS NULL;
    COMMIT;
  END IF;
  INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE)
    SELECT C.PHONE_NUMBER_FEDERAL, 41
      FROM V_CONTRACTS C
      WHERE C.CONTRACT_CANCEL_DATE IS NULL;
  COMMIT;
END;