CREATE OR REPLACE FUNCTION HOT_BILLING_GET_CALL_TAB (pi_row IN SYS_REFCURSOR, pUSE_API integer default 0)
   RETURN CALL_TAB
   PIPELINED
AS
--
--Version=4
--30.01.2015 Алексеев. Добавлена вспомогательная переменная pAT_FT_DE_VS, помогающая определить тип вызова по содержанию услуги (а то интернет воспринимается как звонок) Строка OR (INSTR (LOWER (pAT_FT_DE), 'gprs') > 0)  заменена на OR (INSTR (LOWER (pAT_FT_DE_VS), 'gprs') > 0) 
--29.01.2015 Алексеев. Добавлена новая переменная определяющая загрузку, через API  (pUSE_API  = 1) или гор биллинг
--19.01.2015 Афросин. Не корректно определялся тип звонка при загрузке по API добавил строку OR (INSTR (LOWER (pAT_FT_DE), 'gprs') > 0) в определение типа звонка.
--
   pstart_time                  DATE;
   pSUBSCR_NO                   VARCHAR2 (11);
   poSUBSCR_NO                  VARCHAR2 (11);
   pCH_SEIZ_DT                  VARCHAR2 (16);
   pAT_FT_CODE                  VARCHAR2 (120);
   pAT_FT_CODE_BIL              VARCHAR2 (6); --код при загрузке гор биллинга
   pAT_FT_CODE_API              VARCHAR2 (120); --код при загрузке через API
   pAT_CHG_AMT                  VARCHAR2 (14);
   pCALLING_NO                  VARCHAR2 (21);
   pDURATION                    VARCHAR2 (8);
   pDATA_VOL                    VARCHAR2 (14);
   pCELL_ID                     VARCHAR2 (6);
   pDIALED_DIG                  VARCHAR2 (21);
   pAT_FT_DESC                  VARCHAR2 (240);
   pIMEI                        VARCHAR2 (15);
   pDBF_ID                      INTEGER;
   pcall_cost                   NUMBER;
   pCostNoVAT                   NUMBER;
   pCALL_DATE                   VARCHAR2 (10);
   pCALL_TIME                   VARCHAR2 (8);
   pdur                         NUMBER;
   pAT_FT_DE                    VARCHAR2 (240);
   pAT_FT_DE_VS      varchar2(240);--вспомогательна япеременная, помогающая определить тип вызова по содержанию услуги (а то интернет воспринимается как звонок)
   pMN_UNLIM                    NUMBER (1);
   pServiceType                 VARCHAR2 (1);
   pServiceDirection            NUMBER (1);
   pIsRoaming                   VARCHAR2 (1);
   pRoamingZone                 VARCHAR2 (6);
   pcost_chng                   NUMBER;
   pcost_koef                   NUMBER;

   TYPE T_SERVICES_CACHE IS TABLE OF VARCHAR2 (1000)
      INDEX BY SERVICES.FEATURE_CO%TYPE;

   TYPE T_MN_UNLIM_SERVICES_CACHE IS TABLE OF VARCHAR2 (1000)
      INDEX BY MN_UNLIM_SERVICES.FEATURE_CO%TYPE;

   SERVICES_CACHE_FEATURE_DE    T_SERVICES_CACHE;
   SERVICES_CACHE_DESCRIPTION   T_SERVICES_CACHE;
   MN_UNLIM_SERVICES_CACHE      T_MN_UNLIM_SERVICES_CACHE;
   -- cRECALC_SMS_2_0532_TO_2_95 VARCHAR2(100);
   vSUBSCR_NO                   VARCHAR2 (10);
   CALL_ROW                     CALL_TYPE;
--PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   -- Заполняем кэш
   -- cRECALC_SMS_2_0532_TO_2_95 := db_loader_pckg.get_constant_value('RECALC_SMS_2.0532_TO_2.95');
   --
   FOR rec IN (SELECT feature_co, NVL (MN.MN_UNLIM_GROUP, 0) MN_UNLIM_GROUP
                 FROM MN_UNLIM_SERVICES mn)
   LOOP
      MN_UNLIM_SERVICES_CACHE (rec.feature_co) := rec.MN_UNLIM_GROUP;
   END LOOP;

   --
   FOR rec IN (SELECT FEATURE_CO, FEATURE_DE, DESCRIPTIO
                 FROM services sv)
   LOOP
      SERVICES_CACHE_FEATURE_DE (rec.FEATURE_CO) := rec.FEATURE_DE;
      SERVICES_CACHE_DESCRIPTION (rec.FEATURE_CO) := rec.DESCRIPTIO;
   END LOOP;

   --
   poSUBSCR_NO := '0';

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
              pDBF_ID;
              
        pAT_FT_CODE := pAT_FT_CODE_BIL;
      END IF;

      EXIT WHEN pi_row%NOTFOUND;

      IF pSUBSCR_NO <> poSUBSCR_NO
      THEN
         BEGIN
            SELECT NVL (tar.calc_koeff_detal, 1)
              INTO pcost_koef
              FROM tariffs tar
             WHERE tariff_id =
                      (SELECT C.CURR_TARIFF_ID
                         FROM contracts c
                        WHERE     C.PHONE_NUMBER_FEDERAL = pSUBSCR_NO
                              AND NOT EXISTS
                                     (SELECT 1
                                        FROM contract_cancels cc
                                       WHERE CC.CONTRACT_ID = C.CONTRACT_ID));
         --get_curr_phone_tariff_id(pSUBSCR_NO);
         EXCEPTION
            WHEN OTHERS
            THEN
               pcost_koef := 1;
         END;

         poSUBSCR_NO := pSUBSCR_NO;
      END IF;

      pstart_time := TO_DATE (pCH_SEIZ_DT, 'yyyymmddhh24miss');
      --AT_FT_CODE,
      pCostNoVAT :=
         TO_NUMBER (
            SUBSTR (
               pAT_CHG_AMT,
               0,
               CASE
                  WHEN INSTR (pAT_CHG_AMT, ',00') = 0
                  THEN
                     LENGTH (pAT_CHG_AMT)
                  ELSE
                     INSTR (pAT_CHG_AMT, ',00') - 1
               END),
            '999999D99',
            ' NLS_NUMERIC_CHARACTERS = '',.''');
      pCALL_DATE :=
         TO_CHAR (TO_DATE (pCH_SEIZ_DT, 'yyyymmddhh24miss'), 'dd.mm.yyyy');
      pCALL_TIME :=
         TO_CHAR (TO_DATE (pCH_SEIZ_DT, 'yyyymmddhh24miss'), 'hh24:mi:ss');
      pdur :=
           TO_NUMBER (SUBSTR (pDURATION, -6, 2)) * 3600
         + TO_NUMBER (SUBSTR (pDURATION, -4, 2)) * 60
         + TO_NUMBER (SUBSTR (pDURATION, -2, 2));
      pDURATION :=
         TO_CHAR (TO_DATE (SUBSTR (pDURATION, -6), 'hh24miss'), 'hh24:mi:ss');
      pDIALED_DIG := pDIALED_DIG;

      IF pDIALED_DIG = pSUBSCR_NO
      THEN
         pDIALED_DIG := NULL;
      END IF;

      pAT_FT_DE :=
         CASE
            WHEN SERVICES_CACHE_FEATURE_DE.EXISTS (pAT_FT_CODE)
            THEN
               SERVICES_CACHE_FEATURE_DE (pAT_FT_CODE)
            ELSE
               pAT_FT_DESC
         END;
	  --если загрузка через API, то заполняем переменную pAT_FT_DE_VS
      if pUSE_API = 1 then
        pAT_FT_DE_VS := pAT_FT_CODE;
      else
        pAT_FT_DE_VS := '';
      end if;
      pAT_FT_DESC :=
         CASE
            WHEN SERVICES_CACHE_DESCRIPTION.EXISTS (pAT_FT_CODE)
            THEN
               SERVICES_CACHE_DESCRIPTION (pAT_FT_CODE)
            ELSE
               pAT_FT_DESC
         END;
      pAT_FT_DESC :=
         CASE pAT_FT_DESC
            WHEN 'GPRS internet'
            THEN
               'GPRS-Internet'
            WHEN 'Звонок на спец номер (О)'
            THEN
               'исх/доп.сервис'
            WHEN 'MMS for HLR'
            THEN
               'MMS'
            ELSE
               pAT_FT_DESC
         END;
      /*             begin
                   select nvl(sv.feature_de, pAT_FT_DESC),
                     decode(nvl(sv.descriptio, pAT_FT_DESC),
                          'GPRS internet',
                          'GPRS-Internet',
                          'Звонок на спец номер (О)',
                          'исх/доп.сервис',
                          'MMS for HLR',
                          'MMS'
                          )
                      into pAT_FT_DE, pAT_FT_DESC
                         from services sv
                        where sv.feature_co = pAT_FT_CODE;
                   exception when NO_DATA_FOUND then
                     pAT_FT_DE := pAT_FT_CODE;
                     pAT_FT_DESC := pAT_FT_CODE;
                   end;*/
      --CALLING_NO,
      pAT_CHG_AMT :=
         SUBSTR (
            pAT_CHG_AMT,
            0,
            CASE
               WHEN INSTR (pAT_CHG_AMT, ',00') = 0 THEN LENGTH (pAT_CHG_AMT)
               ELSE INSTR (pAT_CHG_AMT, ',00') - 1
            END);
      pDATA_VOL := CASE WHEN pDATA_VOL = '0' THEN '0,00' ELSE pDATA_VOL END;
      pCELL_ID := CASE WHEN LENGTH (pCELL_ID) < 2 THEN NULL ELSE pCELL_ID END;
      pMN_UNLIM :=
         CASE
            WHEN MN_UNLIM_SERVICES_CACHE.EXISTS (pAT_FT_CODE)
            THEN
               MN_UNLIM_SERVICES_CACHE (pAT_FT_CODE)
            ELSE
               0
         END;

      IF    (INSTR (LOWER (pAT_FT_DE), 'sms') > 0)
         OR (INSTR (LOWER (pAT_FT_DE), 'смс') > 0)
         OR (INSTR (LOWER (pAT_FT_DESC),
                    'короткие сообщения') > 0)
         OR (INSTR (LOWER (pAT_FT_DESC), 'сообщение') > 0)
      THEN
         pServiceType := 'S';
      ELSIF    (INSTR (pAT_FT_DE, 'MMS') > 0)
            OR (INSTR (pAT_FT_DE, 'ММС') > 0)
      THEN
         pServiceType := 'U';
      ELSIF    (INSTR (LOWER (pAT_FT_DESC), 'internet') > 0)
            OR (INSTR (LOWER (pAT_FT_DESC), 'gprs') > 0)
            OR ((nvl(Instr(Lower(pAT_FT_DE_VS), 'gprs'), 0) > 0)
            OR (INSTR (LOWER (pAT_FT_DESC), 'интернет') > 0)
      THEN
         pServiceType := 'G';
      ELSIF INSTR (LOWER (pAT_FT_DESC), 'wap') > 0
      THEN
         pServiceType := 'W';
      ELSE
         pServiceType := 'C';                                        -- Звонки
      END IF;

      IF INSTR (pAT_FT_DE, '(РЕГ)') > 0
      THEN
         -- Роуминг
         pIsRoaming := '1';
         pRoamingZone := 'РФ';
      ELSIF INSTR (pAT_FT_DE, 'БиЛайн СНГ') > 0
      THEN
         -- Роуминг
         pIsRoaming := '1';
         pRoamingZone := 'СНГ';
      ELSE
         -- Роуминга нет
         pIsRoaming := '';
         pRoamingZone := '';
      END IF;

      IF pSUBSCR_NO = pCALLING_NO
      THEN
         IF NVL (pAT_FT_CODE, '1') = 'CBIN'
         THEN
            pServiceDirection := '2';                              -- Входящий
         ELSE
            pServiceDirection := '1';                             -- Исходящий
         END IF;
      --                ANumber = pDIALED_DIG
      ELSE
         pServiceDirection := '2';                                 -- Входящий
      --                ANumber = CALLING_NO
      END IF;

      CASE pServiceType
         WHEN 'G'
         THEN
            -- Интернет-GPRS
            pdur :=
                 TO_NUMBER (pDATA_VOL,
                            '999999D99',
                            ' NLS_NUMERIC_CHARACTERS = '',.''')
               * 1024;                                           -- Из Мб в Кб
         WHEN 'W'
         THEN
            -- WAP
            pdur :=
               TO_NUMBER (pDATA_VOL,
                          '999999D99',
                          ' NLS_NUMERIC_CHARACTERS = '',.''');
         ELSE
            NULL;
      END CASE;

      -- Добавим НДС к стоимости
      pcall_cost := pCostNoVAT * 1.18;

      -- Обработка MNP
      IF (MS_CONSTANTS.GET_CONSTANT_VALUE ('USES_MNP') = 1)
      THEN
         vSUBSCR_NO := MNP_TEMP_TO_MAIN (pSUBSCR_NO);
      ELSE
         vSUBSCR_NO := pSUBSCR_NO;
      END IF;
	  
	  --если загрузка через API, то необходимо занулить pAT_FT_CODE
      IF pUSE_API = 1 THEN
        pAT_FT_CODE := '';
      END IF;

      CALL_ROW :=
         CALL_TYPE (vSUBSCR_NO,
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
                    TRIM (pAT_FT_DE),
                    TRIM (pAT_FT_DESC),
                    pCALLING_NO,
                    pAT_CHG_AMT,
                    pDATA_VOL,
                    TRIM (pCELL_ID),
                    pMN_UNLIM,
                    pcall_cost);

      --Ретарификация
      --CALL_ROW := HOT_BILLING_GET_RETARIFFING (CALL_ROW, pcost_koef);
      /*if CALL_ROW.ServiceType = 'S' then
        -- Для SMS делаем перерасчёт в GSM-Corp с 2,05 на 2,95
        if (cRECALC_SMS_2_0532_TO_2_95 = '1') and (Round(CALL_ROW.call_cost, 2) = 2.05) then
          CALL_ROW.call_cost := 2.95;
        end if;
      end if;
      if nvl(CALL_ROW.AT_FT_CODE,'1') not in ('CBIN','CBOUT') then
         CALL_ROW.call_cost := trunc(CALL_ROW.call_cost * pcost_koef,2);
      end if;*/
      -- Заполним поле с разницей
      --CALL_ROW.cost_chng := CALL_ROW.call_cost - pcall_cost;
      PIPE ROW (CALL_ROW);
   --ADate, ATime, ServiceType, ServiceDirection, _
   --             ANumber, Duration, ACost, _
   --           IsRoaming, RoamingZone, AddInfo, SourceLine, _
   --         RowAlreadyLoaded, ABaseStationCode, CostNoVAT
   END LOOP;
END;
/