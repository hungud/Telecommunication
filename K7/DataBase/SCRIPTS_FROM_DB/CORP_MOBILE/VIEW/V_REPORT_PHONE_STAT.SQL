
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_REPORT_PHONE_STAT" ("ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "BALANCE_VALUE", "OPERATOR_NAME", "TARIFF_NAME", "TARIFF_ID", "ESTIMATE_SUM", "ZEROCOST_OUTCOME_MINUTES", "ZEROCOST_OUTCOME_COUNT", "CALLS_COUNT", "CALLS_MINUTES", "CALLS_COST", "SMS_COUNT", "SMS_COST", "MMS_COUNT", "MMS_COST", "INTERNET_MB", "INTERNET_COST", "OTHER_SERVICES_COST", "PHONE_STATUS") AS 
  SELECT                                                         --#Version=5
         DB_LOADER_PHONE_STAT.ACCOUNT_ID,
          DB_LOADER_PHONE_STAT.YEAR_MONTH,
          DB_LOADER_PHONE_STAT.PHONE_NUMBER,
          IOT_CURRENT_BALANCE.BALANCE AS BALANCE_VALUE,
          OPERATORS.OPERATOR_NAME,
          NVL (TARIFFS.TARIFF_NAME, DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE)
             AS TARIFF_NAME,
          TARIFFS.TARIFF_ID,
          DB_LOADER_PHONE_STAT.ESTIMATE_SUM,
          DB_LOADER_PHONE_STAT.ZEROCOST_OUTCOME_MINUTES,
          DB_LOADER_PHONE_STAT.ZEROCOST_OUTCOME_COUNT,
          DB_LOADER_PHONE_STAT.CALLS_COUNT,
          DB_LOADER_PHONE_STAT.CALLS_MINUTES,
          DB_LOADER_PHONE_STAT.CALLS_COST,
          DB_LOADER_PHONE_STAT.SMS_COUNT,
          DB_LOADER_PHONE_STAT.SMS_COST,
          DB_LOADER_PHONE_STAT.MMS_COUNT,
          DB_LOADER_PHONE_STAT.MMS_COST,
          DB_LOADER_PHONE_STAT.INTERNET_MB,
          DB_LOADER_PHONE_STAT.INTERNET_COST,
            DB_LOADER_PHONE_STAT.ESTIMATE_SUM
          - DB_LOADER_PHONE_STAT.CALLS_COST
          - DB_LOADER_PHONE_STAT.SMS_COST
          - DB_LOADER_PHONE_STAT.MMS_COST
          - DB_LOADER_PHONE_STAT.INTERNET_COST
             AS OTHER_SERVICES_COST,
          CASE
             WHEN DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE = 1 THEN 'Акт.'
             WHEN DB_LOADER_ACCOUNT_PHONES.CONSERVATION = 1 THEN 'Сохр.'
             WHEN DB_LOADER_ACCOUNT_PHONES.SYSTEM_BLOCK = 1 THEN 'Мош.'
             ELSE 'Блок.'
          END
             AS PHONE_STATUS
     FROM DB_LOADER_PHONE_STAT,
          DB_LOADER_ACCOUNT_PHONES,
          TARIFFS,
          ACCOUNTS,
          OPERATORS,
          IOT_CURRENT_BALANCE
    WHERE     DB_LOADER_PHONE_STAT.PHONE_NUMBER =
                 DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER(+)
          AND DB_LOADER_PHONE_STAT.YEAR_MONTH =
                 DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH(+)
          AND DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER =
                 IOT_CURRENT_BALANCE.PHONE_NUMBER(+)
          AND TARIFFS.TARIFF_ID(+) =
                 GET_PHONE_TARIFF_ID (
                    DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER,
                    DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE,
                    DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME)
          AND ACCOUNTS.ACCOUNT_ID(+) = DB_LOADER_PHONE_STAT.ACCOUNT_ID
          AND OPERATORS.OPERATOR_ID(+) = ACCOUNTS.OPERATOR_ID