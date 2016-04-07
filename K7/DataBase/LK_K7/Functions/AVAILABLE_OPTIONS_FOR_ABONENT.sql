CREATE OR REPLACE FUNCTION K7_LK.AVAILABLE_OPTIONS_FOR_ABONENT(
  pUSER_ID IN INTEGER
  ) RETURN AVAILABLE_OPTION_TAB PIPELINED AS
--#Version=3
--
-- 1. ������
-- 3. ������. �������� �������� �� ������������� ��� ������. 
--
CURSOR C_OPTIONS(pTARIFF_ID INTEGER) IS
SELECT
  TARIFF_OPTIONS.TARIFF_OPTION_ID,
  TARIFF_OPTION_COSTS.TARIFF_OPTION_COST_ID,
  TARIFF_OPTION_ADD_INFO.CATEGORY_NAME,
  NVL(TARIFF_OPTIONS.OPTION_NAME_FOR_AB, TARIFF_OPTIONS.OPTION_NAME) OPTION_NAME,
  TARIFF_OPTION_COSTS.TURN_ON_COST,
  TARIFF_OPTION_COSTS.MONTHLY_COST,
  TARIFF_OPTION_ADD_INFO.DESCRIPTION,
  TARIFF_OPTIONS.DISCR_SPISANIE
FROM 
  CORP_MOBILE.TARIFF_OPTIONS, 
  CORP_MOBILE.TARIFF_OPTION_COSTS,
  K7_LK.TARIFF_OPTION_ADD_INFO,
  CORP_MOBILE.OPTIONS_ENABLED_FOR_TARIFFS
WHERE TARIFF_OPTIONS.CAN_BE_TURNED_BY_ABONENT=1
  AND TARIFF_OPTIONS.TARIFF_OPTION_ID = TARIFF_OPTION_COSTS.TARIFF_OPTION_ID(+)
  AND TARIFF_OPTION_COSTS.BEGIN_DATE(+)<=TRUNC(SYSDATE)
  AND TARIFF_OPTION_COSTS.END_DATE(+)>=TRUNC(SYSDATE)
  AND TARIFF_OPTION_ADD_INFO.TARIFF_OPTION_ID(+)=TARIFF_OPTIONS.TARIFF_OPTION_ID
  AND OPTIONS_ENABLED_FOR_TARIFFS.TARIFF_OPTION_ID=TARIFF_OPTIONS.TARIFF_OPTION_ID
  AND OPTIONS_ENABLED_FOR_TARIFFS.TARIFF_ID=pTARIFF_ID
ORDER BY
  TARIFF_OPTION_ADD_INFO.CATEGORY_NAME,
  NVL(TARIFF_OPTIONS.OPTION_NAME_FOR_AB, TARIFF_OPTIONS.OPTION_NAME);
--
CURSOR C_OPTIONS_2(pTARIFF_ID INTEGER, pTARIFF_OPTION_COST_ID INTEGER) IS
SELECT 
  TARIFF_OPTION_NEW_COST.TURN_ON_COST,
  TARIFF_OPTION_NEW_COST.MONTHLY_COST
FROM 
  CORP_MOBILE.TARIFF_OPTION_NEW_COST 
WHERE TARIFF_OPTION_NEW_COST.TARIFF_OPTION_COST_ID=pTARIFF_OPTION_COST_ID
  AND TARIFF_OPTION_NEW_COST.TARIFF_ID=pTARIFF_ID;
--
  vTARIFF_ID INTEGER;
  vTURN_ON_COST CORP_MOBILE.TARIFF_OPTION_NEW_COST.TURN_ON_COST%TYPE;
  vMONTHLY_COST CORP_MOBILE.TARIFF_OPTION_NEW_COST.MONTHLY_COST%TYPE;
--
BEGIN
  SELECT LK_USERS.TARIFF_ID
    INTO vTARIFF_ID
    FROM LK_USERS
    WHERE LK_USERS.ID=pUSER_ID;
  FOR vREC IN C_OPTIONS(vTARIFF_ID) LOOP
    OPEN C_OPTIONS_2(vTARIFF_ID, vREC.TARIFF_OPTION_COST_ID);
    FETCH C_OPTIONS_2 INTO vTURN_ON_COST, vMONTHLY_COST;
    IF C_OPTIONS_2%FOUND THEN
      vREC.TURN_ON_COST := vTURN_ON_COST;
      vREC.MONTHLY_COST := vMONTHLY_COST;
    END IF;
    CLOSE C_OPTIONS_2;
    PIPE ROW(
      AVAILABLE_OPTION_TYPE(
        vREC.TARIFF_OPTION_ID,
        vREC.CATEGORY_NAME,
        vREC.OPTION_NAME,
        vREC.TURN_ON_COST,
        vREC.MONTHLY_COST,
        vREC.DESCRIPTION,
        vREC.DISCR_SPISANIE
        )
      );
  END LOOP;
END;
/

--select * from table(K7_LK.AVAILABLE_OPTIONS_FOR_ABONENT(188220))
