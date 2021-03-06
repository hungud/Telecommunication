
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TIU_REGIONS" 
  BEFORE INSERT OR UPDATE ON REGIONS FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.REGION_ID, 0) = 0 then
      :NEW.REGION_ID := NEW_REGION_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END; 
ALTER TRIGGER "CORP_MOBILE"."TIU_REGIONS" ENABLE