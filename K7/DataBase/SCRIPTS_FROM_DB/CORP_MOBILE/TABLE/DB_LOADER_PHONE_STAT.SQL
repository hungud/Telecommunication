
  CREATE TABLE "CORP_MOBILE"."DB_LOADER_PHONE_STAT" 
   (	"ACCOUNT_ID" NUMBER(*,0), 
	"YEAR_MONTH" NUMBER(*,0), 
	"PHONE_NUMBER" VARCHAR2(10 CHAR), 
	"ESTIMATE_SUM" NUMBER(15,2), 
	"ZEROCOST_OUTCOME_MINUTES" NUMBER(15,2), 
	"ZEROCOST_OUTCOME_COUNT" NUMBER(15,2), 
	"CALLS_COUNT" NUMBER(*,0), 
	"CALLS_MINUTES" NUMBER(10,2), 
	"CALLS_COST" NUMBER(15,2), 
	"SMS_COUNT" NUMBER(*,0), 
	"SMS_COST" NUMBER(15,2), 
	"MMS_COUNT" NUMBER(*,0), 
	"MMS_COST" NUMBER(15,2), 
	"INTERNET_MB" NUMBER(10,3), 
	"INTERNET_COST" NUMBER(15,2), 
	"LAST_CHECK_DATE_TIME" DATE, 
	"COST_CHNG" NUMBER(15,2), 
	"ZEROCOST_INBOX_MINUTES" NUMBER(15,2), 
	"CALLBACKCOST" NUMBER(15,2), 
	"CALLBACKMINUTES" NUMBER(15,2), 
	"CALLBACKCOUNT" NUMBER(15,2), 
	"SMS_FREE_COUNT" NUMBER(*,0), 
	"MMS_FREE_COUNT" NUMBER(*,0), 
	"CALLS_FULL_MINUTES" NUMBER(*,0), 
	"CALLS_COST_WITHOUT_API" NUMBER(15,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 9437184 NEXT 8192 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 