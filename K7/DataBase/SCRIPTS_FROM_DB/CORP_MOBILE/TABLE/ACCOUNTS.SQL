
  CREATE TABLE "CORP_MOBILE"."ACCOUNTS" 
   (	"ACCOUNT_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"OPERATOR_ID" NUMBER(*,0), 
	"ACCOUNT_NUMBER" NUMBER, 
	"LOGIN" VARCHAR2(30 CHAR), 
	"PASSWORD" VARCHAR2(30 CHAR), 
	"USER_CREATED" VARCHAR2(30 CHAR), 
	"DATE_CREATED" DATE, 
	"USER_LAST_UPDATED" VARCHAR2(30 CHAR), 
	"DATE_LAST_UPDATED" DATE, 
	"DO_AUTO_LOAD_DATA" NUMBER(1,0), 
	"LOAD_INTERVAL" NUMBER(4,2) DEFAULT 8, 
	"PAY_LOAD_INTERVAL" NUMBER, 
	"BALANCE_NOTICE_TEXT" VARCHAR2(350 CHAR), 
	"BLOCK_NOTICE_TEXT" VARCHAR2(350 CHAR), 
	"NEXT_MONTH_NOTICE_TEXT" VARCHAR2(350 CHAR), 
	"LOAD_DETAIL_POOL_SIZE" NUMBER(*,0) DEFAULT 100, 
	"LOAD_DETAIL_THREAD_COUNT" NUMBER(*,0) DEFAULT 2, 
	"BALANCE_BLOCK" NUMBER(*,0) DEFAULT 0, 
	"DO_AUTO_BLOCK" NUMBER(1,0) DEFAULT 0, 
	"BALANCE_NOTICE" NUMBER(*,0) DEFAULT 100, 
	"DO_BALANCE_NOTICE" NUMBER(1,0) DEFAULT 0, 
	"DO_BALANCE_NOTICE_MONTH" NUMBER(1,0) DEFAULT 0, 
	"BALANCE_NOTICE_END_MONTH" NUMBER(*,0) DEFAULT 200, 
	"BALANCE_NOTICE_CREDIT" NUMBER(*,0), 
	"TEXT_NOTICE_BALANCE_CREDIT" VARCHAR2(350 CHAR), 
	"BALANCE_BLOCK_CREDIT" NUMBER(*,0), 
	"TEXT_NOTICE_BLOCK_CREDIT" VARCHAR2(350 CHAR), 
	"BALANCE_NOTICE_MONTH_CREDIT" NUMBER(*,0), 
	"TEXT_NOTICE_END_MONTH_CREDIT" VARCHAR2(350 CHAR), 
	"DILER_PAYMETS" NUMBER(*,0), 
	"BALANCE_NOTICE2" NUMBER(*,0), 
	"BALANCE_NOTICE_TEXT2" VARCHAR2(350 CHAR), 
	"BALANCE_NOTICE_CREDIT2" NUMBER(*,0), 
	"TEXT_NOTICE_BALANCE_CREDIT2" VARCHAR2(350 CHAR), 
	"NEXT_MONTH_NOTICE_BALANCE" NUMBER, 
	"COMPANY_NAME" VARCHAR2(30 CHAR), 
	"FILIAL_ID" NUMBER(*,0), 
	"NEW_PSWD" VARCHAR2(30), 
	"N_METHOD" VARCHAR2(50), 
	"IS_COLLECTOR" NUMBER(1,0), 
	"DO_ROAMING_RETARIFICATION" NUMBER(1,0), 
	"SMS_SENDER_NAME_ID" NUMBER(1,0), 
	"SMS_SETT_ACCOUNTS" NUMBER(1,0), 
	"BALANCE_USSD_TEXT" VARCHAR2(500 CHAR), 
	 CONSTRAINT "PK_ACCOUNTS" PRIMARY KEY ("ACCOUNT_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CHECK (DO_AUTO_LOAD_DATA IN (0, 1)) ENABLE, 
	 CHECK (DO_AUTO_BLOCK IN (0, 1)) ENABLE, 
	 CHECK (DO_BALANCE_NOTICE IN (0, 1)) ENABLE, 
	 CHECK (DO_BALANCE_NOTICE_MONTH IN (0, 1)) ENABLE, 
	 CONSTRAINT "FK_ACCOUNTS_OPERATOR_ID" FOREIGN KEY ("OPERATOR_ID")
	  REFERENCES "CORP_MOBILE"."OPERATORS" ("OPERATOR_ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 