
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TIU_DETAIL_TYPES" 
  BEFORE INSERT OR UPDATE ON DETAIL_TYPES FOR EACH ROW
--#Version=1
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.DETAIL_TYPE_ID, 0)=0 THEN
      :NEW.DETAIL_TYPE_ID:=NEW_DETAIL_TYPE_ID;
    END IF;
  END IF;
END; 
ALTER TRIGGER "CORP_MOBILE"."TIU_DETAIL_TYPES" ENABLE