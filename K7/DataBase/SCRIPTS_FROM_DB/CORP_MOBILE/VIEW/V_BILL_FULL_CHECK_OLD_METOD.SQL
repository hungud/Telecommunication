
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_BILL_FULL_CHECK_OLD_METOD" ("ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "ABONKA", "CALLS", "SINGLE_PAYMENTS", "DISCOUNTS", "BILL_SUM", "COMPLETE_BILL", "ABON_MAIN", "ABON_ADD", "ABON_OTHER", "SINGLE_MAIN", "SINGLE_ADD", "SINGLE_PENALTI", "SINGLE_CHANGE_TARIFF", "SINGLE_TURN_ON_SERV", "SINGLE_CORRECTION_ROUMING", "SINGLE_INTRA_WEB", "SINGLE_VIEW_BLACK_LIST", "SINGLE_OTHER", "DISCOUNT_YEAR", "DISCOUNT_SMS_PLUS", "DISCOUNT_CALL", "DISCOUNT_COUNT_ON_PHONES", "DISCOUNT_OTHERS", "CALLS_COUNTRY", "CALLS_SITY", "CALLS_LOCAL", "CALLS_SMS_MMS", "CALLS_GPRS", "CALLS_RUS_RPP", "CALLS_ALL", "ROUMING_NATIONAL", "ROUMING_INTERNATIONAL", "DATE_CREATED", "USER_CREATED", "USER_LAST_UPDATED", "DATE_LAST_UPDATED", "DISCOUNT_SOVINTEL", "BAN") AS 
  select "ACCOUNT_ID","YEAR_MONTH","PHONE_NUMBER","ABONKA","CALLS","SINGLE_PAYMENTS","DISCOUNTS","BILL_SUM","COMPLETE_BILL","ABON_MAIN","ABON_ADD","ABON_OTHER","SINGLE_MAIN","SINGLE_ADD","SINGLE_PENALTI","SINGLE_CHANGE_TARIFF","SINGLE_TURN_ON_SERV","SINGLE_CORRECTION_ROUMING","SINGLE_INTRA_WEB","SINGLE_VIEW_BLACK_LIST","SINGLE_OTHER","DISCOUNT_YEAR","DISCOUNT_SMS_PLUS","DISCOUNT_CALL","DISCOUNT_COUNT_ON_PHONES","DISCOUNT_OTHERS","CALLS_COUNTRY","CALLS_SITY","CALLS_LOCAL","CALLS_SMS_MMS","CALLS_GPRS","CALLS_RUS_RPP","CALLS_ALL","ROUMING_NATIONAL","ROUMING_INTERNATIONAL","DATE_CREATED","USER_CREATED","USER_LAST_UPDATED","DATE_LAST_UPDATED","DISCOUNT_SOVINTEL","BAN" 
  from db_loader_full_finance_bill fb
  where not exists (select 1 
                      from db_loader_bills b
                      where FB.ACCOUNT_ID=B.ACCOUNT_ID
                        and FB.year_month=B.year_month
                        and FB.PHONE_NUMBER =B.PHONE_NUMBER
                        and FB.BILL_SUM = B.BILL_SUM
                        and FB.SINGLE_PAYMENTS =B.SINGLE_PAYMENTS
                        and FB.DISCOUNTS =B.DISCOUNT_VALUE
                        and FB.ABON_ADD = B.SUBSCRIBER_PAYMENT_ADD
                        and FB.ABON_MAIN = B.SUBSCRIBER_PAYMENT_MAIN
                        --and FB.CALLS = b.
                        and FB.COMPLETE_BILL = 1
                      )