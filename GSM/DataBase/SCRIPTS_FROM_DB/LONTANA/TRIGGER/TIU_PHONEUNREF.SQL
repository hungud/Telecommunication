
  CREATE OR REPLACE TRIGGER "LONTANA"."TIU_PHONEUNREF" 
BEFORE INSERT OR UPDATE
ON CRM_PHONEUNREF
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
tmpVar NUMBER;
/******************************************************************************
   NAME:       TIU_PHONEUNREF
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        14.04.2014      Овсянников       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     TIU_PHONEUNREF
      Sysdate:         14.04.2014
      Date and Time:   14.04.2014, 11:16:57, and 14.04.2014 11:16:57
      Username:        Овсянников (set in TOAD Options, Proc Templates)
      Table Name:      CRM_PHONEUNREF (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
 tmpVar := 0;
 IF INSERTING THEN
   SELECT S_NEW_CRM_PHONEUNREF_ID.NEXTVAL INTO tmpVar FROM dual;
   :NEW.ID := tmpVar;
   :NEW.DATE_CREATED := SYSDATE;
   :NEW.USER_CREATED := USER;
 END IF;
 :NEW.DATE_LAST_UPDATED := SYSDATE;
 :NEW.USER_LAST_UPDATED := USER;
 

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TIU_PHONEUNREF;
ALTER TRIGGER "LONTANA"."TIU_PHONEUNREF" ENABLE