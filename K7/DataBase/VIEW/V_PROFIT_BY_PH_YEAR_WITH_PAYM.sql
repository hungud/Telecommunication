CREATE OR REPLACE VIEW V_PROFIT_BY_PH_YEAR_WITH_PAYM AS
  SELECT t.ACCOUNT_ID, t.PHONE_NUMBER, t.BILL_YEAR,
         PROFIT_01, PROFIT_02, PROFIT_03, PROFIT_04, 
         PROFIT_05, PROFIT_06, PROFIT_07, PROFIT_08, 
         PROFIT_09, PROFIT_10, PROFIT_11, PROFIT_12,
         CASE 
           WHEN PROFIT_FOR_YEAR = 0 THEN NULL 
           ELSE PROFIT_FOR_YEAR 
         END AS PROFIT_FOR_YEAR,
         balance,
         CASE
           WHEN balance > 0 THEN PROFIT_FOR_YEAR
           ELSE PROFIT_FOR_YEAR + balance
         END PROFIT_WITH_BALANCE,
         DECODE(get_phone_state(t.phone_number),
                0, 'Заблокирован', 1, 'Активен',
                NULL, 'Нет данных') phone_status
    FROM (SELECT NVL(CONVERT_PCKG.GET_ACCOUNT_ID_BY_PHONE(VP.PHONE_NUMBER),
                     MAX(VP.ACCOUNT_ID)) ACCOUNT_ID,
                 VP.PHONE_NUMBER,
                 TRUNC(VP.YEAR_MONTH/100) BILL_YEAR,
                 SUM(CASE
                       WHEN MOD(VP.YEAR_MONTH, 100) = 1 THEN 
                         VP.PROFIT_SUM - NVL(VR.PAYMENT_ALL_SUM, 0)
                       ELSE NULL END) AS PROFIT_01,
                 SUM(CASE
                       WHEN MOD(VP.YEAR_MONTH, 100) = 2 THEN 
                         VP.PROFIT_SUM - NVL(VR.PAYMENT_ALL_SUM, 0)
                       ELSE NULL END) AS PROFIT_02,
                 SUM(CASE
                       WHEN MOD(VP.YEAR_MONTH, 100) = 3 THEN 
                         VP.PROFIT_SUM - NVL(VR.PAYMENT_ALL_SUM, 0)
                       ELSE NULL END) AS PROFIT_03,
                 SUM(CASE
                       WHEN MOD(VP.YEAR_MONTH, 100) = 4 THEN 
                         VP.PROFIT_SUM - NVL(VR.PAYMENT_ALL_SUM, 0)
                       ELSE NULL END) AS PROFIT_04,
                 SUM(CASE
                       WHEN MOD(VP.YEAR_MONTH, 100) = 5 THEN 
                         VP.PROFIT_SUM - NVL(VR.PAYMENT_ALL_SUM, 0)
                       ELSE NULL END) AS PROFIT_05,
                 SUM(CASE
                       WHEN MOD(VP.YEAR_MONTH, 100) = 6 THEN 
                         VP.PROFIT_SUM - NVL(VR.PAYMENT_ALL_SUM, 0)
                       ELSE NULL END) AS PROFIT_06,
                 SUM(CASE
                       WHEN MOD(VP.YEAR_MONTH, 100) = 7 THEN 
                         VP.PROFIT_SUM - NVL(VR.PAYMENT_ALL_SUM, 0)
                       ELSE NULL END) AS PROFIT_07,
                 SUM(CASE
                       WHEN MOD(VP.YEAR_MONTH, 100) = 8 THEN 
                         VP.PROFIT_SUM - NVL(VR.PAYMENT_ALL_SUM, 0)
                       ELSE NULL END) AS PROFIT_08,
                 SUM(CASE
                       WHEN MOD(VP.YEAR_MONTH, 100) = 9 THEN 
                         VP.PROFIT_SUM - NVL(VR.PAYMENT_ALL_SUM, 0)
                       ELSE NULL END) AS PROFIT_09,
                 SUM(CASE
                       WHEN MOD(VP.YEAR_MONTH, 100) = 10 THEN 
                         VP.PROFIT_SUM - NVL(VR.PAYMENT_ALL_SUM, 0)
                       ELSE NULL END) AS PROFIT_10,
                 SUM(CASE
                       WHEN MOD(VP.YEAR_MONTH, 100) = 11 THEN 
                         VP.PROFIT_SUM - NVL(VR.PAYMENT_ALL_SUM, 0)
                       ELSE NULL END) AS PROFIT_11,
                 SUM(CASE
                       WHEN MOD(VP.YEAR_MONTH, 100) = 12 THEN 
                         VP.PROFIT_SUM - NVL(VR.PAYMENT_ALL_SUM, 0)
                       ELSE NULL END) AS PROFIT_12,
                 --get_abonent_balance (VP.phone_number) AS balance,
                 SUM(VP.PROFIT_SUM - NVL(VR.PAYMENT_ALL_SUM, 0)) AS PROFIT_FOR_YEAR
            FROM V_PROFIT_BY_PHONES VP, 
                 V_RECEIVED_PAYMENTS_PROFIT VR
            where VP.YEAR_MONTH >=201501
              AND VP.YEAR_MONTH = VR.YEAR_MONTH(+)
              AND VP.PHONE_NUMBER = VR.PHONE_NUMBER(+)
            GROUP BY TRUNC(VP.YEAR_MONTH/100), VP.PHONE_NUMBER) T,
         IOT_CURRENT_BALANCE ICB
    WHERE T.PHONE_NUMBER = ICB.PHONE_NUMBER(+);   
    
--GRANT SELECT ON V_PROFIT_BY_PH_YEAR_WITH_PAYM TO CORP_MOBILE_ROLE;   
    
--GRANT SELECT ON V_PROFIT_BY_PH_YEAR_WITH_PAYM TO CORP_MOBILE_ROLE_RO;    