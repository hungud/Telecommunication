
  CREATE TABLE "SIM_TRADE"."TEMP1" 
   (	"STR1" VARCHAR2(100 CHAR), 
	"STR2" VARCHAR2(100 CHAR), 
	"STR3" VARCHAR2(100 CHAR), 
	"STR4" VARCHAR2(100 CHAR), 
	"STR5" VARCHAR2(100 CHAR), 
	"STR6" VARCHAR2(100 CHAR), 
	"D1" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 