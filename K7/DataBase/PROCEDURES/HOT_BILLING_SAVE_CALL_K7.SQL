--#if GetVersion('HOT_BILLING_SAVE_CALL') < 1 then
CREATE OR REPLACE PROCEDURE CORP_MOBILE.HOT_BILLING_SAVE_CALL IS
--#Version=1
--
-- Переносит детализации из hot_billing_temp_call в CALL_MM_YYYY
-- Также запускает пересчет балансов по загруженным номерам и предупреждения
--
  SDBF_ID integer;
  -- ssubscr_no varchar2(11);
  smonth date;
  cursor curf is
    select
     htc.dbf_id,
     trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm')
      from hot_billing_temp_call htc
     where htc.ch_seiz_dt is not null
     group by htc.dbf_id,
              trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm')
     order by 1;
  TYPE curnmSet IS TABLE OF hot_billing_temp_call.SUBSCR_NO%TYPE INDEX BY BINARY_INTEGER;
  curnmc curnmSet;
BEGIN
  open curf;
  loop
    FETCH curf
      into SDBF_ID, smonth;
    EXIT WHEN curf%NOTFOUND;
    select htc.subscr_no BULK COLLECT
      INTO curnmc
      from hot_billing_temp_call htc
     where htc.dbf_id = SDBF_ID
       and trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm') =
           smonth
     group by htc.subscr_no;
    execute immediate 'merge into CALL_' || to_char(smonth, 'mm_yyyy') || ' ct
using (
select distinct tabs.SUBSCR_NO,tabs.START_TIME,tabs.AT_FT_CODE,tabs.DBF_ID,tabs.call_cost,tabs.costnovat,tabs.dur,tabs.IMEI,tabs.ServiceType,tabs.ServiceDirection,tabs.IsRoaming,tabs.RoamingZone,tabs.CALL_DATE,tabs.CALL_TIME,tabs.DURATION,tabs.DIALED_DIG,tabs.AT_FT_DE,tabs.AT_FT_DESC,tabs.CALLING_NO,tabs.AT_CHG_AMT,
tabs.DATA_VOL,tabs.CELL_ID,tabs.MN_UNLIM,tabs.cost_chng from table (HOT_BILLING_GET_CALL_TAB(CURSOR(select * from hot_billing_temp_call htc
where htc.dbf_id=' || SDBF_ID || '
and htc.ch_seiz_dt is not null
and trunc(to_date(htc.ch_seiz_dt, ''yyyymmddhh24miss''), ''mm'')=to_date(''' ||
                      to_char(smonth, 'dd.mm.yyyy') ||
                      ''',''dd.mm.yyyy'')
order by htc.subscr_no))) tabs
) t
on (ct.subscr_no = t.subscr_no and ct.start_time = t.start_time and to_number(ct.AT_CHG_AMT,
                   ''99999999999D99'',
                   '' NLS_NUMERIC_CHARACTERS = '''',.'''''')=to_number(t.AT_CHG_AMT,
                   ''99999999999D99'',
                   '' NLS_NUMERIC_CHARACTERS = '''',.'''''') and to_number(ct.DATA_VOL,
                   ''99999999999D99'',
                   '' NLS_NUMERIC_CHARACTERS = '''',.'''''')=to_number(t.DATA_VOL,
                   ''99999999999D99'',
                   '' NLS_NUMERIC_CHARACTERS = '''',.'''''')
and ct.dur=t.dur)
when not matched then
insert (ct.SUBSCR_NO,ct.START_TIME,ct.AT_FT_CODE,ct.DBF_ID,ct.call_cost,ct.costnovat,ct.dur,ct.IMEI,ct.ServiceType,ct.ServiceDirection,ct.IsRoaming,ct.RoamingZone,ct.CALL_DATE,ct.CALL_TIME,ct.DURATION,ct.DIALED_DIG,ct.AT_FT_DE,ct.AT_FT_DESC,ct.CALLING_NO,ct.AT_CHG_AMT,
ct.DATA_VOL,ct.CELL_ID,ct.MN_UNLIM,ct.INSERT_DATE,ct.cost_chng) values (t.SUBSCR_NO,t.START_TIME,t.AT_FT_CODE,t.DBF_ID,t.call_cost,t.costnovat,t.dur,t.IMEI,t.ServiceType,t.ServiceDirection,t.IsRoaming,t.RoamingZone,t.CALL_DATE,t.CALL_TIME,t.DURATION,t.DIALED_DIG,t.AT_FT_DE,t.AT_FT_DESC,t.CALLING_NO,t.AT_CHG_AMT,
t.DATA_VOL,t.CELL_ID,t.MN_UNLIM,sysdate,t.cost_chng)';
    commit;
    FOR i IN curnmc.FIRST .. curnmc.LAST LOOP
      HOT_BILLING_PCKG.i_usm_PHONE(curnmc(i), smonth);
      HOT_BILLING_ALARM_PHONE(curnmc(i), SDBF_ID);
    END LOOP;
    
    delete hot_billing_temp_call htc
     where htc.dbf_id = SDBF_ID
       and trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm') =
           smonth;
    commit;
    
  end loop;  
  close curf;
  
  -- поиск и удаление дублей по АПИ и ГБ
  DELETE_DOUBLE_DETAIL (sysdate);
end;
/
--#end if
