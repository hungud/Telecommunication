
  CREATE OR REPLACE TRIGGER "LONTANA"."TIU_PHONE_OPTS_FOR_QCB" 
--#Version=0
  BEFORE INSERT OR UPDATE ON DB_LOADER_ACCOUNT_PHONE_OPTS FOR EACH ROW
BEGIN
  IF INSERTING THEN
--    INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE) VALUES(:NEW.PHONE_NUMBER, 46);
    :NEW.ADDED_FOR_RETARIF := GET_OPT_ADDED_FOR_RETARIF(:NEW.ACCOUNT_ID, :NEW.PHONE_NUMBER, :NEW.OPTION_CODE);
  END IF;
  IF UPDATING AND :NEW.TURN_OFF_DATE is not NULL AND :OLD.TURN_OFF_DATE is NULL THEN
--    INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE) VALUES(:OLD.PHONE_NUMBER, 46);
    IF :OLD.ADDED_FOR_RETARIF = 1 THEN
      UPDATE ROAMING_RETARIF_PHONES RRP
        SET RRP.SERVICE_OFF_CONFIRMED_DATETIME = SYSDATE
        WHERE RRP.PHONE_NUMBER = :NEW.PHONE_NUMBER
          AND RRP.OPTION_CODE = :NEW.OPTION_CODE
          AND RRP.END_DATE_TIME IS NOT NULL
          AND RRP.SERVICE_OFF_CONFIRMED_DATETIME IS NULL;
    END IF;  
  END IF;
END;
ALTER TRIGGER "LONTANA"."TIU_PHONE_OPTS_FOR_QCB" ENABLE