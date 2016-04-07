CREATE OR REPLACE FUNCTION GET_ID_LAST_TARIFF_BY_CONTRACT(
  pCONTRACT_ID IN VARCHAR2, 
  pTARIFF_ID IN INTEGER DEFAULT NULL,
  pDATE IN DATE DEFAULT NULL
  ) RETURN INTEGER IS
--Version#1
CURSOR C IS
  SELECT CONTRACTS.TARIFF_ID
    FROM CONTRACTS
    WHERE CONTRACTS.CONTRACT_ID=pCONTRACT_ID
    ORDER BY CONTRACTS.CONTRACT_DATE DESC;
CURSOR CC IS
  SELECT CONTRACT_CHANGES.TARIFF_ID
    FROM CONTRACT_CHANGES
    WHERE CONTRACT_CHANGES.CONTRACT_ID=pCONTRACT_ID
      AND CONTRACT_CHANGES.TARIFF_ID IS NOT NULL
      AND CONTRACT_CHANGES.CONTRACT_CHANGE_DATE<=NVL(pDATE, SYSDATE)
    ORDER BY CONTRACT_CHANGES.CONTRACT_CHANGE_DATE DESC;
    
ID_C C%ROWTYPE;   
ID_CC CC%ROWTYPE;   
BEGIN
  OPEN CC;
  FETCH CC INTO ID_CC;
  IF CC%FOUND THEN
    RETURN ID_CC.TARIFF_ID;
  ELSE
    IF pTARIFF_ID IS NULL THEN
      OPEN C;
      FETCH C INTO ID_C;
      CLOSE C;
    END IF;
    RETURN NVL(pTARIFF_ID, ID_C.TARIFF_ID);
  END IF;
  CLOSE CC;
END;
/   

--grant execute on GET_ID_LAST_TARIFF_BY_CONTRACT to sim_trade_role; 