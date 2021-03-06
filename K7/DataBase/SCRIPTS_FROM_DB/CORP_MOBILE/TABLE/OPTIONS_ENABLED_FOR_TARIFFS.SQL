
  CREATE TABLE "CORP_MOBILE"."OPTIONS_ENABLED_FOR_TARIFFS" 
   (	"ID" NUMBER(*,0), 
	"TARIFF_ID" NUMBER(*,0), 
	"TARIFF_OPTION_ID" NUMBER(*,0), 
	"USER_CREATED" VARCHAR2(30 CHAR), 
	"DATE_CREATED" DATE, 
	"USER_LAST_UPDATED" VARCHAR2(30 CHAR), 
	"DATE_LAST_UPDATED" DATE, 
	 CONSTRAINT "PK_OPTIONS_ENABLED_FOR_TARIFFS" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "FK_OPTS_EN_FOR_TARIFFS_TAR_IF" FOREIGN KEY ("TARIFF_ID")
	  REFERENCES "CORP_MOBILE"."TARIFFS" ("TARIFF_ID") ENABLE, 
	 CONSTRAINT "FK_OPTS_EN_FOR_TARIFFS_OPT_IF" FOREIGN KEY ("TARIFF_OPTION_ID")
	  REFERENCES "CORP_MOBILE"."TARIFF_OPTIONS" ("TARIFF_OPTION_ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 