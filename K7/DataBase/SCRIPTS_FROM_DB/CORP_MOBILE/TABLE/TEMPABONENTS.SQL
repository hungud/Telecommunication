
  CREATE TABLE "CORP_MOBILE"."TEMPABONENTS" 
   (	"ABONENT_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"STATE" NUMBER, 
	 CONSTRAINT "FK_TEMPABONENTS_ABONENT_ID" FOREIGN KEY ("ABONENT_ID")
	  REFERENCES "CORP_MOBILE"."ABONENTS" ("ABONENT_ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 