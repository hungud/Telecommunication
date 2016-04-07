CREATE OR REPLACE TYPE TYPE_PHONE_INACTIV AS OBJECT
(login varchar2(30), 
 phone_number_federal varchar2(10), 
 contract_date date, 
 balance number, 
 PHONE_IS_ACTIVE varchar2(25), 
 Dop_status_name varchar2(100),
 LAST_CHECK_DATE_TIME date,
 DATE_CREATED date,
 CURR_TARIFF_ID integer,
 TARIFF_NAME varchar2(100)
 )
/
