
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."CRM_SEND_SMS" 
 (
    pPHONE_NUMBER IN VARCHAR2,
    pMAILING_NAME IN VARCHAR2,
    pSMS_TEXT IN VARCHAR2
 ) RETURN VARCHAR2 IS 
 PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
 return loader3_pckg.SEND_SMS(pPHONE_NUMBER,pMAILING_NAME,pSMS_TEXT);
END;