
  CREATE TABLE "CORP_MOBILE"."FTP_SETTINGS" 
   (	"FTP_ID" NUMBER(*,0), 
	"FTP_LOCAL_NAME" VARCHAR2(30) NOT NULL ENABLE, 
	"FTP_ADDRESS" VARCHAR2(30 CHAR), 
	"PORT" VARCHAR2(30 CHAR), 
	"LOGIN" VARCHAR2(30 CHAR), 
	"PASSWORD" VARCHAR2(30 CHAR), 
	"STATUS" NUMBER NOT NULL ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 