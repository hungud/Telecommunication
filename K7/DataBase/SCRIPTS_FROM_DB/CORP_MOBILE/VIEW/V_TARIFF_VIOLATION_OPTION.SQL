
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_TARIFF_VIOLATION_OPTION" ("PHONE_NUMBER_FEDERAL", "TARIFF_CODE", "TARIFF_NAME", "OPTION_CODE", "OPTION_NAME") AS 
  SELECT -- 23.06.2015 - Матюнин И.
      -- Есть справочник "Справочник связей обязательных между тарифами и услугами" TARIFF_AND_SERVICE_CONTACT,
      -- и если в периоде для номера не загружены в список тарифных опций обязательные опции для тарифа, на котором находится , то они попадают в список! 
          C.PHONE_NUMBER_FEDERAL,
          TR.TARIFF_CODE,
          TR.TARIFF_NAME,
          OT.OPTION_CODE,
          OT.OPTION_NAME
     FROM CONTRACTS C,
          TARIFF_AND_SERVICE_CONTACT TS,
          TARIFFS TR,
          TARIFF_OPTIONS OT
    WHERE     C.CURR_TARIFF_ID = TS.TARIFF_ID(+)
          AND TS.TARIFF_ID IS NOT NULL
          AND TS.TARIFF_ID = TR.TARIFF_ID(+)
          AND TS.TARIFF_OPTION_ID = OT.TARIFF_OPTION_ID(+)
          AND EXISTS
                 (SELECT 1
                    FROM DB_LOADER_ACCOUNT_PHONES DP
                   WHERE     DP.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
                         AND DP.YEAR_MONTH =
                                TO_NUMBER (TO_CHAR (SYSDATE, 'YYYYMM')))
          AND NOT EXISTS
                 (SELECT 1
                    FROM CONTRACT_CANCELS CC
                   WHERE CC.CONTRACT_ID = C.CONTRACT_ID)
          AND NOT EXISTS
                     (SELECT 1
                        FROM DB_LOADER_ACCOUNT_PHONE_OPTS DB
                       WHERE     DB.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
                             AND DB.YEAR_MONTH =
                                    TO_NUMBER (TO_CHAR (SYSDATE, 'YYYYMM'))
                             AND (   DB.OPTION_CODE = OT.OPTION_CODE
                                  OR (    DB.OPTION_CODE IN ('RDIRECT_S',
                                                             'RDIRECT_K',
                                                             'RDIRECT_C',
                                                             'RDIRECT_A')
                                      AND OT.OPTION_CODE IN ('RDIRECT_S',
                                                             'RDIRECT_K',
                                                             'RDIRECT_C',
                                                             'RDIRECT_A'))))