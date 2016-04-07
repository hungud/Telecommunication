GRANT EXECUTE ON GET_TEXT_ABON_FOR_INET_TARIFF TO K7_LK;
--
CREATE OR REPLACE FUNCTION K7_LK.GET_ABONENT_WARNING(
  pUSER_ID IN INTEGER
) RETURN VARCHAR2 IS
--
--#Version=1
--
-- Возвращает предупреждение, если его надо показать абоненту.
-- Пока только предупреждение о списании абонплаты.
CURSOR C_CONTRACT IS
  SELECT 
    CONTRACTS.CONTRACT_DATE,
    CONTRACTS.PHONE_NUMBER_FEDERAL AS PHONE_NUMBER
  FROM
    CORP_MOBILE.CONTRACTS
  WHERE
    CONTRACTS.CONTRACT_ID=pUSER_ID;
--
vCONTRACT_REC C_CONTRACT%ROWTYPE;
vRESULT VARCHAR2(2000 CHAR);
--
BEGIN
  OPEN C_CONTRACT;
  FETCH C_CONTRACT INTO vCONTRACT_REC;
  CLOSE C_CONTRACT;
  --
  IF     -- Меньше 7 дней до конца месяца
    TO_CHAR(SYSDATE, 'MM') <> TO_CHAR(SYSDATE+7, 'MM')
  OR     -- Или подключен в этом месяце
    TO_CHAR(vCONTRACT_REC.CONTRACT_DATE, 'YYYYMM') = TO_CHAR(SYSDATE, 'YYYYMM')
  THEN     
    vRESULT := CORP_MOBILE.GET_TEXT_ABON_FOR_INET_TARIFF(vCONTRACT_REC.PHONE_NUMBER);  
  END IF;
  --
--  vRESULT := 'Следующее списание абонентской платы за июнь по вашему тарифу произойдет 01.06.2015 в размере 990 руб. Пополните баланс заранее.';
  RETURN vRESULT;
END;
/
