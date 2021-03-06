
  CREATE OR REPLACE TRIGGER "LONTANA"."TIU_FORWARDING_PHONE_NUMBER" 
  BEFORE INSERT OR UPDATE ON FORWARDING_PHONE_NUMBER FOR EACH ROW
--#Version=1
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.FORWARDING_ID, 0) = 0 THEN
      :NEW.FORWARDING_ID := NEW_FORWARDING_ID;
    END IF;
    IF :NEW.SMS_TEXT_ADD IS NULL THEN
      :NEW.SMS_TEXT_ADD:='Переадресация от '||:NEW.PHONE_NUMBER||':';
    END IF;
  END IF;
  :NEW.DATE_LAST_UPDATE:=SYSDATE;
  :NEW.USER_LAST_UPDATE:=USER;
END;
ALTER TRIGGER "LONTANA"."TIU_FORWARDING_PHONE_NUMBER" ENABLE