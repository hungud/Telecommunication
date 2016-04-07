
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_PROFIT_BY_PHONES_YEAR" ("ACCOUNT_ID", "PHONE_NUMBER", "BILL_YEAR", "PROFIT_01", "PROFIT_02", "PROFIT_03", "PROFIT_04", "PROFIT_05", "PROFIT_06", "PROFIT_07", "PROFIT_08", "PROFIT_09", "PROFIT_10", "PROFIT_11", "PROFIT_12", "PROFIT_FOR_YEAR", "BALANCE", "PROFIT_WITH_BALANCE", "PHONE_STATUS") AS 
  SELECT t.ACCOUNT_ID,
            t.PHONE_NUMBER,
            t.BILL_YEAR,
            PROFIT_01,
            PROFIT_02,
            PROFIT_03,
            PROFIT_04,
            PROFIT_05,
            PROFIT_06,
            PROFIT_07,
            PROFIT_08,
            PROFIT_09,
            PROFIT_10,
            PROFIT_11,
            PROFIT_12,
            CASE WHEN PROFIT_FOR_YEAR = 0 THEN NULL ELSE PROFIT_FOR_YEAR END
               AS PROFIT_FOR_YEAR,
            balance,
            CASE
               WHEN balance > 0 THEN PROFIT_FOR_YEAR
               ELSE PROFIT_FOR_YEAR + balance
            END
               PROFIT_WITH_BALANCE,
            DECODE (get_phone_state (t.phone_number),
                    0, 'Заблокирован',
                    1, 'Активен',
                    NULL, 'Нет данных')
               phone_status
       FROM (  SELECT NVL(CONVERT_PCKG.GET_ACCOUNT_ID_BY_PHONE(V_PROFIT_BY_PHONES.PHONE_NUMBER),
                          MAX(V_PROFIT_BY_PHONES.ACCOUNT_ID)) ACCOUNT_ID,
                      V_PROFIT_BY_PHONES.PHONE_NUMBER,
                      TRUNC (V_PROFIT_BY_PHONES.YEAR_MONTH / 100) BILL_YEAR,
                      SUM (
                         CASE
                            WHEN TO_CHAR (V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE
                                    '%01'
                            THEN
                               V_PROFIT_BY_PHONES.PROFIT_SUM
                            ELSE
                               NULL
                         END)
                         AS PROFIT_01,
                      SUM (
                         CASE
                            WHEN TO_CHAR (V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE
                                    '%02'
                            THEN
                               V_PROFIT_BY_PHONES.PROFIT_SUM
                            ELSE
                               NULL
                         END)
                         AS PROFIT_02,
                      SUM (
                         CASE
                            WHEN TO_CHAR (V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE
                                    '%03'
                            THEN
                               V_PROFIT_BY_PHONES.PROFIT_SUM
                            ELSE
                               NULL
                         END)
                         AS PROFIT_03,
                      SUM (
                         CASE
                            WHEN TO_CHAR (V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE
                                    '%04'
                            THEN
                               V_PROFIT_BY_PHONES.PROFIT_SUM
                            ELSE
                               NULL
                         END)
                         AS PROFIT_04,
                      SUM (
                         CASE
                            WHEN TO_CHAR (V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE
                                    '%05'
                            THEN
                               V_PROFIT_BY_PHONES.PROFIT_SUM
                            ELSE
                               NULL
                         END)
                         AS PROFIT_05,
                      SUM (
                         CASE
                            WHEN TO_CHAR (V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE
                                    '%06'
                            THEN
                               V_PROFIT_BY_PHONES.PROFIT_SUM
                            ELSE
                               NULL
                         END)
                         AS PROFIT_06,
                      SUM (
                         CASE
                            WHEN TO_CHAR (V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE
                                    '%07'
                            THEN
                               V_PROFIT_BY_PHONES.PROFIT_SUM
                            ELSE
                               NULL
                         END)
                         AS PROFIT_07,
                      SUM (
                         CASE
                            WHEN TO_CHAR (V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE
                                    '%08'
                            THEN
                               V_PROFIT_BY_PHONES.PROFIT_SUM
                            ELSE
                               NULL
                         END)
                         AS PROFIT_08,
                      SUM (
                         CASE
                            WHEN TO_CHAR (V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE
                                    '%09'
                            THEN
                               V_PROFIT_BY_PHONES.PROFIT_SUM
                            ELSE
                               NULL
                         END)
                         AS PROFIT_09,
                      SUM (
                         CASE
                            WHEN TO_CHAR (V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE
                                    '%10'
                            THEN
                               V_PROFIT_BY_PHONES.PROFIT_SUM
                            ELSE
                               NULL
                         END)
                         AS PROFIT_10,
                      SUM (
                         CASE
                            WHEN TO_CHAR (V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE
                                    '%11'
                            THEN
                               V_PROFIT_BY_PHONES.PROFIT_SUM
                            ELSE
                               NULL
                         END)
                         AS PROFIT_11,
                      SUM (
                         CASE
                            WHEN TO_CHAR (V_PROFIT_BY_PHONES.YEAR_MONTH) LIKE
                                    '%12'
                            THEN
                               V_PROFIT_BY_PHONES.PROFIT_SUM
                            ELSE
                               NULL
                         END)
                         AS PROFIT_12,
                      get_abonent_balance (V_PROFIT_BY_PHONES.phone_number)
                         AS balance,
                      SUM (V_PROFIT_BY_PHONES.PROFIT_SUM) AS PROFIT_FOR_YEAR
                 FROM V_PROFIT_BY_PHONES  
                 where  V_PROFIT_BY_PHONES.YEAR_MONTH >=201601
             GROUP BY TRUNC (V_PROFIT_BY_PHONES.YEAR_MONTH / 100),
                      V_PROFIT_BY_PHONES.PHONE_NUMBER) T 
    union all
    select "ACCOUNT_ID","PHONE_NUMBER","BILL_YEAR","PROFIT_01","PROFIT_02","PROFIT_03","PROFIT_04","PROFIT_05","PROFIT_06","PROFIT_07","PROFIT_08","PROFIT_09","PROFIT_10","PROFIT_11","PROFIT_12","PROFIT_FOR_YEAR","BALANCE","PROFIT_WITH_BALANCE","PHONE_STATUS"
      from SAVED_MV_PROFIT_BY_PHONES_YEAR
   ORDER BY PHONE_NUMBER