CREATE OR REPLACE function HOT_BILLING_GET_RETARIFFING(
  CALL_ROW IN CALL_TYPE, pcost_koef IN number
  ) return CALL_TYPE IS
--
-- Перетарификация строки детализации
--
--     !!!!    ВЕРСИЯ ДЛЯ К7      !!!!!!!!
--
--#Version=5
--
-- 5. 09.06.2015 Афросин Перенес логику в HOT_BILLING_RECALC_ROW_PСKG.HOT_BILLING_GET_RETARIFFING
-- 4. 28.07.2014 Уколов. Подключил перерасчет роуминга
-- 3. 27.07.2014 Уколов. В проверку роуминга отдаю и начальную, и пересчитанную стоимость.
--
  RESULT CALL_TYPE;
BEGIN
  RESULT := HOT_BILLING_RECALC_ROW_PСKG.HOT_BILLING_GET_RETARIFFING(CALL_ROW, pcost_koef);
  RETURN(RESULT);
END;
/