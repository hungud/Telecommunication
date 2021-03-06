
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TIU_DB_LOADER_SIM" 
BEFORE INSERT OR UPDATE
ON DB_LOADER_SIM REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
BEGIN
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;  
END TIU_DB_LOADER_SIM;
ALTER TRIGGER "CORP_MOBILE"."TIU_DB_LOADER_SIM" ENABLE