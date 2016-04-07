CREATE OR REPLACE FUNCTION MCBALANCE_TABLE(
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN MCBALANCE_ROW_TYPE_TAB PIPELINED AS
--#Version=2
--
--v.2 Афроснин 22.07.2015 Добавил обработку ошибок
--v.1 Афроснин 15.07.2015 Возвращает по REST API суммы САС и баланса, доступного для МК.
--
  vRESTS CORP_MOBILE.beeline_rest_api_pckg.TRestsMCBalance;
  vREST  CORP_MOBILE.TInfoRestMCBalance;
  I BINARY_INTEGER;
BEGIN
  begin
    vRESTS := beeline_api_pckg.mcBalance(pPHONE_NUMBER);
    I := vRESTS.FIRST;
    WHILE I IS NOT NULL LOOP
      vREST := vRESTS(I);

      PIPE ROW(
          MCBALANCE_ROW_TYPE(
            vREST.phone ,
            vREST.bsasValue,
            vREST.bmkValue)
        );
      I := vRESTS.NEXT(I);
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;
END;
/
GRANT EXECUTE ON MCBALANCE_TABLE TO CORP_MOBILE_ROLE;
GRANT EXECUTE ON MCBALANCE_TABLE TO CORP_MOBILE_ROLE_RO;