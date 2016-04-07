CREATE TABLE CREDIT_NOTICE_SEND(
  PHONE_NUMBER VARCHAR2(10 CHAR),
  DATE_TIME_CREDIT_NOTICE DATE,
  ABONENT_FIO VARCHAR2(300 CHAR)
  );
  
ALTER TABLE CREDIT_NOTICE_SEND ADD SMS_TEXT VARCHAR2(300 CHAR);
  
GRANT SELECT, UPDATE, INSERT, DELETE ON CREDIT_NOTICE_SEND TO CORP_MOBILE_ROLE;

GRANT SELECT ON CREDIT_NOTICE_SEND TO CORP_MOBILE_ROLE_RO; 