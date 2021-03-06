
  CREATE TABLE "CORP_MOBILE"."TARIFF_OPTION_COSTS" 
   (	"TARIFF_OPTION_COST_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"TARIFF_OPTION_ID" NUMBER(*,0) CONSTRAINT "CHK_TARIFF_OPT_COSTS_OPTID_NN" NOT NULL ENABLE, 
	"BEGIN_DATE" DATE CONSTRAINT "CHK_TARIFF_OPT_COSTS_BEGD_NN" NOT NULL ENABLE, 
	"END_DATE" DATE CONSTRAINT "CHK_TARIFF_OPT_COSTS_ENDD_NN" NOT NULL ENABLE, 
	"TURN_ON_COST" NUMBER(12,2), 
	"MONTHLY_COST" NUMBER(12,2), 
	"USER_CREATED" VARCHAR2(30 CHAR), 
	"DATE_CREATED" DATE, 
	"USER_LAST_UPDATED" VARCHAR2(30 CHAR), 
	"DATE_LAST_UPDATED" DATE, 
	"OPERATOR_TURN_ON_COST" NUMBER(12,2), 
	"OPERATOR_MONTHLY_COST" NUMBER(12,2), 
	 CONSTRAINT "PK_TARIFF_OPTION_COSTS" PRIMARY KEY ("TARIFF_OPTION_COST_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 