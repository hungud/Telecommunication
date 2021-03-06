
  CREATE TABLE "LONTANA"."QUEUE_ITEMS" 
   (	"QUEUE_ITEM_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"QUEUE_TYPE" VARCHAR2(30 CHAR), 
	"STATE" NUMBER(*,0), 
	"PARAM1" VARCHAR2(30 CHAR), 
	"PARAM2" VARCHAR2(30 CHAR), 
	"PARAM3" VARCHAR2(30 CHAR), 
	"PARAM4" VARCHAR2(30 CHAR), 
	"PARAM5" VARCHAR2(30 CHAR), 
	"USER_CREATED" VARCHAR2(30 CHAR), 
	"DATE_CREATED" DATE, 
	"USER_LAST_UPDATED" VARCHAR2(30 CHAR), 
	"DATE_LAST_UPDATED" DATE, 
	"ERROR_MESSAGE" VARCHAR2(2000 CHAR), 
	"DATE_PROCESS" DATE, 
	 CONSTRAINT "PK_QUEUE_ITEMS" PRIMARY KEY ("QUEUE_ITEM_ID")
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