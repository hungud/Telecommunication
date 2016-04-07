CREATE OR REPLACE VIEW V_BEELINE_BILLS AS
  SELECT MIN(ACCOUNT_ID) ACCOUNT_ID,
         YEAR_MONTH YEAR_MONTH,
         PHONE_NUMBER PHONE_NUMBER,
         SUM(BILL_SUM) BEELINE_BILL_SUM
    FROM (SELECT FB.ACCOUNT_ID, FB.YEAR_MONTH, FB.PHONE_NUMBER, FB.BILL_SUM 
            FROM DB_LOADER_FULL_FINANCE_BILL FB
            WHERE FB.COMPLETE_BILL = 1
          UNION ALL
          SELECT B.ACCOUNT_ID, B.YEAR_MONTH, B.PHONE_NUMBER, B.BILL_SUM 
            FROM DB_LOADER_BILLS B, DB_LOADER_FULL_FINANCE_BILL FB
            WHERE B.ACCOUNT_ID = FB.ACCOUNT_ID(+)
              AND B.YEAR_MONTH = FB.YEAR_MONTH(+)
              AND B.PHONE_NUMBER = FB.PHONE_NUMBER(+)
              AND B.YEAR_MONTH <=201501
              AND FB.PHONE_NUMBER IS NULL) 
    GROUP BY YEAR_MONTH, PHONE_NUMBER   