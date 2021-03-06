Create Table BLOCK_SEND_SMS( 
  phone_number   VARCHAR2(50),
   Client_name VARCHAR2(50),
   Client_Surname VARCHAR2(50),
   Date_of_send VARCHAR2(50),
   Time_of_send VARCHAR2(50) 
  );
         
ALTER TABLE BLOCK_SEND_SMS ADD SEND_DATE_TIME  DATE;

UPDATE BLOCK_SEND_SMS
 SET SEND_DATE_TIME=TO_DATE(DATE_OF_SEND || ' ' || Time_of_SEND, 'MM/DD/YYYY HH24:MI')
 WHERE SEND_DATE_TIME IS NULL;
 
ALTER TABLE BLOCK_SEND_SMS ADD ABONENT_FIO  VARCHAR2(100 CHAR);

UPDATE BLOCK_SEND_SMS
 SET ABONENT_FIO=CLIENT_SURNAME || ' ' || CLIENT_NAME
 WHERE ABONENT_FIO IS NULL;  

CREATE INDEX I_BLOCK_SEND_SMS_PHONE_DATE ON BLOCK_SEND_SMS(PHONE_NUMBER, SEND_DATE_TIME);