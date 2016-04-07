create table AUTO_UNBLOCKED_PHONE
(
         phone_number  varchar2(50),
         Client_name varchar2(50),
         Client_Surname varchar2(50),
         Ballance     number,
         Date_of_unblock varchar2(50),
         Time_of_unblock varchar2(50),
         Note     varchar2(300 CHAR)
);

ALTER TABLE AUTO_UNBLOCKED_PHONE ADD UNBLOCK_DATE_TIME DATE;

UPDATE AUTO_UNBLOCKED_PHONE
 SET UNBLOCK_DATE_TIME=TO_DATE(DATE_OF_UNBLOCK || ' ' || Time_of_unblock, 'MM/DD/YYYY HH24:MI')
 WHERE UNBLOCK_DATE_TIME IS NULL; 
 
ALTER TABLE AUTO_UNBLOCKED_PHONE ADD (MANUAL_BLOCK  NUMBER  DEFAULT 0);

ALTER TABLE AUTO_UNBLOCKED_PHONE ADD USER_NAME  VARCHAR2(30 CHAR);

ALTER TABLE AUTO_UNBLOCKED_PHONE ADD ABONENT_FIO  VARCHAR2(100 CHAR);

UPDATE AUTO_UNBLOCKED_PHONE
 SET ABONENT_FIO=CLIENT_SURNAME || ' ' || CLIENT_NAME
 WHERE ABONENT_FIO IS NULL; 
 
 
CREATE INDEX I_AUTO_UNBLOCKED_PHONE_P_D_N ON AUTO_UNBLOCKED_PHONE (PHONE_NUMBER, UNBLOCK_DATE_TIME, NOTE)
COMPRESS 1;