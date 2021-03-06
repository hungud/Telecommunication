
  CREATE OR REPLACE TRIGGER "LONTANA"."TIU_SIM_STATUSES" 
  BEFORE INSERT OR UPDATE ON LONTANA.SIM_STATUSES FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.SIM_STATUS_ID, 0) = 0 THEN
      :NEW.SIM_STATUS_ID := NEW_SIM_STATUS_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END; 
ALTER TRIGGER "LONTANA"."TIU_SIM_STATUSES" ENABLE