
  CREATE OR REPLACE PROCEDURE "LONTANA"."ADD_SITE_DETAIL_T" (pPHONE_NUMBER  IN VARCHAR2,
                            pLOADING_YEAR  IN VARCHAR2,
                            pLOADING_MONTH IN VARCHAR2) IS

    smonth  date;
  BEGIN
    smonth:=to_date('01'||pLOADING_MONTH||pLOADING_YEAR,'ddmmyyyy');
   execute immediate 'merge into CALL_' || to_char(smonth, 'mm_yyyy') || ' ct
using (
  select distinct tabs.SUBSCR_NO,tabs.START_TIME,tabs.AT_FT_CODE,tabs.DBF_ID,tabs.call_cost,tabs.costnovat,tabs.dur,tabs.IMEI,tabs.ServiceType,tabs.ServiceDirection,tabs.IsRoaming,tabs.RoamingZone,tabs.CALL_DATE,tabs.CALL_TIME,tabs.DURATION,tabs.DIALED_DIG,tabs.AT_FT_DE,tabs.AT_FT_DESC,tabs.CALLING_NO,tabs.AT_CHG_AMT,
tabs.DATA_VOL,tabs.CELL_ID,tabs.MN_UNLIM from table (HOT_BILLING_GET_CALL_TAB(CURSOR(

select *  from table(clob_to_pipeHB('||pLOADING_YEAR||',
                                  '||pLOADING_MONTH||',
                                  ''' ||pPHONE_NUMBER||'''
                                  )) tt
where tt.ch_seiz_dt is not null
and trunc(to_date(tt.ch_seiz_dt, ''yyyymmddhh24miss''), ''mm'')=to_date(''' ||
                        to_char(smonth, 'dd.mm.yyyy') ||
                        ''',''dd.mm.yyyy'')
                        ))) tabs
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
ct.DATA_VOL,ct.CELL_ID,ct.MN_UNLIM,ct.INSERT_DATE) values (t.SUBSCR_NO,t.START_TIME,t.AT_FT_CODE,t.DBF_ID,t.call_cost,t.costnovat,t.dur,t.IMEI,t.ServiceType,t.ServiceDirection,t.IsRoaming,t.RoamingZone,t.CALL_DATE,t.CALL_TIME,t.DURATION,t.DIALED_DIG,t.AT_FT_DE,t.AT_FT_DESC,t.CALLING_NO,t.AT_CHG_AMT,
t.DATA_VOL,t.CELL_ID,t.MN_UNLIM,sysdate)';
      commit;
      HOT_BILLING_PCKG.i_usm_PHONE(pPHONE_NUMBER, smonth);
END;