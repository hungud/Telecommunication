
  CREATE TABLE "LONTANA"."DB_LOADER_BILLS" 
   (	"ACCOUNT_ID" NUMBER(*,0), 
	"YEAR_MONTH" NUMBER(*,0), 
	"PHONE_NUMBER" VARCHAR2(10 CHAR), 
	"DATE_BEGIN" DATE, 
	"DATE_END" DATE, 
	"BILL_SUM" NUMBER(15,2), 
	"SUBSCRIBER_PAYMENT_MAIN" NUMBER(15,2), 
	"SUBSCRIBER_PAYMENT_ADD" NUMBER(15,2), 
	"SINGLE_PAYMENTS" NUMBER(15,2), 
	"CALLS_LOCAL_COST" NUMBER(15,2), 
	"CALLS_OTHER_CITY_COST" NUMBER(15,2), 
	"CALLS_OTHER_COUNTRY_COST" NUMBER(15,2), 
	"MESSAGES_COST" NUMBER(15,2), 
	"INTERNET_COST" NUMBER(15,2), 
	"OTHER_COUNTRY_ROAMING_COST" NUMBER(15,2), 
	"NATIONAL_ROAMING_COST" NUMBER(15,2), 
	"PENI_COST" NUMBER(15,2), 
	"DISCOUNT_VALUE" NUMBER(15,2), 
	"TARIFF_CODE" VARCHAR2(30 CHAR), 
	"OTHER_COUNTRY_ROAMING_CALLS" NUMBER(15,2), 
	"OTHER_COUNTRY_ROAMING_MESSAGES" NUMBER(15,2), 
	"OTHER_COUNTRY_ROAMING_INTERNET" NUMBER(15,2), 
	"NATIONAL_ROAMING_CALLS" NUMBER(15,2), 
	"NATIONAL_ROAMING_MESSAGES" NUMBER(15,2), 
	"NATIONAL_ROAMING_INTERNET" NUMBER(15,2), 
	"BILL_CHECKED" NUMBER(*,0), 
	"DATE_CREATED" DATE, 
	"USER_CREATED" VARCHAR2(30 CHAR), 
	"USER_LAST_UPDATED" VARCHAR2(30 CHAR), 
	"DATE_LAST_UPDATED" DATE, 
	 CONSTRAINT "FK_DB_LOADER_BILLS_ACCOUNT_ID" FOREIGN KEY ("ACCOUNT_ID")
	  REFERENCES "LONTANA"."ACCOUNTS" ("ACCOUNT_ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 19922944 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 