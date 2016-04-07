
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TIU_CALL_BACK_REQUEST" 
  BEFORE INSERT OR UPDATE ON  CALL_BACK_REQUEST FOR EACH ROW
--#Version=1
BEGIN
   IF INSERTING THEN
     :NEW.date_insert := sysdate;
     :NEW.date_update := sysdate;
     :NEW.req_count := 0;
   else
     :NEW.date_update := sysdate;
   end if;
END;

ALTER TRIGGER "CORP_MOBILE"."TIU_CALL_BACK_REQUEST" ENABLE