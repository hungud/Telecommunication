--GRANT SELECT ON CORP_MOBILE.V_PHONE_NUMBER_LIMITS TO CORP_MOBILE_LK;

CREATE OR REPLACE FUNCTION CORP_MOBILE_LK.TURN_OPTION_ON_OFF(
  pPHONE_NUMBER IN VARCHAR2, 
  pTARIFF_OPTION_ID IN INTEGER,
  pTURN_ON IN INTEGER -- 0-отключить, 1-подключить
) RETURN VARCHAR2 IS
--
--Version=4
--
-- 4. 2015.11.03. Крайнов. Добавил защиты при отключении услуг.
-- Подключение или отключение услуги.
-- Работает через BEELINE_API.
--
CURSOR C_OPTIONS IS
  SELECT TARIFF_OPTIONS.OPTION_CODE
  FROM CORP_MOBILE.TARIFF_OPTIONS
  WHERE TARIFF_OPTIONS.TARIFF_OPTION_ID=pTARIFF_OPTION_ID;
--
vOPTION_CODE CORP_MOBILE.TARIFF_OPTIONS.OPTION_CODE%TYPE;
vRESULT VARCHAR2(2000);
--
BEGIN
  OPEN C_OPTIONS;
  FETCH C_OPTIONS INTO vOPTION_CODE;
  CLOSE C_OPTIONS;
  IF vOPTION_CODE IS NULL THEN
    vRESULT := 'Option not found';
  ELSE
    IF pTURN_ON = 1 THEN
      IF IS_OPTION_CAN_BE_TURNED_ON(pPHONE_NUMBER, pTARIFF_OPTION_ID) = 0 THEN
        vRESULT := 'Недостаточно средств для подключения услуги. Пополните счет.';
      END IF;
    END IF;
    IF pTURN_ON = 0 THEN
      IF IS_OPTION_CAN_BE_TURNED_ON(pPHONE_NUMBER, pTARIFF_OPTION_ID) = 0 THEN
        vRESULT := 'Отключение услуги запрещено.';
      END IF;
    END IF;
    IF vRESULT IS NULL THEN -- Если ошибок нет
      vRESULT := CORP_MOBILE.BEELINE_API_PCKG.TURN_TARIFF_OPTION(
        pPHONE_NUMBER => pPHONE_NUMBER,
        pOPTION_CODE => vOPTION_CODE,
        pTURN_ON => pTURN_ON, -- 0: выключить, 1: включить
        pEFF_DATE => NULL,   -- Дата подключения услуги (NULL - прямо сейчас)
        pEXP_DATE => NULL,   -- Дата автоматического отключения (NULL - не отключать)
        pREQUEST_INITIATOR => 'ЛК Т/т' -- Инициатор запроса (до 10 знаков)
      );
      IF vRESULT LIKE 'Заявка №%' THEN
        vRESULT := 'OK';
      END IF;
    END IF; 
  END IF;  
  RETURN vRESULT;
END;
/
