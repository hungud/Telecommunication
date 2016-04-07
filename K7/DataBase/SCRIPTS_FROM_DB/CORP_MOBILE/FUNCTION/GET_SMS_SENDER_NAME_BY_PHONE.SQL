
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_SMS_SENDER_NAME_BY_PHONE" (pPhoneNumber VARCHAR2) RETURN VARCHAR2 IS
/******************************************************************************
   NAME:       GET_SMS_SENDER_NAME_BY_PHONE
   

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        24/11/2014   Admin       1. Функция получения имени для поля "от кого" при отправке СМС


******************************************************************************/

SENDER_NAME SMS_SENDER_NAME.SMS_SENDER_NAME%TYPE;

BEGIN
  
  
  SELECT 
    (SELECT SMS_SENDER_NAME FROM SMS_SENDER_NAME WHERE  SMS_SENDER_NAME.SMS_SENDER_NAME_ID =  ACCOUNTS.SMS_SENDER_NAME_ID) 
    INTO SENDER_NAME
  FROM 
    ACCOUNTS
  WHERE  
    ACCOUNT_ID = GET_ACCOUNT_ID_BY_PHONE(pPhoneNumber);
  
  RETURN nvl(SENDER_NAME, MS_CONSTANTS.GET_CONSTANT_VALUE('SMS_SENDER_NAME'));
     
END GET_SMS_SENDER_NAME_BY_PHONE;