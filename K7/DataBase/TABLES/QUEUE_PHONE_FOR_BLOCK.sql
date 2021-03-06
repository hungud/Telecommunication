CREATE TABLE QUEUE_PHONE_FOR_BLOCK(
  PHONE_NUMBER NUMBER(11, 0),
  NEW_STATUS_CODE VARCHAR2(10 CHAR),
  DATE_INSERT DATE
  ); 
  
CREATE OR REPLACE TRIGGER TIU_QUEUE_PHONE_FOR_BLOCK
  BEFORE INSERT OR UPDATE ON QUEUE_PHONE_FOR_BLOCK FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    :NEW.DATE_INSERT := SYSDATE;
  END IF;  
END;