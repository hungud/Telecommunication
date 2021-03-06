
  CREATE OR REPLACE TRIGGER "LONTANA"."TIU_QUEUE_ITEMS" 
  BEFORE INSERT OR UPDATE ON QUEUE_ITEMS FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.QUEUE_ITEM_ID, 0) = 0 then
      :NEW.QUEUE_ITEM_ID := NEW_QUEUE_ITEM_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
  ELSIF UPDATING THEN 
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
  END IF;
END;
ALTER TRIGGER "LONTANA"."TIU_QUEUE_ITEMS" ENABLE