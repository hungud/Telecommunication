
  CREATE OR REPLACE TRIGGER "LONTANA"."TI_HB_USM_PHONE" 
--#Version=1
  BEFORE INSERT ON hot_billing_usm_PHONE FOR EACH ROW
BEGIN
    :NEW.Date_insert := sysdate;
    if :NEW.U_MONTH is null then
      :NEW.U_MONTH := trunc(sysdate, 'mm');
    end if;
END;
ALTER TRIGGER "LONTANA"."TI_HB_USM_PHONE" ENABLE