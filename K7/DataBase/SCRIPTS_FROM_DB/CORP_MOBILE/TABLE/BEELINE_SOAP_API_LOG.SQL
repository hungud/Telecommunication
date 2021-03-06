
  CREATE TABLE "CORP_MOBILE"."BEELINE_SOAP_API_LOG" 
   (	"BSAL_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"SOAP_REQUEST" VARCHAR2(4000), 
	"SOAP_ANSWER" "XMLTYPE", 
	"INSERT_DATE" DATE, 
	"PHONE" VARCHAR2(11), 
	"ACCOUNT_ID" NUMBER(3,0), 
	"LOAD_TYPE" NUMBER(3,0), 
	 CONSTRAINT "PK_BSAL" PRIMARY KEY ("BSAL_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 262144 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_BEELINE_SOAP_API_LOG"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 8192 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_BEELINE_SOAP_API_LOG" 
 XMLTYPE COLUMN "SOAP_ANSWER" STORE AS BASICFILE CLOB (
  TABLESPACE "TS_BEELINE_SOAP_API_LOG" ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT))  ENABLE ROW MOVEMENT 