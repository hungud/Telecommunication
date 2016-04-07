CREATE OR REPLACE PACKAGE HOT_BILLING_PCKG_KOK AS
  --
--#Version=2
--2. 2016.02.02. Крайнов. Чистка пакета.
--
  procedure ADD_SITE_DETAIL(
    pPHONE_NUMBER  IN VARCHAR2,
    pLOADING_YEAR  IN VARCHAR2,
    pLOADING_MONTH IN VARCHAR2
    );
--    
  FUNCTION GET_HOT_BILLING_MONTH(
    pYEAR IN INTEGER, 
    pMONTH IN INTEGER
    ) RETURN INTEGER;
--    
  FUNCTION get_last_load_detail(
    MSISDN IN VARCHAR2,
    LYEAR  IN VARCHAR2,
    LMONTH IN VARCHAR2
    ) RETURN date;
--
  FUNCTION HOT_BILLING_GET_CALL_TAB(
    pi_row IN sys_refcursor
    ) return CALL_TAB_V2 PIPELINED;
--
  PROCEDURE HOT_BILLING_SAVE_CALL(
    pDBF_ID IN INTEGER
    );
--
  FUNCTION HOT_BILLING_GET_RETARIFFING(
    CALL_ROW IN CALL_TYPE_V2, 
    pCOST_KOEF IN NUMBER
    ) return CALL_TYPE_V2;

  PROCEDURE LOAD_HOT_BILLING(
    pSTREAM IN INTEGER DEFAULT 0
    );
--    
END;
/
CREATE OR REPLACE PACKAGE BODY HOT_BILLING_PCKG_KOK AS
--
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
--
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
  END;
--
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
--
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
--
  PROCEDURE HOT_BILLING_LOAD_DBF(
    pDBF_ID IN INTEGER
    ) IS
  BEGIN
    FOR rec IN (SELECT ROWID, HBF.FILE_NAME, HBF.HBF_ID
                  FROM HOT_BILLING_FILES HBF
                  WHERE HBF.HBF_ID = pDBF_ID)
    LOOP
      UPDATE HOT_BILLING_FILES hbf
        SET hbf.DATE_START = SYSDATE
        WHERE HBF.HBF_ID = rec.HBF_ID;
      COMMIT;
      dbase_pkg.load_table (
         p_dir        => 'DBF_FILES_COPY_DBF',
         p_file       => rec.FILE_NAME,
         p_tname      => 'HOT_BILLING_CALLS_READING',
         p_dbf_id     => rec.HBF_ID,
         p_cnames     => 'SUBSCR_NO,CH_SEIZ_DT,US_SEQ_N,AT_SOC,AT_FT_CODE,PC_PLAN_CD,C_ACT_CD,AT_CHG_AMT,CALLING_NO,MESSAGE_TP,SRV_FT_CD,DURATION,DATA_VOL,IMEI,CELL_ID,PROV_ID,DIALED_DIG,UOM,DISCT_SOCS,AT_FT_DESC',
         p_colnames   => 'SUBSCR_NO,CH_SEIZ_DT,US_SEQ_N,AT_SOC,AT_FT_CODE,PC_PLAN_CD,C_ACT_CD,AT_CHG_AMT,CALLING_NO,MESSAGE_TP,SRV_FT_CD,DURATION,DATA_VOL,IMEI,CELL_ID,PROV_ID,DIALED_DIG,UOM,DISCT_SOCS,AT_FT_DESC',
         p_show       => FALSE);
      --Удаляем записи которые не коррекны
      UPDATE HOT_BILLING_FILES hbf
        SET hbf.DATE_END = SYSDATE, 
            HBF.COUNT_LOADING = nvl(HBF.COUNT_LOADING, 0) + 1
        WHERE HBF.HBF_ID = rec.HBF_ID;
      -- Оправляем номера на подсчет статистики     
      /*for rec in (select distinct subscr_no  
                    from hot_billing_temp_call 
                    where dbf_id = hbf_idp)
      loop
        HOT_BILLING_ALARM_PHONE(rec.subscr_no, hbf_idp);     
      end loop;*/
      COMMIT;
    END LOOP;
  END;
--
  PROCEDURE UPDATE_REFS_HB_TEMP_UNSORT(
    pDBF_ID IN INTEGER
    ) IS
  PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
  /*  -- Обновим СПРАВОЧНИК HOT_BILLING_CALL_UOM
    MERGE INTO HOT_BILLING_CALL_UOM HC
      USING (SELECT DISTINCT HU.UOM
               FROM HOT_BILLING_CALLS_READING HU
               WHERE HU.DBF_ID = pDBF_ID
                 AND LENGTH(HU.SUBSCR_NO) = 10
                 AND HU.UOM IS NOT NULL) HB
        ON (HC.UOM = HB.UOM )  
      WHEN MATCHED THEN  
        UPDATE SET HC.DATE_LAST_UPDATE = SYSDATE  
      WHEN NOT MATCHED THEN 
        INSERT(HC.UOM) VALUES(HB.UOM);   
    COMMIT; */
    null;
  /*  -- Обновим СПРАВОЧНИК HOT_BILLING_CALL_C_ACT_CD
    MERGE INTO HOT_BILLING_CALL_C_ACT_CD HC
      USING (SELECT DISTINCT HU.C_ACT_CD
               FROM HOT_BILLING_CALLS_READING HU
               WHERE HU.DBF_ID = pDBF_ID
                 AND LENGTH(HU.SUBSCR_NO) = 10
                 AND HU.C_ACT_CD IS NOT NULL) HB
        ON (HC.C_ACT_CD = HB.C_ACT_CD )  
      WHEN MATCHED THEN  
        UPDATE SET HC.DATE_LAST_UPDATE = SYSDATE  
      WHEN NOT MATCHED THEN 
        INSERT(HC.C_ACT_CD) VALUES(HB.C_ACT_CD);   
    COMMIT; */  
    null;
    -- Обновим СПРАВОЧНИК HOT_BILLING_CALL_MESSAGE_TP
  /*  MERGE INTO HOT_BILLING_CALL_MESSAGE_TP HC
      USING (SELECT DISTINCT HU.MESSAGE_TP
               FROM HOT_BILLING_CALLS_READING HU
               WHERE HU.DBF_ID = pDBF_ID
                 AND LENGTH(HU.SUBSCR_NO) = 10
                 AND HU.MESSAGE_TP IS NOT NULL) HB
        ON (HC.MESSAGE_TP = HB.MESSAGE_TP )  
      WHEN MATCHED THEN  
        UPDATE SET HC.DATE_LAST_UPDATE = SYSDATE  
      WHEN NOT MATCHED THEN 
        INSERT(HC.MESSAGE_TP) VALUES(HB.MESSAGE_TP);   
    COMMIT; */   
    null;  
    -- Обновим СПРАВОЧНИК HOT_BILLING_CALL_SRV_FT_CD
    MERGE INTO HOT_BILLING_CALL_SRV_FT_CD HC
      USING (SELECT DISTINCT HU.SRV_FT_CD
               FROM HOT_BILLING_CALLS_READING HU
               WHERE HU.DBF_ID = pDBF_ID
                 AND LENGTH(HU.SUBSCR_NO) = 10
                 AND HU.SRV_FT_CD IS NOT NULL) HB
        ON (HC.SRV_FT_CD = HB.SRV_FT_CD)  
      WHEN MATCHED THEN  
        UPDATE SET HC.DATE_LAST_UPDATE = SYSDATE  
      WHEN NOT MATCHED THEN 
        INSERT(HC.SRV_FT_CD) VALUES(HB.SRV_FT_CD);  
    -- Обновим СПРАВОЧНИК HOT_BILLING_CALL_AT_FT_CODE
    --  Обновим актуальность описания и дату
    MERGE INTO HOT_BILLING_CALL_AT_FT_CODE HC
      USING (SELECT DISTINCT HU.AT_FT_CODE, TRIM(HU.AT_FT_DESC) AT_FT_DESC
               FROM HOT_BILLING_CALLS_READING HU
               WHERE HU.DBF_ID = pDBF_ID
                 AND LENGTH(HU.SUBSCR_NO) = 10
                 AND HU.AT_FT_CODE IS NOT NULL
                 AND HU.AT_FT_DESC IS NOT NULL) HB
        ON (HC.AT_FT_CODE = HB.AT_FT_CODE)  
      WHEN MATCHED THEN  
        UPDATE SET HC.DATE_LAST_UPDATE = SYSDATE,
                   HC.AT_FT_DESC = HB.AT_FT_DESC  
      WHEN NOT MATCHED THEN 
        INSERT(HC.AT_FT_CODE, HC.AT_FT_DESC) 
          VALUES(HB.AT_FT_CODE, HB.AT_FT_DESC);  
    -- Обновим СПРАВОЧНИК HOT_BILLING_CALL_PROV_ID 
    MERGE INTO HOT_BILLING_CALL_PROV_ID HC
      USING (SELECT DISTINCT HU.PROV_ID
               FROM HOT_BILLING_CALLS_READING HU
               WHERE HU.DBF_ID = pDBF_ID
                 AND LENGTH(HU.SUBSCR_NO) = 10
                 AND HU.PROV_ID IS NOT NULL) HB
        ON (HC.PROV_ID = HB.PROV_ID)  
      WHEN MATCHED THEN  
        UPDATE SET HC.DATE_LAST_UPDATE = SYSDATE  
      WHEN NOT MATCHED THEN 
        INSERT(HC.PROV_ID) 
          VALUES(HB.PROV_ID);   
    COMMIT;      
  END;    
--
  PROCEDURE SORTING_ERROR_CALLS(
    pDBF_ID IN INTEGER
    ) IS    
  PRAGMA AUTONOMOUS_TRANSACTION;
    vSUBSCR_NO NUMBER(11);
    vCH_SEIZ_DT DATE;
    vUS_SEQ_N NUMBER(9);
    vAT_CHG_AMT NUMBER(11, 2);
    vDATA_VOL NUMBER(11, 2);
    vIMEI NUMBER(15);
    vCELL_ID NUMBER(6);
    vITOG BOOLEAN;
  BEGIN 
    FOR line IN (SELECT HU.*, HU.ROWID
                   FROM HOT_BILLING_CALLS_READING HU
                   WHERE HU.DBF_ID = pDBF_ID)
    LOOP 
      vITOG:=FALSE;        
      -- Проверяем возможна ли смена типа данных           
      BEGIN
        vSUBSCR_NO:=TO_NUM(line.SUBSCR_NO);
        vCH_SEIZ_DT:=TO_DATE(line.CH_SEIZ_DT, 'YYYYMMDDHH24MISS');
        vUS_SEQ_N:=TO_NUM(line.US_SEQ_N);
        vAT_CHG_AMT:=TO_NUM(line.AT_CHG_AMT);
        vDATA_VOL:=TO_NUM(line.DATA_VOL);
        vIMEI:=TO_NUM(line.IMEI);
        vCELL_ID:=TO_NUM(line.CELL_ID);
      EXCEPTION
        WHEN OTHERS THEN
          vITOG:=TRUE;
      END;
      -- Проверяем на пустые данные
      IF (line.AT_FT_CODE IS NULL) 
          OR (line.AT_FT_DESC IS NULL) 
          OR (line.SRV_FT_CD IS NULL) 
          OR (LENGTH(line.SUBSCR_NO) <> 10)THEN
        vITOG:=TRUE;
      END IF;
      -- Переносим в ошибки, если строка некорректна
      IF vITOG THEN
        INSERT INTO HOT_BILLING_CALLS_ERROR(
                 DBF_ID, SUBSCR_NO, CH_SEIZ_DT, US_SEQ_N, AT_SOC, AT_FT_CODE, 
                 PC_PLAN_CD, C_ACT_CD, AT_CHG_AMT, CALLING_NO, MESSAGE_TP, 
                 SRV_FT_CD, DURATION, DATA_VOL, IMEI, CELL_ID, 
                 PROV_ID, DIALED_DIG, UOM, DISCT_SOCS, AT_FT_DESC)
          SELECT HU.DBF_ID, HU.SUBSCR_NO, HU.CH_SEIZ_DT, US_SEQ_N, HU.AT_SOC, HU.AT_FT_CODE, 
                 HU.PC_PLAN_CD, HU.C_ACT_CD, HU.AT_CHG_AMT, HU.CALLING_NO, HU.MESSAGE_TP, 
                 HU.SRV_FT_CD, HU.DURATION, HU.DATA_VOL, HU.IMEI, HU.CELL_ID, 
                 HU.PROV_ID, HU.DIALED_DIG, HU.UOM, HU.DISCT_SOCS, HU.AT_FT_DESC
            FROM HOT_BILLING_CALLS_READING HU
            WHERE HU.ROWID = line.ROWID;
        DELETE 
          FROM HOT_BILLING_CALLS_READING HU
          WHERE HU.ROWID = line.ROWID;
        COMMIT;
      END IF;
    END LOOP;
    COMMIT;
  END;
--
  PROCEDURE SORTING_DUPLICATE_CALLS(
    pDBF_ID IN INTEGER,
    pMONTHS IN DATE
    ) IS
  PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    EXECUTE IMMEDIATE
      'INSERT INTO HOT_BILLING_CALLS_DUPLICATE(
               DBF_ID, SUBSCR_NO, CH_SEIZ_DT, US_SEQ_N, AT_SOC, AT_FT_CODE, 
               PC_PLAN_CD, C_ACT_CD, AT_CHG_AMT, CALLING_NO, MESSAGE_TP, 
               SRV_FT_CD, DURATION, DATA_VOL, IMEI, CELL_ID, PROV_ID, 
               DIALED_DIG, UOM, DISCT_SOCS, CALL_COST, DUR, MN_UNLIM)
        SELECT IC.DBF_ID, IC.SUBSCR_NO, IC.CH_SEIZ_DT, IC.US_SEQ_N, IC.AT_SOC, IC.AT_FT_CODE, 
               IC.PC_PLAN_CD, IC.C_ACT_CD, IC.AT_CHG_AMT, IC.CALLING_NO, IC.MESSAGE_TP, 
               IC.SRV_FT_CD, IC.DURATION, IC.DATA_VOL, IC.IMEI, IC.CELL_ID, IC.PROV_ID, 
               IC.DIALED_DIG, IC.UOM, IC.DISCT_SOCS, IC.CALL_COST, IC.DUR, IC.MN_UNLIM
          FROM HOT_BILLING_CALLS_INSERTING IC,
               CALL_' || TO_CHAR (pMONTHS, 'YYYY_MM') || ' C
          WHERE IC.DBF_ID = :vDBF_ID
            AND C.SUBSCR_NO = IC.SUBSCR_NO
            AND C.CH_SEIZ_DT = IC.CH_SEIZ_DT
            AND C.US_SEQ_N = IC.US_SEQ_N'
      USING pDBF_ID;
    COMMIT;                      
  END;
--
  FUNCTION HOT_BILLING_GET_CALL_TAB(
    pi_row IN sys_refcursor
    ) return CALL_TAB_V2 PIPELINED AS
--
  pDBF_ID     INTEGER;
  pSUBSCR_NO  NUMBER(11);
  pCH_SEIZ_DT DATE;
  pUS_SEQ_N   NUMBER(9);
  pAT_SOC     VARCHAR2(9 BYTE);
  pAT_FT_CODE VARCHAR2(6 BYTE);
  pPC_PLAN_CD VARCHAR2(9 BYTE);
  pC_ACT_CD   VARCHAR2(1 BYTE);
  pAT_CHG_AMT NUMBER(11, 2);
  pCALLING_NO VARCHAR2(21 BYTE);
  pMESSAGE_TP VARCHAR2(1 BYTE);
  pSRV_FT_CD  VARCHAR2(6 BYTE);
  pDURATION   VARCHAR2(8 BYTE);
  pDATA_VOL   NUMBER(11, 2);
  pIMEI       NUMBER(15);
  pCELL_ID    NUMBER(6);
  pPROV_ID    VARCHAR2(8 BYTE);
  pDIALED_DIG VARCHAR2(21 BYTE);
  pUOM        VARCHAR2(2 BYTE);
  pDISCT_SOCS VARCHAR2(100 BYTE);
  pCALL_COST  number;
  pDUR        number;
  pMN_UNLIM   number(1);
  pCOST_KOEF  number;
  vCOUNT INTEGER;
  TYPE T_MN_UNLIM_SERVICES_CACHE IS TABLE OF VARCHAR2(1000) index by MN_UNLIM_SERVICES.FEATURE_CO%TYPE;
  TYPE T_TARIFF_KOEFF_CACHE IS TABLE OF NUMBER index by TARIFFS.TARIFF_CODE%TYPE;
  MN_UNLIM_SERVICES_CACHE T_MN_UNLIM_SERVICES_CACHE;
  TARIFFS_CALC_KOEFF_CACHE T_TARIFF_KOEFF_CACHE;
  vSUBSCR_NO VARCHAR2(10);
  CALL_ROW CALL_TYPE_V2;
  --PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  -- Заполняем кэш
  FOR rec IN (SELECT feature_co, NVL(MN.MN_UNLIM_GROUP, 0) MN_UNLIM_GROUP
                from MN_UNLIM_SERVICES mn) 
  LOOP
    MN_UNLIM_SERVICES_CACHE(rec.feature_co) := rec.MN_UNLIM_GROUP;
  END LOOP;
  FOR rec IN (SELECT DISTINCT TR.TARIFF_CODE FROM TARIFFS TR 
                WHERE TR.CALC_KOEFF_DETAL IS NOT NULL AND TR.CALC_KOEFF_DETAL <> 1) 
  LOOP
    TARIFFS_CALC_KOEFF_CACHE(rec.TARIFF_CODE) := 4/3;
  END LOOP;
  --  
  LOOP
    FETCH pi_row INTO pDBF_ID, pSUBSCR_NO, pCH_SEIZ_DT, pUS_SEQ_N, pAT_SOC, pAT_FT_CODE, 
      pPC_PLAN_CD, pC_ACT_CD, pAT_CHG_AMT, pCALLING_NO, pMESSAGE_TP, pSRV_FT_CD,
      pDURATION, pDATA_VOL, pIMEI, pCELL_ID, pPROV_ID, pDIALED_DIG, pUOM, pDISCT_SOCS; 
    EXIT WHEN pi_row%NOTFOUND;
    --    
    BEGIN
      IF TARIFFS_CALC_KOEFF_CACHE.EXISTS(pPC_PLAN_CD) THEN
        SELECT NVL(TR.CALC_KOEFF_DETAL, 1) INTO pCOST_KOEF
          FROM DB_LOADER_ABONENT_PERIODS D, TARIFFS TR
          WHERE D.YEAR_MONTH = TO_NUMBER(TO_CHAR(pCH_SEIZ_DT, 'YYYYMM'))
            AND D.PHONE_NUMBER = pSUBSCR_NO
            AND D.BEGIN_DATE <= TRUNC(pCH_SEIZ_DT)
            AND D.END_DATE >= TRUNC(pCH_SEIZ_DT)
            AND D.TARIFF_ID = TR.TARIFF_ID(+);
      ELSE
        pCOST_KOEF:=1;
      END IF;            
    EXCEPTION
      WHEN OTHERS THEN
        pCOST_KOEF:=1;
    END;
    /*pdur := to_number(substr(pDURATION, -6, 2)) * 3600 
          + to_number(substr(pDURATION, -4, 2)) * 60 
          + to_number(substr(pDURATION, -2, 2));
    pDURATION := to_char(to_date(substr(pDURATION, -6), 'hh24miss'),'hh24:mi:ss');
    IF LENGTH(pCELL_ID) < 2 THEN
      pCELL_ID:=NULL;
    END IF;  */
    IF MN_UNLIM_SERVICES_CACHE.EXISTS(pAT_FT_CODE) THEN  
      pMN_UNLIM:= MN_UNLIM_SERVICES_CACHE(pAT_FT_CODE);
    ELSE
      pMN_UNLIM:=0;
    END IF;
    -- Добавим НДС к стоимости
    pCALL_COST := pAT_CHG_AMT * TO_NUM(MS_CONSTANTS.GET_CONSTANT_VALUE('VAT')); --- НДС        
    
    vSUBSCR_NO := pSUBSCR_NO;
    
--    -- Обработка MNP
--    IF (MS_CONSTANTS.GET_CONSTANT_VALUE('USES_MNP') = 1) THEN
--      vSUBSCR_NO := MNP_TEMP_TO_MAIN(pSUBSCR_NO);
--    ELSE
--      vSUBSCR_NO := pSUBSCR_NO;
--    END IF;
            
    CALL_ROW := CALL_TYPE_V2(
      pDBF_ID, vSUBSCR_NO, pCH_SEIZ_DT, pUS_SEQ_N, pAT_SOC, pAT_FT_CODE, pPC_PLAN_CD, 
      pC_ACT_CD, pAT_CHG_AMT, pCALLING_NO, pMESSAGE_TP, pSRV_FT_CD, pDURATION,
      pDATA_VOL, pIMEI, pCELL_ID, pPROV_ID, pDIALED_DIG, pUOM, pDISCT_SOCS,
      pCALL_COST, pDUR, pMN_UNLIM);

    --Ретарификация
    CALL_ROW := HOT_BILLING_PCKG_KOK.HOT_BILLING_GET_RETARIFFING(CALL_ROW, pCOST_KOEF);
    
    PIPE ROW(CALL_ROW);
    --
  END LOOP;
END; 
--
  PROCEDURE HOT_BILLING_SAVE_CALL(
    pDBF_ID IN INTEGER
    ) IS
  --      
  TYPE curnmSet IS TABLE OF HOT_BILLING_CALLS_READING.SUBSCR_NO%TYPE INDEX BY BINARY_INTEGER;
  --
  curnmc curnmSet;
BEGIN
  DELETE FROM HOT_BILLING_CALLS_READING;
  -- Шрузим данные из файла
  HOT_BILLING_LOAD_DBF(pDBF_ID);
  --работу в один поток делаем из учета DBF_ID, и месяца
  FOR rec IN (SELECT TRUNC(TO_DATE(CH_SEIZ_DT, 'YYYYMMDDHH24MISS'), 'MM') smonth
                FROM HOT_BILLING_CALLS_READING HTC
                GROUP BY TRUNC(TO_DATE(CH_SEIZ_DT, 'YYYYMMDDHH24MISS'), 'MM')
                ORDER BY TRUNC(TO_DATE(CH_SEIZ_DT, 'YYYYMMDDHH24MISS'), 'MM') ASC)                  
  LOOP
    -- Подготавливаем временные талицы
    DELETE FROM HOT_BILLING_CALLS_SORTED;
    DELETE FROM HOT_BILLING_CALLS_INSERTING;
    -- Подготавливаем данные нового файла              
    SORTING_ERROR_CALLS(pDBF_ID);   -- Убираем ошибочные звонки                           
    UPDATE_REFS_HB_TEMP_UNSORT(pDBF_ID);   -- Обновление справочников
    -- Перенос данных для работы во временную таблицу (формирование типов и вторичный ключей)
    INSERT INTO HOT_BILLING_CALLS_SORTED(
           DBF_ID, SUBSCR_NO, CH_SEIZ_DT, US_SEQ_N, AT_SOC, AT_FT_CODE, PC_PLAN_CD, 
           C_ACT_CD, AT_CHG_AMT, CALLING_NO, MESSAGE_TP, SRV_FT_CD, DURATION, 
           DATA_VOL, IMEI, CELL_ID, PROV_ID, DIALED_DIG, UOM, DISCT_SOCS)
      SELECT DBF_ID, TO_NUM(SUBSCR_NO), TO_DATE(CH_SEIZ_DT, 'YYYYMMDDHH24MISS'), US_SEQ_N, AT_SOC, AT_FT_CODE, PC_PLAN_CD,
             C_ACT_CD, TO_NUM(AT_CHG_AMT), CALLING_NO, MESSAGE_TP, SRV_FT_CD, DURATION, 
             TO_NUM(DATA_VOL), TO_NUM(IMEI), TO_NUM(CELL_ID), PROV_ID, DIALED_DIG, UOM, DISCT_SOCS
        FROM HOT_BILLING_CALLS_READING CR
        WHERE CR.DBF_ID = pDBF_ID
          AND TRUNC(TO_DATE(CH_SEIZ_DT, 'YYYYMMDDHH24MISS'), 'MM') = rec.SMONTH;
    -- Запоминаем список номеров в обновлении    
    SELECT htc.subscr_no 
      BULK COLLECT INTO curnmc
      FROM HOT_BILLING_CALLS_SORTED htc
      WHERE htc.dbf_id = pDBF_ID
        AND TRUNC(htc.ch_seiz_dt, 'mm') = rec.SMONTH
      GROUP BY htc.subscr_no;
    -- Перетарифицируем звонки во временной таблице
                      
    
    INSERT INTO HOT_BILLING_CALLS_INSERTING(DBF_ID, SUBSCR_NO, CH_SEIZ_DT, US_SEQ_N, AT_SOC, 
                                            AT_FT_CODE, PC_PLAN_CD, C_ACT_CD, AT_CHG_AMT, 
                                            CALLING_NO, MESSAGE_TP, SRV_FT_CD, DURATION,
                                            DATA_VOL, IMEI, CELL_ID, PROV_ID, DIALED_DIG,
                                            UOM, DISCT_SOCS, CALL_COST, DUR, MN_UNLIM)
      SELECT DISTINCT tabs.DBF_ID, tabs.SUBSCR_NO, tabs.CH_SEIZ_DT, tabs.US_SEQ_N, tabs.AT_SOC, 
             tabs.AT_FT_CODE, tabs.PC_PLAN_CD, tabs.C_ACT_CD, tabs.AT_CHG_AMT, 
             tabs.CALLING_NO, tabs.MESSAGE_TP, tabs.SRV_FT_CD, tabs.DURATION,
             tabs.DATA_VOL, tabs.IMEI, tabs.CELL_ID, tabs.PROV_ID, tabs.DIALED_DIG,
             tabs.UOM, tabs.DISCT_SOCS, tabs.CALL_COST, tabs.DUR, tabs.MN_UNLIM
        FROM TABLE(HOT_BILLING_PCKG_KOK.HOT_BILLING_GET_CALL_TAB(CURSOR(
                      SELECT DBF_ID, SUBSCR_NO, CH_SEIZ_DT, US_SEQ_N, AT_SOC, AT_FT_CODE, PC_PLAN_CD, 
                             C_ACT_CD, AT_CHG_AMT, CALLING_NO, MESSAGE_TP, SRV_FT_CD, DURATION, 
                             DATA_VOL, IMEI, CELL_ID, PROV_ID, DIALED_DIG, UOM, DISCT_SOCS                                         
                        FROM HOT_BILLING_CALLS_SORTED CR
                        WHERE CR.DBF_ID = pDBF_ID
                        ORDER BY CR.SUBSCR_NO))) tabs;
    -- Обработка дублей в самом гор.биллинге
    --SORTING_DUPLICATE_CALLS(pDBF_ID, rec.SMONTH); -- Пока отключено за ненадобностью.                          
    -- Сохранение данных
    EXECUTE IMMEDIATE
      'MERGE INTO CALL_' || TO_CHAR (rec.SMONTH, 'YYYY_MM') || ' CT
         USING (SELECT IC.DBF_ID, IC.SUBSCR_NO, IC.CH_SEIZ_DT, IC.US_SEQ_N, IC.AT_SOC, IC.AT_FT_CODE, 
                       IC.PC_PLAN_CD, IC.C_ACT_CD, IC.AT_CHG_AMT, IC.CALLING_NO, IC.MESSAGE_TP, 
                       IC.SRV_FT_CD, IC.DURATION, IC.DATA_VOL, IC.IMEI, IC.CELL_ID, IC.PROV_ID, 
                       IC.DIALED_DIG, IC.UOM, IC.DISCT_SOCS, IC.CALL_COST, IC.DUR, IC.MN_UNLIM
                  FROM HOT_BILLING_CALLS_INSERTING IC
                  WHERE IC.DBF_ID = :vDBF_ID) t
           ON (ct.SUBSCR_NO = t.SUBSCR_NO 
                AND ct.CH_SEIZ_DT = t.CH_SEIZ_DT 
                AND (ct.US_SEQ_N = t.US_SEQ_N
                      OR ct.US_SEQ_N = :vAPI_DBF_ID))
         WHEN NOT MATCHED THEN
           INSERT(ct.DBF_ID, ct.SUBSCR_NO, ct.CH_SEIZ_DT, ct.US_SEQ_N, ct.AT_SOC, ct.AT_FT_CODE,
                  ct.PC_PLAN_CD, ct.C_ACT_CD, ct.AT_CHG_AMT, ct.CALLING_NO, ct.MESSAGE_TP,
                  ct.SRV_FT_CD, ct.DURATION, ct.DATA_VOL, ct.IMEI, ct.CELL_ID, ct.PROV_ID, 
                  ct.DIALED_DIG, ct.UOM, ct.DISCT_SOCS, ct.CALL_COST, ct.DUR, ct.MN_UNLIM)                  
             VALUES(t.DBF_ID, t.SUBSCR_NO, t.CH_SEIZ_DT, t.US_SEQ_N, t.AT_SOC, t.AT_FT_CODE,
                    t.PC_PLAN_CD, t.C_ACT_CD, t.AT_CHG_AMT, t.CALLING_NO, t.MESSAGE_TP,
                    t.SRV_FT_CD, t.DURATION, t.DATA_VOL, t.IMEI, t.CELL_ID, t.PROV_ID,
                    t.DIALED_DIG, t.UOM, t.DISCT_SOCS, t.CALL_COST, t.DUR, t.MN_UNLIM)
         WHEN MATCHED THEN 
           UPDATE 
             SET ct.DBF_ID = t.DBF_ID, ct.US_SEQ_N = t.US_SEQ_N, ct.AT_SOC = t.AT_SOC, ct.AT_FT_CODE = t.AT_FT_CODE,
                 ct.PC_PLAN_CD = t.PC_PLAN_CD, ct.C_ACT_CD = t.C_ACT_CD, ct.AT_CHG_AMT = t.AT_CHG_AMT, ct.CALLING_NO = t.CALLING_NO, 
                 ct.MESSAGE_TP = t.MESSAGE_TP, ct.SRV_FT_CD = t.SRV_FT_CD, ct.DURATION = t.DURATION, ct.DATA_VOL = t.DATA_VOL, 
                 ct.IMEI = t.IMEI, ct.CELL_ID = t.CELL_ID, ct.PROV_ID = t.PROV_ID, ct.DIALED_DIG = t.DIALED_DIG, ct.UOM = t.UOM, 
                 ct.DISCT_SOCS = t.DISCT_SOCS, ct.CALL_COST = t.CALL_COST, ct.DUR = t.DUR, ct.MN_UNLIM = t.MN_UNLIM
             where ct.US_SEQ_N <> t.US_SEQ_N'
      USING pDBF_ID, MS_CONSTANTS.GET_CONSTANT_VALUE('API_DBF_ID');
    -- Удаление сохраненных данный из несортированного
    DELETE 
      FROM HOT_BILLING_CALLS_READING HU
      WHERE HU.DBF_ID = pDBF_ID
        AND TRUNC(TO_DATE(CH_SEIZ_DT, 'YYYYMMDDHH24MISS'), 'MM') = rec.SMONTH;
    --    
    COMMIT;
  END LOOP;
  --
END;
--
  FUNCTION HOT_BILLING_GET_RETARIFFING(
    CALL_ROW IN CALL_TYPE_V2, 
    pCOST_KOEF IN NUMBER
    ) return CALL_TYPE_V2 as
    RESULT CALL_TYPE_V2;
  BEGIN
    RESULT := CALL_ROW;
    if nvl(CALL_ROW.AT_FT_CODE, '1') not in ('CBIN','CBOUT') then
      RESULT.CALL_COST := trunc(CALL_ROW.CALL_COST * pCOST_KOEF, 4);
    end if;
    --HOT_BILLING_UPDATE_LAST_ROAMNG(CALL_ROW, RESULT);
    -- Пересчет роуминга (перетарификация)
    --HOT_BILLING_RETARIF_ROAMING(RESULT);
    --RESULT.COST_CHNG := RESULT.CALL_COST - CALL_ROW.CALL_COST;
    RETURN(RESULT);
  END;
--
  procedure writelog_recalc(
    vSUBSCR_NO IN VARCHAR2, 
    vSTART_TIME IN DATE, 
    vDBF_ID IN NUMBER, 
    vDURATION IN INTEGER, 
    vTARIFF_ID IN INTEGER, 
    vCOST_MIN IN INTEGER, 
    vCNT_PODKL IN INTEGER, 
    vNAME_OPCION IN VARCHAR2, 
    vTICKET_ID IN VARCHAR2, 
    vCONTRACT_ID IN INTEGER, 
    vDURATION2 IN INTEGER
    ) AS
    PRAGMA AUTONOMOUS_TRANSACTION;                          
  BEGIN
    INSERT INTO HOT_BIL_RECALC_LOG(
             SUBSCR_NO, START_TIME, DBF_ID, DURATION, TARIFF_ID, COST_MIN, 
             CNT_PODKL, NAME_OPCION, RECORD_TIME, TICKET_ID, CONTRACT_ID, DURATION2)
      VALUES(vSUBSCR_NO, vSTART_TIME, vDBF_ID, vDURATION, vTARIFF_ID, vCOST_MIN, 
             vCNT_PODKL, vNAME_OPCION, sysdate, vTICKET_ID, vCONTRACT_ID, vDURATION2);
    COMMIT;   
  EXCEPTION 
    WHEN OTHERS THEN 
      ROLLBACK;                        
  END;
--

  PROCEDURE LOAD_HOT_BILLING(
    pSTREAM IN INTEGER DEFAULT 0
    ) IS
  BEGIN
    FOR rec IN (
      SELECT FILE_NAME, HBF_ID
        FROM HOT_BILLING_FILES 
        WHERE HBF_ID >= 145994 AND SUBSTR(FILE_NAME, -3) = 'dbf'
          AND DATE_END IS NULL AND NVL(COUNT_LOADING, 0) = 0
          AND MOD(pSTREAM, MS_CONSTANTS.GET_CONSTANT_VALUE('COUNT_STREAM_HOT_BILLING')) = pSTREAM
        ORDER BY HBF_ID ASC)
    LOOP
      HOT_BILLING_PCKG_KOK.HOT_BILLING_SAVE_CALL(rec.HBF_ID);
    END LOOP;
  END;  
--
END;
/