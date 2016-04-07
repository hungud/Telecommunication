create OR REPLACE view V_DEBIT_AND_CREDIT AS
--Versions = 2 Овсянников: Добавлено новое поле в выборке CONTRACT_NUM 11.10.2012
--Versions = 3 Овсянников: Добавлены новые поля в выборке по деталям по счёту 11.10.2012
--Versions = 4 Овсянников: Добавлены новые поля в выборку 15.10.2012
   SELECT v.YEAR_MONTH,
          v.PHONE_NUMBER,
          v.BILL_SUM_OLD BEELINE_BILL,
          V.BILL_SUM_NEW CLIENT_BILL,
          (SELECT SUM (P.PAYMENT_SUM)
             FROM DB_LOADER_PAYMENTS P
            WHERE     P.PHONE_NUMBER = V.PHONE_NUMBER
              AND TO_CHAR(P.PAYMENT_DATE,'YYYYMM') = v.YEAR_MONTH)
             PAYMENTS,
          (SELECT SUM (P.PAYMENT_SUM)
             FROM V_FULL_BALANCE_PAYMENTS P
            WHERE     P.PHONE_NUMBER = V.PHONE_NUMBER
                  AND TO_CHAR(P.PAYMENT_DATE,'YYYYMM') = v.YEAR_MONTH)
             PAYMENTS_FULL,
          GET_ABONENT_BALANCE (V.PHONE_NUMBER, TO_DATE(v.YEAR_MONTH||'01','YYYYMMDD')) BALANCE_ON_BEGIN,
          (SELECT C.CONTRACT_DATE
             FROM V_CONTRACTS c
            WHERE     c.PHONE_NUMBER_FEDERAL = v.PHONE_NUMBER
                  AND C.CONTRACT_CANCEL_DATE IS NULL
                  AND ROWNUM = 1)
             CONTRACT_DATE
     FROM V_BILL_FINANCE_FOR_CLIENTS v

GRANT SELECT ON V_DEBIT_AND_CREDIT TO SIM_TRADE_ROLE;
