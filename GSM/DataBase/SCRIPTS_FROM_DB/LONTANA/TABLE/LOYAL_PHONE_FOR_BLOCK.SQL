
  CREATE TABLE "LONTANA"."LOYAL_PHONE_FOR_BLOCK" 
   (	"PHONE_NUMBER" VARCHAR2(10 CHAR), 
	"ACCOUNT_ID" NUMBER(*,0), 
	"DATE_CHECK" DATE, 
	"DATE_FUTURE_BLOCK" DATE, 
	"BALANCE_BLOCK" NUMBER(13,2), 
	"FIO" VARCHAR2(100 CHAR), 
	"BALANCE" NUMBER(13,2), 
	"SMS_TEMPLATE" VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 