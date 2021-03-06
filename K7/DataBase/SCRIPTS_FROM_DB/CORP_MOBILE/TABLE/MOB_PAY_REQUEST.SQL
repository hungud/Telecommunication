
  CREATE TABLE "CORP_MOBILE"."MOB_PAY_REQUEST" 
   (	"PHONE" VARCHAR2(11), 
	"SUM_PAY" NUMBER, 
	"REQ_COUNT" NUMBER(*,0), 
	"DATE_INSERT" DATE, 
	"DATE_UPDATE" DATE, 
	"USER_CREATED" VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 8192 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 