
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TIU_MN_UNLIM_VOLUME" 
  BEFORE INSERT OR UPDATE ON MN_UNLIM_VOLUME FOR EACH ROW
--#Version=1
BEGIN
    :NEW.UPDATE_DATE := SYSDATE;
END;



ALTER TRIGGER "CORP_MOBILE"."TIU_MN_UNLIM_VOLUME" ENABLE