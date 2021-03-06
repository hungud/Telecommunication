
  CREATE TABLE "CORP_MOBILE"."QUEUE_UPDATE_PHONE_HISTORY" 
   (	"PHONE_NUMBER" VARCHAR2(100 CHAR), 
	"BEGIN_DATE" DATE, 
	"END_DATE" DATE, 
	"PHONE_IS_ACTIVE" NUMBER(1,0), 
	"CELL_PLAN_CODE" VARCHAR2(50 CHAR), 
	"CONSERVATION" NUMBER(1,0), 
	"SYSTEM_BLOCK" NUMBER(1,0), 
	"STATUS_ID" NUMBER(*,0), 
	"DATE_REPORT" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 