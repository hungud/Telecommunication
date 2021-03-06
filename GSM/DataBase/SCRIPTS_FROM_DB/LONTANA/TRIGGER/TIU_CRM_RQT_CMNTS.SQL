
  CREATE OR REPLACE TRIGGER "LONTANA"."TIU_CRM_RQT_CMNTS" 
  BEFORE INSERT OR UPDATE ON CRM_REQUEST_COMMENTS FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.COMMENT_ID, 0) = 0 then
      :NEW.COMMENT_ID := S_NEW_COMMENT_ID.NEXTVAL;
    END IF;
  END IF;
  :NEW.DATE_LAST_UPDATED:=SYSDATE;
END;
ALTER TRIGGER "LONTANA"."TIU_CRM_RQT_CMNTS" ENABLE