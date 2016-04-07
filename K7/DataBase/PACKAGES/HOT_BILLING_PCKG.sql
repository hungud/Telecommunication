CREATE OR REPLACE PACKAGE HOT_BILLING_PCKG AS
  --
--#Version=15
--v.15 Афросин 03.06.2015 Добавил в CalcDetailSumOpt, CalcDetailSum подсчет суммы звонков, загруженных не по API 
--14 2014.12.02 Крайнов. Изменения чтонения XML деталок из API
--Алексеев 05.11.2014 Добавление подсчета полных платных минут(в процедуре  CalcDetailSumOpt).
--v11. 2014.10.30 Бакунов Константин: CalcDetailSumOpt: исключено условие c.call_cost<>0 из (c.servtype=''S'' and c.call_cost<>0) и добалена проверка  на calldirection = 1
--Алексеев 30.10.2014 Добавлена проверка на пустоту соответствующей таблицы CALL (процедура CalcDetailSumOpt)
--v9. 2014.10.24 Бакунов Константин: Добавление количества бесплатных SMS и MMS (в процедуре  CalcDetailSumOpt).
-- 09.09.2014 николаев - добавлено удаление мг\мн состовляющих при перерасчете группировок по детализации
-- Афросин 04.09.2014 - Добавил удаление дубликатов DELETE_DOUBLE_DETAIL в ADD_SITE_DETAIL_API по каждому номеру
-- 6. Уколов. 28.05.14. Вынес SAVE_CALL в HOT_BILLING_SAVE_CALL, удалил GET_CALL_TAB (используем HOT_BILLING_GET_CALL_TAB).
  --V5. 2013.11.23 Николаев Переписана загрузка с сайта минуя HOT_BILLING_TEMP_CALL. Добавлена загрузка с API. Добавлен пересчет стоимости звонка по коэффициенту из тарифа.
  --
  /*v.4 2013.24.10 Safonova CalcDetailSumOpt -
   добавлено в CalcDetailSumOpt исключения дублирования записей по всем полям таблмцы call_<месяц>_<год>
  , кроме AT_FT_CODE,AT_FT_DE,AT_FT_DESCю.Цель - исключение дублей по AT_FT_CODE = UXRUS и UVXLD. Денежные считаются UXRUS*/

  --v3. 2013.08.01 Николаев Добавлены оповещения абонента о прекращении действия пакета GPRS и пакета звонков plus
  --v2. 2013.06.21 Овсянников Добавление в существующий пакет функции CalcDetailSumOpt для оптимизации функции CalcDetailSum

  procedure ADD_SITE_DETAIL(pPHONE_NUMBER  IN VARCHAR2,
                            pLOADING_YEAR  IN VARCHAR2,
                            pLOADING_MONTH IN VARCHAR2);
  procedure ADD_SITE_DETAIL_API(pPHONE_NUMBER  IN VARCHAR2,
                            pLOADING_YEAR  IN VARCHAR2,
                            pLOADING_MONTH IN VARCHAR2);
  FUNCTION GET_HOT_BILLING_MONTH(pYEAR IN INTEGER, pMONTH IN INTEGER)
    RETURN INTEGER;
  FUNCTION MSISDN_REFRESH_UPD(MSISDNs IN VARCHAR2, typeru in number)
    RETURN NUMBER;
  PROCEDURE CalcDetailSum(ssubscr in varchar2, smonth in date);
  PROCEDURE CalcDetailSumOpt(ssubscr in varchar2, smonth in date);
  PROCEDURE i_usm_PHONE(subscr in varchar2, smonth in date);
  PROCEDURE SAVE_CALL_PHONE(pPHONE_LIST_ARRAY IN TPHONE_LIST_ARRAY);
  PROCEDURE SAVE_CALL(modn in integer,

                      resm  in integer,
                      sitef in integer);
  FUNCTION get_last_load_detail(MSISDN IN VARCHAR2,
                                LYEAR  IN VARCHAR2,
                                LMONTH IN VARCHAR2) RETURN date;

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

  PROCEDURE ALARM_PHONE(subscr in varchar2, PDBF_ID in integer) IS
  BEGIN
    HOT_BILLING_ALARM_PHONE(subscr, PDBF_ID);
  END;

  PROCEDURE SAVE_CALL_PHONE(pPHONE_LIST_ARRAY IN TPHONE_LIST_ARRAY) IS
    SDBF_ID integer;
    k       number;
    -- ssubscr_no varchar2(11);
    smonth  date;
    subscrp varchar2(11);
    cursor curnm is
      select htc.subscr_no,
             trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm'),
             count(*)
        from hot_billing_temp_call htc
       where htc.dbf_id = 7529
         and htc.ch_seiz_dt is not null
         and exists
       (select 1
                from TEMP_PHONE_SAVE_CALL_PHONE
               where TEMP_PHONE_SAVE_CALL_PHONE.phone = htc.subscr_no) --EXISTS_PHONE_TAB(htc.subscr_no,pPHONE_LIST_ARRAY)=1
       group by htc.subscr_no,
                trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm');
  BEGIN
    SDBF_ID := 7529;
    FORALL i IN 1 .. pPHONE_LIST_ARRAY.COUNT
      INSERT INTO TEMP_PHONE_SAVE_CALL_PHONE
      VALUES
        (pPHONE_LIST_ARRAY(i).p);
    open curnm;
    loop
      FETCH curnm
        into subscrp, smonth, k;
      EXIT WHEN curnm%NOTFOUND;
      execute immediate 'merge into CALL_' || to_char(smonth, 'mm_yyyy') || ' ct
using (
  select distinct tabs.SUBSCR_NO,tabs.START_TIME,tabs.AT_FT_CODE,tabs.DBF_ID,tabs.call_cost,tabs.costnovat,tabs.dur,tabs.IMEI,tabs.ServiceType,tabs.ServiceDirection,tabs.IsRoaming,tabs.RoamingZone,tabs.CALL_DATE,tabs.CALL_TIME,tabs.DURATION,tabs.DIALED_DIG,tabs.AT_FT_DE,tabs.AT_FT_DESC,tabs.CALLING_NO,tabs.AT_CHG_AMT,
tabs.DATA_VOL,tabs.CELL_ID,tabs.MN_UNLIM from table (HOT_BILLING_GET_CALL_TAB(CURSOR(select * from hot_billing_temp_call htc
where htc.dbf_id=' || SDBF_ID || '
and htc.ch_seiz_dt is not null
and htc.subscr_no=''' || subscrp || '''
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
         and htc.subscr_no = subscrp
         and trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm') =
             smonth;
      commit;
      i_usm_PHONE(subscrp, smonth);
    end loop;
    close curnm;
    for i in pPHONE_LIST_ARRAY.First .. pPHONE_LIST_ARRAY.Last loop
      i_usm_PHONE(pPHONE_LIST_ARRAY(i).p, trunc(sysdate, 'mm'));
    end loop;
  end;

  PROCEDURE SAVE_CALL(modn in integer, resm in integer, sitef in integer) IS
  BEGIN
    HOT_BILLING_SAVE_CALL;
  end;

  PROCEDURE i_usm_PHONE(subscr in varchar2, smonth in date) IS
    flag integer;
  begin
    select count(*)
      into flag
      from hot_billing_usm_PHONE hbu
     where hbu.phone_number = subscr
       and hbu.u_month = smonth;
    if flag = 0 then
      insert into hot_billing_usm_PHONE values (subscr, null, smonth);
      commit;
    end if;
  end;

  PROCEDURE CalcDetailSum(ssubscr in varchar2, smonth in date) IS
    DetailSum              number := 0;
    ZeroCostOutcomeMinutes number := 0;
    ZEROCOST_INBOX_MINUTES number := 0;
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
    sd                     number(1);
    coun                   number;
    scost                  number;
    sdurcm                 number;
    sdurm                  number;
    pCOST_CHNG             number;
    SCOST_CHNG             number := 0;
	  SMSfreeCount           number := 0;
    MMSfreeCount           number := 0;
    curnm                  sys_refcursor;
	  pDB integer;
    pAPI_DBF_ID            Integer;
    vTotalCallsCostWithoutApi              number := 0;
    vSumCallCostWithoutApi number;
  BEGIN
    --проверяем есть ли данные в таблице CALL
    SELECT DB
    INTO pDB 
    FROM HOT_BILLING_MONTH
    WHERE YEAR_MONTH = to_number(to_char(smonth, 'yyyymm'));
  
   IF pDB = 1 THEN
    /* open curnm for 'select \*+index(c CALL_' || to_char(smonth, 'mm_yyyy') || '$subscr#stime$IDX)*\ c.servicetype,decode(c.call_cost,0,0,1),count(*),sum(c.call_cost),
    sum(decode(c.servicetype,''C'',ceil(c.dur/60),''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur)),
    sum(decode(c.servicetype,''C'',c.dur/60,''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur))
     from call_' || to_char(smonth, 'mm_yyyy') || ' c
    where c.start_time>nvl(DB_LOADER_PCKG.GET_PHONE_BALANCE_DATE(c.subscr_no),trunc(sysdate,''mm'')-1/86400)
    and (c.servicetype=''C''
    or (c.servicetype=''S'')
    or (c.servicetype=''U'')
    or c.servicetype=''G''
    or c.servicetype=''W'')
    and c.subscr_no=''' || ssubscr || '''
    group by c.servicetype,decode(c.call_cost,0,0,1)';

    */
    pAPI_DBF_ID := to_number(nvl(MS_CONSTANTS.GET_CONSTANT_VALUE('API_DBF_ID'), '-1'));
    open curnm for 'select /*+index(c CALL_' || to_char(smonth, 'mm_yyyy') || '$subscr#stime$IDX)*/ 
                          c.servicetype,
                          c.servicedirection,
                          decode(c.call_cost,0,0,1),count(*),sum(c.call_cost),
                          sum(c.COST_CHNG),
                          sum(decode(c.servicetype,''C'',ceil(c.dur/60),''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur)),
                          sum(decode(c.servicetype,''C'',c.dur/60,''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur)),
                          sum(decode(c.servtype,''C'', CALLS_COST_WITHOUT_API, 0)) SUM_CALLS_COST_WITHOUT_API
                    from 
                      (
                        select distinct 
                                      subscr_no,
                                      start_time,
                                      dbf_id,
                                      call_cost,
                                      costnovat,
                                      dur,
                                      imei,
                                      servicetype,
                                      servicedirection,
                                      call_date,
                                      call_time,
                                      duration,
                                      dialed_dig,
                                      calling_no,
                                      at_chg_amt,
                                      data_vol,
                                      cell_id,
                                      mn_unlim,
                                      insert_date,
                                      COST_CHNG,
                                      case DBF_ID
                                        when to_number(:pAPI_DBF_ID) then 0
                                      else
                                        call_cost
                                      end CALLS_COST_WITHOUT_API  
                        from call_' || to_char(smonth, 'mm_yyyy') || ' 
                      ) c
                    where 
                      c.start_time>nvl(DB_LOADER_PCKG.GET_PHONE_BALANCE_DATE(c.subscr_no),trunc(sysdate,''mm'')-1/86400)
                      and (c.servicetype=''C''
                      or (c.servicetype=''S'')
                      or (c.servicetype=''U'')
                      or c.servicetype=''G''
                      or c.servicetype=''W'')
                      and c.subscr_no=''' || ssubscr || '''
                  group by c.servicetype,c.servicedirection,decode(c.call_cost,0,0,1)' 
              USING pAPI_DBF_ID;

    loop
      FETCH curnm
        into sst,sd, zf, coun, scost, pCOST_CHNG, sdurcm, sdurm, vSumCallCostWithoutApi;
      EXIT WHEN curnm%NOTFOUND;
      case sst
        when 'C' then
          begin
            if zf = 0 then
              if sd =1 then
               ZeroCostOutcomeMinutes := ZeroCostOutcomeMinutes + sdurcm;
              else
               ZEROCOST_INBOX_MINUTES := ZEROCOST_INBOX_MINUTES + sdurcm;
              end if;
              ZeroCostOutcomeCount   := ZeroCostOutcomeCount + coun;
            else
              CallsCost    := CallsCost + scost;
              CallsMinutes := CallsMinutes + sdurm;
              CallsCount   := CallsCount + coun;
            end if;
            vTotalCallsCostWithoutApi := vTotalCallsCostWithoutApi + nvl(vSumCallCostWithoutApi, 0);
          end;
        when 'S' then
          IF   scost > 0  THEN
              SMSCount := SMSCount + coun;
              SMSCost  := SMSCost + scost;
          ELSE
              IF   sd = 1  THEN
                  SMSfreeCount := SMSfreeCount + coun;
              END IF;
          END IF;
        when 'U' then
           IF   scost > 0  THEN
              MMSCount := MMSCount + coun;
              MMSCost  := MMSCost + scost;
          ELSE
              IF   sd = 1  THEN
                  MMSfreeCount := MMSfreeCount + coun;
              END IF;
          END IF;
        when 'G' then
          InternetMB   := InternetMB + sdurcm;
          InternetCost := InternetCost + scost;
        when 'W' then
          InternetMB   := InternetMB + sdurcm;
          InternetCost := InternetCost + scost;
      end case;
      DetailSum := DetailSum + scost;
      SCOST_CHNG := SCOST_CHNG + nvl(pCOST_CHNG,0);
    end loop;
    close curnm;
    begin
      DB_LOADER_PCKG.SET_DB_LOADER_PHONE_STAT(to_number(to_char(smonth,'yyyy')),
                                              to_number(to_char(smonth,'mm')),
                                              GET_login_BY_PHONE(ssubscr),
                                              ssubscr,
                                              DetailSum,
                                              ZeroCostOutcomeMinutes,
                                              ZeroCostOutcomeCount,
                                              CallsCount,
                                              CallsMinutes,
                                              CallsCost,
                                              SMSCount,
                                              SMSCost,
                                              MMSCount,
                                              MMSCost,
                                              InternetMB,
                                              InternetCost,
                                              round(SCOST_CHNG, 2),
                                              ZEROCOST_INBOX_MINUTES,
                                              0,
                                              0,
                                              0,
                                              SMSfreeCount,
                                              MMSfreeCount,
                                              vTotalCallsCostWithoutApi
                                              );
      commit;
      /*  SET_DB_LOADER_PHONE_STATHB(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),
      GET_login_BY_PHONE(ssubscr),ssubscr,DetailSum,ZeroCostOutcomeMinutes,ZeroCostOutcomeCount,
      CallsCount,CallsMinutes,CallsCost,SMSCount,SMSCost,MMSCount,MMSCost,InternetMB,InternetCost);*/
    exception
      when others then
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
      DB_LOADER_PCKG.SET_MN_UNLIM_VOLUME(to_number(to_char(smonth, 'yyyy')),
                                         to_number(to_char(smonth, 'mm')),
                                         ssubscr,
                                         MnUnlimD,
                                         MnUnlimT,
                                         MnUnlimO);
      commit;
      --SET_MN_UNLIM_VOLUMEHB(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),ssubscr,MnUnlimD,MnUnlimT,MnUnlimO);
    exception
      when others then
        null;
    end;
   END IF;
  end;

  PROCEDURE CalcDetailSumOpt(ssubscr in varchar2, smonth in date) IS
    DetailSum              number := 0;
    ZeroCostOutcomeMinutes number := 0;
    ZEROCOST_INBOX_MINUTES number := 0;
    ZeroCostOutcomeCount   number := 0;
    CallsCost              number := 0;
    CallsMinutes           number := 0;
    CallsCount             number := 0;
    SMSCount               number := 0;
    SMSCost                number := 0;
    MMSCount               number := 0;
    MMSCost                number := 0;
	  SMSfreeCount           number := 0;
    MMSfreeCount           number := 0;
    InternetMB             number := 0;
    InternetCost           number := 0;
    MnUnlimD               number := 0;
    MnUnlimO               number := 0;
    MnUnlimT               number := 0;
    CallBackCost           number := 0;
    CallBackMinutes        number := 0;
    CallBackCount          number := 0;
    sst                    varchar2(2);
    zf                     number(1);
    sd                     number(1);
    coun                   number;
    scost                  number;
    sdurcm                 number;
    sdurm                  number;
    curnm                  sys_refcursor;
    pCOST_CHNG             number;
    SCOST_CHNG             number := 0;
	  CallsFullMinutes      number := 0;
	  pDB integer;
    vTotalCallsCostWithoutApi              number := 0;
    vSumCallCostWithoutApi number;
    pAPI_DBF_ID integer;
BEGIN
    --проверяем есть ли данные в таблице CALL
    SELECT DB
    INTO pDB 
    FROM HOT_BILLING_MONTH
    WHERE YEAR_MONTH = to_number(to_char(smonth, 'yyyymm'));
    
  
  IF pDB = 1 THEN
    /* open curnm for 'select c.servicetype,decode(c.call_cost,0,0,1),count(*),sum(c.call_cost),
    sum(decode(c.servicetype,''C'',ceil(c.dur/60),''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur)),
    sum(decode(c.servicetype,''C'',c.dur/60,''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur))
     from call_' || to_char(smonth, 'mm_yyyy') || ' c
    where c.start_time>(SELECT nvl(DB_LOADER_PCKG.GET_PHONE_BALANCE_DATE(:phone_number),trunc(sysdate,''mm'')-1/86400) FROM DUAL)
    and (c.servicetype=''C''
    or (c.servicetype=''S'')
    or (c.servicetype=''U'')
    or c.servicetype=''G''
    or c.servicetype=''W'')
    and c.subscr_no=:phone_number
    group by c.servicetype,decode(c.call_cost,0,0,1)' USING ssubscr, ssubscr; */
    --19610 v.4
    pAPI_DBF_ID := to_number(nvl(MS_CONSTANTS.GET_CONSTANT_VALUE('API_DBF_ID'), '-1'));
    open curnm for 'select
                      c.servtype,
                      c.servicedirection,
                      decode(c.call_cost,0,0,1),
                      count(*),
                      sum(c.call_cost),
                      sum(c.COST_CHNG),
                      sum(decode(c.servtype,''C'',ceil(c.dur/60),''B'',ceil(c.dur/60),''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur)),
                      sum(decode(c.servtype,''C'',c.dur/60,''B'',c.dur/60,''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur)),
                      sum(decode(c.servtype,''C'',c.CALLS_COST_WITHOUT_API, 0)) SUM_CALLS_COST_WITHOUT_API
                    from 
                        (
                          select distinct subscr_no, 
                                          start_time,
                                          at_ft_code,dbf_id,
                                          call_cost,
                                          costnovat,
                                          dur,
                                          imei,
                                          case at_ft_code
                                            when ''CBIN'' then ''B''
                                            when ''CBOUT'' then ''B''
                                          else
                                            servicetype
                                          end servtype,
                                          servicedirection,
                                          call_date,
                                          call_time,
                                          duration,
                                          dialed_dig,
                                          calling_no,
                                          at_chg_amt,
                                          data_vol,
                                          cell_id,
                                          mn_unlim,
                                          insert_date, 
                                          COST_CHNG,
                                          case DBF_ID
                                            when to_number(:pAPI_DBF_ID) then 0
                                          else
                                            call_cost
                                          end CALLS_COST_WITHOUT_API  
                          from 
                              call_' || to_char(smonth,'mm_yyyy') || ' 
                        ) c
                    where 
                      c.start_time>(SELECT nvl(DB_LOADER_PCKG.GET_PHONE_BALANCE_DATE(:phone_number),trunc(sysdate,''mm'')-1/86400) FROM DUAL)
                      and (c.servtype=''C''
                      or (c.servtype=''S'')
                      or (c.servtype=''U'')
                      or c.servtype=''G''
                      or c.servtype=''W''
                      or c.servtype=''B'')
                      and c.subscr_no=:phone_number
                      and ((c.call_cost=0 and not exists (select 1 from services s
                      where s.feature_co=c.at_ft_code
                      and s.not_use_for_calc=1))
                      or c.call_cost<>0)
                      group by c.servtype,c.servicedirection,decode(c.call_cost,0,0,1)'
      USING pAPI_DBF_ID, ssubscr, ssubscr;

    loop
      FETCH curnm
        into sst,sd, zf, coun, scost, pCOST_CHNG, sdurcm, sdurm, vSumCallCostWithoutApi;
      EXIT WHEN curnm%NOTFOUND;
      
      case sst
        when 'C' then
          begin
            if zf = 0 then
              if sd =1 then
               ZeroCostOutcomeMinutes := ZeroCostOutcomeMinutes + sdurcm;
              else
               ZEROCOST_INBOX_MINUTES := ZEROCOST_INBOX_MINUTES + sdurcm;
              end if;
               ZeroCostOutcomeCount   := ZeroCostOutcomeCount + coun;
            else
              CallsCost    := CallsCost + scost;
              CallsMinutes := CallsMinutes + sdurm;
              CallsFullMinutes := CallsFullMinutes + sdurcm;
              CallsCount   := CallsCount + coun;
            end if;
            vTotalCallsCostWithoutApi := vTotalCallsCostWithoutApi + nvl(vSumCallCostWithoutApi, 0);
          end;
          
        when 'S' then
		  IF scost > 0  THEN
              SMSCount := SMSCount + coun;
              SMSCost  := SMSCost + scost;
          ELSE
              IF   sd = 1  THEN
                  SMSfreeCount := SMSfreeCount + coun;
              END IF;
          END IF;
        when 'U' then
          IF   scost > 0  THEN
              MMSCount := MMSCount + coun;
              MMSCost  := MMSCost + scost;
          ELSE
              IF   sd = 1  THEN
                  MMSfreeCount := MMSfreeCount + coun;
              END IF;
          END IF;
        when 'G' then
          InternetMB   := InternetMB + sdurcm;
          InternetCost := InternetCost + scost;
        when 'W' then
          InternetMB   := InternetMB + sdurcm;
          InternetCost := InternetCost + scost;
        when 'B' then
            CallBackCost    := CallBackCost + scost;
            CallBackMinutes := CallBackMinutes + sdurm;
            CallBackCount   := CallBackCount + coun;
      end case;
      DetailSum  := DetailSum + scost;
      SCOST_CHNG := SCOST_CHNG + nvl(pCOST_CHNG,0);
    end loop;
    close curnm;
    begin
      DB_LOADER_PCKG.SET_DB_LOADER_PHONE_STAT(to_number(to_char(smonth,
                                                                'yyyy')),
                                              to_number(to_char(smonth,
                                                                'mm')),
                                              GET_login_BY_PHONE(ssubscr),
                                              ssubscr,
                                              DetailSum,
                                              ZeroCostOutcomeMinutes,
                                              ZeroCostOutcomeCount,
                                              CallsCount,
                                              CallsMinutes,
                                              CallsCost,
                                              SMSCount,
                                              SMSCost,
                                              MMSCount,
                                              MMSCost,											 
                                              InternetMB,
                                              InternetCost,
                                              round(SCOST_CHNG, 2),
                                              ZEROCOST_INBOX_MINUTES,
                                              CallBackCost,
                                              CallBackMinutes,
                                              CallBackCount/2,
											                        SMSfreeCount,
                                              MMSfreeCount,
											                        CallsFullMinutes,
                                              vTotalCallsCostWithoutApi
                                            );
      commit;
      /*  SET_DB_LOADER_PHONE_STATHB(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),
      GET_login_BY_PHONE(ssubscr),ssubscr,DetailSum,ZeroCostOutcomeMinutes,ZeroCostOutcomeCount,
      CallsCount,CallsMinutes,CallsCost,SMSCount,SMSCost,MMSCount,MMSCost,InternetMB,InternetCost);*/
    exception
      when others then
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
      DB_LOADER_PCKG.SET_MN_UNLIM_VOLUME(to_number(to_char(smonth, 'yyyy')),
                                         to_number(to_char(smonth, 'mm')),
                                         ssubscr,
                                         MnUnlimD,
                                         MnUnlimT,
                                         MnUnlimO);
      commit;
      --SET_MN_UNLIM_VOLUMEHB(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),ssubscr,MnUnlimD,MnUnlimT,MnUnlimO);
    exception
      when others then
        null;
    end;
   END IF;
  end;

  FUNCTION MSISDN_REFRESH_UPD(MSISDNs IN VARCHAR2, typeru in number)
    RETURN NUMBER IS
    RES number(1);
    --#Version=1
  BEGIN
    case typeru
      when 3 then
        begin
          delete MSISDN_REFRESH mr
           where mr.msisdn = MSISDNs
             and mr.typer = 1;
          commit;
          res := 0;
        end;
      when 4 then
        begin
          select count(*)
            into res
            from MSISDN_REFRESH mr
           where mr.msisdn = MSISDNs;
          if res > 0 then
            res := 0;
          else
            res := 1;
          end if;
        end;
      when 5 then
        begin
          delete MSISDN_REFRESH mr where mr.msisdn = MSISDNs;
          commit;
          res := 0;
        end;
      else
        begin
          insert into MSISDN_REFRESH values (MSISDNs, typeru);
          commit;
          res := 0;
        end;
    end case;
    RETURN RES;
  EXCEPTION
    WHEN others THEN
      return 1;
  END;

  --Деталка из файла, загруженного с сайта
  FUNCTION HBclob_to_pipe(year_T  in integer,
                          month_t in integer,
                          phone_t in varchar2) RETURN CALL_TEMP_TAB
    pipelined AS
    line_t   CALL_TEMP_TYPE := CALL_TEMP_TYPE(NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL);
    cl       clob;
    l_amount pls_integer := 1;
    l_length pls_integer;
    token    varchar2(4000);
    sobch    varchar2(4000);
    y        number := 0;
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
        y := y + 1;
        if y >= 3 then
          select phone_t into line_t.subscr_no from dual;
          select to_char(to_date(substr(sobch,
                                        1,
                                        instr(sobch, chr(9), 1, 1) - 1) ||
                                 substr(sobch,
                                        instr(sobch, chr(9), 1, 1) + 1,
                                        instr(sobch, chr(9), 1, 2) -
                                        (instr(sobch, chr(9), 1, 1) + 1)),
                                 'dd.mm.yyyyhh24:mi:ss'),
                         'yyyymmddhh24miss')
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
                                           (instr(sobch, chr(9), 1, 2) + 1)),
                                    ':',
                                    ''),
                     '000000')
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

          select 7529 into line_t.dbf_id from dual;
          select substr(sobch, instr(sobch, chr(9), 1, 9) + 1, 6)
            into line_t.cell_id
            from dual;

          pipe ROW(line_t);
        end if;
        sobch := null;
      elsif i = l_length then
        sobch := sobch || token;
        select phone_t into line_t.subscr_no from dual;
        select to_char(to_date(substr(sobch,
                                      1,
                                      instr(sobch, chr(9), 1, 1) - 1) ||
                               substr(sobch,
                                      instr(sobch, chr(9), 1, 1) + 1,
                                      instr(sobch, chr(9), 1, 2) -
                                      (instr(sobch, chr(9), 1, 1) + 1)),
                               'dd.mm.yyyyhh24:mi:ss'),
                       'yyyymmddhh24miss')
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
                                     (instr(sobch, chr(9), 1, 2) + 1)),
                              ':',
                              '')
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

        select 7529 into line_t.dbf_id from dual;
        select substr(sobch, instr(sobch, chr(9), 1, 9) + 1, 6)
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
    smonth date;
  BEGIN
    --  insert into hot_billing_temp_call
    --    select *
    --      from table(clob_to_pipeHB(to_number(pLOADING_YEAR),
    --                                to_number(pLOADING_MONTH),
    --                               pPHONE_NUMBER));
    -- commit;
    smonth := to_date('01' || pLOADING_MONTH || pLOADING_YEAR, 'ddmmyyyy');
    execute immediate 'merge into CALL_' || to_char(smonth, 'mm_yyyy') || ' ct
using (
  select distinct tabs.SUBSCR_NO,tabs.START_TIME,tabs.AT_FT_CODE,tabs.DBF_ID,tabs.call_cost,tabs.costnovat,tabs.dur,tabs.IMEI,tabs.ServiceType,tabs.ServiceDirection,tabs.IsRoaming,tabs.RoamingZone,tabs.CALL_DATE,tabs.CALL_TIME,tabs.DURATION,tabs.DIALED_DIG,tabs.AT_FT_DE,tabs.AT_FT_DESC,tabs.CALLING_NO,tabs.AT_CHG_AMT,
tabs.DATA_VOL,tabs.CELL_ID,tabs.MN_UNLIM,tabs.cost_chng  from table (HOT_BILLING_GET_CALL_TAB(CURSOR(

select *  from table(clob_to_pipeHB(' || pLOADING_YEAR || ',
                                  ' || pLOADING_MONTH || ',
                                  ''' || pPHONE_NUMBER || '''
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
ct.DATA_VOL,ct.CELL_ID,ct.MN_UNLIM,ct.INSERT_DATE,ct.cost_chng) values (t.SUBSCR_NO,t.START_TIME,t.AT_FT_CODE,t.DBF_ID,t.call_cost,t.costnovat,t.dur,t.IMEI,t.ServiceType,t.ServiceDirection,t.IsRoaming,t.RoamingZone,t.CALL_DATE,t.CALL_TIME,t.DURATION,t.DIALED_DIG,t.AT_FT_DE,t.AT_FT_DESC,t.CALLING_NO,t.AT_CHG_AMT,
t.DATA_VOL,t.CELL_ID,t.MN_UNLIM,sysdate,t.cost_chng)';
    commit;
    i_usm_PHONE(pPHONE_NUMBER, smonth);
  END;

  procedure ADD_SITE_DETAIL_API(pPHONE_NUMBER  IN VARCHAR2,
                                pLOADING_YEAR  IN VARCHAR2,
                                pLOADING_MONTH IN VARCHAR2) IS
    smonth date;
    pvLOADING_MONTH varchar2(4);
    pbsal_id VARCHAR2 (20);
    vSOAP_ANSWER XMLTYPE;
  BEGIN
    if length(pLOADING_MONTH) = 1 then
      pvLOADING_MONTH :='0'||pLOADING_MONTH;
    else
      pvLOADING_MONTH := pLOADING_MONTH;
    end if;
    --  insert into hot_billing_temp_call
    --    select *
    --      from table(clob_to_pipeHB(to_number(pLOADING_YEAR),
    --                                to_number(pLOADING_MONTH),
    --                               pPHONE_NUMBER));
    -- commit;
    pbsal_id := beeline_api_pckg.phone_detail_call(pPHONE_NUMBER);
    --
    DELETE FROM API_GET_UNBILLED_CALLS_LIST;   
    --
    SELECT L.SOAP_ANSWER INTO vSOAP_ANSWER 
      FROM BEELINE_SOAP_API_LOG L
      WHERE L.BSAL_ID = TO_NUMBER (pBSAL_ID);
    --
    INSERT INTO API_GET_UNBILLED_CALLS_LIST(callDate, callNumber, callToNumber, serviceName, callType, dataVolume, callAmt, callDuration)
      SELECT  extractvalue (value(d) ,'/UnbilledCallsList/callDate') callDate
             ,extractvalue (value(d) ,'/UnbilledCallsList/callNumber') callNumber
             ,extractvalue (value(d) ,'/UnbilledCallsList/callToNumber') callToNumber
             ,extractvalue (value(d) ,'/UnbilledCallsList/serviceName') serviceName
             ,extractvalue (value(d) ,'/UnbilledCallsList/callType') callType
             ,extractvalue (value(d) ,'/UnbilledCallsList/dataVolume') dataVolume
             ,extractvalue (value(d) ,'/UnbilledCallsList/callAmt') callAmt
             ,extractvalue (value(d) ,'/UnbilledCallsList/callDuration') callDuration
        FROM TABLE(XmlSequence(vSOAP_ANSWER.extract('S:Envelope/S:Body/ns0:getUnbilledCallsListResponse/UnbilledCallsList',
                                                    'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) D;  
    --
    smonth := to_date('01' || pvLOADING_MONTH || pLOADING_YEAR, 'ddmmyyyy');
    execute immediate 'merge into CALL_' || to_char(smonth, 'mm_yyyy') || ' ct
                        using (select distinct tabs.SUBSCR_NO, tabs.START_TIME, tabs.AT_FT_CODE, tabs.DBF_ID, tabs.call_cost, 
                                      tabs.costnovat, tabs.dur, tabs.IMEI, tabs.ServiceType, tabs.ServiceDirection, 
                                      tabs.IsRoaming, tabs.RoamingZone, tabs.CALL_DATE, tabs.CALL_TIME, tabs.DURATION, 
                                      tabs.DIALED_DIG, tabs.AT_FT_DE, tabs.AT_FT_DESC, tabs.CALLING_NO, tabs.AT_CHG_AMT, 
                                      tabs.DATA_VOL, tabs.CELL_ID, tabs.MN_UNLIM, tabs.cost_chng  
                                 from table (HOT_BILLING_GET_CALL_TAB(CURSOR(SELECT *
                                                                               FROM (SELECT ''' || pPHONE_NUMBER || ''' SUBSCR_NO,
                                                                                            TO_CHAR(CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(UC.callDate), ''yyyymmddhh24miss'') CH_SEIZ_DT,
                                                                                            '''' AT_FT_CODE,
                                                                                            DECODE(REPLACE(UC.callAmt, ''.'', '',''), ''0,0'', ''0'', REPLACE(UC.callAmt, ''.'', '','')) AT_CHG_AMT,
                                                                                            UC.callNumber CALLING_NO,
                                                                                            REGEXP_REPLACE(UC.callDuration, '':'', '''') DURATION,
                                                                                            DECODE(REPLACE(UC.dataVolume, ''.'', '',''), ''0,0'', ''0'', REPLACE(UC.dataVolume, ''.'', '','')) DATA_VOL,
                                                                                            '''' IMEI,
                                                                                            '''' CELL_ID,
                                                                                            DECODE(UC.callToNumber, ''' || pPHONE_NUMBER || ''', '''', UC.callToNumber) DIALED_DIG,
                                                                                            UC.callType AT_FT_DESC,
                                                                                            TO_NUMBER(MS_CONSTANTS.GET_CONSTANT_VALUE (''API_DBF_ID'')) DBF_ID
                                                                                       FROM API_GET_UNBILLED_CALLS_LIST UC) TT
                                                                               where TT.ch_seiz_dt is not null 
                                                                                 and trunc(to_date(TT.ch_seiz_dt, ''yyyymmddhh24miss''), ''mm'')=
                                                                                      to_date(''' || to_char(smonth, 'dd.mm.yyyy') || ''',''dd.mm.yyyy'')
                                             ))) tabs
                              ) t
                          on (ct.subscr_no = t.subscr_no and ct.start_time = t.start_time 
                              and to_number(ct.AT_CHG_AMT,''99999999999D99'','' NLS_NUMERIC_CHARACTERS = '''',.'''''')= 
                                    to_number(t.AT_CHG_AMT, ''99999999999D99'','' NLS_NUMERIC_CHARACTERS = '''',.'''''') 
                              and to_number(ct.DATA_VOL,''99999999999D99'','' NLS_NUMERIC_CHARACTERS = '''',.'''''')=
                                    to_number(t.DATA_VOL,''99999999999D99'','' NLS_NUMERIC_CHARACTERS = '''',.'''''')
                              and ct.dur=t.dur)
                        when not matched then
                          insert (ct.SUBSCR_NO, ct.START_TIME, ct.AT_FT_CODE, ct.DBF_ID, ct.call_cost, 
                                  ct.costnovat, ct.dur, ct.IMEI, ct.ServiceType, ct.ServiceDirection, 
                                  ct.IsRoaming, ct.RoamingZone, ct.CALL_DATE, ct.CALL_TIME, ct.DURATION, 
                                  ct.DIALED_DIG, ct.AT_FT_DE, ct.AT_FT_DESC, ct.CALLING_NO, ct.AT_CHG_AMT, 
                                  ct.DATA_VOL, ct.CELL_ID, ct.MN_UNLIM, ct.INSERT_DATE, ct.cost_chng) 
                            values (t.SUBSCR_NO, t.START_TIME, t.AT_FT_CODE, t.DBF_ID, t.call_cost, 
                                    t.costnovat, t.dur, t.IMEI, t.ServiceType, t.ServiceDirection, 
                                    t.IsRoaming, t.RoamingZone, t.CALL_DATE, t.CALL_TIME, t.DURATION, 
                                    t.DIALED_DIG, t.AT_FT_DE, t.AT_FT_DESC, t.CALLING_NO, t.AT_CHG_AMT, 
                                    t.DATA_VOL,t.CELL_ID,t.MN_UNLIM,sysdate,t.cost_chng)';
    DELETE_DOUBLE_DETAIL(pPHONE_NUMBER);
    commit;
    i_usm_PHONE(pPHONE_NUMBER, smonth);
  END;

  FUNCTION GET_HOT_BILLING_MONTH(pYEAR IN INTEGER, pMONTH IN INTEGER)
    RETURN INTEGER IS
    --Vesion=1
    res integer;
  BEGIN
    select hbm.db
      into res
      from HOT_BILLING_MONTH hbm
     where hbm.year_month = pYEAR * 100 + pMONTH;
    RETURN RES;
  exception
    when others then
      return 0;
  END;

  FUNCTION get_last_load_detail(MSISDN IN VARCHAR2,
                                LYEAR  IN VARCHAR2,
                                LMONTH IN VARCHAR2) RETURN date IS
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