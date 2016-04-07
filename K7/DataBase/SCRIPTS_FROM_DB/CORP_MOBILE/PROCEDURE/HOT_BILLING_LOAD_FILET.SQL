
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HOT_BILLING_LOAD_FILET" (
  NAME_FILEP IN varchar2
  ) IS
SHBF_ID integer;
BEGIN
  select hbf.HBF_ID into SHBF_ID from hot_billing_files hbf
  where hbf.file_name=NAME_FILEP;
execute immediate 'CREATE TABLE HOT_BILLING_CSVT (
SUBSCR_NO varchar2(11),
CH_SEIZ_DT varchar2(14),
AT_FT_CODE varchar2(10),
AT_CHG_AMT varchar2(10),
CALLING_NO varchar2(30),
DURATION varchar2(8),
DATA_VOL varchar2(10),
CELL_ID varchar2(10),
DIALED_DIG varchar2(30),
AT_FT_DESC varchar2(300)
)
 ORGANIZATION EXTERNAL
 (
   TYPE ORACLE_LOADER
   DEFAULT DIRECTORY PROCESSED
   ACCESS PARAMETERS
   (
             records delimited by 0x''0A'' CHARACTERSET CL8MSWIN1251
             SKIP 1
             badfile PROCESSED:''CSV%a_%p.bad''
             nologfile
             fields terminated by '';''  LRTRIM
            MISSING FIELD VALUES ARE NULL (SUBSCR_NO char(11),
CH_SEIZ_DT char(14),
AT_FT_CODE char(10),
AT_CHG_AMT char(10),
CALLING_NO char(30),
DURATION char(8),
DATA_VOL char(10),
CELL_ID char(10),
DIALED_DIG char(30),
AT_FT_DESC char(300))
   )
   LOCATION ('''||NAME_FILEP||''')
 )
 PARALLEL 10
 REJECT LIMIT unlimited';
 execute immediate 'insert into HOT_BILLING
 select tabs.SUBSCR_NO,tabs.CALL_TIME,tabs.COL_VALUE,sysdate,'||SHBF_ID||' from table (sample3_tab_fnc2(CURSOR(select * from HOT_BILLING_CSVT))) tabs
 where not exists(select 1 from HOT_BILLING hb
 where hb.SUBSCR_NO=tabs.SUBSCR_NO
 and hb.CALL_TIME=tabs.CALL_TIME
 and hb.COL_VALUE=tabs.COL_VALUE)';
 commit;
 execute immediate 'drop table HOT_BILLING_CSVT';
end;
