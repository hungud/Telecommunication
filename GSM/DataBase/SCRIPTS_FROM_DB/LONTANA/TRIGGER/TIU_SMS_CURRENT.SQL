
  CREATE OR REPLACE TRIGGER "LONTANA"."TIU_SMS_CURRENT" 
 before insert or update on SMS_CURRENT
FOR EACH ROW
BEGIN
  if INSERTING then
    :NEW.Insert_Date:=sysdate;
    :new.id := sms_current_seq.nextval;
  end if;
  :NEW.UPDATE_DATE:= sysdate;
END;
ALTER TRIGGER "LONTANA"."TIU_SMS_CURRENT" ENABLE