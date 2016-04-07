CREATE OR REPLACE TYPE TYPE_GPRS_PHONE_LIMIT AS OBJECT
(PHONE_NUMBER varchar2(10 char), 
 CONTRACT_DATE date,  
 CONTRACT_ID integer,
 TARIFF_CODE varchar2(30 char),
 TARIFF_NAME varchar2(100 char),
 PHONE_IS_ACTIVE varchar2(25), 
 BALANCE number,
 INTERNET_VOL_1 number,
 CALL_MINUTES_1 integer,
 PROFIT_1 number,
 INTERNET_VOL_2 number,
 CALL_MINUTES_2 integer,
 PROFIT_2 number,
 INTERNET_VOL_3 number,
 CALL_MINUTES_3 integer,
 PROFIT_3 number,
 INTERNET_VOL_4 number,
 CALL_MINUTES_4 integer,
 PROFIT_4 number,
 INTERNET_VOL_5 number,
 CALL_MINUTES_5 integer,
 PROFIT_5 number,
 INTERNET_VOL_6 number,
 CALL_MINUTES_6 integer,
 PROFIT_6 number,
 INTERNET_VOL_7 number,
 CALL_MINUTES_7 integer,
 PROFIT_7 number,
 INTERNET_VOL_8 number,
 CALL_MINUTES_8 integer,
 PROFIT_8 number,
 INTERNET_VOL_9 number,
 CALL_MINUTES_9 integer,
 PROFIT_9 number,
 INTERNET_VOL_10 number,
 CALL_MINUTES_10 integer,
 PROFIT_10 number,
 INTERNET_VOL_11 number,
 CALL_MINUTES_11 integer,
 PROFIT_11 number,
 INTERNET_VOL_12 number,
 CALL_MINUTES_12 integer,
 PROFIT_12 number);