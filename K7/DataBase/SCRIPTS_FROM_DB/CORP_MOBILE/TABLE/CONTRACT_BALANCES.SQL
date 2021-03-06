
  CREATE TABLE "CORP_MOBILE"."CONTRACT_BALANCES" 
   (	"CONTRACT_BALANCE_ID" NUMBER(*,0), 
	"CONTRACT_ID" NUMBER(*,0) CONSTRAINT "NN_CONTRACT_BALANCE_CONTRACT" NOT NULL ENABLE, 
	"BALANCE_DATE" DATE CONSTRAINT "NN_CONTRACT_BALANCE_DATE" NOT NULL ENABLE, 
	"BALANCE_VALUE" NUMBER(15,2) NOT NULL ENABLE, 
	"USER_CREATED" VARCHAR2(30 CHAR), 
	"DATE_CREATED" DATE, 
	"USER_LAST_UPDATED" VARCHAR2(30 CHAR), 
	"DATE_LAST_UPDATED" DATE, 
	"PHONE_NUMBER" VARCHAR2(10 CHAR), 
	 CONSTRAINT "PK_CONTRACT_BALANCE_ID" PRIMARY KEY ("CONTRACT_BALANCE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1
  FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1
  FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 