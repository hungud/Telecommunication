
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TI_MAIL_REQUEST" 
  BEFORE INSERT ON  MAIL_REQUEST FOR EACH ROW
--#Version=1
BEGIN
     :NEW.date_insert := sysdate;
     :NEW.send_count := 0;
END;

ALTER TRIGGER "CORP_MOBILE"."TI_MAIL_REQUEST" ENABLE