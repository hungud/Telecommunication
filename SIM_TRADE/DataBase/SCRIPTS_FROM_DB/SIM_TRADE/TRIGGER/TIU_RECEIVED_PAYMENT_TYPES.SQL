
  CREATE OR REPLACE TRIGGER "SIM_TRADE"."TIU_RECEIVED_PAYMENT_TYPES" 
--#Version=1 
  BEFORE INSERT  ON RECEIVED_PAYMENT_TYPES FOR EACH ROW 
BEGIN  
    IF NVL(:NEW.RECEIVED_PAYMENT_TYPE_ID, 0) = 0 then  
      :NEW.RECEIVED_PAYMENT_TYPE_ID := NEW_RECEIVED_PAYMENT_TYPE_ID; 
    END IF;  
END; 


ALTER TRIGGER "SIM_TRADE"."TIU_RECEIVED_PAYMENT_TYPES" ENABLE