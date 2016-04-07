
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TI_MSISDN_REFRESH" 
  AFTER INSERT ON MSISDN_REFRESH FOR EACH ROW
  DECLARE
    v_username varchar2(50);
--#Version=1
BEGIN
SELECT user INTO v_username
    FROM dual;
   insert into TAR_LOG values(v_username,null,'Ручное обновление текущей детализации по номеру '||:NEW.msisdn,1);
END;
ALTER TRIGGER "CORP_MOBILE"."TI_MSISDN_REFRESH" ENABLE