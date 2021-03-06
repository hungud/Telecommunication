
  CREATE TABLE "CORP_MOBILE"."ACCOUNT_LOAD_LOGS" 
   (	"ACCOUNT_LOAD_LOG_ID" NUMBER(*,0), 
	"ACCOUNT_ID" NUMBER(*,0), 
	"LOAD_DATE_TIME" DATE, 
	"IS_SUCCESS" NUMBER(1,0), 
	"ERROR_TEXT" VARCHAR2(2000 CHAR), 
	"ACCOUNT_LOAD_TYPE_ID" NUMBER(*,0), 
	"BEELINE_RN" VARCHAR2(30), 
	"BAN" NUMBER(*,0), 
	 CHECK (IS_SUCCESS IN (0, 1)) ENABLE, 
	 CONSTRAINT "PK_ACCOUNT_LOAD_LOGS" PRIMARY KEY ("ACCOUNT_LOAD_LOG_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 16777216 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_LOGS"  ENABLE, 
	 CONSTRAINT "FK_ACCOUNT_LOAD_TYPE_ID" FOREIGN KEY ("ACCOUNT_LOAD_TYPE_ID")
	  REFERENCES "CORP_MOBILE"."ACCOUNT_LOAD_TYPES" ("ACCOUNT_LOAD_TYPE_ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 40894464 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_LOGS"  ENABLE ROW MOVEMENT 