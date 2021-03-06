
  CREATE TABLE "LONTANA"."SIM_CURRENT_PHONE_OPTIONS" 
   (	"CURRENT_PHONE_OPTION_ID" NUMBER(*,0), 
	"PHONE_NUMBER" VARCHAR2(10 CHAR) NOT NULL ENABLE, 
	"OPTION_CODE" NUMBER NOT NULL ENABLE, 
	"DATE_OPTION_CHECK" DATE, 
	 PRIMARY KEY ("CURRENT_PHONE_OPTION_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 851968 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 2097152 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 