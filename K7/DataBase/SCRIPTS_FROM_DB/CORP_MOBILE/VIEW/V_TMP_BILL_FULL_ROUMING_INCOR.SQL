
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_TMP_BILL_FULL_ROUMING_INCOR" ("ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "ABONKA", "CALLS", "SINGLE_PAYMENTS", "DISCOUNTS", "BILL_SUM", "COMPLETE_BILL", "ABON_MAIN", "ABON_ADD", "ABON_OTHER", "SINGLE_MAIN", "SINGLE_ADD", "SINGLE_PENALTI", "SINGLE_CHANGE_TARIFF", "SINGLE_TURN_ON_SERV", "SINGLE_CORRECTION_ROUMING", "SINGLE_INTRA_WEB", "SINGLE_VIEW_BLACK_LIST", "SINGLE_OTHER", "DISCOUNT_YEAR", "DISCOUNT_SMS_PLUS", "DISCOUNT_CALL", "DISCOUNT_COUNT_ON_PHONES", "DISCOUNT_OTHERS", "CALLS_COUNTRY", "CALLS_SITY", "CALLS_LOCAL", "CALLS_SMS_MMS", "CALLS_GPRS", "CALLS_RUS_RPP", "CALLS_ALL", "ROUMING_NATIONAL", "ROUMING_INTERNATIONAL") AS 
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
          "SINGLE_CORRECTION_ROUMING",
          "SINGLE_INTRA_WEB",
          "SINGLE_VIEW_BLACK_LIST",
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
          "ROUMING_NATIONAL",
          "ROUMING_INTERNATIONAL"
     FROM TMPDB_LOADER_FULL_FINANCE_BILL FB
    WHERE     FB.BILL_SUM <> 0
          AND (   (    FB.ROUMING_INTERNATIONAL <> 0
                   AND FB.ROUMING_INTERNATIONAL <>
                          NVL (
                             (SELECT SUM (MNR.ROUMING_SUM)
                                FROM TMPDB_LOADER_FULL_BILL_MN_ROW MNR
                               WHERE     MNR.ACCOUNT_ID = FB.ACCOUNT_ID
                                     AND MNR.YEAR_MONTH = FB.YEAR_MONTH
                                     AND MNR.PHONE_NUMBER = FB.PHONE_NUMBER),
                             0))
               OR (    FB.ROUMING_NATIONAL <> 0
                   AND FB.ROUMING_NATIONAL <>
                          NVL (
                             (SELECT SUM (MNR.ROUMING_SUM)
                                FROM TMPDB_LOADER_FULL_BILL_MG_ROW MNR
                               WHERE     MNR.ACCOUNT_ID = FB.ACCOUNT_ID
                                     AND MNR.YEAR_MONTH = FB.YEAR_MONTH
                                     AND MNR.PHONE_NUMBER = FB.PHONE_NUMBER),
                             0)))