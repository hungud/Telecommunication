
  CREATE OR REPLACE TRIGGER "SIM_TRADE"."TI_USSD_LEAFS" 
  BEFORE INSERT ON USSD_LEAFS FOR EACH ROW
--#Version=1
BEGIN
    :NEW.LEAF_ID := NEW_LEAF_ID;
END;

--GRANT DELETE, INSERT, SELECT, UPDATE ON USSD_LEAFS TO CORP_MOBILE_ROLE;

--GRANT SELECT ON USSD_LEAFS TO CORP_MOBILE_ROLE_RO;
ALTER TRIGGER "SIM_TRADE"."TI_USSD_LEAFS" ENABLE