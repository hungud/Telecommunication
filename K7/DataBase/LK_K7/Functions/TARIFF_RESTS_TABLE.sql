CREATE OR REPLACE FUNCTION K7_LK.TARIFF_RESTS_TABLE(
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN K7_LK.TARIFF_REST_ROW_TAB PIPELINED AS
--#Version=1
--
-- Возвращает остатки пакетов
--v.1 06.11.2015 Афросин добавил функцию
--
BEGIN

  FOR vREC IN (
                SELECT * FROM TABLE(CORP_MOBILE.TARIFF_RESTS_TABLE(pPHONE_NUMBER))
              )
  LOOP
    PIPE ROW(
        TARIFF_REST_ROW_TYPE(
          vREC.PHONE_NUMBER,
          vREC.UNIT_TYPE,
          vREC.REST_TYPE,
          vREC.INITIAL_SIZE,
          vREC.CURR_VALUE,
          vREC.NEXT_VALUE,
          vREC.FREQUENCY,
          vREC.SOC,
          vREC.SOC_NAME,
          vREC.REST_NAME)
      );
      --
  END LOOP;
END;
/


