
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."SAMPLE3_TAB_FNC2T" (pi_row IN sys_refcursor)
return HOT_BIL_TAB PIPELINED AS
pcall_time date;
l_element varchar2(400);
pSUBSCR_NO varchar2(11);
CH_SEIZ_DT varchar2(14);
AT_FT_CODE varchar2(10);
AT_CHG_AMT varchar2(10);
CALLING_NO varchar2(30);
DURATION varchar2(8);
DATA_VOL varchar2(10);
CELL_ID varchar2(10);
DIALED_DIG varchar2(30);
AT_FT_DESC varchar2(300);
flag integer;
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
LOOP
     FETCH pi_row INTO pSUBSCR_NO,CH_SEIZ_DT,AT_FT_CODE,AT_CHG_AMT,CALLING_NO,
DURATION,DATA_VOL,CELL_ID,DIALED_DIG,AT_FT_DESC;
     EXIT WHEN pi_row%NOTFOUND;

select to_date(CH_SEIZ_DT,'yyyymmddhh24miss'),
to_char(to_date(CH_SEIZ_DT,'yyyymmddhh24miss'),'dd.mm.yyyy'||chr(9)||'hh24:mi:ss')||
chr(9)||to_char(to_date(substr(DURATION,-6),'hh24miss'),'hh24:mi:ss')||
chr(9)||decode(DIALED_DIG,pSUBSCR_NO,'',DIALED_DIG)||
chr(9)||nvl((select sv.feature_de from services sv
      where sv.feature_co=AT_FT_CODE),AT_FT_DESC)||
chr(9)||decode(nvl((select sv.descriptio from services sv
      where sv.feature_co=AT_FT_CODE),AT_FT_DESC),'GPRS internet','GPRS-Internet',
      'Звонок на спец номер (О)','исх/доп.сервис','MMS for HLR','MMS',nvl((select sv.descriptio from services sv
      where sv.feature_co=AT_FT_CODE),AT_FT_DESC))||
chr(9)||CALLING_NO||
chr(9)||substr(AT_CHG_AMT,0,decode(instr(AT_CHG_AMT,',00')-1,-1,length(AT_CHG_AMT),instr(AT_CHG_AMT,',00')-1))||
chr(9)||DATA_VOL||
chr(9)||CELL_ID||
chr(9)||nvl((select mn.mn_unlim_group from MN_UNLIM_SERVICES mn
      where mn.feature_co=AT_FT_CODE),0) into pcall_time,l_element from dual;
      select count(1) into flag from hot_billing hb
      where hb.subscr_no=pSUBSCR_NO
      and hb.call_time=pcall_time
      and hb.col_value=l_element;
if flag=0 then
PIPE ROW ( HOT_BIL_TYPE(pSUBSCR_NO,pcall_time,l_element));
end if;
END LOOP;
RETURN;
END;
