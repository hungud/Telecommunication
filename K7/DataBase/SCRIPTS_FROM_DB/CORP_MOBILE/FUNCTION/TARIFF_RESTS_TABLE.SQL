
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."TARIFF_RESTS_TABLE" (
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN TARIFF_REST_ROW_TAB PIPELINED AS
--#Version=1
--
--v.1 Афроснин 13.02.2015 Возвращает остатки пакетов  по REST_API
--
  vRESTS CORP_MOBILE.beeline_rest_api_pckg.TRests;
  vREST  CORP_MOBILE.TInfoRest;
  I BINARY_INTEGER;
BEGIN
  vRESTS := beeline_api_pckg.rest_info_rests(pPHONE_NUMBER);
  I := vRESTS.FIRST;
  WHILE I IS NOT NULL LOOP
    vREST := vRESTS(I);

    PIPE ROW(
        TARIFF_REST_ROW_TYPE(
          pPHONE_NUMBER,
          vREST.unitType,
          vREST.restType,
          vREST.initialSize,
          vREST.currValue,
          vREST.nextValue,
          vREST.frequency,
          vREST.soc,
          vREST.socName,
          vREST.restName)
      );
    I := vRESTS.NEXT(I);
  END LOOP;
END;