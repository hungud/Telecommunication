create table FRAUD_BLOCKED_PHONE
(
         phone_number  varchar2(50),
         date_block date
); 

ALTER TABLE FRAUD_BLOCKED_PHONE
ADD STATUS INTEGER;

ALTER TABLE FRAUD_BLOCKED_PHONE
ADD ADD_DATE date;

CREATE OR REPLACE TRIGGER TI_FRAUD_BLOCKED_PHONE
  BEFORE INSERT ON FRAUD_BLOCKED_PHONE FOR EACH ROW
--#Version=1
BEGIN
    :NEW.ADD_DATE := SYSDATE;
    :NEW.DATE_BLOCK := SYSDATE;
    :NEW.STATUS:=0;
END;
