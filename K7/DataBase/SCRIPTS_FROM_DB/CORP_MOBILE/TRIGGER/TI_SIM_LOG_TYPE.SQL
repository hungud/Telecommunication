
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TI_SIM_LOG_TYPE" 
--#Version=1
  BEFORE INSERT ON SIM_LOG_TYPE FOR EACH ROW
BEGIN
    :NEW.SIM_LOG_TYPE_ID := S_NEW_SIM_LOG_TYPE_ID.Nextval;
END;
ALTER TRIGGER "CORP_MOBILE"."TI_SIM_LOG_TYPE" ENABLE