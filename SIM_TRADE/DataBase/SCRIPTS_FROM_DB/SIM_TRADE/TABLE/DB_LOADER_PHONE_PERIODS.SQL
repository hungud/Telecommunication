
  CREATE TABLE "SIM_TRADE"."DB_LOADER_PHONE_PERIODS" 
   (	"YEAR_MONTH" NUMBER(*,0), 
	"PHONE_NUMBER" VARCHAR2(10 CHAR), 
	"ACCOUNT_ID" NUMBER(*,0), 
	"TARIFF_CODE" VARCHAR2(12 CHAR), 
	 CONSTRAINT "PK_DB_PHONE_MODEL_PERIODS" PRIMARY KEY ("PHONE_NUMBER", "YEAR_MONTH") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 
 PCTTHRESHOLD 50