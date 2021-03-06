
  CREATE TABLE "CORP_MOBILE"."TELETIE_CONN_LOGS" 
   (	"CONN_LOG_ID" NUMBER(*,0), 
	"CONN_TYPE_ID" NUMBER(*,0), 
	"CONN_REQUEST" VARCHAR2(200), 
	"CONN_ANSWER" VARCHAR2(200), 
	"CREATE_DATE_TIME" DATE DEFAULT SYSDATE, 
	"IS_SUCCESS" NUMBER(1,0), 
	"ERROR_TEXT" VARCHAR2(2000 CHAR), 
	 CONSTRAINT "FK_CONN_TYPE_ID" FOREIGN KEY ("CONN_TYPE_ID")
	  REFERENCES "CORP_MOBILE"."TELETIE_CONN_TYPES" ("CONN_TYPE_ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 