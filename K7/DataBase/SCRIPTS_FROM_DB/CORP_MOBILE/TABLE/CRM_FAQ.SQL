
  CREATE TABLE "CORP_MOBILE"."CRM_FAQ" 
   (	"QUESTION" VARCHAR2(1000 CHAR) NOT NULL ENABLE, 
	"ANSWER" VARCHAR2(1000 CHAR) NOT NULL ENABLE, 
	"FAQ_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"DATE_CREATED" DATE, 
	"DATE_LAST_UPDATED" DATE, 
	"PATH" VARCHAR2(300 CHAR), 
	 CONSTRAINT "PK_CRM_FAQ" PRIMARY KEY ("FAQ_ID")
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