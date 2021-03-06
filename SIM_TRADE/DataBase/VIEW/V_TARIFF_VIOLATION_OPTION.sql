CREATE OR REPLACE VIEW V_TARIFF_VIOLATION_OPTION AS
  SELECT C.PHONE_NUMBER_FEDERAL,
         TR.TARIFF_CODE,
         TR.TARIFF_NAME,
         OT.OPTION_CODE,
         OT.OPTION_NAME
    FROM CONTRACTS C,
         TARIFF_AND_SERVICE_CONTACT TS,
         TARIFFS TR,
         TARIFF_OPTIONS OT
    WHERE C.CURR_TARIFF_ID = TS.TARIFF_ID(+)
      AND TS.TARIFF_ID IS NOT NULL
      AND TS.TARIFF_ID = TR.TARIFF_ID(+)
      AND TS.TARIFF_OPTION_ID = OT.TARIFF_OPTION_ID(+)
      AND EXISTS (SELECT 1
                    FROM DB_LOADER_ACCOUNT_PHONES DP
                    WHERE DP.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
                      AND DP.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM')))
      AND NOT EXISTS (SELECT 1
                        FROM CONTRACT_CANCELS CC
                        WHERE CC.CONTRACT_ID = C.CONTRACT_ID)
      AND NOT EXISTS (SELECT 1
                        FROM DB_LOADER_ACCOUNT_PHONE_OPTS DB
                        WHERE DB.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
                          AND DB.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
                          AND (DB.OPTION_CODE = OT.OPTION_CODE
                              OR (DB.OPTION_CODE IN ('RDIRECT_S', 'RDIRECT_K', 'RDIRECT_C', 'RDIRECT_A')
                                  AND OT.OPTION_CODE IN ('RDIRECT_S', 'RDIRECT_K', 'RDIRECT_C', 'RDIRECT_A')))); 

--GRANT SELECT ON V_TARIFF_VIOLATION_OPTION TO CORP_MOBILE_ROLE;                        

--GRANT SELECT ON V_TARIFF_VIOLATION_OPTION TO LONTANA_ROLE;                            