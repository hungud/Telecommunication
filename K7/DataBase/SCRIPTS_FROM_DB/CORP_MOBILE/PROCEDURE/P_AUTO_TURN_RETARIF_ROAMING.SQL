
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."P_AUTO_TURN_RETARIF_ROAMING" IS
--#Version=4
--
-- Процедура проверяет и при необходимости подключает скидку на роуминг для абонентов.
-- Делается для автоматической перетарификации.
--
-- Период проверки роуминга (в часах)
-- Должно быть меньше, чем период проверки на отключение в P_AUTO_TURN_RETARIF_ROAM_OFF !!!
C_ROAMING_PERIOD CONSTANT NUMBER := 12; 
-- Время пропуска процедуры до и после перехода на новый месяц (в долях суток)
cNOT_CHECK_HRS_BEFOR_NEW_MONTH CONSTANT NUMBER := 10/60/24; -- 10 минут до
cNOT_CHECK_HRS_AFTER_NEW_MONTH CONSTANT NUMBER := 1/24;     -- 1 час после
--
CURSOR C_PHONES IS
  -- Номера, у которых был роуминг за последние сутки, 
  -- и перетарификация включена в настройках лицевого счета.
  SELECT
    LAST_ROAMING_TIMESTAMPS.PHONE_NUMBER,
    ACCOUNTS.DO_ROAMING_RETARIFICATION
  FROM
    LAST_ROAMING_TIMESTAMPS,
    ACCOUNTS
  WHERE
    LAST_ROAMING_TIMESTAMPS.LAST_FULLCOST_CALL_DATE_TIME > SYSDATE-C_ROAMING_PERIOD/24 -- Был роуминговый звонок за период проверки
    AND ACCOUNTS.ACCOUNT_ID=GET_ACCOUNT_ID_BY_PHONE(LAST_ROAMING_TIMESTAMPS.PHONE_NUMBER) -- Лицевой счет
    AND NVL(ACCOUNTS.DO_ROAMING_RETARIFICATION, 0) <> 0 -- И лицевой счет разрешает перетарификацию
    AND NOT EXISTS( /* И нет активных записей в таблице перетарификации */
      SELECT 1 FROM ROAMING_RETARIF_PHONES
      WHERE ROAMING_RETARIF_PHONES.PHONE_NUMBER=LAST_ROAMING_TIMESTAMPS.PHONE_NUMBER
      AND ROAMING_RETARIF_PHONES.END_DATE_TIME IS NULL
    )
    --AND LAST_ROAMING_TIMESTAMPS.PHONE_NUMBER='9689681650' -- временно для отладки
    ;
BEGIN
  -- Задачу не выполняем некоторое время до и после перехода на новый месяц (еще могут быть не загружены статусы и прочие сведения).
  IF TO_CHAR(SYSDATE, 'MM') <> TO_CHAR(SYSDATE+cNOT_CHECK_HRS_BEFOR_NEW_MONTH, 'MM') -- Месяц меняется
    OR TO_CHAR(SYSDATE, 'MM') <> TO_CHAR(SYSDATE-cNOT_CHECK_HRS_AFTER_NEW_MONTH, 'MM') THEN
    -- На границе смены месяца ничего не делаем.
    NULL;
  ELSE
    --
    -- Основная часть
    --
    -- Перебираем все номера
    FOR vREC IN C_PHONES LOOP
      -- Проверяем и подключаем перетарификацию
      P_CHECK_ROAMING_RETARIF_PHONE(vREC.PHONE_NUMBER, vREC.DO_ROAMING_RETARIFICATION);
    END LOOP;
  END IF;
END;