CREATE OR REPLACE PROCEDURE CHECK_MONTH_TARIFF_PAY IS
  NOW_MONTH INTEGER;
BEGIN
  NOW_MONTH:=TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'));
  IF TO_CHAR(SYSDATE, 'YYYYMM') <> TO_CHAR(SYSDATE+1, 'YYYYMM') THEN
    FOR rec IN (SELECT C.CONTRACT_ID,
                       C.PHONE_NUMBER_FEDERAL, 
                       TR.MONTHLY_PAYMENT
                  FROM CONTRACTS C, 
                       TARIFFS TR/*, 
                       DB_LOADER_ACCOUNT_PHONES D*/
                  WHERE C.CURR_TARIFF_ID = TR.TARIFF_ID(+)
                    AND NVL(TR.DISCR_SPISANIE, 0) = 1                    
                    AND C.DOP_STATUS IS NULL
                    /*AND D.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
                    AND D.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
                    AND NVL(D.PHONE_IS_ACTIVE, -1) = 1*/)
    LOOP
      IF GET_ABONENT_BALANCE(rec.PHONE_NUMBER_FEDERAL) <= rec.MONTHLY_PAYMENT THEN
        UPDATE CONTRACTS C
          SET C.DOP_STATUS = 302
          WHERE C.CONTRACT_ID = rec.CONTRACT_ID;
        COMMIT;
      END IF;
    END LOOP;  
  END IF;
  FOR rec IN (SELECT C.CONTRACT_ID,
                     C.PHONE_NUMBER_FEDERAL, 
                     TR.MONTHLY_PAYMENT
                FROM CONTRACTS C, 
                     TARIFFS TR/*, 
                     DB_LOADER_ACCOUNT_PHONES D*/
                WHERE C.CURR_TARIFF_ID = TR.TARIFF_ID(+)
                  AND NVL(TR.DISCR_SPISANIE, 0) = 1
                  AND NVL(C.DOP_STATUS, 0) = 302
                 /* AND D.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
                  AND D.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
                  AND NVL(D.PHONE_IS_ACTIVE, -1) = 0*/)
  LOOP
    IF GET_ABONENT_BALANCE(rec.PHONE_NUMBER_FEDERAL) > rec.MONTHLY_PAYMENT THEN
      UPDATE CONTRACTS C
        SET C.DOP_STATUS = NULL
        WHERE C.CONTRACT_ID = rec.CONTRACT_ID;
      COMMIT;
    END IF;
  END LOOP;  
END;
/
