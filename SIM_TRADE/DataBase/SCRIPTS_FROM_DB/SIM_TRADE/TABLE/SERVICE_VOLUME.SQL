
  CREATE TABLE "SIM_TRADE"."SERVICE_VOLUME" 
   (	"SERVICE_VOLUME_ID" NUMBER NOT NULL ENABLE, 
	"NOTICE_VOLUME" NUMBER(*,0), 
	"NOTICE_VOLUME_TEXT" VARCHAR2(200 CHAR), 
	"VOLUME_EXCEEDED" NUMBER(*,0), 
	"VOLUME_EXCEEDED_TEXT" VARCHAR2(200 CHAR), 
	"OPTION_CODE" VARCHAR2(30 CHAR), 
	"SQL_TEXT" VARCHAR2(2000 CHAR), 
	"SQL_PV" VARCHAR2(200 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 