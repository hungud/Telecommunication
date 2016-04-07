CREATE OR REPLACE VIEW V_BILLS_VIOL_NO_CONTRACT as
--Version=2
--2. ��������. ������� ������ ���� ACCOUNTS.ACCOUNT_NUMBER

  SELECT FB.YEAR_MONTH,
         FB.ACCOUNT_ID,
         FB.PHONE_NUMBER,
         FB.ABONKA,
         FB.CALLS,
         FB.SINGLE_PAYMENTS,
         FB.DISCOUNTS,
         FB.BILL_SUM,
         A.ACCOUNT_NUMBER
    FROM DB_LOADER_FULL_FINANCE_BILL FB, ACCOUNTS A
    WHERE FB.BILL_SUM > 0
      AND FB.COMPLETE_BILL = 1
      AND FB.ACCOUNT_ID = A.ACCOUNT_ID
      AND NOT EXISTS (SELECT 1 
                        FROM CONTRACTS C, 
                             CONTRACT_CANCELS CC
                        WHERE C.PHONE_NUMBER_FEDERAL = FB.PHONE_NUMBER
                          AND C.CONTRACT_ID = CC.CONTRACT_ID(+)
                          AND C.CONTRACT_DATE <= LAST_DAY(TO_DATE(TO_CHAR(FB.YEAR_MONTH)||'01', 'YYYYMMDD'))
                          AND (CC.CONTRACT_CANCEL_DATE IS NULL
                              OR CC.CONTRACT_CANCEL_DATE >= TO_DATE(TO_CHAR(FB.YEAR_MONTH)||'01', 'YYYYMMDD')) )
  UNION ALL
  SELECT B.YEAR_MONTH,
         B.ACCOUNT_ID,
         B.PHONE_NUMBER,
         B.SUBSCRIBER_PAYMENT_MAIN + B.SUBSCRIBER_PAYMENT_ADD AS ABONKA,
         B.CALLS_OTHER_COUNTRY_COST + B.CALLS_OTHER_CITY_COST + B.CALLS_LOCAL_COST
          + B.INTERNET_COST + B.MESSAGES_COST AS CALLS,
         B.SINGLE_PAYMENTS,
         B.DISCOUNT_VALUE AS DISCOUNTS,
         B.BILL_SUM,
         A.ACCOUNT_NUMBER
    FROM DB_LOADER_BILLS B,
         DB_LOADER_FULL_FINANCE_BILL FB, ACCOUNTS A
    WHERE B.BILL_SUM>0
      AND B.ACCOUNT_ID = FB.ACCOUNT_ID(+) 
      AND B.YEAR_MONTH = FB.YEAR_MONTH(+) 
      AND B.PHONE_NUMBER = FB.PHONE_NUMBER(+)
      AND FB.PHONE_NUMBER IS NULL 
      AND B.ACCOUNT_ID = A.ACCOUNT_ID 
      AND NOT EXISTS (SELECT 1
                        FROM CONTRACTS C, 
                             CONTRACT_CANCELS CC
                        WHERE C.PHONE_NUMBER_FEDERAL = FB.PHONE_NUMBER
                          AND C.CONTRACT_ID = CC.CONTRACT_ID(+)
                          AND C.CONTRACT_DATE <= B.DATE_END
                          AND (CC.CONTRACT_CANCEL_DATE IS NULL
                              OR CC.CONTRACT_CANCEL_DATE >= B.DATE_BEGIN));
                          
GRANT SELECT ON V_BILLS_VIOL_NO_CONTRACT TO CORP_MOBILE_ROLE;                                               