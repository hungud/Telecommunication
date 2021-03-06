
  CREATE TABLE "SIM_TRADE"."BEELINE_SOAP_API_LOG" 
   (	"BSAL_ID" NUMBER(*,0) NOT NULL DISABLE, 
	"SOAP_REQUEST" VARCHAR2(4000), 
	"SOAP_ANSWER" "SYS"."XMLTYPE" , 
	"INSERT_DATE" DATE, 
	"PHONE" VARCHAR2(11), 
	"LOAD_TYPE" NUMBER(*,0), 
	"ACCOUNT_ID" NUMBER(*,0), 
	 CONSTRAINT "PK_BSAL" PRIMARY KEY ("BSAL_ID")
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
  TABLESPACE "TS_LOGS" 
 XMLTYPE COLUMN "SOAP_ANSWER" STORE AS SECUREFILE BINARY XML (
  TABLESPACE "TS_LOGS" ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES 
  STORAGE(INITIAL 106496 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) ALLOW NONSCHEMA DISALLOW ANYSCHEMA 