
  CREATE TABLE "LONTANA"."CONSTANTS" 
   (	"NAME" VARCHAR2(30) NOT NULL ENABLE, 
	"DESCR" VARCHAR2(400), 
	"TYPE" CHAR(1) NOT NULL ENABLE, 
	"VALUE" VARCHAR2(256), 
	"CONSTANT_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"PAGE_NAME" VARCHAR2(256), 
	"ORDER_NUMBER" NUMBER(*,0), 
	"CAPTION" VARCHAR2(256), 
	"ITEMS" VARCHAR2(2000), 
	"ACCESS_VERSTION" NUMBER(13,6) DEFAULT 0, 
	"ACCESS_VERSTION_STRING" VARCHAR2(30 CHAR) DEFAULT '0.0.0.0', 
	 CONSTRAINT "PK_CONSTANTS" PRIMARY KEY ("CONSTANT_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 131072 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "UNQ_CONST_NAME" UNIQUE ("NAME")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 131072 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 131072 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 