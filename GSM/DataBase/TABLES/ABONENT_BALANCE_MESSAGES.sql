--#if isclient("CORP_MOBILE") OR isclient("GSM_CORP") then

--#if not TableExists("ABONENT_BALANCE_MESSAGES") then
CREATE TABLE ABONENT_BALANCE_MESSAGES (
  UNIQUE_REQUEST_ID VARCHAR2(30 CHAR),
  REQUEST_DATE_TIME DATE,
  PHONE_NUMBER VARCHAR2(10 CHAR),
  BALANCE_VALUE NUMBER(10, 2),
  BALANCE_MESSAGE VARCHAR2(300 CHAR),
  ERROR_MESSAGE VARCHAR2(200 CHAR)
  );
--#end if

--#if not IndexExists("I_ABONENT_BALANCE_MESSAGES_RID") THEN
CREATE INDEX I_ABONENT_BALANCE_MESSAGES_RID 
ON ABONENT_BALANCE_MESSAGES (UNIQUE_REQUEST_ID);
--#end if

--#end if
