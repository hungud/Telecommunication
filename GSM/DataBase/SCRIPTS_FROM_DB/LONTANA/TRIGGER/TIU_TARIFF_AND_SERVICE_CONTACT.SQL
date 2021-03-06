
  CREATE OR REPLACE TRIGGER "LONTANA"."TIU_TARIFF_AND_SERVICE_CONTACT" 
  BEFORE INSERT OR UPDATE ON TARIFF_AND_SERVICE_CONTACT FOR EACH ROW 
--#Version=1
BEGIN 
  IF INSERTING THEN 
    IF NVL(:NEW.TAS_CONTACT_ID, 0) = 0 then
      :NEW.TAS_CONTACT_ID := NEW_TAS_CONTACT_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END; 
ALTER TRIGGER "LONTANA"."TIU_TARIFF_AND_SERVICE_CONTACT" ENABLE