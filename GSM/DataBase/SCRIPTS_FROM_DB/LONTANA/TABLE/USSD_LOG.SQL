
  CREATE TABLE "LONTANA"."USSD_LOG" 
   (	"ID" NUMBER(*,0), 
	"XCPAXACTION" VARCHAR2(50), 
	"XCPAMSGID" VARCHAR2(50), 
	"USSD_DATE" DATE, 
	"INSERT_DATE" DATE, 
	"MSISDN" VARCHAR2(11), 
	"XCPASTATUS" VARCHAR2(20), 
	"XCPAERROR" VARCHAR2(3), 
	"ERROR_TEXT" VARCHAR2(2000), 
	"USSD" VARCHAR2(50), 
	"TEXT_RES" VARCHAR2(200), 
	"TYPE_LOG" NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 8192 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 