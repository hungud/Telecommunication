GRANT SELECT ON DB_LOADER_PHONE_STAT TO CORP_MOBILE_LK;

CREATE OR REPLACE FUNCTION CORP_MOBILE_LK.GET_PHONE_CURRENT_STATS(
  pPHONE_NUMBER IN VARCHAR2,
  pYEAR_MONTH IN NUMBER DEFAULT NULL
  ) RETURN CORP_MOBILE_LK.T_PHONE_STATS_TAB PIPELINED AS
--#Version=6
--
-- Возвращается статистику использования номера за период
-- Используем как
--   SELECT * FROM TABLE(GET_PHONE_CURRENT_STATS('9689681650'))
-- Для компиляции делаем GRANT SELECT ON DB_LOADER_PHONE_STAT TO CORP_MOBILE_LK;
--
-- 6. Уколов. Поправил формулировки согласно письму от 20.07.15.
-- 5. Уколов. Сделал проверку остатков пакетов в статистике, и уточнение объема трафика
-- 4. Уколов. в статистике не учитывались количество и стоимость платных MMS.
-- 3. Уколов. Статистику минут вывожу поминутную, а не посекундную
-- 2. Уколов. Добавил вывод бесплатные минуты
--
CURSOR C IS
  SELECT *
  FROM CORP_MOBILE.DB_LOADER_PHONE_STAT
  WHERE DB_LOADER_PHONE_STAT.PHONE_NUMBER=pPHONE_NUMBER
    AND YEAR_MONTH=NVL(pYEAR_MONTH, TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM')));
vREC C%ROWTYPE;
--
CURSOR C_INTERNET IS
  SELECT SUM(
    CASE
      WHEN INITIAL_SIZE = -100 THEN -- Магическое значение - безлимит
        NULL -- В итоге получим NULL
      WHEN CURR_VALUE < 0 THEN -- Отрицательный остаток - значит, потратили все.
        INITIAL_SIZE
      ELSE 
        INITIAL_SIZE-CURR_VALUE
    END
    ) as TRAFFIC_MB
  FROM 
    TABLE(CORP_MOBILE.TARIFF_RESTS_TABLE(pPHONE_NUMBER))
  WHERE 
    UNIT_TYPE='INTERNET';
vINTERNET NUMBER;
--
BEGIN
  OPEN C;
  FETCH C INTO vREC;
  IF C%FOUND THEN
    IF pYEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM')) THEN
      BEGIN
        OPEN C_INTERNET;
        FETCH C_INTERNET INTO vINTERNET;
        CLOSE C_INTERNET;
        -- Если потраченный интернет больше статистики, то показывает потраченный из остатков
        IF vINTERNET IS NOT NULL AND vINTERNET > vREC.INTERNET_MB THEN
          vREC.INTERNET_MB := vINTERNET;
        END IF;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
    END IF;
    --
    -- ESTIMATE_SUM, ZEROCOST_OUTCOME_MINUTES, ZEROCOST_OUTCOME_COUNT, CALLS_COUNT, CALLS_MINUTES, CALLS_COST, SMS_COUNT, SMS_COST, MMS_COUNT, MMS_COST, INTERNET_MB, INTERNET_COST, LAST_CHECK_DATE_TIME, COST_CHNG, ZEROCOST_INBOX_MINUTES, CALLBACKCOST, CALLBACKMINUTES, CALLBACKCOUNT
    PIPE ROW(T_PHONE_STATS(1, 'Дата/время актуализации', to_char(vREC.LAST_CHECK_DATE_TIME, 'DD.MM.YYYY HH24:MI')));
    PIPE ROW(T_PHONE_STATS(1, 'Бесплатные вызовы', NULL));
    PIPE ROW(T_PHONE_STATS(2,     'Исходящие, мин.', vREC.ZEROCOST_OUTCOME_MINUTES));
    PIPE ROW(T_PHONE_STATS(2,     'Входящие, мин.', vREC.ZEROCOST_INBOX_MINUTES));
    PIPE ROW(T_PHONE_STATS(2,     'Звонков, шт.', vREC.ZEROCOST_OUTCOME_COUNT));
    PIPE ROW(T_PHONE_STATS(1, 'Платные вызовы', NULL));
    PIPE ROW(T_PHONE_STATS(2,     'Всего, мин.', vREC.CALLS_FULL_MINUTES));
    PIPE ROW(T_PHONE_STATS(2,     'Звонков, шт.', vREC.CALLS_COUNT));
    PIPE ROW(T_PHONE_STATS(2,     'Стоимость, руб.', vREC.CALLS_COST));
    PIPE ROW(T_PHONE_STATS(1, 'SMS и MMS', NULL));
    PIPE ROW(T_PHONE_STATS(2,     'Бесплатных, шт.', vREC.SMS_FREE_COUNT+vREC.MMS_FREE_COUNT));
    PIPE ROW(T_PHONE_STATS(2,     'Платных, шт.', vREC.SMS_COUNT+vREC.MMS_COUNT));
    PIPE ROW(T_PHONE_STATS(2,     'Стоимость, руб.', vREC.SMS_COST+vREC.MMS_COST));
    PIPE ROW(T_PHONE_STATS(1, 'Интернет', NULL));
    PIPE ROW(T_PHONE_STATS(2,     'Мегабайт', vREC.INTERNET_MB));
    PIPE ROW(T_PHONE_STATS(2,     'Стоимость, руб.', vREC.INTERNET_COST));
--    PIPE ROW(T_PHONE_STATS(1, 'Call Back минут', NULL));
--    PIPE ROW(T_PHONE_STATS(2,     'Минут', vREC.CALLBACKMINUTES));
--    PIPE ROW(T_PHONE_STATS(2,     'Звонков', vREC.CALLBACKCOUNT));
--    PIPE ROW(T_PHONE_STATS(2,     'Стоимость', vREC.CALLBACKCOST));
    PIPE ROW(T_PHONE_STATS(1, 'Прочие услуги, руб.', vREC.CALLBACKCOST));
  END IF;
  CLOSE C;
END;
/

-- select * from table(CORP_MOBILE_LK.GET_PHONE_CURRENT_STATS(:pPHONE_NUMBER))
