
  CREATE OR REPLACE TRIGGER "SIM_TRADE"."TI_SERVICE_VOLUME" 
  BEFORE INSERT OR UPDATE ON SERVICE_VOLUME FOR EACH ROW
--#Version=1
BEGIN
   IF NVL(:NEW.SERVICE_VOLUME_ID, 0) = 0 then
      :NEW.SERVICE_VOLUME_ID := NEW_SERVICE_VOLUME_ID;
    END IF;
END; 

ALTER TRIGGER "SIM_TRADE"."TI_SERVICE_VOLUME" ENABLE