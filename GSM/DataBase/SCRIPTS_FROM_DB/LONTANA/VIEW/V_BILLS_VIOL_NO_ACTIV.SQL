
  CREATE OR REPLACE FORCE VIEW "LONTANA"."V_BILLS_VIOL_NO_ACTIV" ("YEAR_MONTH", "ACCOUNT_ID", "PHONE_NUMBER", "ABONKA", "CALLS", "SINGLE_PAYMENTS", "DISCOUNTS", "BILL_SUM") AS 
  SELECT FB.YEAR_MONTH,
         FB.ACCOUNT_ID,
         FB.PHONE_NUMBER,
         FB.ABONKA,
         FB.CALLS,
         FB.SINGLE_PAYMENTS,
         FB.DISCOUNTS,
         FB.BILL_SUM
    FROM DB_LOADER_FULL_FINANCE_BILL FB
    WHERE FB.BILL_SUM > 0
      AND FB.COMPLETE_BILL = 1
      AND NOT EXISTS (SELECT 1 
                        FROM DB_LOADER_ACCOUNT_PHONE_HISTS H
                        WHERE H.PHONE_NUMBER = FB.PHONE_NUMBER
                          AND H.PHONE_IS_ACTIVE = 1
                          AND H.END_DATE >= TO_DATE(TO_CHAR(FB.YEAR_MONTH)||'01', 'YYYYMMDD')
                          AND H.BEGIN_DATE < ADD_MONTHS(TO_DATE(TO_CHAR(FB.YEAR_MONTH)||'01', 'YYYYMMDD'), 1))
      AND EXISTS (SELECT 1 
                    FROM DB_LOADER_ACCOUNT_PHONE_HISTS H
                    WHERE H.PHONE_NUMBER = FB.PHONE_NUMBER
                      AND H.END_DATE >= TO_DATE(TO_CHAR(FB.YEAR_MONTH)||'01', 'YYYYMMDD')
                      AND H.BEGIN_DATE < ADD_MONTHS(TO_DATE(TO_CHAR(FB.YEAR_MONTH)||'01', 'YYYYMMDD'), 1))
  UNION ALL
  SELECT B.YEAR_MONTH,
         B.ACCOUNT_ID,
         B.PHONE_NUMBER,
         B.SUBSCRIBER_PAYMENT_MAIN + B.SUBSCRIBER_PAYMENT_ADD AS ABONKA,
         B.CALLS_OTHER_COUNTRY_COST + B.CALLS_OTHER_CITY_COST + B.CALLS_LOCAL_COST
          + B.INTERNET_COST + B.MESSAGES_COST AS CALLS,
         B.SINGLE_PAYMENTS,
         B.DISCOUNT_VALUE AS DISCOUNTS,
         B.BILL_SUM
    FROM DB_LOADER_BILLS B,
         DB_LOADER_FULL_FINANCE_BILL FB
    WHERE B.BILL_SUM>0
      AND B.ACCOUNT_ID = FB.ACCOUNT_ID(+) 
      AND B.YEAR_MONTH = FB.YEAR_MONTH(+) 
      AND B.PHONE_NUMBER = FB.PHONE_NUMBER(+)
      AND FB.PHONE_NUMBER IS NULL  
      AND NOT EXISTS (SELECT 1 
                        FROM DB_LOADER_ACCOUNT_PHONE_HISTS H
                        WHERE H.PHONE_NUMBER = FB.PHONE_NUMBER
                          AND H.PHONE_IS_ACTIVE = 1
                          AND TRUNC(H.END_DATE) >= B.DATE_BEGIN
                          AND TRUNC(H.BEGIN_DATE) <= b.DATE_END)
      AND EXISTS (SELECT 1 
                    FROM DB_LOADER_ACCOUNT_PHONE_HISTS H
                    WHERE H.PHONE_NUMBER = FB.PHONE_NUMBER
                      AND TRUNC(H.END_DATE) >= B.DATE_BEGIN
                      AND TRUNC(H.BEGIN_DATE) <= b.DATE_END) 