
  CREATE TABLE "LONTANA"."BALANCEENDM_REPORT" 
   (	"LOGIN" VARCHAR2(30), 
	"YEAR_MONTH" NUMBER(*,0), 
	"PHONE_NUMBER" VARCHAR2(11), 
	"DATE_BALANCE" DATE, 
	"BALANCE" NUMBER, 
	"PHONE_IS_ACTIVE" NUMBER(1,0), 
	"BEGIN_DATE" DATE, 
	"SUBSCRIBER_PAYMENT_NEW" NUMBER, 
	"ACTIV" NUMBER(*,0), 
	"ALL_CALLS" NUMBER, 
	"DILER_CALLS" NUMBER, 
	"BILL_SUM_NEW" NUMBER, 
	"DILER_SUM" NUMBER, 
	"TARIFF_NAME" VARCHAR2(100), 
	"SESSION_ID" NUMBER(*,0), 
	"DATE_REPORT" DATE, 
	"TYPE_ABON" VARCHAR2(30), 
	"EXIT_PLUS" VARCHAR2(30), 
	"DILER_SUM_OLD" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 