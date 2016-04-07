
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HOT_BILLING_LOAD_FILE" (NAME_FILEP IN varchar2, numf In varchar2) IS
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
  execute immediate 'merge into hot_billing hb
using (
  select tabs.SUBSCR_NO,tabs.CALL_TIME,tabs.COL_VALUE,sysdate as INSERT_DATE,' ||
                    SHBF_ID || ' as HBF_ID from table (sample3_tab_fnc2(CURSOR(select * from HOT_BILLING_CSV'||numf||'))) tabs
) t
on (hb.col_value = t.COL_VALUE)
when not matched then
  insert (hb.SUBSCR_NO, hb.CALL_TIME,hb.COL_VALUE,hb.INSERT_DATE,hb.HBF_ID) values (t.SUBSCR_NO, t.CALL_TIME,t.COL_VALUE,t.INSERT_DATE,t.HBF_ID)';
  
 --  'insert into HOT_BILLING
 --select tabs.SUBSCR_NO,tabs.CALL_TIME,tabs.COL_VALUE,sysdate,' ||
  --                  SHBF_ID || ' from table (sample3_tab_fnc2T(CURSOR(select * from HOT_BILLING_CSV'||numf||'))) tabs';
  commit;
  execute immediate 'drop table HOT_BILLING_CSV'||numf;
  UTL_FILE.frename('NEW_CSV',
                   NAME_FILEP,
                   'PROCESSED',
                   '1' || NAME_FILEP,
                   true);
  UTL_FILE.frename('PROCESSED',
                   '1' || NAME_FILEP,
                   'PROCESSED',
                   NAME_FILEP,
                   true);
end;
