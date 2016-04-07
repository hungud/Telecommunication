
  CREATE OR REPLACE FORCE VIEW "SIM_TRADE"."V_PROFIT_BY_PHONES_YEAR" ("ACCOUNT_ID", "PHONE_NUMBER", "BILL_YEAR", "PROFIT_01", "PROFIT_02", "PROFIT_03", "PROFIT_04", "PROFIT_05", "PROFIT_06", "PROFIT_07", "PROFIT_08", "PROFIT_09", "PROFIT_10", "PROFIT_11", "PROFIT_12", "PROFIT_FOR_YEAR", "BALANCE", "PROFIT_WITH_BALANCE") AS 
  SELECT ACCOUNT_ID,
       PHONE_NUMBER,
       BILL_YEAR,
       CASE 
         WHEN PROFIT_01 = 0 THEN NULL 
         ELSE PROFIT_01 
       END AS PROFIT_01,
       CASE 
         WHEN PROFIT_02 = 0 THEN NULL 
         ELSE PROFIT_02 
       END AS PROFIT_02,
       CASE
         WHEN PROFIT_03 = 0 THEN NULL 
         ELSE PROFIT_03 
       END AS PROFIT_03,
       CASE
         WHEN PROFIT_04 = 0 THEN NULL 
         ELSE PROFIT_04 
       END AS PROFIT_04,
       CASE
         WHEN PROFIT_05 = 0 THEN NULL 
         ELSE PROFIT_05
       END AS PROFIT_05,
       CASE
         WHEN PROFIT_06 = 0 THEN NULL 
         ELSE PROFIT_06 
       END AS PROFIT_06,
       CASE 
         WHEN PROFIT_07 = 0 THEN NULL 
         ELSE PROFIT_07 
       END AS PROFIT_07,
       CASE 
         WHEN PROFIT_08 = 0 THEN NULL 
         ELSE PROFIT_08 
       END AS PROFIT_08,
       CASE 
         WHEN PROFIT_09 = 0 THEN NULL 
         ELSE PROFIT_09 
       END AS PROFIT_09,
       CASE 
         WHEN PROFIT_10 = 0 THEN NULL 
         ELSE PROFIT_10 
       END AS PROFIT_10,
       CASE 
         WHEN PROFIT_11 = 0 THEN NULL 
         ELSE PROFIT_11 
       END AS PROFIT_11,
       CASE 
         WHEN PROFIT_12 = 0 THEN NULL 
         ELSE PROFIT_12 
       END AS PROFIT_12,
       CASE 
         WHEN PROFIT_FOR_YEAR = 0 THEN NULL 
         ELSE PROFIT_FOR_YEAR 
       END AS PROFIT_FOR_YEAR,
       BALANCE,
       PROFIT_FOR_YEAR + BALANCE PROFIT_WITH_BALANCE
  FROM (SELECT ACCOUNT_ID,
               PHONE_NUMBER,
               TRUNC(V_PROFIT_BY_PHONES.YEAR_MONTH / 100) BILL_YEAR,
               SUM(CASE 
                     WHEN TO_CHAR(V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE '%01' THEN V_PROFIT_BY_PHONES.PROFIT_SUM 
                     ELSE 0 
                   END) AS PROFIT_01,
               SUM(CASE 
                     WHEN TO_CHAR(V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE '%02' THEN V_PROFIT_BY_PHONES.PROFIT_SUM 
                     ELSE 0 
                   END) AS PROFIT_02,
               SUM(CASE 
                     WHEN TO_CHAR(V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE '%03' THEN V_PROFIT_BY_PHONES.PROFIT_SUM 
                     ELSE 0 
                   END) AS PROFIT_03,
               SUM(CASE 
                     WHEN TO_CHAR(V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE '%04' THEN V_PROFIT_BY_PHONES.PROFIT_SUM 
                     ELSE 0 
                   END) AS PROFIT_04,
               SUM(CASE 
                     WHEN TO_CHAR(V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE '%05' THEN V_PROFIT_BY_PHONES.PROFIT_SUM 
                     ELSE 0 
                   END) AS PROFIT_05,
               SUM(CASE 
                     WHEN TO_CHAR(V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE '%06' THEN V_PROFIT_BY_PHONES.PROFIT_SUM 
                     ELSE 0 
                   END) AS PROFIT_06,
               SUM(CASE 
                     WHEN TO_CHAR(V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE '%07' THEN V_PROFIT_BY_PHONES.PROFIT_SUM 
                     ELSE 0 
                   END) AS PROFIT_07,
               SUM(CASE 
                     WHEN TO_CHAR(V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE '%08' THEN V_PROFIT_BY_PHONES.PROFIT_SUM 
                     ELSE 0 
                   END) AS PROFIT_08,
               SUM(CASE 
                     WHEN TO_CHAR(V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE '%09' THEN V_PROFIT_BY_PHONES.PROFIT_SUM 
                     ELSE 0 
                   END) AS PROFIT_09,
               SUM(CASE 
                     WHEN TO_CHAR(V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE '%10' THEN V_PROFIT_BY_PHONES.PROFIT_SUM 
                     ELSE 0 
                   END) AS PROFIT_10,
               SUM(CASE 
                     WHEN TO_CHAR(V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE '%11' THEN V_PROFIT_BY_PHONES.PROFIT_SUM 
                     ELSE 0 
                   END) AS PROFIT_11,
               SUM(CASE 
                     WHEN TO_CHAR(V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE '%12' THEN V_PROFIT_BY_PHONES.PROFIT_SUM 
                     ELSE 0 
                   END) AS PROFIT_12,
               SUM(V_PROFIT_BY_PHONES.PROFIT_SUM) AS PROFIT_FOR_YEAR,
               GET_ABONENT_BALANCE(V_PROFIT_BY_PHONES.PHONE_NUMBER) BALANCE 
          FROM V_PROFIT_BY_PHONES
          GROUP BY TRUNC(V_PROFIT_BY_PHONES.YEAR_MONTH / 100),
                   PHONE_NUMBER,
                   ACCOUNT_ID) T
  ORDER BY PHONE_NUMBER 