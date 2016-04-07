--#if not TableExists("LOG_SEND_SMS") then
create TABLE LOG_SEND_SMS(
  YEAR_MONTH INTEGER,
  SMS_ID INTEGER,
  PHONE_NUMBER VARCHAR2(10 CHAR),  
  DATE_SEND DATE,
  SMS_TEXT VARCHAR2(300 CHAR),
  NOTE VARCHAR2(100 CHAR)
  );
--#end if

  
--#if not IndexExists("I_LOG_SMS_SMS_ID") THEN
CREATE INDEX I_LOG_SMS_SMS_ID ON LOG_SEND_SMS 
(SMS_ID)
LOGGING
NOPARALLEL;  
--#end if
  
--#if not IndexExists("I_LOG_SMS_DATE") THEN
CREATE INDEX I_LOG_SMS_DATE ON LOG_SEND_SMS 
(DATE_SEND)
LOGGING
NOPARALLEL;   
--#end if
  
--#if not IndexExists("I_LOG_SMS_PHONE") THEN
CREATE INDEX I_LOG_SMS_PHONE ON LOG_SEND_SMS 
(PHONE_NUMBER)
LOGGING
NOPARALLEL;   
--#end if
  
--#if not IndexExists("I_LOG_SMS_Y_M") THEN
CREATE INDEX I_LOG_SMS_Y_M ON LOG_SEND_SMS 
(YEAR_MONTH)
LOGGING
NOPARALLEL; 
--#end if

--#if GetVersion("TIU_LOG_SEND_SMS")<5 then
CREATE OR REPLACE TRIGGER TIU_LOG_SEND_SMS
  BEFORE INSERT OR UPDATE ON LOG_SEND_SMS FOR EACH ROW
--#Version=5
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN   
  IF INSERTING THEN
    :NEW.DATE_SEND:=SYSDATE;
    IF NVL(:NEW.YEAR_MONTH, 0)=0 THEN
      :NEW.YEAR_MONTH:=TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'));
    END IF;
  END IF;
END;
--#end if

--#if not GrantExists("LOG_SEND_SMS", "ROLE", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT ALL ON LOG_SEND_SMS TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("LOG_SEND_SMS", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON LOG_SEND_SMS TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if


--#if not GrantExists("LOG_SEND_SMS", "ROLE_RO", "INSERT") then
begin EXECUTE IMMEDIATE 'GRANT INSERT ON LOG_SEND_SMS TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if
ALTER TABLE LOG_SEND_SMS MODIFY(SMS_TEXT VARCHAR2(2000 CHAR))
/