
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TI_CALL_BACK_LOG" 
  BEFORE INSERT ON  CALL_BACK_LOG FOR EACH ROW
--#Version=1
BEGIN
     :NEW.date_insert := sysdate;
END;

ALTER TRIGGER "CORP_MOBILE"."TI_CALL_BACK_LOG" ENABLE