
  CREATE TABLE "SIM_TRADE"."DB_LOADER_ACCOUNT_PHONE_HISTS" 
   (	"HISTORY_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"PHONE_NUMBER" VARCHAR2(100 CHAR), 
	"BEGIN_DATE" DATE, 
	"END_DATE" DATE, 
	"PHONE_IS_ACTIVE" NUMBER(1,0), 
	"CELL_PLAN_CODE" VARCHAR2(50 CHAR), 
	"USER_CREATED" VARCHAR2(30 CHAR), 
	"DATE_CREATED" DATE, 
	"USER_LAST_UPDATED" VARCHAR2(30 CHAR), 
	"DATE_LAST_UPDATED" DATE, 
	"CONSERVATION" NUMBER(1,0), 
	"SYSTEM_BLOCK" NUMBER(1,0), 
	"STATUS_ID" NUMBER(*,0), 
	 CONSTRAINT "PK_DB_LOADER_ACC_PHONE_HISTS" PRIMARY KEY ("HISTORY_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 917504 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "U_PHONE_END_DATE" UNIQUE ("PHONE_NUMBER", "END_DATE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 6291456 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 