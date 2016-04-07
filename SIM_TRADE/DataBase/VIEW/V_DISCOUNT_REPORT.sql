CREATE OR REPLACE VIEW V_DISCOUNT_REPORT AS
--Version=5
--
-- ����� � ������ �� �����
--
SELECT DB_LOADER_BILLS.ACCOUNT_ID,
       DB_LOADER_BILLS.YEAR_MONTH,
       NVL(TARIFFS.TARIFF_NAME, DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE) TARIFF_NAME,
       DB_LOADER_BILLS.PHONE_NUMBER,
       DB_LOADER_BILLS.BILL_SUM,
       DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN,
       -DB_LOADER_BILLS.DISCOUNT_VALUE AS DISCOUNT_VALUE,
       CASE 
         WHEN DB_LOADER_BILLS.BILL_SUM = 0 THEN 0 
         ELSE CASE
                WHEN DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN=0 THEN 0
                ELSE - ROUND(DB_LOADER_BILLS.DISCOUNT_VALUE / DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN * 100, 2)
              END
       END DISCOUNT_PERCENT
  FROM DB_LOADER_BILLS,
       DB_LOADER_ACCOUNT_PHONES,
       TARIFFS
  WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=DB_LOADER_BILLS.PHONE_NUMBER
    AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH=DB_LOADER_BILLS.YEAR_MONTH
    AND TARIFFS.TARIFF_ID(+)=GET_PHONE_TARIFF_ID(DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER,
                                                 DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE,
                                                 DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME)
    AND DB_LOADER_BILLS.BILL_SUM <> 0
  ORDER BY TARIFF_NAME, DB_LOADER_BILLS.PHONE_NUMBER
/