CREATE OR REPLACE VIEW V_BILL_FOR_DILER_V1 AS
-- Version = 1
--
-- 1.
  SELECT VN.ACCOUNT_ID,
         VN.YEAR_MONTH,
         VN.PHONE_NUMBER,         
         BILL_SUM_ORIGIN,
         BILL_SUM,
         DISCOUNT_VALUE,
         DILER_PAYMENT,
         DILER_PAYMENT_FULL,
         SUBSCRIBER_PAYMENT_NEW,
         SUBSCRIBER_PAYMENT_OLD,
         SUBSCRIBER_PAYMENT_ADD_OLD,
         CASE
           WHEN VN.BILL_SUM>0 THEN
             LOADER5_PCKG.CALC_OPTION_COST(VN.ACCOUNT_ID, VN.YEAR_MONTH, VN.PHONE_NUMBER, VN.TARIFF_ID, 1)
           ELSE 0
         END AS OPTION_COST_DILER, 
         CASE
           WHEN VN.BILL_SUM>0 THEN
             LOADER5_PCKG.CALC_OPTION_COST(VN.ACCOUNT_ID, VN.YEAR_MONTH, VN.PHONE_NUMBER, VN.TARIFF_ID, 1, 0)
           ELSE 0
         END AS OPTION_COST_DILER_BEELINE, 
         CASE
           WHEN VN.BILL_SUM>0 THEN
             LOADER5_PCKG.CALC_OPTION_COST(VN.ACCOUNT_ID, VN.YEAR_MONTH, VN.PHONE_NUMBER, VN.TARIFF_ID, 0)
           ELSE 0
         END AS OPTION_COST_FULL,
         (SELECT T.TARIFF_NAME
            FROM TARIFFS T
            WHERE T.TARIFF_ID = VN.TARIFF_ID) TARIFF_NAME,
         VN.TAIL,
         CHECK_LONG_PLUS_BALANCE,
         NVL((select TRUNC(c.INSTALLMENT_PAYMENT_SUM / C.INSTALLMENT_PAYMENT_MONTHS, 4)
                from CONTRACTS C
                WHERE C.PHONE_NUMBER_FEDERAL = VN.PHONE_NUMBER
                  AND C.INSTALLMENT_PAYMENT_SUM > 0
                  AND NOT EXISTS (SELECT 1
                                    FROM CONTRACT_CANCELS CC
                                    WHERE CC.CONTRACT_ID = C.CONTRACT_ID)), 
             0) AS INSTALLMENT_PAYMENT_SUM,
         0 AS DILER_SUMM_OLD_MONTH_IN_MINUS
    FROM (SELECT V.ACCOUNT_ID,
                 V.YEAR_MONTH,
                 V.PHONE_NUMBER,
                 V.BILL_SUM_OLD BILL_SUM_ORIGIN,
                 TB.BILL_SUMM BILL_SUM,
                 TB.DISCOUNT DISCOUNT_VALUE,
                 CASE
                   WHEN TB.BILL_SUMM > 0 THEN
                     LOADER5_PCKG.CALC_DILER_PAYMENT(V.ACCOUNT_ID, V.YEAR_MONTH, V.PHONE_NUMBER, 0)
                   ELSE 0
                 END AS DILER_PAYMENT,
                 CASE
                   WHEN TB.BILL_SUMM > 0 THEN
                     LOADER5_PCKG.CALC_DILER_PAYMENT(V.ACCOUNT_ID, V.YEAR_MONTH, V.PHONE_NUMBER, 1)
                   ELSE 0
                 END AS DILER_PAYMENT_FULL,
                 TB.ABON_TP SUBSCRIBER_PAYMENT_NEW,
                 TRUNC(V.ABON_TP_OLD, 4) SUBSCRIBER_PAYMENT_OLD,
                 V.ABON_ADD_OLD SUBSCRIBER_PAYMENT_ADD_OLD,
                 GET_ABONENT_BALANCE(V.PHONE_NUMBER, LAST_DAY(TO_DATE(V.YEAR_MONTH||'01', 'YYYYMMDD'))) TAIL,
                 CASE
                   WHEN V.ACCOUNT_ID=1 AND V.YEAR_MONTH<=201002 THEN 0
                   ELSE CHECK_LONG_PLUS_BALANCE(V.PHONE_NUMBER, V.YEAR_MONTH)
                 END CHECK_LONG_PLUS_BALANCE,
                 (SELECT AP.TARIFF_ID
                    FROM V_BILL_ABON_PER_FOR_CLIENT AP
                    WHERE AP.ACCOUNT_ID = V.ACCOUNT_ID
                      AND AP.YEAR_MONTH = V.YEAR_MONTH
                      AND AP.PHONE_NUMBER = V.PHONE_NUMBER
                      AND AP.TARIFF_CODE IS NOT NULL
                      AND AP.DATE_END = (SELECT MAX(AP2.DATE_END)
                                           FROM V_BILL_ABON_PER_FOR_CLIENT AP2
                                           WHERE AP2.ACCOUNT_ID = AP.ACCOUNT_ID
                                             AND AP2.YEAR_MONTH = AP.YEAR_MONTH
                                             AND AP2.PHONE_NUMBER = AP.PHONE_NUMBER)
                      AND ROWNUM = 1) TARIFF_ID
            FROM v_phone_beeline_bills V,
                 TARIFER_BILL_FOR_CLIENTS TB, -- V_BILL_FINANCE_FOR_CLIENTS V,
                 ACCOUNTS AC,
                 BILL_FOR_DILER_SAVED DS
            WHERE V.YEAR_MONTH = TB.YEAR_MONTH(+)
              AND V.PHONE_NUMBER = TB.PHONE_NUMBER(+)
              AND V.YEAR_MONTH >=201501
              AND V.ACCOUNT_ID=AC.ACCOUNT_ID(+)
              AND AC.DILER_PAYMETS=1
              AND V.ACCOUNT_ID = DS.ACCOUNT_ID(+)
              AND V.YEAR_MONTH = DS.YEAR_MONTH(+)
              AND V.PHONE_NUMBER = DS.PHONE_NUMBER(+)
              AND DS.PHONE_NUMBER IS NULL 
        --      AND CHECK_CONTRACTS_BY_YEAR_MONTH(V.PHONE_NUMBER, V.YEAR_MONTH)=1
              AND EXISTS (SELECT 1
                            FROM CONTRACTS C, contract_cancels CC
                            WHERE C.PHONE_NUMBER_FEDERAL = V.PHONE_NUMBER
                              AND C.CONTRACT_ID = CC.CONTRACT_ID(+)
                              AND C.CONTRACT_DATE < ADD_MONTHS(TO_DATE(V.YEAR_MONTH||'01', 'yyyymmdd'), 1)
                              AND (CC.CONTRACT_CANCEL_DATE IS NULL OR CC.CONTRACT_CANCEL_DATE >= TO_DATE(V.YEAR_MONTH||'01', 'yyyymmdd'))
                            GROUP BY C.PHONE_NUMBER_FEDERAL)) VN
  UNION ALL
  SELECT DS.ACCOUNT_ID,
         DS.YEAR_MONTH,
         DS.PHONE_NUMBER,
         DS.BILL_SUM_ORIGIN,
         DS.BILL_SUM,     
         DS.DISCOUNT_VALUE,
         DS.DILER_PAYMENT,
         DS.DILER_PAYMENT_FULL,
         DS.SUBSCRIBER_PAYMENT_NEW,
         DS.SUBSCRIBER_PAYMENT_OLD,
         DS.SUBSCRIBER_PAYMENT_ADD_OLD,
         DS.OPTION_COST_DILER, 
         DS.OPTION_COST_DILER_BEELINE, 
         DS.OPTION_COST_FULL,
         DS.TARIFF_NAME,
         DS.TAIL,
         DS.CHECK_LONG_PLUS_BALANCE,
         DS.INSTALLMENT_PAYMENT_SUM,
         DS.DILER_SUMM_OLD_MONTH_IN_MINUS
    FROM BILL_FOR_DILER_SAVED DS
    WHERE EXISTS (SELECT 1
                    FROM CONTRACTS C, contract_cancels CC
                    WHERE C.PHONE_NUMBER_FEDERAL = DS.PHONE_NUMBER
                      AND C.CONTRACT_ID = CC.CONTRACT_ID(+)
                      AND C.CONTRACT_DATE < ADD_MONTHS(TO_DATE(DS.YEAR_MONTH||'01', 'yyyymmdd'), 1)
                      AND (CC.CONTRACT_CANCEL_DATE IS NULL OR CC.CONTRACT_CANCEL_DATE >= TO_DATE(DS.YEAR_MONTH||'01', 'yyyymmdd'))
                    GROUP BY C.PHONE_NUMBER_FEDERAL)