CREATE OR REPLACE VIEW V_PROFIT_BY_PHONES AS
--
--#Version=6
--
-- 17.09.13. Крайнов. Переведено на счета детальные.
-- Возвращается доходность в разрезе периодов и телефонных номеров
-- Доходность рассчитывается только для периодов, на которые выставлен
-- счёт оператора. 
-- Определяется как разница между суммой счёта для клиента
-- и суммой счёта оператора.
--
SELECT V.ACCOUNT_ID,
       V.YEAR_MONTH,
       V.PHONE_NUMBER,
       CASE 
         WHEN V.BILL_SUM_OLD < 0 THEN 0
         ELSE V.BILL_SUM_OLD
       END AS OPERATOR_BILL_SUM,
       CASE
         WHEN V.BILL_SUM_OLD < 0 THEN 0
         ELSE V.BILL_SUM_NEW
       END AS CLIENT_BILL_SUM,
       CASE
         WHEN V.BILL_SUM_OLD < 0 THEN 0
         ELSE V.BILL_SUM_NEW - V.BILL_SUM_OLD
       END AS PROFIT_SUM
  FROM V_BILL_FINANCE_FOR_CLIENTS V;
 /* WHERE FB.PHONE_NUMBER=V.PHONE_NUMBER
    AND FB.YEAR_MONTH=V.YEAR_MONTH
    AND FB.ACCOUNT_ID=V.ACCOUNT_ID;*/
  /*  AND 0 <> V_BILL_FOR_CLIENT.BILL_SUM - DB_LOADER_BILLS.BILL_SUM
    AND (DB_LOADER_BILLS.PHONE_NUMBER, DB_LOADER_BILLS.YEAR_MONTH) in 
      (SELECT PHONE_NUMBER, YEAR_MONTH
         FROM DB_LOADER_PHONE_STAT
         WHERE (ZEROCOST_OUTCOME_MINUTES <> 0)
           OR (CALLS_COUNT <> 0)
           OR (CALLS_COST <> 0)
           OR (SMS_COUNT <> 0)
           OR (MMS_COUNT <> 0)
           OR (INTERNET_MB <> 0))*/
/
