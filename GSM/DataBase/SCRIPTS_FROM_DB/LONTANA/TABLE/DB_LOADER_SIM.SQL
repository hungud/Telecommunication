
  CREATE TABLE "LONTANA"."DB_LOADER_SIM" 
   (	"ACCOUNT_ID" NUMBER(*,0), 
	"PHONE_NUMBER" VARCHAR2(10 CHAR), 
	"SIM_NUMBER" VARCHAR2(18 CHAR), 
	"IMSI_NUMBER" VARCHAR2(15 CHAR), 
	"USER_LAST_UPDATED" VARCHAR2(30 CHAR), 
	"DATE_LAST_UPDATED" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 9437184 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 