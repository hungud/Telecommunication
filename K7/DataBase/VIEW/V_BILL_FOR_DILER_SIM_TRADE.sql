CREATE OR REPLACE VIEW V_BILL_FOR_DILER_SIM_TRADE AS
SELECT B.ACCOUNT_ID, B.YEAR_MONTH, B.PHONE_NUMBER,
         B.BILL_SUM AS BILL_SUM_ORIGIN, 
         V1.BILL_SUM AS BILL_SUM,
         TRUNC(CASE
                 WHEN (B.BILL_SUM > 0)
                       AND (  B.SUBSCRIBER_PAYMENT_MAIN + B.SUBSCRIBER_PAYMENT_ADD + B.SINGLE_PAYMENTS + B.DISCOUNT_VALUE - B.BILL_SUM * 0.012 / 1.012 > 0 )
                   THEN TRUNC(B.SUBSCRIBER_PAYMENT_MAIN + B.SUBSCRIBER_PAYMENT_ADD + B.SINGLE_PAYMENTS + B.DISCOUNT_VALUE - B.BILL_SUM * 0.012 / 1.012, 2)
                 ELSE 0
               END / 1.18, 2) AS KOMISSIYA,
         b.tariff_code      
    FROM V_BILL_FOR_CLIENT V1, 
          DB_LOADER_BILLS B
    WHERE B.PHONE_NUMBER = V1.PHONE_NUMBER(+) 
      AND B.YEAR_MONTH = V1.YEAR_MONTH(+)
      AND B.ACCOUNT_ID = V1.ACCOUNT_ID(+)
      and b.YEAR_MONTH<=201207
  UNION ALL
  SELECT B.ACCOUNT_ID, B.YEAR_MONTH, B.PHONE_NUMBER,
         TRUNC(V2.BILL_SUM_OLD, 2) AS BILL_SUM_ORIGIN, 
         TRUNC(V2.BILL_SUM_NEW, 2) AS BILL_SUM,
         TRUNC(CASE
                 WHEN (B.BILL_SUM > 0) THEN 
                   TRUNC(B.ABON_MAIN + B.SINGLE_MAIN + B.ABON_ADD + B.SINGLE_ADD + B.DISCOUNT_SMS_PLUS + B.DISCOUNT_YEAR, 2)
                 ELSE 0
               END / 1.18, 2) AS KOMISSIYA,
         (select ap.tariff_code from db_loader_full_bill_abon_per ap where ap.account_id=b.account_id and ap.year_month=b.year_month and ap.phone_number=b.phone_number
          and ap.tariff_code is not null
          and (ap.date_begin,ap.date_end)
              =
              (select max(ap2.date_begin),max(ap2.date_end)
              from db_loader_full_bill_abon_per ap2 where ap2.account_id=b.account_id and ap2.year_month=b.year_month and ap2.phone_number=b.phone_number)
         ) tariff_code      
    FROM V_BILL_FINANCE_FOR_CLIENTS V2, 
          DB_LOADER_FULL_FINANCE_BILL B
    WHERE B.PHONE_NUMBER = V2.PHONE_NUMBER(+) 
      AND B.YEAR_MONTH = V2.YEAR_MONTH(+)
      AND B.ACCOUNT_ID = V2.ACCOUNT_ID(+)
      AND B.YEAR_MONTH>=201208
      AND B.COMPLETE_BILL = 1
      AND B.BILL_SUM >= 1 -- счета больше 1р
      AND (B.ABON_MAIN + B.SINGLE_MAIN + B.CALLS_ALL > 0) -- Сумма абонки за ТП и звонков больше 0
      AND EXISTS (SELECT 1
                    FROM CONTRACTS,
                         CONTRACT_CANCELS
                    WHERE CONTRACTS.PHONE_NUMBER_FEDERAL = B.PHONE_NUMBER
                      AND CONTRACTS.CONTRACT_DATE <= LAST_DAY(TO_DATE(TO_CHAR(B.YEAR_MONTH)||'01', 'YYYYMMDD'))
                      AND CONTRACTS.CONTRACT_ID = CONTRACT_CANCELS.CONTRACT_ID(+)
                      AND (CONTRACT_CANCELS.CONTRACT_CANCEL_DATE IS NULL 
                            OR CONTRACT_CANCELS.CONTRACT_CANCEL_DATE >= TO_DATE(TO_CHAR(B.YEAR_MONTH)||'01', 'YYYYMMDD'))
                 );
