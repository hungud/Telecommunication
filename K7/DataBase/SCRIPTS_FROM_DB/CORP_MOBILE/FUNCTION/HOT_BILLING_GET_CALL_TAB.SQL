
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."HOT_BILLING_GET_CALL_TAB" (pi_row IN sys_refcursor, pUSE_API integer default 0) return CALL_TAB
    PIPELINED AS
--
--Version=8
--v.8 08.08.2015 - Матюнин И. - Добавлено условия для более корретного определения Интернета в рамках задачи http://redmine.tarifer.ru/issues/3182
--v.7 22.07.2015 Афросин Добавил проставку признака PROV_ID для 
--                Исходящее SMS: Популярные страны
--                 Исходящее SMS: СНГ
--                Исходящее SMS: Остальной мир 2
--                 Исходящее SMS: Остальной мир 4
--v.6 18.06.2015 Афросин Добавил загрузку PROV_ID
--v.5 09.06.2015 Е.Кочнев Добавлена обработка междугородних звонков.
--                  Пересчет роуминговых звонков вынесен в пакет HOT_BILLING_RECALC_ROW
--30.01.2015 Алексеев. Добавлена вспомогательная переменная pAT_FT_DE_VS, помогающая определить тип вызова по содержанию услуги (а то интернет воспринимается как звонок) Строка OR (INSTR (LOWER (pAT_FT_DE), 'gprs') > 0)  заменена на OR (INSTR (LOWER (pAT_FT_DE_VS), 'gprs') > 0) 
--29.01.2015 Алексеев. Добавлена новая переменная определяющая загрузку, через API  (pUSE_API  = 1) или гор биллинг
--19.01.2015 Афросин. Не корректно определялся тип звонка при загрузке по API добавил строку OR (INSTR (LOWER (pAT_FT_DE), 'gprs') > 0) в определение типа звонка.
--    
  pstart_time       date;
  pSUBSCR_NO        varchar2(11);
  poSUBSCR_NO        varchar2(11);
  pCH_SEIZ_DT       varchar2(16);
  pAT_FT_CODE_BIL            VARCHAR2 (6); --код при загрузке гор биллинга
  pAT_FT_CODE_API            VARCHAR2 (120); --код при загрузке через API
  pAT_FT_CODE       varchar2(120);
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
  pAT_FT_DE_VS    varchar2(240);--вспомогательна япеременная, помогающая определить тип вызова по содержанию услуги (а то интернет воспринимается как звонок)
  pMN_UNLIM         number(1);
  pServiceType      varchar2(1);
  pServiceDirection number(1);
  pIsRoaming        varchar2(1);
  pRoamingZone      varchar2(6);
  pcost_chng        number;
  pcost_koef        number;
  pPROV_ID          INTEGER; -- ID роуминг-провайдера
  pPROV_ID_STR      varchar2(8);
  TYPE T_SERVICES_CACHE IS TABLE OF VARCHAR2(1000) index by SERVICES.FEATURE_CO%TYPE;
  TYPE T_MN_UNLIM_SERVICES_CACHE IS TABLE OF VARCHAR2(1000) index by MN_UNLIM_SERVICES.FEATURE_CO%TYPE;
  SERVICES_CACHE_FEATURE_DE T_SERVICES_CACHE;
  SERVICES_CACHE_DESCRIPTION T_SERVICES_CACHE;
  MN_UNLIM_SERVICES_CACHE T_MN_UNLIM_SERVICES_CACHE;
  vSUBSCR_NO VARCHAR2(10);
  CALL_ROW CALL_TYPE;
  --PRAGMA AUTONOMOUS_TRANSACTION;
  function AUTO_UPDATE_ROAMING_PROVIDERS(pProv_code varchar2, pCAll_DESC varchar2)
    return integer
      AS
         PRAGMA AUTONOMOUS_TRANSACTION;
         res integer;
         vCT integer;
         vCAll_DESC MN_ROAMING_CALL_DESC.CALL_DESC%TYPE;
      BEGIN
         vCAll_DESC := trim(pCAll_DESC);
         if nvl(trim(pProv_code), '-1') = '-1' then
          res := -1; 
         else
           MERGE INTO ROAMING_PROVIDERS rp
                USING (SELECT pProv_code ROAMING_PROVIDER_CODE from dual) t_dual
                   ON (    rp.ROAMING_PROVIDER_CODE = t_dual.ROAMING_PROVIDER_CODE)
           WHEN MATCHED
           THEN
              UPDATE 
                SET rp.DATE_LAST_UPDATED = SYSDATE
           WHEN NOT MATCHED
           THEN
              INSERT     (rp.ROAMING_PROVIDER_CODE)
                  VALUES (t_dual.ROAMING_PROVIDER_CODE)
                  ;

          select ROAMING_PROVIDER_ID into res
          from
            ROAMING_PROVIDERS
          where
            ROAMING_PROVIDER_CODE = pProv_code; 
         --
         end if;
        COMMIT;
        
        -- если не нашли ид провайдера, то ищем по расшифровке вызывов
        if nvl(res, -1) = -1 then
          begin
            
            select
              count(*) into vCT
            from
              MN_ROAMING_CALL_DESC
            where
              CALL_DESC = vCAll_DESC;
           
            if nvl(vCT, 0) > 0 then
              select
                ROAMING_PROVIDER_ID into res
              from
                MN_ROAMING_CALL_DESC
              where
                CALL_DESC = vCAll_DESC;  
            end if;
              
          exception
            when others then
              null;
          end;
        end if;
        
        
        Return nvl(res, -1);
      END;
BEGIN
  -- Заполняем кэш
  --
  FOR rec IN (
                SELECT
                  feature_co,
                  NVL(MN.MN_UNLIM_GROUP, 0) MN_UNLIM_GROUP
                from 
                  MN_UNLIM_SERVICES mn
             ) LOOP
    MN_UNLIM_SERVICES_CACHE(rec.feature_co) := rec.MN_UNLIM_GROUP;
  END LOOP;
  --
  FOR rec IN (
                SELECT
                  FEATURE_CO,
                  FEATURE_DE,
                  DESCRIPTIO
                from
                  services sv
             ) LOOP
    SERVICES_CACHE_FEATURE_DE(rec.FEATURE_CO) := rec.FEATURE_DE;
    SERVICES_CACHE_DESCRIPTION(rec.FEATURE_CO) := rec.DESCRIPTIO;
  END LOOP;
  --  
  poSUBSCR_NO:='0';
  LOOP
    IF pUSE_API = 1 THEN --через API
      FETCH pi_row
       INTO pSUBSCR_NO,
            pCH_SEIZ_DT,
            pAT_FT_CODE_API,
            pAT_CHG_AMT,
            pCALLING_NO,
            pDURATION,
            pDATA_VOL,
            pIMEI,
            pCELL_ID,
            pDIALED_DIG,
            pAT_FT_DESC,
            pDBF_ID;
                
      pAT_FT_CODE := pAT_FT_CODE_API;
      pPROV_ID := AUTO_UPDATE_ROAMING_PROVIDERS('-1', pAT_FT_DESC);
    ELSE
      FETCH pi_row
       INTO pSUBSCR_NO,
            pCH_SEIZ_DT,
            pAT_FT_CODE_BIL,
            pAT_CHG_AMT,
            pCALLING_NO,
            pDURATION,
            pDATA_VOL,
            pIMEI,
            pCELL_ID,
            pDIALED_DIG,
            pAT_FT_DESC,
            pDBF_ID,
            pPROV_ID_STR
            ;
                
      pAT_FT_CODE := pAT_FT_CODE_BIL;
      pPROV_ID := AUTO_UPDATE_ROAMING_PROVIDERS(pPROV_ID_STR, pAT_FT_DESC);
    END IF;
    
--    
    EXIT WHEN pi_row%NOTFOUND;
--    
    if pSUBSCR_NO<>poSUBSCR_NO then
      begin
        select 
          nvl(tar.calc_koeff_detal, 1) into pcost_koef
        from 
          tariffs tar
        where 
          tariff_id =
                      (
                       select
                         C.CURR_TARIFF_ID
                       from
                         contracts c
                       where
                         C.PHONE_NUMBER_FEDERAL = pSUBSCR_NO
                       and not exists
                                     (select 1
                                      from
                                        contract_cancels cc
                                      where CC.CONTRACT_ID = C.CONTRACT_ID
                                      )
                      );
         --get_curr_phone_tariff_id(pSUBSCR_NO);
      exception
        when others then
          pcost_koef := 1;
      end;
     poSUBSCR_NO := pSUBSCR_NO;
    end if;
--    
    pstart_time := to_date(pCH_SEIZ_DT, 'yyyymmddhh24miss');
    --AT_FT_CODE,
    pCostNoVAT := to_number(
                            substr(
                                    pAT_CHG_AMT,
                                    0,
                                    case when instr(pAT_CHG_AMT, ',00') = 0 THEN
                                           length(pAT_CHG_AMT)
                                         ELSE
                                           instr(pAT_CHG_AMT, ',00') - 1
                                         END
                                  ),
                            '999999D99',
                            ' NLS_NUMERIC_CHARACTERS = '',.'''
                           );
    pCALL_DATE := to_char(to_date(pCH_SEIZ_DT, 'yyyymmddhh24miss'), 'dd.mm.yyyy');
    pCALL_TIME := to_char(to_date(pCH_SEIZ_DT, 'yyyymmddhh24miss'), 'hh24:mi:ss');
    pdur := to_number(
                       substr(pDURATION, -6, 2)) * 3600 +
                       to_number(substr(pDURATION, -4, 2)) * 60 +
                       to_number(substr(pDURATION, -2, 2)
                     );
    pDURATION := to_char(to_date(substr(pDURATION, -6), 'hh24miss'),'hh24:mi:ss');
    pDIALED_DIG := pDIALED_DIG;
    if pDIALED_DIG = pSUBSCR_NO then
      pDIALED_DIG := NULL;
    END IF;
--   
    pAT_FT_DE := CASE 
                   WHEN SERVICES_CACHE_FEATURE_DE.EXISTS(pAT_FT_CODE) THEN 
                     SERVICES_CACHE_FEATURE_DE(pAT_FT_CODE) 
                 ELSE
                   pAT_FT_DESC
                 END;
    --если загрузка через API, то заполняем переменную pAT_FT_DE_VS
    if pUSE_API = 1 then
      pAT_FT_DE_VS := pAT_FT_CODE;
    else
      pAT_FT_DE_VS := '';
    end if;
    
    pAT_FT_DESC := CASE 
                     WHEN SERVICES_CACHE_DESCRIPTION.EXISTS(pAT_FT_CODE) THEN 
                       SERVICES_CACHE_DESCRIPTION(pAT_FT_CODE)
                   ELSE
                     pAT_FT_DESC
                   END;
--                   
    pAT_FT_DESC := CASE pAT_FT_DESC
                     WHEN 'GPRS internet' THEN
                       'GPRS-Internet'
                     WHEN 'Звонок на спец номер (О)' THEN
                       'исх/доп.сервис'
                     WHEN 'MMS for HLR' THEN
                       'MMS'
                   ELSE
                     pAT_FT_DESC
                   END;

    pAT_CHG_AMT := substr
                        (
                          pAT_CHG_AMT,
                          0,
                          CASE
                            WHEN instr(pAT_CHG_AMT, ',00') = 0 THEN
                              length(pAT_CHG_AMT)
                          ELSE
                            instr(pAT_CHG_AMT, ',00') - 1
                          END
                       );
           
    pDATA_VOL := CASE 
                   WHEN pDATA_VOL='0' THEN 
                     '0,00'
                 ELSE
                   pDATA_VOL
                 END;
    pCELL_ID := case
                  when length(pCELL_ID) < 2 then
                    null
                else
                  pCELL_ID
                end;
--    
    pMN_UNLIM := CASE 
                   WHEN MN_UNLIM_SERVICES_CACHE.EXISTS(pAT_FT_CODE) THEN 
                     MN_UNLIM_SERVICES_CACHE(pAT_FT_CODE)
                   ELSE
                     0
                   END;
--
    if (Instr(Lower(pAT_FT_DE), 'sms') > 0) or
       (Instr(Lower(pAT_FT_DE), 'смс') > 0) or
       (Instr(Lower(pAT_FT_DESC), 'короткие сообщения') > 0) or
       (Instr(Lower(pAT_FT_DESC), 'сообщение') > 0) then
      pServiceType := 'S';
    elsif (Instr(pAT_FT_DE, 'MMS') > 0) or (Instr(pAT_FT_DE, 'ММС') > 0) then
      pServiceType := 'U';
    elsif (Instr(Lower(pAT_FT_DESC), 'internet') > 0) or          
          (Instr(Lower(pAT_FT_DESC), 'gprs') > 0) or
          (Instr(Lower(pAT_FT_DE), 'gprs') > 0) OR  -- v8
          (nvl(Instr(Lower(pAT_FT_DE_VS), 'gprs'), 0) > 0) or
          (Instr(Lower(pAT_FT_DESC), 'интернет') > 0) then
      pServiceType := 'G';
    elsif Instr(Lower(pAT_FT_DESC), 'wap') > 0 then
      pServiceType := 'W';
    else
      pServiceType := 'C'; -- Звонки
    end if;
--
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
      if nvl(pAT_FT_CODE,'1') ='CBIN' then
        pServiceDirection := '2'; -- Входящий
      else
        pServiceDirection := '1'; -- Исходящий
      end if;
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
        
    -- Обработка MNP
    IF (MS_CONSTANTS.GET_CONSTANT_VALUE('USES_MNP') = 1) THEN
      vSUBSCR_NO := MNP_TEMP_TO_MAIN(pSUBSCR_NO);
    ELSE
      vSUBSCR_NO := pSUBSCR_NO;
    END IF;

    --если загрузка через API, то необходимо занулить pAT_FT_CODE
    IF pUSE_API  = 1 THEN
      pAT_FT_CODE := '';
    END IF;
            
    CALL_ROW := CALL_TYPE(vSUBSCR_NO,
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
                       pcall_cost,
                       pPROV_ID
                       );

    --Ретарификация
    CALL_ROW := HOT_BILLING_RECALC_ROW_PCKG.HOT_BILLING_GET_RETARIFFING(CALL_ROW, pcost_koef);
    CALL_ROW := HOT_BILLING_RECALC_ROW_PCKG.HOT_BILLING_AUTO_CONNECT_MG(CALL_ROW);

    PIPE ROW(CALL_ROW);
    --ADate, ATime, ServiceType, ServiceDirection, _
    --             ANumber, Duration, ACost, _
    --           IsRoaming, RoamingZone, AddInfo, SourceLine, _
    --         RowAlreadyLoaded, ABaseStationCode, CostNoVAT
  END LOOP;
END;