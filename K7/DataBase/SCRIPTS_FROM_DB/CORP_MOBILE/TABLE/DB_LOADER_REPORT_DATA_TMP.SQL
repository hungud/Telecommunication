
  CREATE GLOBAL TEMPORARY TABLE "CORP_MOBILE"."DB_LOADER_REPORT_DATA_TMP" 
   (	"YEAR_MONTH" NUMBER(*,0), 
	"PHONE_NUMBER" VARCHAR2(20 CHAR) NOT NULL ENABLE, 
	"DETAIL_SUM" NUMBER(10,2) NOT NULL ENABLE, 
	"DATE_LAST_UPDATE" DATE
   ) ON COMMIT DELETE ROWS 