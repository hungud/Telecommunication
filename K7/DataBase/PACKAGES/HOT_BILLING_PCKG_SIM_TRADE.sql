CREATE OR REPLACE PACKAGE HOT_BILLING_PCKG AS
procedure ADD_SITE_DETAIL(pPHONE_NUMBER  IN VARCHAR2,
                                                   pLOADING_YEAR  IN VARCHAR2,
                                                   pLOADING_MONTH IN VARCHAR2);
FUNCTION GET_HOT_BILLING_MONTH(pYEAR IN INTEGER,
    pMONTH IN INTEGER
  ) RETURN INTEGER;
PROCEDURE SAVE_CALL_PHONE(pPHONE_LIST_ARRAY IN TPHONE_LIST_ARRAY);
FUNCTION MSISDN_REFRESH_UPD(
  MSISDNs IN VARCHAR2,
  typeru in number
  ) RETURN NUMBER;
PROCEDURE CalcDetailSum(ssubscr in varchar2,
                        smonth  in date);
PROCEDURE i_usm_PHONE(subscr in varchar2,smonth in date);

PROCEDURE SAVE_CALL(modn in integer,

                    resm in integer,
                    sitef in integer);
FUNCTION get_last_load_detail(MSISDN IN VARCHAR2,
                                                LYEAR  IN VARCHAR2,
                                                LMONTH IN VARCHAR2)
  RETURN date;
END HOT_BILLING_PCKG;
/
CREATE OR REPLACE PACKAGE BODY HOT_BILLING_PCKG AS

function pEXISTS_PHONE_TAB(pphone            in varchar2,
                                            pPHONE_LIST_ARRAY in TPHONE_LIST_ARRAY)
  return varchar2 is

BEGIN
  FOR i IN pPHONE_LIST_ARRAY.FIRST .. pPHONE_LIST_ARRAY.LAST LOOP
    if pPHONE_LIST_ARRAY(i).p = pphone then
      return '1';
    end if;
  END LOOP;
  return '0';
END;

PROCEDURE SAVE_CALL_PHONE(pPHONE_LIST_ARRAY IN TPHONE_LIST_ARRAY) IS
  SDBF_ID    integer;
  k          number;
 -- ssubscr_no varchar2(11);
  smonth     date;
  subscrp varchar2(11);
  cursor curnm is
    select htc.subscr_no,trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm'),count(*)
      from hot_billing_temp_call htc
     where htc.dbf_id = 7529
     and htc.ch_seiz_dt is not null
     and EXISTS_PHONE_TAB(htc.subscr_no,pPHONE_LIST_ARRAY)=1
     group by htc.subscr_no,trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm');
BEGIN
  SDBF_ID :=7529;
  open curnm;
  loop
    FETCH curnm
      into subscrp, smonth, k;
    EXIT WHEN curnm%NOTFOUND;
    execute immediate 'merge into CALL_' || to_char(smonth, 'mm_yyyy') || ' ct
using (
  select distinct tabs.SUBSCR_NO,tabs.START_TIME,tabs.AT_FT_CODE,tabs.DBF_ID,tabs.call_cost,tabs.costnovat,tabs.dur,tabs.IMEI,tabs.ServiceType,tabs.ServiceDirection,tabs.IsRoaming,tabs.RoamingZone,tabs.CALL_DATE,tabs.CALL_TIME,tabs.DURATION,tabs.DIALED_DIG,tabs.AT_FT_DE,tabs.AT_FT_DESC,tabs.CALLING_NO,tabs.AT_CHG_AMT,
tabs.DATA_VOL,tabs.CELL_ID,tabs.MN_UNLIM from table (HOT_BILLING_PCKG.GET_CALL_TAB(CURSOR(select * from hot_billing_temp_call htc
where htc.dbf_id=' || SDBF_ID || '
and htc.ch_seiz_dt is not null
and htc.subscr_no='''||subscrp||'''
and trunc(to_date(htc.ch_seiz_dt, ''yyyymmddhh24miss''), ''mm'')=to_date(''' ||
                      to_char(smonth, 'dd.mm.yyyy') ||
                      ''',''dd.mm.yyyy'')))) tabs
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
    delete hot_billing_temp_call htc
     where htc.dbf_id = SDBF_ID
     and htc.subscr_no=subscrp
       and trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm') =
           smonth;
    commit;
      i_usm_PHONE(subscrp, smonth);
  end loop;
  close curnm;
  for i in pPHONE_LIST_ARRAY.First .. pPHONE_LIST_ARRAY.Last loop
      i_usm_PHONE(pPHONE_LIST_ARRAY(i).p, trunc(sysdate,'mm'));
  end loop;
end;

PROCEDURE SAVE_CALL(modn in integer,
                    resm in integer,
                    sitef in integer) IS
  SDBF_ID    integer;
  k          number;
 -- ssubscr_no varchar2(11);
  smonth     date;
  cursor curf is
    select htc.dbf_id,
           trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm'),
           count(*)
      from hot_billing_temp_call htc
     where mod(htc.dbf_id, modn) = resm
     and htc.ch_seiz_dt is not null
     and ((htc.dbf_id<>7529 and sitef=0) or (htc.dbf_id=7529 and sitef=1))
     group by htc.dbf_id,
              trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm')
     order by 1;
  cursor curnm is
    select htc.subscr_no, count(*)
      from hot_billing_temp_call htc
     where htc.dbf_id = SDBF_ID
       and trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm') =
           smonth
     group by htc.subscr_no;
  TYPE curnmSet IS TABLE OF curnm%ROWTYPE;
  curnmc curnmSet;
BEGIN
  open curf;
  loop
    FETCH curf
      into SDBF_ID, smonth, k;
    EXIT WHEN curf%NOTFOUND;
    select htc.subscr_no, count(*) BULK COLLECT
      INTO curnmc
      from hot_billing_temp_call htc
     where htc.dbf_id = SDBF_ID
       and trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm') =
           smonth
     group by htc.subscr_no;
    execute immediate 'merge into CALL_' || to_char(smonth, 'mm_yyyy') || ' ct
using (
  select distinct tabs.SUBSCR_NO,tabs.START_TIME,tabs.AT_FT_CODE,tabs.DBF_ID,tabs.call_cost,tabs.costnovat,tabs.dur,tabs.IMEI,tabs.ServiceType,tabs.ServiceDirection,tabs.IsRoaming,tabs.RoamingZone,tabs.CALL_DATE,tabs.CALL_TIME,tabs.DURATION,tabs.DIALED_DIG,tabs.AT_FT_DE,tabs.AT_FT_DESC,tabs.CALLING_NO,tabs.AT_CHG_AMT,
tabs.DATA_VOL,tabs.CELL_ID,tabs.MN_UNLIM from table (HOT_BILLING_PCKG.GET_CALL_TAB(CURSOR(select * from hot_billing_temp_call htc
where htc.dbf_id=' || SDBF_ID || '
and htc.ch_seiz_dt is not null
and trunc(to_date(htc.ch_seiz_dt, ''yyyymmddhh24miss''), ''mm'')=to_date(''' ||
                      to_char(smonth, 'dd.mm.yyyy') ||
                      ''',''dd.mm.yyyy'')))) tabs
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
    delete hot_billing_temp_call htc
     where htc.dbf_id = SDBF_ID
       and trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm') =
           smonth;
    commit;
    FOR i IN curnmc.FIRST .. curnmc.LAST LOOP
      i_usm_PHONE(curnmc(i).subscr_no, smonth);
    END LOOP;
  end loop;

  close curf;
end;


PROCEDURE i_usm_PHONE(subscr in varchar2,smonth in date) IS
  flag integer;
begin
  select count(*)
    into flag
    from hot_billing_usm_PHONE hbu
   where hbu.phone_number = subscr
   and hbu.u_month=smonth;
  if flag = 0 then
    insert into hot_billing_usm_PHONE values (subscr, null,smonth);
    commit;
  end if;
end;

PROCEDURE CalcDetailSum(ssubscr in varchar2,
                                                      smonth  in date) IS
  DetailSum              number := 0;
  ZeroCostOutcomeMinutes number := 0;
  ZeroCostOutcomeCount   number := 0;
  CallsCost              number := 0;
  CallsMinutes           number := 0;
  CallsCount             number := 0;
  SMSCount               number := 0;
  SMSCost                number := 0;
  MMSCount               number := 0;
  MMSCost                number := 0;
  InternetMB             number := 0;
  InternetCost           number := 0;
  MnUnlimD               number := 0;
  MnUnlimO               number := 0;
  MnUnlimT               number := 0;
  sst                    varchar2(2);
  zf                     number(1);
  coun                   number;
  scost                  number;
  sdurcm                 number;
  sdurm                  number;
  curnm                  sys_refcursor;
BEGIN
  open curnm for 'select /*+index(c CALL_' || to_char(smonth, 'mm_yyyy') || '$subscr#stime$IDX)*/ c.servicetype,decode(c.call_cost,0,0,1),count(*),sum(c.call_cost),
sum(decode(c.servicetype,''C'',ceil(c.dur/60),''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur)),
sum(decode(c.servicetype,''C'',c.dur/60,''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur))
 from call_' || to_char(smonth, 'mm_yyyy') || ' c
where c.start_time>nvl(DB_LOADER_PCKG.GET_PHONE_BALANCE_DATE(c.subscr_no),trunc(sysdate,''mm'')-1/86400)
and (c.servicetype=''C''
or (c.servicetype=''S'' and c.call_cost<>0)
or (c.servicetype=''U'' and c.call_cost<>0)
or c.servicetype=''G''
or c.servicetype=''W'')
and c.subscr_no=''' || ssubscr || '''
group by c.servicetype,decode(c.call_cost,0,0,1)';
  loop
    FETCH curnm
      into sst, zf, coun, scost, sdurcm, sdurm;
    EXIT WHEN curnm%NOTFOUND;
    case sst
      when 'C' then
        if zf = 0 then
          ZeroCostOutcomeMinutes := ZeroCostOutcomeMinutes + sdurcm;
          ZeroCostOutcomeCount   := ZeroCostOutcomeCount + coun;
        else
          CallsCost    := CallsCost + scost;
          CallsMinutes := CallsMinutes + sdurm;
          CallsCount   := CallsCount + coun;
        end if;
      when 'S' then
        SMSCount := SMSCount + coun;
        SMSCost  := SMSCost + scost;
      when 'U' then
        MMSCount := MMSCount + coun;
        MMSCost  := MMSCost + scost;
      when 'G' then
        InternetMB   := InternetMB + sdurcm;
        InternetCost := InternetCost + scost;
      when 'W' then
        InternetMB   := InternetMB + sdurcm;
        InternetCost := InternetCost + scost;
    end case;
    DetailSum := DetailSum + scost;
  end loop;
  close curnm;
  begin
  DB_LOADER_PCKG.SET_DB_LOADER_PHONE_STAT(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),
  GET_login_BY_PHONE(ssubscr),ssubscr,DetailSum,ZeroCostOutcomeMinutes,ZeroCostOutcomeCount,
  CallsCount,CallsMinutes,CallsCost,SMSCount,SMSCost,MMSCount,MMSCost,InternetMB,InternetCost);
  commit;
/*  SET_DB_LOADER_PHONE_STATHB(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),
  GET_login_BY_PHONE(ssubscr),ssubscr,DetailSum,ZeroCostOutcomeMinutes,ZeroCostOutcomeCount,
  CallsCount,CallsMinutes,CallsCost,SMSCount,SMSCost,MMSCount,MMSCost,InternetMB,InternetCost);*/
  exception when others then
    null;
  end;
  open curnm for 'select /*+index(c CALL_' || to_char(smonth, 'mm_yyyy') || '$subscr#MN$IDX)*/ c.mn_unlim,
sum(ceil(c.dur/60)*60) from call_' || to_char(smonth, 'mm_yyyy') || ' c
where c.start_time>=DB_LOADER_PCKG.GET_MN_UNLIM_SDATE(c.subscr_no)
and DB_LOADER_PCKG.GET_MN_UNLIM_SDATE(c.subscr_no)<>to_date(''31.12.1999'',''dd.mm.yyyy'')
and c.mn_unlim<>0
and c.dur>2
and c.subscr_no=''' || ssubscr || '''
group by c.mn_unlim';
  loop
    FETCH curnm
      into zf, sdurm;
    EXIT WHEN curnm%NOTFOUND;
    case zf
      when 1 then
        --2000
        MnUnlimD := MnUnlimD + sdurm;
      when 2 then
        --300
        MnUnlimT := MnUnlimT + sdurm;
      when 3 then
        --150
        MnUnlimO := MnUnlimO + sdurm;
    end case;
  end loop;
  close curnm;
  begin
  DB_LOADER_PCKG.SET_MN_UNLIM_VOLUME(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),ssubscr,MnUnlimD,MnUnlimT,MnUnlimO);
  commit;
  --SET_MN_UNLIM_VOLUMEHB(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),ssubscr,MnUnlimD,MnUnlimT,MnUnlimO);
  exception when others then
    null;
  end;
end;

FUNCTION MSISDN_REFRESH_UPD(
  MSISDNs IN VARCHAR2,
  typeru in number
  ) RETURN NUMBER IS
  RES number(1);
--#Version=1
BEGIN
  case typeru
    when 3 then
      begin
        delete MSISDN_REFRESH mr
        where mr.msisdn=MSISDNs
        and mr.typer=1;
        commit;
        res:=0;
      end;
    when 4 then
      begin
        select count(*) into res from MSISDN_REFRESH mr
        where mr.msisdn=MSISDNs;
        if res>0 then
          res:=0;
        else
          res:=1;
        end if;
      end;
      when 5 then
      begin
        delete MSISDN_REFRESH mr
        where mr.msisdn=MSISDNs;
        commit;
        res:=0;
      end;
    else
      begin
        insert into MSISDN_REFRESH values(MSISDNs,typeru);
        commit;
        res:=0;
      end;
  end case;
  RETURN RES;
EXCEPTION WHEN others THEN
  return 1;
END;

--Деталка из файла, загруженного с сайта
FUNCTION HBclob_to_pipe(year_T  in integer,
                                        month_t in integer,
                                        phone_t in varchar2)
  RETURN CALL_TEMP_TAB
  pipelined AS
  line_t   CALL_TEMP_TYPE := CALL_TEMP_TYPE(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
  cl       clob;
  l_amount pls_integer := 1;
  l_length pls_integer;
  token    varchar2(4000);
  sobch    varchar2(4000);
  y number :=0;
BEGIN
  select LOADER3_PCKG.GET_SITE_PHONE_DETAIL(year_T, month_t, phone_t)
    into cl
    from dual;
  l_length := dbms_lob.getlength(cl);
  for i in 1 .. l_length loop
    dbms_lob.read(lob_loc => cl,
                  amount  => l_amount,
                  offset  => i,
                  buffer  => token);
   if (token = chr(10)) /*or (token = chr(13)) */
     then
       y:=y+1;
      if y>=3 then
      select phone_t
        into line_t.subscr_no
        from dual;
      select to_char(to_date(substr(sobch,
                            1,
                            instr(sobch, chr(9), 1, 1) - 1) ||
                     substr(sobch,
                            instr(sobch, chr(9), 1, 1) + 1,
                            instr(sobch, chr(9), 1, 2) -
                            (instr(sobch, chr(9), 1, 1) + 1)),'dd.mm.yyyyhh24:mi:ss'),'yyyymmddhh24miss')
        into line_t.ch_seiz_dt
        from dual;

       select substr(sobch,
                              instr(sobch, chr(9), 1, 7) + 1,
                              instr(sobch, chr(9), 1, 8) -
                              (instr(sobch, chr(9), 1, 7) + 1))
        into line_t.at_chg_amt
        from dual;

      select substr(sobch,
                              instr(sobch, chr(9), 1, 6) + 1,
                              instr(sobch, chr(9), 1, 7) -
                              (instr(sobch, chr(9), 1, 6) + 1))
        into line_t.calling_no
        from dual;

          select nvl(regexp_replace(substr(sobch,
                              instr(sobch, chr(9), 1, 2) + 1,
                              instr(sobch, chr(9), 1, 3) -
                              (instr(sobch, chr(9), 1, 2) + 1)),':',''),'000000')
        into line_t.duration
        from dual;

          select substr(sobch,
                              instr(sobch, chr(9), 1, 8) + 1,
                              instr(sobch, chr(9), 1, 9) -
                              (instr(sobch, chr(9), 1, 8) + 1))
        into line_t.data_vol
        from dual;

        select substr(sobch,
                              instr(sobch, chr(9), 1, 3) + 1,
                              instr(sobch, chr(9), 1, 4) -
                              (instr(sobch, chr(9), 1, 3) + 1))
        into line_t.dialed_dig
        from dual;
        select substr(sobch,
                              instr(sobch, chr(9), 1, 4) + 1,
                              instr(sobch, chr(9), 1, 5) -
                              (instr(sobch, chr(9), 1, 4) + 1))
        into line_t.at_ft_desc
        from dual;

        select 7529
        into line_t.dbf_id
        from dual;
        select substr(sobch,
                              instr(sobch, chr(9), 1, 9) + 1,
                              6)
        into line_t.cell_id
        from dual;

        pipe ROW(line_t);
      end if;
      sobch := null;
    elsif i = l_length then
      sobch := sobch || token;
      select phone_t
        into line_t.subscr_no
        from dual;
      select to_char(to_date(substr(sobch,
                            1,
                            instr(sobch, chr(9), 1, 1) - 1) ||
                     substr(sobch,
                            instr(sobch, chr(9), 1, 1) + 1,
                            instr(sobch, chr(9), 1, 2) -
                            (instr(sobch, chr(9), 1, 1) + 1)),'dd.mm.yyyyhh24:mi:ss'),'yyyymmddhh24miss')
        into line_t.ch_seiz_dt
        from dual;

       select substr(sobch,
                              instr(sobch, chr(9), 1, 7) + 1,
                              instr(sobch, chr(9), 1, 8) -
                              (instr(sobch, chr(9), 1, 7) + 1))
        into line_t.at_chg_amt
        from dual;

      select substr(sobch,
                              instr(sobch, chr(9), 1, 6) + 1,
                              instr(sobch, chr(9), 1, 7) -
                              (instr(sobch, chr(9), 1, 6) + 1))
        into line_t.calling_no
        from dual;

          select regexp_replace(substr(sobch,
                              instr(sobch, chr(9), 1, 2) + 1,
                              instr(sobch, chr(9), 1, 3) -
                              (instr(sobch, chr(9), 1, 2) + 1)),':','')
        into line_t.duration
        from dual;

          select substr(sobch,
                              instr(sobch, chr(9), 1, 8) + 1,
                              instr(sobch, chr(9), 1, 9) -
                              (instr(sobch, chr(9), 1, 8) + 1))
        into line_t.data_vol
        from dual;

        select substr(sobch,
                              instr(sobch, chr(9), 1, 3) + 1,
                              instr(sobch, chr(9), 1, 4) -
                              (instr(sobch, chr(9), 1, 3) + 1))
        into line_t.dialed_dig
        from dual;
        select substr(sobch,
                              instr(sobch, chr(9), 1, 4) + 1,
                              instr(sobch, chr(9), 1, 5) -
                              (instr(sobch, chr(9), 1, 4) + 1))
        into line_t.at_ft_desc
        from dual;

        select 7529
        into line_t.dbf_id
        from dual;
        select substr(sobch,
                              instr(sobch, chr(9), 1, 9) + 1,
                              6)
        into line_t.cell_id
        from dual;

        pipe ROW(line_t);
    else
      sobch := sobch || token;
    end if;
  end loop;
  RETURN;
END;

procedure ADD_SITE_DETAIL(pPHONE_NUMBER  IN VARCHAR2,
                                                   pLOADING_YEAR  IN VARCHAR2,
                                                   pLOADING_MONTH IN VARCHAR2) IS
BEGIN
insert into hot_billing_temp_call select * from table(clob_to_pipeHB(to_number(pLOADING_YEAR),to_number(pLOADING_MONTH),pPHONE_NUMBER));
commit;
END;

FUNCTION GET_HOT_BILLING_MONTH(pYEAR IN INTEGER,
    pMONTH IN INTEGER
  ) RETURN INTEGER IS
--Vesion=1
res integer;
BEGIN
  select hbm.db into res from HOT_BILLING_MONTH hbm
  where hbm.year_month=pYEAR*100+pMONTH;
  RETURN RES;
exception when others then
  return 0;
END;

function GET_CALL_TAB(pi_row IN sys_refcursor)
  return CALL_TAB
  PIPELINED AS
  pstart_time       date;
  pSUBSCR_NO        varchar2(11);
  pCH_SEIZ_DT       varchar2(16);
  pAT_FT_CODE       varchar2(6);
  pAT_CHG_AMT       varchar2(14);
  pCALLING_NO       varchar2(21);
  pDURATION         varchar2(8);
  pDATA_VOL         varchar2(14);
  pCELL_ID          varchar2(6);
  pDIALED_DIG       varchar2(21);
  pAT_FT_DESC       varchar2(240);
  pIMEI             varchar2(15);
  pDBF_ID           INTEGER;
  pcall_cost        number;
  pCostNoVAT        number;
  pCALL_DATE        varchar2(10);
  pCALL_TIME        varchar2(8);
  pdur              number;
  pAT_FT_DE         varchar2(240);
  pMN_UNLIM         number(1);
  pServiceType      varchar2(1);
  pServiceDirection number(1);
  pIsRoaming        varchar2(1);
  pRoamingZone      varchar2(6);
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  LOOP
    FETCH pi_row
      INTO pSUBSCR_NO,
           pCH_SEIZ_DT,
           pAT_FT_CODE,
           pAT_CHG_AMT,
           pCALLING_NO,
           pDURATION,
           pDATA_VOL,
           pIMEI,
           pCELL_ID,
           pDIALED_DIG,
           pAT_FT_DESC,
           pDBF_ID;
    EXIT WHEN pi_row%NOTFOUND;

    select to_date(pCH_SEIZ_DT, 'yyyymmddhh24miss'),
           --AT_FT_CODE,
           to_number(substr(pAT_CHG_AMT,
                            0,
                            decode(instr(pAT_CHG_AMT, ',00') - 1,
                                   -1,
                                   length(pAT_CHG_AMT),
                                   instr(pAT_CHG_AMT, ',00') - 1)),
                     '999999D99',
                     ' NLS_NUMERIC_CHARACTERS = '',.'''),
           to_char(to_date(pCH_SEIZ_DT, 'yyyymmddhh24miss'), 'dd.mm.yyyy'),
           to_char(to_date(pCH_SEIZ_DT, 'yyyymmddhh24miss'), 'hh24:mi:ss'),
           to_char(to_date(substr(pDURATION, -6), 'hh24miss'), 'hh24:mi:ss'),
           to_number(substr(pDURATION, -6, 2)) * 3600 +
           to_number(substr(pDURATION, -4, 2)) * 60 +
           to_number(substr(pDURATION, -2, 2)),
           decode(pDIALED_DIG, pSUBSCR_NO, '', pDIALED_DIG),
           nvl((select sv.feature_de
                 from services sv
                where sv.feature_co = pAT_FT_CODE),
               pAT_FT_DESC),
           decode(nvl((select sv.descriptio
                        from services sv
                       where sv.feature_co = pAT_FT_CODE),
                      pAT_FT_DESC),
                  'GPRS internet',
                  'GPRS-Internet',
                  'Звонок на спец номер (О)',
                  'исх/доп.сервис',
                  'MMS for HLR',
                  'MMS',
                  nvl((select sv.descriptio
                        from services sv
                       where sv.feature_co = pAT_FT_CODE),
                      pAT_FT_DESC)),
           --CALLING_NO,
           substr(pAT_CHG_AMT,
                  0,
                  decode(instr(pAT_CHG_AMT, ',00') - 1,
                         -1,
                         length(pAT_CHG_AMT),
                         instr(pAT_CHG_AMT, ',00') - 1)),
           decode(pDATA_VOL,'0','0,00',pDATA_VOL),
           case when length(pCELL_ID)<2 then null
             else pCELL_ID
               end CELL_ID,
           nvl((select mn.mn_unlim_group
                 from MN_UNLIM_SERVICES mn
                where mn.feature_co = pAT_FT_CODE),
               0)
    --DBF_ID
      into pstart_time,
           pCostNoVAT,
           pCALL_DATE,
           pCALL_TIME,
           pDURATION,
           pdur,
           pDIALED_DIG,
           pAT_FT_DE,
           pAT_FT_DESC,
           pAT_CHG_AMT,
           pDATA_VOL,
           pCELL_ID,
           pMN_UNLIM
      from dual;

    if (Instr(Lower(pAT_FT_DE), 'sms') > 0) or (Instr(Lower(pAT_FT_DE), 'смс') > 0) or
       (Instr(Lower(pAT_FT_DESC), 'короткие сообщения') > 0) then
      pServiceType := 'S';
    elsif (Instr(pAT_FT_DE, 'MMS') > 0) or (Instr(pAT_FT_DE, 'ММС') > 0) then
      pServiceType := 'U';
    elsif (Instr(Lower(pAT_FT_DESC), 'internet') > 0) or
          (Instr(Lower(pAT_FT_DESC), 'gprs') > 0) or
          (Instr(Lower(pAT_FT_DESC), 'интернет') > 0) then
      pServiceType := 'G';
    elsif Instr(Lower(pAT_FT_DESC), 'wap') > 0 then
      pServiceType := 'W';
    else
      pServiceType := 'C'; -- Звонки
    end if;
    if Instr(pAT_FT_DE, '(РЕГ)') > 0 then
      -- Роуминг
      pIsRoaming   := '1';
      pRoamingZone := 'РФ';
    elsif Instr(pAT_FT_DE, 'БиЛайн СНГ') > 0 then
      -- Роуминг
      pIsRoaming   := '1';
      pRoamingZone := 'СНГ';
    else
      -- Роуминга нет
      pIsRoaming   := '';
      pRoamingZone := '';
    end if;
    if pSUBSCR_NO = pCALLING_NO then
      pServiceDirection := '1'; -- Исходящий
      --                ANumber = pDIALED_DIG
    else
      pServiceDirection := '2'; -- Входящий
      --                ANumber = CALLING_NO
    end if;

    case pServiceType
      when 'G' then
        -- Интернет-GPRS
        pdur := to_number(pDATA_VOL,
                          '999999D99',
                          ' NLS_NUMERIC_CHARACTERS = '',.''') * 1024; -- Из Мб в Кб
      when 'W' then
        -- WAP
        pdur := to_number(pDATA_VOL,
                          '999999D99',
                          ' NLS_NUMERIC_CHARACTERS = '',.''');
      else
        null;
    end case;
    -- Добавим НДС к стоимости
    pcall_cost := pCostNoVAT * 1.18;
    if pServiceType = 'S' then
      -- Для SMS делаем перерасчёт в GSM-Corp с 2,05 на 2,95
      if (nvl(db_loader_pckg.get_constant_value('RECALC_SMS_2.0532_TO_2.95'),
              0) = 1) and (Round(pcall_cost, 2) = 2.05) then
        pcall_cost := 2.95;
      end if;
    end if;

    PIPE ROW(CALL_TYPE(pSUBSCR_NO,
                       pstart_time,
                       pAT_FT_CODE,
                       pDBF_ID,
                       pcall_cost,
                       pCostNoVAT,
                       pdur,
                       pIMEI,
                       pServiceType,
                       pServiceDirection,
                       pIsRoaming,
                       pRoamingZone,
                       pCALL_DATE,
                       pCALL_TIME,
                       pDURATION,
                       pDIALED_DIG,
                       trim(pAT_FT_DE),
                       trim(pAT_FT_DESC),
                       pCALLING_NO,
                       pAT_CHG_AMT,
                       pDATA_VOL,
                       trim(pCELL_ID),
                       pMN_UNLIM));
    --ADate, ATime, ServiceType, ServiceDirection, _
    --             ANumber, Duration, ACost, _
    --           IsRoaming, RoamingZone, AddInfo, SourceLine, _
    --         RowAlreadyLoaded, ABaseStationCode, CostNoVAT
  END LOOP;
  RETURN;
END;

FUNCTION get_last_load_detail(MSISDN IN VARCHAR2,
                                                LYEAR  IN VARCHAR2,
                                                LMONTH IN VARCHAR2)
  RETURN date IS
  RES date;
  --#Version=1
BEGIN
  select dlp.last_check_date_time
    into res
    from db_loader_phone_stat dlp
   where dlp.phone_number = MSISDN
     and dlp.year_month = to_number(LYEAR || LMONTH);
  RETURN RES;
EXCEPTION
  WHEN others THEN
    return to_date('31.12.2000', 'dd.mm.yyyy');
END;

END;
/