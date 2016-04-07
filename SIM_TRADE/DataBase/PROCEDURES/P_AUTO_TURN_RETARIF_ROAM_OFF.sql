--#if GetVersion("P_AUTO_TURN_RETARIF_ROAM_OFF") < 3
CREATE OR REPLACE PROCEDURE P_AUTO_TURN_RETARIF_ROAM_OFF IS
--#Version=3
--
-- Процедура проверяет и отключает скидку на роуминг для абонентов, у которых закончился роуминг.
-- Делается для автоматической перетарификации.
--
-- 3. Уколов. 31.07.2014. Исправил обновление нескольких записей (ошибка ORA-01002)
--
-- Период окончания роуминга (в часах)
-- Должно быть больше, чем период проверки на подключение в P_AUTO_TURN_RETARIF_ROAMING !!!
C_ROAMING_TIMEOUT CONSTANT NUMBER := 24;
-- Время пропуска процедуры до и после перехода на новый месяц (в долях суток)
cNOT_CHECK_HRS_BEFOR_NEW_MONTH CONSTANT NUMBER := 10/60/24; -- 10 минут до
cNOT_CHECK_HRS_AFTER_NEW_MONTH CONSTANT NUMBER := 10/60/24;     -- 10 минут после
--
CURSOR C_PHONES IS
  -- Номера с перетарификацией, у которых не было роуминга за период окончания. 
  SELECT
    ROAMING_RETARIF_PHONES.ID,
    ROAMING_RETARIF_PHONES.PHONE_NUMBER,
    ROAMING_RETARIF_PHONES.OPTION_CODE
  FROM
    LAST_ROAMING_TIMESTAMPS,
    ROAMING_RETARIF_PHONES
  WHERE
    ROAMING_RETARIF_PHONES.PHONE_NUMBER=LAST_ROAMING_TIMESTAMPS.PHONE_NUMBER
    AND ((LAST_ROAMING_TIMESTAMPS.LAST_SERVICE_DATE_TIME < SYSDATE-C_ROAMING_TIMEOUT/24 -- Последний роуминг был раньше периода проверки
            AND TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) >= 22) -- До 22:00 не отключаем (нет смысла, абонка уже начислена)
        -- Если прошло > 26 часов, то отключаем в любом случае (не сработала процедура отключения)
        OR LAST_ROAMING_TIMESTAMPS.LAST_SERVICE_DATE_TIME < SYSDATE-(C_ROAMING_TIMEOUT+2)/24) 
    AND ROAMING_RETARIF_PHONES.END_DATE_TIME IS NULL /* И запись в таблице перетарификации активна */
    ;
--
vRESULT VARCHAR2(2000);
vTICKET_ID VARCHAR2(20);
--
BEGIN
  -- Задачу не выполняем некоторое время до и после перехода на новый месяц (еще могут быть не загружены статусы и прочие сведения).
  IF TO_CHAR(SYSDATE, 'MM') <> TO_CHAR(SYSDATE+cNOT_CHECK_HRS_BEFOR_NEW_MONTH, 'MM') -- Месяц меняется
    OR TO_CHAR(SYSDATE, 'MM') <> TO_CHAR(SYSDATE-cNOT_CHECK_HRS_AFTER_NEW_MONTH, 'MM') THEN -- До 22 часов тоже не проверяем (нет смысла отключать)
    -- На границе смены месяца ничего не делаем.
    NULL;
    debug_out('Закрытие - Мимо коридора');
  ELSE
    --
    -- Основная часть
    --
    -- Перебираем все номера
    FOR vREC IN C_PHONES LOOP
      debug_out(vREC.PHONE_NUMBER || ': disable ' || vREC.OPTION_CODE);
      -- Отключаем перетарификацию
      vRESULT := BEELINE_API_PCKG.TURN_TARIFF_OPTION(vREC.PHONE_NUMBER, vREC.OPTION_CODE, 0, NULL, NULL, 'RETARIF');
      IF vRESULT LIKE 'Заявка №%' THEN
        -- Проставляем дату окончания перетарификации
        vTICKET_ID := regexp_replace(vRESULT, 'Заявка № *(\d+)', '\1');
        UPDATE ROAMING_RETARIF_PHONES
        SET 
          END_DATE_TIME=SYSDATE,
          SERVICE_OFF_TICKET_ID = vTICKET_ID,
          SERVICE_OFF_ERROR_MESSAGE = NULL
        WHERE
          ROAMING_RETARIF_PHONES.ID = vREC.ID;
      ELSE
        UPDATE ROAMING_RETARIF_PHONES
        SET 
          SERVICE_OFF_ERROR_MESSAGE = vRESULT
        WHERE
          ROAMING_RETARIF_PHONES.ID = vREC.ID;
      END IF;
      COMMIT;
    END LOOP;
  END IF;
END;
/
--#end if
