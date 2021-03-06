
  CREATE TABLE "LONTANA"."CONTRACT_CANCELS" 
   (	"CONTRACT_CANCEL_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"CONTRACT_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"FILIAL_ID" NUMBER(*,0), 
	"CONTRACT_CANCEL_DATE" DATE NOT NULL ENABLE, 
	"CONTRACT_CANCEL_TYPE_ID" NUMBER(*,0), 
	"SUM_GET" NUMBER, 
	"SUM_PUT" NUMBER, 
	"USER_CREATED" VARCHAR2(30 CHAR), 
	"DATE_CREATED" DATE, 
	"USER_LAST_UPDATED" VARCHAR2(30 CHAR), 
	"DATE_LAST_UPDATED" DATE, 
	"CONFIRMED" NUMBER(1,0), 
	"RECEIVED_PAYMENT_ID" NUMBER(38,0), 
	 CONSTRAINT "PK_CONTRACT_CANCELS" PRIMARY KEY ("CONTRACT_CANCEL_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 131072 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "FK_CONTRACT_CANCELS_TARIFF_ID" FOREIGN KEY ("CONTRACT_ID")
	  REFERENCES "LONTANA"."CONTRACTS" ("CONTRACT_ID") ENABLE, 
	 CONSTRAINT "FK_CONTRACT_CANCELS_FILIAL_ID" FOREIGN KEY ("FILIAL_ID")
	  REFERENCES "LONTANA"."FILIALS" ("FILIAL_ID") ENABLE, 
	 CONSTRAINT "FK_CONTRACT_CANCELS_TYPE_ID" FOREIGN KEY ("CONTRACT_CANCEL_TYPE_ID")
	  REFERENCES "LONTANA"."CONTRACT_CANCEL_TYPES" ("CONTRACT_CANCEL_TYPE_ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 262144 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 