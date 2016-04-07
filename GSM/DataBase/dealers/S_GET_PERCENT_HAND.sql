CREATE OR REPLACE FUNCTION WWW_DEALER.S_GET_PERCENT_HAND(
  pMANAGER_MODE INTEGER, 
  pUSER_ID INTEGER, 
  pOPERATOR_ID INTEGER, 
  pTARIFF_ID INTEGER,
  pDATE DATE
  ) RETURN NUMBER IS
--#Version=2
--v2. Матюнин И. - Добавлена еще одна таблица, из которой берутся проценты D_CONTR_TARIFF_PERC_HANDS
  CURSOR CUR_CONTRAGENT_HAND IS
    SELECT PH.PERCENT
      FROM D_CONTRAGENT_PRC_HANDS PH
     WHERE PH.USER_ID = pUSER_ID
       AND PH.OPERATOR_ID = pOPERATOR_ID
       AND ((PH.PERIOD IS NULL) OR (PH.PERIOD <= pDATE)) -- проуент внесенный вручную до указанной даты
     ORDER BY PH.PERIOD DESC NULLS LAST -- последний установленный процент
       ;
       

  CURSOR CUR_TARIFF_HAND IS
    SELECT PH.PERCENT
      FROM D_TARIFF_PRC_HANDS PH
     WHERE PH.USER_ID = pUSER_ID
       AND PH.TARIFF_ID = pTARIFF_ID
       AND ((PH.PERIOD IS NULL) OR (PH.PERIOD <= pDATE)) -- проуент внесенный вручную до указанной даты
     ORDER BY PH.PERIOD DESC NULLS LAST -- последний установленный процент
     ;
  
  -- Проценты контрагентов по тарифам
  CURSOR CUR_CONTRAGENT_TAR_PRC_HAND IS    
    SELECT PH.PERCENT
      FROM D_CONTR_TARIFF_PERC_HANDS PH
     WHERE PH.USER_ID = pUSER_ID
       AND PH.TARIFF_ID = pTARIFF_ID
       AND ((PH.PERIOD IS NULL) OR (PH.PERIOD <= pDATE)) -- проуент внесенный вручную до указанной даты
     ORDER BY PH.PERIOD DESC NULLS LAST -- последний установленный процент
     ;
       
  vRES NUMBER;
BEGIN
  -- процент внесенный вручную  

  -- в режиме менеджера видим реальные проценты
  IF pMANAGER_MODE = 1 THEN
    RETURN NULL;
  ELSE
    vRES := NULL;
    --  
    OPEN CUR_TARIFF_HAND;
    FETCH CUR_TARIFF_HAND INTO vRES;
    CLOSE CUR_TARIFF_HAND;
    
    IF NVL(vRES, 0) = 0 THEN
      OPEN CUR_CONTRAGENT_HAND;
      FETCH CUR_CONTRAGENT_HAND INTO vRES;
      CLOSE CUR_CONTRAGENT_HAND;
      
      IF NVL(vRES, 0) = 0 THEN
        OPEN CUR_CONTRAGENT_TAR_PRC_HAND;
        FETCH CUR_CONTRAGENT_TAR_PRC_HAND INTO vRES;
        CLOSE CUR_CONTRAGENT_TAR_PRC_HAND;
      END IF;      
      
    END IF;
    
    RETURN vRES;
  END IF;  
END;
/
