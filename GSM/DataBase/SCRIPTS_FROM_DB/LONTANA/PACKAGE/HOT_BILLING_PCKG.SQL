
  CREATE OR REPLACE PACKAGE "LONTANA"."HOT_BILLING_PCKG" AS
   --
   --#Version=12
   --v12 06.10.2015 Афросин. Поправил пересчет статистики в процедуре SAVE_CALL 
   --v11 02.10.2015 Афросин. Переделал удаление дубликатов только на те данные которые загрузили
   --v10 30.09.2015 Афросин. Переделал разбор таблицы hot_billing_temp_call c выборки по dbf_id на subscr_no 
   --v9 24.04.2015 Крайнов. В екзекьют добавлен параметр, для кэширования запроса.
   --v8 23.03.2015 Афросин. Добавил удаление дубликатов в процедуру SAVE_CALL
   --v7 29.01.2015 Алексеев. Добавлена новая переменная определяющая загрузку, через API  (pUSE_API  = 1) или гор биллинг в функцию HOT_BILLING_GET_CALL_TAB
   --v.6 19.01.2015 Афросин. Не корректно определялся тип звонка при загрузке по API передаем UC.serviceName AT_FT_CODE в HOT_BILLING_GET_CALL_TAB
   --v5. Алексеев 30.10.2014 Добавлена проверка на пустоту соответствующей таблицы CALL (процедура CalcDetailSumOpt)
   --v4. 09.09.2014 Николаев - добавлено удаление мг\мн состовляющих при перерасчете группировок по детализации
   --v3. 2013.08.01 Николаев Добавлены оповещения абонента о прекращении действия пакета GPRS и пакета звонков plus
   --v2. 2013.06.21 Овсянников Добавление в существующий пакет функции CalcDetailSumOpt для оптимизации функции CalcDetailSum
   PROCEDURE ADD_SITE_DETAIL (pPHONE_NUMBER    IN VARCHAR2,
                              pLOADING_YEAR    IN VARCHAR2,
                              pLOADING_MONTH   IN VARCHAR2);

   PROCEDURE ADD_SITE_DETAIL_API (pPHONE_NUMBER    IN VARCHAR2,
                                  pLOADING_YEAR    IN VARCHAR2,
                                  pLOADING_MONTH   IN VARCHAR2);

   FUNCTION GET_HOT_BILLING_MONTH (pYEAR IN INTEGER, pMONTH IN INTEGER)
      RETURN INTEGER;

   FUNCTION GET_CALL_TAB (pi_row IN SYS_REFCURSOR)
      RETURN CALL_TAB
      PIPELINED;

   FUNCTION MSISDN_REFRESH_UPD (MSISDNs IN VARCHAR2, typeru IN NUMBER)
      RETURN NUMBER;

   PROCEDURE CalcDetailSum (ssubscr IN VARCHAR2, smonth IN DATE);

   PROCEDURE CalcDetailSumOpt (ssubscr IN VARCHAR2, smonth IN DATE);

   PROCEDURE i_usm_PHONE (subscr IN VARCHAR2, smonth IN DATE);

   PROCEDURE SAVE_CALL_PHONE (pPHONE_LIST_ARRAY IN TPHONE_LIST_ARRAY);

   PROCEDURE SAVE_CALL (modn IN INTEGER, resm IN INTEGER, sitef IN INTEGER);

   FUNCTION get_last_load_detail (MSISDN   IN VARCHAR2,
                                  LYEAR    IN VARCHAR2,
                                  LMONTH   IN VARCHAR2)
      RETURN DATE;
END HOT_BILLING_PCKG;
CREATE OR REPLACE PACKAGE BODY "LONTANA"."HOT_BILLING_PCKG" AS

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
    flag      integer;
    SMS       varchar2(2000);
    phone_num varchar2(11);
    tarif_id  int;
    cursor curp1 is
      SELECT regexp_substr(str, '[^,]+', 1, level) str
        FROM (SELECT MS_params.GET_PARAM_VALUE('PHONE_NOTICE_ROAM') str
                FROM dual) t
      CONNECT BY instr(str, ',', 1, level - 1) > 0;
    cursor curp is
      SELECT regexp_substr(str, '[^,]+', 1, level) str
        FROM (SELECT MS_params.GET_PARAM_VALUE('PHONE_NOTICE_CALL') str
                FROM dual) t
      CONNECT BY instr(str, ',', 1, level - 1) > 0;
  begin
    select count(*)
      into flag
      from hot_billing_temp_call htc, DB_LOADER_ACCOUNT_PHONES dlp
     where ((Instr(Lower(AT_FT_DESC), 'internet') > 0) or
           (Instr(Lower(AT_FT_DESC), 'gprs') > 0) or
           (Instr(Lower(AT_FT_DESC), 'интернет') > 0) or
           (Instr(Lower(AT_FT_DESC), 'wap') > 0))
       and to_number(substr(AT_CHG_AMT,
                            0,
                            decode(instr(AT_CHG_AMT, ',00') - 1,
                                   -1,
                                   length(AT_CHG_AMT),
                                   instr(AT_CHG_AMT, ',00') - 1)),
                     '999999D99',
                     ' NLS_NUMERIC_CHARACTERS = '',.''') > 0
       and dlp.phone_number = htc.subscr_no
       and dlp.year_month = to_number(substr(htc.ch_seiz_dt, 1, 6))
       and GET_PHONE_TARIFF_ID(Dlp.PHONE_NUMBER,
                               Dlp.CELL_PLAN_CODE,
                               Dlp.LAST_CHECK_DATE_TIME) in
           (SELECT to_number(regexp_substr(str, '[^,]+', 1, level)) str
              FROM (SELECT MS_params.GET_PARAM_VALUE('TP_NOTIFY_GPRS') str
                      FROM dual) t
            CONNECT BY instr(str, ',', 1, level - 1) > 0)
       and htc.subscr_no = subscr
       and htc.dbf_id = PDBF_ID
       and not exists
     (select 1
              from ALARM_PHONE_LOG apl
             where apl.phone = htc.subscr_no
               and trunc(apl.date_insert, 'mm') = trunc(sysdate, 'mm')
               and apl.type_alarm = 1);
    if flag > 0 then
      select GET_PHONE_TARIFF_ID(phone_number, DD.CELL_PLAN_CODE)
        Into tarif_id
        from db_loader_account_phones DD
       where phone_number = subscr
         and year_month = to_char(sysdate, 'YYYYMM');
      if Instr(MS_params.GET_PARAM_VALUE('TP_NOTIFY_GPRS_ISKL'),
               to_char(tarif_id)) > 0 then
        SMS := LOADER3_pckg.SEND_SMS(subscr,
                                     'SMS-info',
                                     MS_params.GET_PARAM_VALUE('MES_NOTIFY_GPRS_ISKL'));
      else
        SMS := LOADER3_pckg.SEND_SMS(subscr,
                                     'SMS-info',
                                     MS_params.GET_PARAM_VALUE('MES_NOTIFY_GPRS'));
      end if;
    
      insert into ALARM_PHONE_LOG values (subscr, null, 1);
      commit;
    end if;
    select count(*)
      into flag
      from hot_billing_temp_call htc, DB_LOADER_ACCOUNT_PHONES dlp
     where Instr(Lower(AT_FT_DESC), 'sms') = 0
       and Instr(Lower(AT_FT_DESC), 'смс') = 0
       and Instr(Lower(AT_FT_DESC), 'короткие сообщения') = 0
       and Instr(Lower(AT_FT_DESC), 'mms') = 0
       and Instr(Lower(AT_FT_DESC), 'ммс') = 0
       and Instr(Lower(AT_FT_DESC), 'internet') = 0
       and Instr(Lower(AT_FT_DESC), 'gprs') = 0
       and Instr(Lower(AT_FT_DESC), 'интернет') = 0
       and Instr(Lower(AT_FT_DESC), 'wap') = 0
       and to_number(substr(AT_CHG_AMT,
                            0,
                            decode(instr(AT_CHG_AMT, ',00') - 1,
                                   -1,
                                   length(AT_CHG_AMT),
                                   instr(AT_CHG_AMT, ',00') - 1)),
                     '999999D99',
                     ' NLS_NUMERIC_CHARACTERS = '',.''') > 0
       and mod(to_number(substr(AT_CHG_AMT,
                                0,
                                decode(instr(AT_CHG_AMT, ',00') - 1,
                                       -1,
                                       length(AT_CHG_AMT),
                                       instr(AT_CHG_AMT, ',00') - 1)),
                         '999999D99',
                         ' NLS_NUMERIC_CHARACTERS = '',.'''),
               5) = 0
       and dlp.phone_number = htc.subscr_no
       and dlp.year_month = to_number(substr(htc.ch_seiz_dt, 1, 6))
       and GET_PHONE_TARIFF_ID(Dlp.PHONE_NUMBER,
                               Dlp.CELL_PLAN_CODE,
                               Dlp.LAST_CHECK_DATE_TIME) in
           (SELECT to_number(regexp_substr(str, '[^,]+', 1, level)) str
              FROM (SELECT MS_params.GET_PARAM_VALUE('TP_NOTIFY_CALL') str
                      FROM dual) t
            CONNECT BY instr(str, ',', 1, level - 1) > 0)
       and htc.subscr_no = subscr
       and htc.dbf_id = PDBF_ID
       and not exists
     (select 1
              from ALARM_PHONE_LOG apl
             where apl.phone = htc.subscr_no
               and trunc(apl.date_insert, 'mm') = trunc(sysdate, 'mm')
               and apl.type_alarm = 2);
    if flag > 0 then
      select count(*)
        into flag
        from hot_billing_temp_call htc, DB_LOADER_ACCOUNT_PHONES dlp
       where Instr(Lower(AT_FT_DESC), 'sms') = 0
         and Instr(Lower(AT_FT_DESC), 'смс') = 0
         and Instr(Lower(AT_FT_DESC), 'короткие сообщения') = 0
         and Instr(Lower(AT_FT_DESC), 'mms') = 0
         and Instr(Lower(AT_FT_DESC), 'ммс') = 0
         and Instr(Lower(AT_FT_DESC), 'internet') = 0
         and Instr(Lower(AT_FT_DESC), 'gprs') = 0
         and Instr(Lower(AT_FT_DESC), 'интернет') = 0
         and Instr(Lower(AT_FT_DESC), 'wap') = 0
         and Instr(nvl((select sv.feature_de
                         from services sv
                        where sv.feature_co = AT_FT_CODE),
                       AT_FT_DESC),
                   'CF') > 0
         and to_number(substr(AT_CHG_AMT,
                              0,
                              decode(instr(AT_CHG_AMT, ',00') - 1,
                                     -1,
                                     length(AT_CHG_AMT),
                                     instr(AT_CHG_AMT, ',00') - 1)),
                       '999999D99',
                       ' NLS_NUMERIC_CHARACTERS = '',.''') > 0
         and mod(to_number(substr(AT_CHG_AMT,
                                  0,
                                  decode(instr(AT_CHG_AMT, ',00') - 1,
                                         -1,
                                         length(AT_CHG_AMT),
                                         instr(AT_CHG_AMT, ',00') - 1)),
                           '999999D99',
                           ' NLS_NUMERIC_CHARACTERS = '',.'''),
                 5) = 0
         and dlp.phone_number = htc.subscr_no
         and dlp.year_month = to_number(substr(htc.ch_seiz_dt, 1, 6))
         and GET_PHONE_TARIFF_ID(Dlp.PHONE_NUMBER,
                                 Dlp.CELL_PLAN_CODE,
                                 Dlp.LAST_CHECK_DATE_TIME) in
             (SELECT to_number(regexp_substr(str, '[^,]+', 1, level)) str
                FROM (SELECT MS_params.GET_PARAM_VALUE('TP_NOTIFY_CALL') str
                        FROM dual) t
              CONNECT BY instr(str, ',', 1, level - 1) > 0)
         and htc.subscr_no = subscr
         and htc.dbf_id = PDBF_ID;
      if flag = 0 then
        open curp;
        loop
          FETCH curp
            into phone_num;
          EXIT WHEN curp%NOTFOUND;
          SMS := LOADER3_pckg.SEND_SMS(phone_num,
                                       'SMS-info',
                                       'У абонента ' || subscr ||
                                       ' закончился пакет plus.');
        end loop;
        close curp;
        insert into ALARM_PHONE_LOG values (subscr, null, 2);
        commit;
      else
        select count(*)
          into flag
          from ALARM_PHONE_LOG apl
         where apl.phone = subscr
           and trunc(apl.date_insert) = trunc(sysdate)
           and apl.type_alarm = 3;
        if flag = 0 then
          SMS := LOADER3_pckg.SEND_SMS(subscr,
                                       'SMS-info',
                                       MS_params.GET_PARAM_VALUE('MES_NOTIFY_CALL'));
          insert into ALARM_PHONE_LOG values (subscr, null, 3);
          commit;
        end if;
      end if;
    end if;
  end;

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
       where htc.dbf_id = 4339
         and htc.ch_seiz_dt is not null
         and exists
       (select 1
                from TEMP_PHONE_SAVE_CALL_PHONE
               where TEMP_PHONE_SAVE_CALL_PHONE.phone = htc.subscr_no) --EXISTS_PHONE_TAB(htc.subscr_no,pPHONE_LIST_ARRAY)=1
       group by htc.subscr_no,
                trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm');
  BEGIN
    SDBF_ID := 4339;
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
tabs.DATA_VOL,tabs.CELL_ID,tabs.MN_UNLIM,tabs.cost_chng from table (HOT_BILLING_GET_CALL_TAB(CURSOR(select * from hot_billing_temp_call htc
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
ct.DATA_VOL,ct.CELL_ID,ct.MN_UNLIM,ct.INSERT_DATE,ct.cost_chng) values (t.SUBSCR_NO,t.START_TIME,t.AT_FT_CODE,t.DBF_ID,t.call_cost,t.costnovat,t.dur,t.IMEI,t.ServiceType,t.ServiceDirection,t.IsRoaming,t.RoamingZone,t.CALL_DATE,t.CALL_TIME,t.DURATION,t.DIALED_DIG,t.AT_FT_DE,t.AT_FT_DESC,t.CALLING_NO,t.AT_CHG_AMT,
t.DATA_VOL,t.CELL_ID,t.MN_UNLIM,sysdate,t.cost_chng)';
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

  PROCEDURE SAVE_CALL(
    modn in integer, 
    resm in integer, 
    sitef in integer
    ) IS
  SDBF_ID integer;
--  k number;
  smonth date;
  v_SUBSCR_NO hot_billing_temp_call.SUBSCR_NO%TYPE;
  
   CURSOR curf_with_MOd IS
    SELECT htc.dbf_id,
           TRUNC (TO_DATE (htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm'),
           HTC.SUBSCR_NO
      FROM hot_billing_temp_call htc
      WHERE htc.ch_seiz_dt IS NOT NULL
       and mod(to_number(HTC.SUBSCR_NO) ,modn) = resm--выборка потока
      GROUP BY htc.dbf_id, TRUNC (TO_DATE (htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm'), HTC.SUBSCR_NO
      ORDER BY 1;
  
  --
  CURSOR curf IS
    SELECT htc.dbf_id,
           TRUNC (TO_DATE (htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm')
      FROM hot_billing_temp_call htc
      WHERE htc.ch_seiz_dt IS NOT NULL
      GROUP BY htc.dbf_id, TRUNC (TO_DATE (htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm')
      ORDER BY 1;    
  
  cursor curnm is
    select /*+index(htc HB_TEMP_CALL$DBF_ID$IDX)*/
           htc.subscr_no
      from hot_billing_temp_call htc
      where htc.dbf_id = SDBF_ID
        and trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm') = smonth
      group by htc.subscr_no;
  TYPE curnmSet IS TABLE OF curnm%ROWTYPE;
  curnmc curnmSet;
  
  BEGIN
    
    if nvl(resm, 0 ) = 0 AND nvl(modn, 1) = 1 then
      --работу в один поток делаем из учета DBF_ID, и месяца
    --
    OPEN curf;
    LOOP
      FETCH curf INTO SDBF_ID, smonth;
        EXIT WHEN curf%NOTFOUND;
      --   
      SELECT htc.subscr_no 
        BULK COLLECT INTO curnmc
        FROM hot_billing_temp_call htc
        WHERE htc.dbf_id = SDBF_ID
          AND TRUNC(TO_DATE(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm') = smonth
        GROUP BY htc.subscr_no;
      --
      EXECUTE IMMEDIATE
        'merge into CALL_' || TO_CHAR (smonth, 'mm_yyyy') || ' ct
           using (select distinct tabs.SUBSCR_NO,tabs.START_TIME,tabs.AT_FT_CODE,tabs.DBF_ID,tabs.call_cost,
                         tabs.costnovat,tabs.dur,tabs.IMEI,tabs.ServiceType,tabs.ServiceDirection,
                         tabs.IsRoaming,tabs.RoamingZone,tabs.CALL_DATE,tabs.CALL_TIME,tabs.DURATION,
                         tabs.DIALED_DIG,tabs.AT_FT_DE,tabs.AT_FT_DESC,tabs.CALLING_NO,tabs.AT_CHG_AMT,
                         tabs.DATA_VOL,tabs.CELL_ID,tabs.MN_UNLIM, tabs.cost_chng  
                    from table(HOT_BILLING_GET_CALL_TAB(CURSOR(select
                                                                  SUBSCR_NO,
                                                                  CH_SEIZ_DT,
                                                                  AT_FT_CODE,
                                                                  AT_CHG_AMT,
                                                                  CALLING_NO,
                                                                  DURATION,
                                                                  DATA_VOL,
                                                                  IMEI,
                                                                  CELL_ID,
                                                                  DIALED_DIG,
                                                                  AT_FT_DESC,
                                                                  DBF_ID 
                                                                 from hot_billing_temp_call htc
                                                                 where htc.dbf_id = :vSDBF_ID
                                                                   and trunc(to_date(htc.ch_seiz_dt, ''yyyymmddhh24miss''), ''mm'')
                                                                     = to_date(''' || TO_CHAR (smonth, 'dd.mm.yyyy') || ''',''dd.mm.yyyy'')
                                                                 order by htc.subscr_no))) tabs) t
             on (ct.subscr_no = t.subscr_no 
                  and ct.start_time = t.start_time 
                  and to_number(ct.AT_CHG_AMT, ''99999999999D99'', '' NLS_NUMERIC_CHARACTERS = '''',.'''''')
                      =to_number(t.AT_CHG_AMT, ''99999999999D99'', '' NLS_NUMERIC_CHARACTERS = '''',.'''''') 
                  and to_number(ct.DATA_VOL, ''99999999999D99'', '' NLS_NUMERIC_CHARACTERS = '''',.'''''')
                      =to_number(t.DATA_VOL, ''99999999999D99'', '' NLS_NUMERIC_CHARACTERS = '''',.'''''') 
                  and ct.dur=t.dur)
           when not matched then
             insert(ct.SUBSCR_NO,ct.START_TIME,ct.AT_FT_CODE,ct.DBF_ID,ct.call_cost,
                    ct.costnovat,ct.dur,ct.IMEI,ct.ServiceType,ct.ServiceDirection,
                    ct.IsRoaming,ct.RoamingZone,ct.CALL_DATE,ct.CALL_TIME,ct.DURATION,
                    ct.DIALED_DIG,ct.AT_FT_DE,ct.AT_FT_DESC,ct.CALLING_NO,ct.AT_CHG_AMT,
                    ct.DATA_VOL,ct.CELL_ID,ct.MN_UNLIM,ct.INSERT_DATE,ct.cost_chng) 
               values(t.SUBSCR_NO,t.START_TIME,t.AT_FT_CODE,t.DBF_ID,t.call_cost,
                      t.costnovat,t.dur,t.IMEI,t.ServiceType,t.ServiceDirection,
                      t.IsRoaming,t.RoamingZone,t.CALL_DATE,t.CALL_TIME,t.DURATION,
                      t.DIALED_DIG,t.AT_FT_DE,t.AT_FT_DESC,t.CALLING_NO,t.AT_CHG_AMT,
                      t.DATA_VOL,t.CELL_ID,t.MN_UNLIM,sysdate,t.cost_chng)'
        USING SDBF_ID;
        commit;
        DELETE_DOUBLE_DETAIL;
--        /*
        FOR i IN curnmc.FIRST .. curnmc.LAST LOOP
--          DELETE_DOUBLE_DETAIL(curnmc(i).subscr_no);
          
          i_usm_PHONE(curnmc(i).subscr_no, smonth);
          --    ALARM_PHONE(curnmc(i).subscr_no,SDBF_ID);
        END LOOP;
        --
--        */
        delete hot_billing_temp_call htc
          where htc.dbf_id = SDBF_ID
            and trunc(to_date(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm') = smonth;
        
        commit;
        --
      end loop;
      --
      close curf;
    else
       --работу в несколько потоков делаем из учета DBF_ID, месяца, и номера телефона
    
      OPEN curf_with_MOd;
      LOOP
        FETCH curf_with_MOd INTO SDBF_ID, smonth, v_SUBSCR_NO;
          EXIT WHEN curf_with_MOd%NOTFOUND;

        EXECUTE IMMEDIATE
          'merge into CALL_' || TO_CHAR (smonth, 'mm_yyyy') || ' ct
             using (select distinct tabs.SUBSCR_NO,tabs.START_TIME,tabs.AT_FT_CODE,tabs.DBF_ID,tabs.call_cost,
                           tabs.costnovat,tabs.dur,tabs.IMEI,tabs.ServiceType,tabs.ServiceDirection,
                           tabs.IsRoaming,tabs.RoamingZone,tabs.CALL_DATE,tabs.CALL_TIME,tabs.DURATION,
                           tabs.DIALED_DIG,tabs.AT_FT_DE,tabs.AT_FT_DESC,tabs.CALLING_NO,tabs.AT_CHG_AMT,
                           tabs.DATA_VOL,tabs.CELL_ID,tabs.MN_UNLIM, tabs.cost_chng
                      from table(HOT_BILLING_GET_CALL_TAB(CURSOR(select 
                                                                    SUBSCR_NO,
                                                                    CH_SEIZ_DT,
                                                                    AT_FT_CODE,
                                                                    AT_CHG_AMT,
                                                                    CALLING_NO,
                                                                    DURATION,
                                                                    DATA_VOL,
                                                                    IMEI,
                                                                    CELL_ID,
                                                                    DIALED_DIG,
                                                                    AT_FT_DESC,
                                                                    DBF_ID 
                                                                  from hot_billing_temp_call htc
                                                                  where htc.dbf_id = :vSDBF_ID
                                                                     and htc.subscr_no = :v_SUBSCR_NO 
                                                                     and trunc(to_date(htc.ch_seiz_dt, ''yyyymmddhh24miss''), ''mm'')
                                                                       = to_date(''' || TO_CHAR (smonth, 'dd.mm.yyyy') || ''',''dd.mm.yyyy'')
                                                                   --order by htc.subscr_no
                                                                   ))) tabs) t
               on (ct.subscr_no = t.subscr_no 
                    and ct.start_time = t.start_time 
                    and to_number(ct.AT_CHG_AMT, ''99999999999D99'', '' NLS_NUMERIC_CHARACTERS = '''',.'''''')
                        =to_number(t.AT_CHG_AMT, ''99999999999D99'', '' NLS_NUMERIC_CHARACTERS = '''',.'''''') 
                    and to_number(ct.DATA_VOL, ''99999999999D99'', '' NLS_NUMERIC_CHARACTERS = '''',.'''''')
                        =to_number(t.DATA_VOL, ''99999999999D99'', '' NLS_NUMERIC_CHARACTERS = '''',.'''''') 
                    and ct.dur=t.dur)
             when not matched then
               insert(ct.SUBSCR_NO,ct.START_TIME,ct.AT_FT_CODE,ct.DBF_ID,ct.call_cost,
                      ct.costnovat,ct.dur,ct.IMEI,ct.ServiceType,ct.ServiceDirection,
                      ct.IsRoaming,ct.RoamingZone,ct.CALL_DATE,ct.CALL_TIME,ct.DURATION,
                      ct.DIALED_DIG,ct.AT_FT_DE,ct.AT_FT_DESC,ct.CALLING_NO,ct.AT_CHG_AMT,
                      ct.DATA_VOL,ct.CELL_ID,ct.MN_UNLIM,ct.INSERT_DATE,ct.cost_chng) 
                 values(t.SUBSCR_NO,t.START_TIME,t.AT_FT_CODE,t.DBF_ID,t.call_cost,
                        t.costnovat,t.dur,t.IMEI,t.ServiceType,t.ServiceDirection,
                        t.IsRoaming,t.RoamingZone,t.CALL_DATE,t.CALL_TIME,t.DURATION,
                        t.DIALED_DIG,t.AT_FT_DE,t.AT_FT_DESC,t.CALLING_NO,t.AT_CHG_AMT,
                        t.DATA_VOL,t.CELL_ID,t.MN_UNLIM,sysdate,t.cost_chng)'
          USING SDBF_ID, v_SUBSCR_NO;
        -- поиск и удаление дублей по АПИ и ГБ
        DELETE_DOUBLE_DETAIL (v_SUBSCR_NO, to_char(smonth, 'mm_yyyy'));    
        --
        HOT_BILLING_PCKG.i_usm_PHONE (v_SUBSCR_NO, smonth);

        DELETE hot_billing_temp_call htc
          WHERE htc.dbf_id = SDBF_ID
            AND TRUNC(TO_DATE(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm') = smonth
            and htc.SUBSCR_NO = v_SUBSCR_NO
            ;
        --    
        --коммит делаем после цикла
        COMMIT;
      END LOOP;
      CLOSE curf_with_MOd;
    end if;
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
    pCOST_CHNG             number;
    SCOST_CHNG             number := 0;
  BEGIN
    open curnm for 'select /*+index(c CALL_' || to_char(smonth, 'mm_yyyy') || '$numsub#stime$IDX)*/ c.servicetype,decode(c.call_cost,0,0,1),count(*),sum(c.call_cost),
    sum(c.COST_CHNG),    
sum(decode(c.servicetype,''C'',ceil(c.dur/60),''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur)),
sum(decode(c.servicetype,''C'',c.dur/60,''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur))
 from call_' || to_char(smonth, 'mm_yyyy') || ' c
where c.start_time>nvl(DB_LOADER_PCKG.GET_PHONE_BALANCE_DATE(''' || ssubscr || '''),trunc(sysdate,''mm'')-1/86400)
and (c.servicetype=''C''
or (c.servicetype=''S'' and c.call_cost<>0)
or (c.servicetype=''U'' and c.call_cost<>0)
or c.servicetype=''G''
or c.servicetype=''W'')
and c.subscr_no=''' || ssubscr || '''
group by c.servicetype,decode(c.call_cost,0,0,1)';
    loop
      FETCH curnm
        into sst, zf, coun, scost, pCOST_CHNG, sdurcm, sdurm;
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
      DetailSum  := DetailSum + scost;
      SCOST_CHNG := SCOST_CHNG + pCOST_CHNG;
    end loop;
    close curnm;
    begin
      DB_LOADER_PCKG.SET_DB_LOADER_PHONE_STAT(to_number(to_char(smonth,
                                                                'yyyy')),
                                              to_number(to_char(smonth,
                                                                'mm')),
                                              GET_login_BY_PHONE(ssubscr),
                                              ssubscr,
                                              round(DetailSum, 2),
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
                                              round(SCOST_CHNG, 2));
      commit;
      /*  SET_DB_LOADER_PHONE_STATHB(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),
      GET_login_BY_PHONE(ssubscr),ssubscr,DetailSum,ZeroCostOutcomeMinutes,ZeroCostOutcomeCount,
      CallsCount,CallsMinutes,CallsCost,SMSCount,SMSCost,MMSCount,MMSCost,InternetMB,InternetCost);*/
    exception
      when others then
        null;
    end;
    if 1 = 2 then
      open curnm for 'select /*+index(c CALL_' || to_char(smonth,
                                                          'mm_yyyy') || '$subscr#MN$IDX)*/ c.mn_unlim,
sum(ceil(c.dur/60)*60) from call_' || to_char(smonth, 'mm_yyyy') || ' c
where c.start_time>=DB_LOADER_PCKG.GET_MN_UNLIM_SDATE(c.subscr_no)
and DB_LOADER_PCKG.GET_MN_UNLIM_SDATE(c.subscr_no)<>to_date(''31.12.1999'',''dd.mm.yyyy'')
and c.mn_unlim<>0
and c.dur>2
and c.subscr_no=' || ssubscr || '
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
        DB_LOADER_PCKG.SET_MN_UNLIM_VOLUME(to_number(to_char(smonth,
                                                             'yyyy')),
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
    end if;
  end;

  PROCEDURE CalcDetailSumOpt(ssubscr in varchar2, smonth in date) IS
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
    pCOST_CHNG             number;
    SCOST_CHNG             number := 0;
    pDB integer;
  BEGIN
  --проверяем есть ли данные в таблице CALL
    SELECT DB
    INTO pDB 
    FROM HOT_BILLING_MONTH
    WHERE YEAR_MONTH = to_number(to_char(smonth, 'yyyymm'));
    --
    IF pDB = 1 THEN
    /*open curnm for 'select \*+index(c CALL_' || to_char(smonth, 'mm_yyyy') || '$numsub#stime$IDX)*\ c.servicetype,decode(c.call_cost,0,0,1),count(*),sum(c.call_cost),
    sum(c.COST_CHNG),
sum(decode(c.servicetype,''C'',ceil(c.dur/60),''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur)),
sum(decode(c.servicetype,''C'',c.dur/60,''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur))
 from call_' || to_char(smonth, 'mm_yyyy') || ' c
where c.start_time>(SELECT nvl(DB_LOADER_PCKG.GET_PHONE_BALANCE_DATE(''' || ssubscr || '''),trunc(sysdate,''mm'')-1/86400) FROM DUAL)
and (c.servicetype=''C''
or (c.servicetype=''S'' and c.call_cost<>0)
or (c.servicetype=''U'' and c.call_cost<>0)
or c.servicetype=''G''
or c.servicetype=''W'')
and c.subscr_no=''' || ssubscr || '''
group by c.servicetype,decode(c.call_cost,0,0,1)';*/
      open curnm for 
        'select /*+ index(c CALL_' || to_char(smonth, 'mm_yyyy') || '$SUBSCR#STIME$IDX) */
                c.servicetype,decode(c.call_cost,0,0,1),count(*),sum(c.call_cost), sum(c.COST_CHNG), 
                sum(decode(c.servicetype,''C'',ceil(c.dur/60),''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur)),
                sum(decode(c.servicetype,''C'',c.dur/60,''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur))
           from call_' || to_char(smonth, 'mm_yyyy') || ' c,
                ((SELECT nvl(DB_LOADER_PCKG.GET_PHONE_BALANCE_DATE( :pSUBSCR_NO1),
                         trunc(sysdate,''mm'')-1/86400) date_start 
                    FROM DUAL)) b
           where c.subscr_no= :pSUBSCR_NO2
             and c.start_time>b.date_start 
             and (c.servicetype=''C''
                  or (c.servicetype=''S'' and c.call_cost<>0) 
                  or (c.servicetype=''U'' and c.call_cost<>0) 
                  or c.servicetype=''G'' 
                  or c.servicetype=''W'')
             and ((c.call_cost=0 
                    and not exists (select 1 
                                      from services s
                                      where s.feature_co=c.at_ft_code
                                        and s.not_use_for_calc=1))
                  or c.call_cost<>0)
           group by c.servicetype,decode(c.call_cost,0,0,1)'
        USING ssubscr, ssubscr;
      loop
        FETCH curnm
          into sst, zf, coun, scost, pCOST_CHNG, sdurcm, sdurm;
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
        DetailSum  := DetailSum + scost;
        SCOST_CHNG := SCOST_CHNG + pCOST_CHNG;
      end loop;
      close curnm;
      begin
        DB_LOADER_PCKG.SET_DB_LOADER_PHONE_STAT(to_number(to_char(smonth, 'yyyy')),
                                                to_number(to_char(smonth, 'mm')),
                                                GET_login_BY_PHONE(ssubscr),
                                                ssubscr,
                                                round(DetailSum, 2),
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
                                                round(SCOST_CHNG, 2));
        commit;
        /*  SET_DB_LOADER_PHONE_STATHB(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),
        GET_login_BY_PHONE(ssubscr),ssubscr,DetailSum,ZeroCostOutcomeMinutes,ZeroCostOutcomeCount,
        CallsCount,CallsMinutes,CallsCost,SMSCount,SMSCost,MMSCount,MMSCost,InternetMB,InternetCost);*/
      exception
        when others then
          null;
      end;
      if 1 = 2 then      
     /* open curnm for 'select \*+index(c CALL_' || to_char(smonth,
                                                          'mm_yyyy') || '$subscr#MN$IDX)*\ c.mn_unlim,
sum(ceil(c.dur/60)*60) from call_' || to_char(smonth, 'mm_yyyy') || ' c
where c.start_time>=DB_LOADER_PCKG.GET_MN_UNLIM_SDATE(c.subscr_no)
and DB_LOADER_PCKG.GET_MN_UNLIM_SDATE(c.subscr_no)<>to_date(''31.12.1999'',''dd.mm.yyyy'')
and c.mn_unlim<>0
and c.dur>2
and c.subscr_no=''' || ssubscr || '''
group by c.mn_unlim';*/
        open curnm for 
          'select /*+ index(c CALL_' || to_char(smonth, 'mm_yyyy') || '$subscr#MN$IDX) */ c.mn_unlim,
                  sum(ceil(c.dur/60)*60) 
             from call_' || to_char(smonth, 'mm_yyyy') || ' c
             where  c.subscr_no= :pSUBSCR_NO
               and c.start_time>=DB_LOADER_PCKG.GET_MN_UNLIM_SDATE(c.subscr_no)
               and DB_LOADER_PCKG.GET_MN_UNLIM_SDATE(c.subscr_no)<>to_date(''31.12.1999'',''dd.mm.yyyy'')
               and c.mn_unlim<>0
               and c.dur>2
             group by c.mn_unlim'
          USING ssubscr;
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
      end if;
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
        
          select 4339 into line_t.dbf_id from dual;
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
      
        select 4339 into line_t.dbf_id from dual;
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
    pvLOADING_MONTH VARCHAR2(10);
    pbsal_id VARCHAR2 (20);
    vSOAP_ANSWER XMLTYPE;
  BEGIN
    if length(pLOADING_MONTH) = 1 then
      pvLOADING_MONTH :='0'||pLOADING_MONTH;
    else
      pvLOADING_MONTH := pLOADING_MONTH;
    end if;
    --
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
                                                                                            UC.serviceName AT_FT_CODE,
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
                                             ), 1)) tabs
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

  function GET_CALL_TAB(pi_row IN sys_refcursor) return CALL_TAB
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
    pcost_chng        number;
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
    pcost_chngf number;
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
             to_char(to_date(substr(pDURATION, -6), 'hh24miss'),
                     'hh24:mi:ss'),
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
             decode(pDATA_VOL, '0', '0,00', pDATA_VOL),
             case
               when length(pCELL_ID) < 2 then
                null
               else
                pCELL_ID
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
    
      if (Instr(Lower(pAT_FT_DE), 'sms') > 0) or
         (Instr(Lower(pAT_FT_DE), 'смс') > 0) or
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
      pcost_chng := 0;
      if pServiceType = 'S' then
        -- Для SMS делаем перерасчёт в GSM-Corp с 2,05 на 2,95
        if (nvl(db_loader_pckg.get_constant_value('RECALC_SMS_2.0532_TO_2.95'),
                0) = 1) and (Round(pcall_cost, 2) = 2.05) then
          pcost_chng := 2.95 - pcall_cost;
          pcall_cost := 2.95;
        end if;
      end if;
      --Ретарификация 
      select count(*)
        into pcost_chngf
        from (SELECT regexp_substr(str, '[^,]+', 1, level) str
                FROM (SELECT MS_params.GET_PARAM_VALUE('HOT_BILL_RETARIF_ACCOUNT_ID') str
                        FROM dual) t
              CONNECT BY instr(str, ',', 1, level - 1) > 0) tt
       where tt.str = to_char(get_account_id_by_phone(pSUBSCR_NO));
      if pcost_chngf > 0 then
        case pServiceType
          when 'S' then
            -- SMS
            if Round(pcall_cost, 2) = 2.95 then
              pcall_cost := 2.5;
              pcost_chng := pcost_chng - 0.45;
            end if;
          when 'C' then
            -- Call
            if InStr(Lower(pAT_FT_DE), 'исх') > 0 then
              if pcall_cost = 0 then
                pcall_cost := round(0.1 * ceil(pdur / 60), 4);
                pcost_chng := pcall_cost;
              else
                if (pcall_cost = 1.3452) or
                   (abs(pcall_cost - (pdur / 60) * 1.3452) < 0.1) then
                  pcost_chng := round(pcall_cost * 1.5 / 1.3452 -
                                      pcall_cost,
                                      4);
                  pcall_cost := round(pcall_cost * 1.5 / 1.3452, 4);
                end if;
              end if;
            end if;
          else
            null;
        end case;
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
                         pMN_UNLIM,
                         pcost_chng));
      --ADate, ATime, ServiceType, ServiceDirection, _
      --             ANumber, Duration, ACost, _
      --           IsRoaming, RoamingZone, AddInfo, SourceLine, _
      --         RowAlreadyLoaded, ABaseStationCode, CostNoVAT
    END LOOP;
    RETURN;
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