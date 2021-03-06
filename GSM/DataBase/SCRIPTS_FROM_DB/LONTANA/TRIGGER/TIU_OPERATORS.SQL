
  CREATE OR REPLACE TRIGGER "LONTANA"."TIU_OPERATORS" 
  BEFORE INSERT OR UPDATE ON OPERATORS FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.OPERATOR_ID, 0) = 0 then
      :NEW.OPERATOR_ID := NEW_OPERATOR_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END; 
ALTER TRIGGER "LONTANA"."TIU_OPERATORS" ENABLE