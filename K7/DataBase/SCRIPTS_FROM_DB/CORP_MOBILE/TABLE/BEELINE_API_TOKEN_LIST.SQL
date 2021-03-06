
  CREATE TABLE "CORP_MOBILE"."BEELINE_API_TOKEN_LIST" 
   (	"ACC_LOG" VARCHAR2(50), 
	"TOKEN" VARCHAR2(100), 
	"LAST_UPDATE" DATE, 
	"REST_TOKEN" VARCHAR2(100), 
	"REST_LAST_UPDATE" DATE, 
	"IS_VALID" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 