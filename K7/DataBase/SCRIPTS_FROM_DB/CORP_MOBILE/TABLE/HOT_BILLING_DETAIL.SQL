
  CREATE TABLE "CORP_MOBILE"."HOT_BILLING_DETAIL" 
   (	"DATEP" VARCHAR2(10), 
	"TIMEP" VARCHAR2(8), 
	"DURP" VARCHAR2(8), 
	"DIALEDP" VARCHAR2(30), 
	"FT_CODEP" VARCHAR2(200), 
	"FT_DESCP" VARCHAR2(300), 
	"CALLINGP" VARCHAR2(30), 
	"CHARGEP" VARCHAR2(10), 
	"VOLP" VARCHAR2(10), 
	"CELL_IDP" VARCHAR2(10), 
	"MN_UNLIMP" VARCHAR2(1)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "HBT2012_08"
      ACCESS PARAMETERS
      ( records delimited by 0x'0A' CHARACTERSET CL8MSWIN1251
             badfile HBT2012_08:'DET%a_%p.bad'
             nologfile
             fields terminated by 0x'09'  LRTRIM
            MISSING FIELD VALUES ARE NULL (datep char(10),
timep char(8),
durp char(8),
dialedp char(30),
ft_codep char(200),
ft_descp char(300),
callingp char(30),
chargep char(10),
volp char(10),
cell_idp char(10),
mn_unlimp char(1))
       )
      LOCATION
       ( '9629622004.txt'
       )
    )
   REJECT LIMIT UNLIMITED 
  PARALLEL 10 