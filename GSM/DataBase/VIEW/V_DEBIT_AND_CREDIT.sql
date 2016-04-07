create OR REPLACE view V_DEBIT_AND_CREDIT AS
--Versions = 2 Овсянников: Добавлено новое поле в выборке CONTRACT_NUM 11.10.2012
--Versions = 3 Овсянников: Добавлены новые поля в выборке по деталям по счёту 11.10.2012
--Versions = 4 Овсянников: Добавлены новые поля в выборку 15.10.2012
  select b.YEAR_MONTH,
         b.PHONE_NUMBER,
         B.DATE_BEGIN,
         B.DATE_END,
         b.BILL_SUM BEELINE_BILL,
         V.BILL_SUM_NEW CLIENT_BILL,
         V.ABON_TP_OLD,
         V.ABON_TP_NEW,
         V.ABON_ADD_OLD,
         V.ABON_ADD_NEW,
         V.CALLS_GPRS,
         V.CALLS_COUNTRY,
         V.CALLS_SMS_MMS,
         V.CALLS_LOCAL,
         V.CALLS_RUS_RPP,
         V.CALLS_SITY,
         V.DISCOUNT_OLD,
         V.DISCOUNT_NEW,
         V1.ROUMING_NATIONAL,
         V1.ROUMING_INTERNATIONAL,
         (SELECT SUM(P.PAYMENT_SUM)
            FROM DB_LOADER_PAYMENTS P
            WHERE P.PHONE_NUMBER=B.PHONE_NUMBER
              AND P.PAYMENT_DATE>=B.DATE_BEGIN
              AND P.PAYMENT_DATE<=B.DATE_END) PAYMENTS,              
         (SELECT SUM(P.PAYMENT_SUM)
            FROM V_FULL_BALANCE_PAYMENTS P
            WHERE P.PHONE_NUMBER=B.PHONE_NUMBER
              AND P.PAYMENT_DATE>=B.DATE_BEGIN
              AND P.PAYMENT_DATE<=B.DATE_END) PAYMENTS_FULL,
         GET_ABONENT_BALANCE(B.PHONE_NUMBER, B.DATE_BEGIN) BALANCE_ON_BEGIN,
         (select C.CONTRACT_DATE 
            from V_CONTRACTS c 
            WHERE c.PHONE_NUMBER_FEDERAL=b.PHONE_NUMBER
              and C.CONTRACT_CANCEL_DATE is null           
              and rownum=1) CONTRACT_DATE, 
         (select C.CONTRACT_NUM 
            from V_CONTRACTS c 
            WHERE c.PHONE_NUMBER_FEDERAL=b.PHONE_NUMBER
              and C.CONTRACT_CANCEL_DATE is null           
              and rownum=1) CONTRACT_NUM 
    from db_loader_bills b,
         V_BILL_FINANCE_FOR_CLIENTS v,
         V_BILL_FINANCE_FOR_CLIENT_DET v1
    where b.YEAR_MONTH=v.YEAR_MONTH(+)
      and b.PHONE_NUMBER=v.PHONE_NUMBER(+)
      and b.ACCOUNT_ID=v.ACCOUNT_ID(+)
      and b.YEAR_MONTH=v1.YEAR_MONTH(+)
      and b.PHONE_NUMBER=v1.PHONE_NUMBER(+)
      and b.ACCOUNT_ID=v1.ACCOUNT_ID(+)

GRANT SELECT ON V_DEBIT_AND_CREDIT TO LONTANA_ROLE;    
GRANT SELECT ON V_DEBIT_AND_CREDIT TO LONTANA_ROLE_RO;    
