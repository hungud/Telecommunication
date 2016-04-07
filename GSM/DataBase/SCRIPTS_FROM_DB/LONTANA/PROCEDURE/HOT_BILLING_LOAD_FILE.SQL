
  CREATE OR REPLACE PROCEDURE "LONTANA"."HOT_BILLING_LOAD_FILE" (NAME_FILEP IN varchar2, numf In varchar2) IS
  SHBF_ID integer;
BEGIN
  select hbf.HBF_ID
    into SHBF_ID
    from hot_billing_files hbf
   where hbf.file_name = NAME_FILEP;
  begin
    execute immediate 'drop table HOT_BILLING_CSV'||numf;
  exception
    when others then
      null;
  end;
  execute immediate 'CREATE TABLE HOT_BILLING_CSV'||numf||' (
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
   DEFAULT DIRECTORY NEW_CSV
   ACCESS PARAMETERS
   (
             records delimited by 0x''0A'' CHARACTERSET CL8MSWIN1251
             SKIP 1
             badfile NEW_CSV:''CSV%a_%p.bad''
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
   LOCATION (''' || NAME_FILEP || ''')
 )
 PARALLEL 10
 REJECT LIMIT unlimited';

  execute immediate 'merge into HOT_BILLING_TEMP_CALL hb
using (
  select tabs.SUBSCR_NO, tabs.CH_SEIZ_DT,tabs.AT_FT_CODE,tabs.AT_CHG_AMT,tabs.CALLING_NO,tabs.DURATION,tabs.DATA_VOL,tabs.IMEI,tabs.CELL_ID,tabs.DIALED_DIG,tabs.AT_FT_DESC,' ||
                    SHBF_ID || ' as DBF_ID from HOT_BILLING_CSV'||numf||' tabs
) t
on (t.UBSCR_NO=hb.UBSCR_NO and 
t.CH_SEIZ_DT=hb.CH_SEIZ_DT and 
t.AT_FT_CODE=hb.AT_FT_CODE and 
t.AT_CHG_AMT=hb.AT_CHG_AMT and
t.CALLING_NO=hb.CALLING_NO and 
t.DURATION=hb.DURATION and
t.DATA_VOL=hb.DATA_VOL and
t.IMEI=hb.IMEI and
t.CELL_ID=hb.CELL_ID and
t.DIALED_DIG=hb.DIALED_DIG and
t.AT_FT_DESC=hb.AT_FT_DESC)
when not matched then
  insert (hb.SUBSCR_NO, hb.CH_SEIZ_DT,hb.AT_FT_CODE,hb.AT_CHG_AMT,hb.CALLING_NO,hb.DURATION,hb.DATA_VOL,hb.IMEI,hb.CELL_ID,hb.DIALED_DIG,hb.AT_FT_DESC,hb.DBF_ID) values (t.SUBSCR_NO, t.CH_SEIZ_DT,t.AT_FT_CODE,t.AT_CHG_AMT,t.CALLING_NO,t.DURATION,t.DATA_VOL,t.IMEI,t.CELL_ID,t.DIALED_DIG,t.AT_FT_DESC,t.DBF_ID)';

 --  'insert into HOT_BILLING
 --select tabs.SUBSCR_NO,tabs.CALL_TIME,tabs.COL_VALUE,sysdate,' ||
  --                  SHBF_ID || ' from table (sample3_tab_fnc2T(CURSOR(select * from HOT_BILLING_CSV'||numf||'))) tabs';
  commit;
 /* execute immediate 'drop table HOT_BILLING_CSV'||numf;
  UTL_FILE.frename('NEW_CSV',
                   NAME_FILEP,
                   'PROCESSED',
                   '1' || NAME_FILEP,
                   true);
  UTL_FILE.frename('PROCESSED',
                   '1' || NAME_FILEP,
                   'PROCESSED',
                   NAME_FILEP,
                   true);*/
end;
