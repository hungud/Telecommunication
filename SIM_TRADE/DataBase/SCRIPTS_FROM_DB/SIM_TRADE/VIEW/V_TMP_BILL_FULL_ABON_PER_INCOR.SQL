
  CREATE OR REPLACE FORCE VIEW "SIM_TRADE"."V_TMP_BILL_FULL_ABON_PER_INCOR" ("ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "ABONKA", "CALLS", "SINGLE_PAYMENTS", "DISCOUNTS", "BILL_SUM", "COMPLETE_BILL", "ABON_MAIN", "ABON_ADD", "ABON_OTHER", "SINGLE_MAIN", "SINGLE_ADD", "SINGLE_PENALTI", "SINGLE_CHANGE_TARIFF", "SINGLE_TURN_ON_SERV", "SINGLE_OTHER", "DISCOUNT_YEAR", "DISCOUNT_SMS_PLUS", "DISCOUNT_CALL", "DISCOUNT_COUNT_ON_PHONES", "DISCOUNT_OTHERS", "CALLS_COUNTRY", "CALLS_SITY", "CALLS_LOCAL", "CALLS_SMS_MMS", "CALLS_GPRS", "CALLS_RUS_RPP", "CALLS_ALL", "SINGLE_CORRECTION_ROUMING", "ROUMING_INTERNATIONAL") AS 
  SELECT "ACCOUNT_ID",
          "YEAR_MONTH",
          "PHONE_NUMBER",
          "ABONKA",
          "CALLS",
          "SINGLE_PAYMENTS",
          "DISCOUNTS",
          "BILL_SUM",
          "COMPLETE_BILL",
          "ABON_MAIN",
          "ABON_ADD",
          "ABON_OTHER",
          "SINGLE_MAIN",
          "SINGLE_ADD",
          "SINGLE_PENALTI",
          "SINGLE_CHANGE_TARIFF",
          "SINGLE_TURN_ON_SERV",
          "SINGLE_OTHER",
          "DISCOUNT_YEAR",
          "DISCOUNT_SMS_PLUS",
          "DISCOUNT_CALL",
          "DISCOUNT_COUNT_ON_PHONES",
          "DISCOUNT_OTHERS",
          "CALLS_COUNTRY",
          "CALLS_SITY",
          "CALLS_LOCAL",
          "CALLS_SMS_MMS",
          "CALLS_GPRS",
          "CALLS_RUS_RPP",
          "CALLS_ALL",
          "SINGLE_CORRECTION_ROUMING",
          "ROUMING_INTERNATIONAL"
     FROM TMPDB_LOADER_FULL_FINANCE_BILL FB
    WHERE     FB.BILL_SUM <> 0
          AND FB.ABONKA <> 0
          AND FB.ABONKA <>
                 NVL (
                    (SELECT SUM (AP.ABON_ALL)
                       FROM TMPDB_LOADER_FULL_BILL_AB_PER AP
                      WHERE     AP.ACCOUNT_ID = FB.ACCOUNT_ID
                            AND AP.YEAR_MONTH = FB.YEAR_MONTH
                            AND AP.PHONE_NUMBER = FB.PHONE_NUMBER),
                    0)