--#if GetVersion("HOT_BILLING_UPDATE_LAST_ROAMNG") < 5
CREATE OR REPLACE PROCEDURE HOT_BILLING_UPDATE_LAST_ROAMNG(
  CALL_ROW IN CALL_TYPE,
  RECALC_CALL_ROW IN CALL_TYPE -- Пересчитанная стоимость
  ) IS
--#Version=5
-- Процедура обновляет дату/время последнего роуминга, если он был для услуги
--
-- 5. Крайнов. 14.11.14. Поправка вставки для поля LAST_FULLCOST_CALL_DATE_TIME
-- 4. Уколов. 09.09.14. Сделал контроль роуминга только на входящих звонках 
--    (на некоторых тарифах входящие не тарифицируются - их пропускаем).
-- 3. Уколов. 30.07.14. Сделал обновление поля LAST_FULLCOST_CALL_DATE_TIME.
-- 2. Уколов. 27.07.14. Сделал контроль на стоимость звонка за 1 минуту.
--
  PRAGMA AUTONOMOUS_TRANSACTION;
  --
  CURSOR C_LAST_ROAMING(pPHONE_NUMBER VARCHAR2) IS
    SELECT 
      LAST_SERVICE_DATE_TIME,
      LAST_FULLCOST_CALL_DATE_TIME
    FROM 
      LAST_ROAMING_TIMESTAMPS
    WHERE 
      PHONE_NUMBER=pPHONE_NUMBER;
  --  
  vLAST_SERVICE_DATE_TIME DATE;
  vLAST_FULLCOST_CALL_DATE_TIME DATE;
  cROAMING_COST_PER_MINUTE CONSTANT NUMBER := 9.94;
BEGIN
  -- Если услуга в роуминге
  IF CALL_ROW.AT_FT_DE LIKE '(РЕГ)%' THEN
    OPEN C_LAST_ROAMING(CALL_ROW.SUBSCR_NO);
    FETCH C_LAST_ROAMING INTO vLAST_SERVICE_DATE_TIME, vLAST_FULLCOST_CALL_DATE_TIME;
    IF C_LAST_ROAMING%NOTFOUND THEN
      -- Не нашли - добавляем новую запись
      -- Если сумма сразу подходит, то сразу заполняем LAST_FULLCOST_CALL_DATE_TIME
      IF RECALC_CALL_ROW.CALL_COST > 0
          AND RECALC_CALL_ROW.DUR > 0
          AND ((RECALC_CALL_ROW.CALL_COST / TRUNC((RECALC_CALL_ROW.DUR + 59)/60)) 
            BETWEEN cROAMING_COST_PER_MINUTE AND cROAMING_COST_PER_MINUTE+0.0099 ) THEN
        INSERT INTO LAST_ROAMING_TIMESTAMPS (
          PHONE_NUMBER, 
          LAST_SERVICE_DATE_TIME,
          LAST_FULLCOST_CALL_DATE_TIME
        ) VALUES (
          CALL_ROW.SUBSCR_NO,
          CALL_ROW.START_TIME,
          CALL_ROW.START_TIME
        );
      ELSE
        INSERT INTO LAST_ROAMING_TIMESTAMPS (
          PHONE_NUMBER, 
          LAST_SERVICE_DATE_TIME
        ) VALUES (
          CALL_ROW.SUBSCR_NO,
          CALL_ROW.START_TIME
        );
      END IF;
      COMMIT;
    ELSE
      -- Нашли.
      -- Обновляем, если новая дата больше существующей на 1 час или более, 
      -- чтобы не обновлять слишком уж часто.
      IF CALL_ROW.START_TIME > vLAST_SERVICE_DATE_TIME + 1/24 THEN
        UPDATE LAST_ROAMING_TIMESTAMPS 
          SET LAST_SERVICE_DATE_TIME = CALL_ROW.START_TIME
          WHERE LAST_ROAMING_TIMESTAMPS.PHONE_NUMBER = CALL_ROW.SUBSCR_NO;
        COMMIT;
      END IF;
    END IF;
    IF -- Звонок входящий (на некоторых тарифах входящие не тарифицируются)
      (RECALC_CALL_ROW.SERVICEDIRECTION = 2
      -- Если стоимость звонка после пересчета 9,94 руб. ЗА 1 МИНУТУ
      AND RECALC_CALL_ROW.CALL_COST > 0
      AND RECALC_CALL_ROW.DUR > 0
      AND (RECALC_CALL_ROW.CALL_COST / TRUNC((RECALC_CALL_ROW.DUR + 59)/60)) 
        BETWEEN cROAMING_COST_PER_MINUTE AND cROAMING_COST_PER_MINUTE+0.0099)
       or (RECALC_CALL_ROW.SERVICEDIRECTION = 1
            and RECALC_CALL_ROW.AT_FT_DE LIKE '(РЕГ)%'
            and RECALC_CALL_ROW.CALL_COST > 0
            AND RECALC_CALL_ROW.DUR > 0
            AND (RECALC_CALL_ROW.CALL_COST / TRUNC((RECALC_CALL_ROW.DUR + 59)/60)) 
              BETWEEN cROAMING_COST_PER_MINUTE AND cROAMING_COST_PER_MINUTE+0.0099 )  
      THEN
      --
      -- Обновляем, если новая дата больше существующей на 1 час или более, 
      -- чтобы не обновлять слишком уж часто.
      IF (CALL_ROW.START_TIME > vLAST_FULLCOST_CALL_DATE_TIME + 1/24) 
          or (vLAST_FULLCOST_CALL_DATE_TIME is null) THEN
        UPDATE LAST_ROAMING_TIMESTAMPS 
          SET LAST_FULLCOST_CALL_DATE_TIME = CALL_ROW.START_TIME
          WHERE LAST_ROAMING_TIMESTAMPS.PHONE_NUMBER = CALL_ROW.SUBSCR_NO;
        COMMIT;
      END IF;
    END IF;
  END IF;
END;
/
--#end if
