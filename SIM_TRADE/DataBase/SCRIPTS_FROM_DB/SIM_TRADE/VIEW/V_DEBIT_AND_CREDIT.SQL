
  CREATE OR REPLACE FORCE VIEW "SIM_TRADE"."V_DEBIT_AND_CREDIT" ("YEAR_MONTH", "PHONE_NUMBER", "BEELINE_BILL", "CLIENT_BILL", "PAYMENTS", "PAYMENTS_FULL", "BALANCE_ON_BEGIN", "CONTRACT_DATE", "CONTRACT_NUM") AS 
  SELECT 
--
--Version=5
--
--V.5   Афросин 25.05.2015 Переделал поле CONTRACT_NUM - туда брались данные не из той таблицы
--Version = 4 Овсянников: Добавлены новые поля в выборку 15.10.2012
--Version = 3 Овсянников: Добавлены новые поля в выборке по деталям по счёту 11.10.2012
--Version = 2 Овсянников: Добавлено новое поле в выборке CONTRACT_NUM 11.10.2012   
   
   v.YEAR_MONTH,
          v.PHONE_NUMBER,
          v.BILL_SUM_OLD BEELINE_BILL,
          V.BILL_SUM_NEW CLIENT_BILL,
          (SELECT
              SUM (P.PAYMENT_SUM)
             FROM DB_LOADER_PAYMENTS P
             WHERE 
              P.PHONE_NUMBER = V.PHONE_NUMBER
              AND TO_CHAR (P.PAYMENT_DATE, 'YYYYMM') = v.YEAR_MONTH
          )
             PAYMENTS,
             
          (
            SELECT
              SUM (P.PAYMENT_SUM)
            FROM
              V_FULL_BALANCE_PAYMENTS P
            WHERE
              P.PHONE_NUMBER = V.PHONE_NUMBER
              AND TO_CHAR (P.PAYMENT_DATE, 'YYYYMM') = v.YEAR_MONTH
           )
             PAYMENTS_FULL,
          GET_ABONENT_BALANCE (
             V.PHONE_NUMBER,
             TO_DATE (v.YEAR_MONTH || '01', 'YYYYMMDD') - 1
             )
            BALANCE_ON_BEGIN,
          
          (SELECT C.CONTRACT_DATE
             FROM V_CONTRACTS c
            WHERE     c.PHONE_NUMBER_FEDERAL = v.PHONE_NUMBER
                  AND C.CONTRACT_CANCEL_DATE IS NULL
                  AND ROWNUM = 1
            )
             CONTRACT_DATE,
             (SELECT ACCOUNT_NUMBER
             FROM ACCOUNTS
            WHERE ACCOUNT_ID = v.ACCOUNT_ID)
             CONTRACT_NUM
     FROM V_BILL_FINANCE_FOR_CLIENTS v