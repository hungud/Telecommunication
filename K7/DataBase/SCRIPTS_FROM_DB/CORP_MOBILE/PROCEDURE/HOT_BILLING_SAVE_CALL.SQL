
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HOT_BILLING_SAVE_CALL" (
  nMOD_NUM in number default 0,--модуль потока
  nMOD in number default 1--потоки

) IS
--#Version=6
--
-- v.6 02.06.2015. Афросин.Поправил: Если коичество потоков =1 и номер потока = 0,  то идем по старому алгоритму
-- v.5 27.05.2015. Афросин. Добавил поддержку потоков с разбиением по номерам
-- v.4 22.04.2015. Крайнов. Переделал екзек в екзек с параметром.
-- v.3 Афросин 26.03.015 убрал процедуру HOT_BILLING_ALARM_PHONE (curnmc (i), SDBF_ID); в  HOT_BILLING_LOAD_DBF   
-- Переносит детализации из hot_billing_temp_call в CALL_MM_YYYY
-- Также запускает пересчет балансов по загруженным номерам и предупреждения
--
  SDBF_ID INTEGER;
  -- ssubscr_no varchar2(11);
  smonth DATE;
  v_SUBSCR_NO hot_billing_temp_call.SUBSCR_NO%TYPE;
--
  CURSOR curf_with_MOd IS
    SELECT htc.dbf_id,
           TRUNC (TO_DATE (htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm'),
           HTC.SUBSCR_NO
      FROM hot_billing_temp_call htc
      WHERE htc.ch_seiz_dt IS NOT NULL
       and mod(to_number(HTC.SUBSCR_NO) ,nMOD) = nMOD_NUM--выборка потока
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
      
  TYPE curnmSet IS TABLE OF hot_billing_temp_call.SUBSCR_NO%TYPE INDEX BY BINARY_INTEGER;
--
  curnmc curnmSet;
  
BEGIN
  --
  if nvl(nMOD_NUM, 0 ) = 0 AND nvl(nMOD, 1) = 1 then
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
                         tabs.DATA_VOL,tabs.CELL_ID,tabs.MN_UNLIM, tabs.cost_chng, tabs.PROV_ID ROAMING_PROVIDER_ID  
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
                                                                  DBF_ID,
                                                                  PROV_ID 
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
                    ct.DATA_VOL,ct.CELL_ID,ct.MN_UNLIM,ct.INSERT_DATE,ct.cost_chng, ct.ROAMING_PROVIDER_ID) 
               values(t.SUBSCR_NO,t.START_TIME,t.AT_FT_CODE,t.DBF_ID,t.call_cost,
                      t.costnovat,t.dur,t.IMEI,t.ServiceType,t.ServiceDirection,
                      t.IsRoaming,t.RoamingZone,t.CALL_DATE,t.CALL_TIME,t.DURATION,
                      t.DIALED_DIG,t.AT_FT_DE,t.AT_FT_DESC,t.CALLING_NO,t.AT_CHG_AMT,
                      t.DATA_VOL,t.CELL_ID,t.MN_UNLIM,sysdate,t.cost_chng, t.ROAMING_PROVIDER_ID)'
        USING SDBF_ID;
      -- поиск и удаление дублей по АПИ и ГБ
      --  DELETE_DOUBLE_DETAIL;
      --    commit;
      FOR i IN curnmc.FIRST .. curnmc.LAST
      LOOP
        DELETE_DOUBLE_DETAIL (curnmc (i));
      END LOOP;
      --
      FOR i IN curnmc.FIRST .. curnmc.LAST
      LOOP
        HOT_BILLING_PCKG.i_usm_PHONE (curnmc (i), smonth);
        --перенесена в загрузку файлов HOT_BILLING_LOAD_DBF
        --HOT_BILLING_ALARM_PHONE (curnmc (i), SDBF_ID);
      END LOOP;
      --
      DELETE hot_billing_temp_call htc
        WHERE htc.dbf_id = SDBF_ID
          AND TRUNC(TO_DATE(htc.ch_seiz_dt, 'yyyymmddhh24miss'), 'mm') = smonth;
      --    
      COMMIT;
    END LOOP;
    CLOSE curf;
    --
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
                         tabs.DATA_VOL,tabs.CELL_ID,tabs.MN_UNLIM, tabs.cost_chng, tabs.PROV_ID ROAMING_PROVIDER_ID 
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
                                                                  DBF_ID,
                                                                  PROV_ID  
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
                    ct.DATA_VOL,ct.CELL_ID,ct.MN_UNLIM,ct.INSERT_DATE,ct.cost_chng, ct.ROAMING_PROVIDER_ID ) 
               values(t.SUBSCR_NO,t.START_TIME,t.AT_FT_CODE,t.DBF_ID,t.call_cost,
                      t.costnovat,t.dur,t.IMEI,t.ServiceType,t.ServiceDirection,
                      t.IsRoaming,t.RoamingZone,t.CALL_DATE,t.CALL_TIME,t.DURATION,
                      t.DIALED_DIG,t.AT_FT_DE,t.AT_FT_DESC,t.CALLING_NO,t.AT_CHG_AMT,
                      t.DATA_VOL,t.CELL_ID,t.MN_UNLIM,sysdate,t.cost_chng, t.ROAMING_PROVIDER_ID)'
        USING SDBF_ID, v_SUBSCR_NO;
      -- поиск и удаление дублей по АПИ и ГБ
      DELETE_DOUBLE_DETAIL (v_SUBSCR_NO);    
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
  --
END;