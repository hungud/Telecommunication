
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_DEBITORKA" ("PHONE_NUMBER", "PAYMENTS_ALL", "BILLS_ALL", "PAYMENTS_ALL_BEELINE", "BILLS_ALL_BEELINE", "PAYMENTS_ALL_MINUS", "BILLS_ALL_MINUS", "PAYMENTS_ALL_BEELINE_MINUS", "BILLS_ALL_BEELINE_MINUS", "DEBITORKA", "DEBITORKA_MINUS", "DEBITORKA_BEELINE", "DEBITORKA_BEELINE_MINUS", "CELL_PLAN_CODE") AS 
  SELECT T2."PHONE_NUMBER",T2."PAYMENTS_ALL",T2."BILLS_ALL",T2."PAYMENTS_ALL_BEELINE",T2."BILLS_ALL_BEELINE",T2."PAYMENTS_ALL_MINUS",T2."BILLS_ALL_MINUS",T2."PAYMENTS_ALL_BEELINE_MINUS",T2."BILLS_ALL_BEELINE_MINUS",
         T2.PAYMENTS_ALL + T2.BILLS_ALL DEBITORKA,
         T2.PAYMENTS_ALL_MINUS + T2.BILLS_ALL_MINUS DEBITORKA_MINUS,
         T2.PAYMENTS_ALL_BEELINE + T2.BILLS_ALL_BEELINE DEBITORKA_BEELINE,
         T2.PAYMENTS_ALL_BEELINE_MINUS + T2.BILLS_ALL_BEELINE_MINUS DEBITORKA_BEELINE_MINUS,
         phone.cell_plan_code
FROM (SELECT T1.PHONE_NUMBER,
             (SELECT SUM(CS.PAYMENTS_SUMM_ALL)
              FROM CONTRACT_STATISTICS CS
              WHERE CS.PHONE_NUMBER = T1.PHONE_NUMBER) PAYMENTS_ALL,
             (SELECT SUM(CS.BILLS_SUMM_ALL)
              FROM CONTRACT_STATISTICS CS
              WHERE CS.PHONE_NUMBER = T1.PHONE_NUMBER) BILLS_ALL,

             (SELECT SUM(CS.PAYMENTS_SUMM_BEELINE)
              FROM CONTRACT_STATISTICS CS
              WHERE CS.PHONE_NUMBER = T1.PHONE_NUMBER) PAYMENTS_ALL_BEELINE,
             (SELECT SUM(CS.BILLS_SUMM_BEELINE)
              FROM CONTRACT_STATISTICS CS
              WHERE CS.PHONE_NUMBER = T1.PHONE_NUMBER) BILLS_ALL_BEELINE,

             (SELECT SUM(CS.PAYMENTS_SUMM_ALL)
              FROM CONTRACT_STATISTICS CS
              WHERE CS.PHONE_NUMBER = T1.PHONE_NUMBER
                AND CS.PAYMENTS_SUMM_ALL + CS.BILLS_SUMM_ALL <= 0
                AND CS.PAYMENTS_SUMM_ALL <> 0) PAYMENTS_ALL_MINUS,
             (SELECT SUM(CS.BILLS_SUMM_ALL)
              FROM CONTRACT_STATISTICS CS
              WHERE CS.PHONE_NUMBER = T1.PHONE_NUMBER
                AND CS.PAYMENTS_SUMM_ALL + CS.BILLS_SUMM_ALL <= 0
                AND CS.PAYMENTS_SUMM_ALL <> 0) BILLS_ALL_MINUS,

             (SELECT SUM(CS.PAYMENTS_SUMM_BEELINE)
              FROM CONTRACT_STATISTICS CS
              WHERE CS.PHONE_NUMBER = T1.PHONE_NUMBER
                AND CS.PAYMENTS_SUMM_BEELINE + CS.BILLS_SUMM_BEELINE <= 0
               AND CS.PAYMENTS_SUMM_BEELINE <> 0) PAYMENTS_ALL_BEELINE_MINUS,
             (SELECT SUM(CS.BILLS_SUMM_BEELINE)
              FROM CONTRACT_STATISTICS CS
              WHERE CS.PHONE_NUMBER = T1.PHONE_NUMBER
                AND CS.PAYMENTS_SUMM_BEELINE + CS.BILLS_SUMM_BEELINE <= 0
                AND CS.PAYMENTS_SUMM_BEELINE <> 0) BILLS_ALL_BEELINE_MINUS

      FROM (SELECT PHONE_NUMBER
            FROM CONTRACT_STATISTICS
            GROUP BY PHONE_NUMBER) T1) T2,
           (SELECT p.phone_number, p.cell_plan_code
            FROM  db_loader_account_phones p
            WHERE p.year_month = (SELECT MAX(year_month)
                                  FROM db_loader_account_phones
                                  WHERE phone_number = p.phone_number)) phone,
           (SELECT a.phone_number, year_month, phone_is_active phone_is_active1,
                   LAG(phone_is_active,1) OVER (PARTITION BY a.phone_number ORDER BY year_month) phone_is_active2,
                   LAG(phone_is_active,2) OVER (PARTITION BY a.phone_number ORDER BY year_month) phone_is_active3,
                   LAG(phone_is_active,3) OVER (PARTITION BY a.phone_number ORDER BY year_month) phone_is_active4
            FROM db_loader_account_phones a, iot_current_balance b
            where a.phone_number = b.phone_number and b.balance < 0) ap
      WHERE t2.PHONE_NUMBER = phone.phone_number(+)
        AND t2.PHONE_NUMBER = ap.phone_number
        AND ap.year_month = (SELECT MAX(year_month) FROM db_loader_account_phones /*WHERE phone_number=t2.phone_number*/)
        AND ap.phone_is_active1 = 0
        AND ap.phone_is_active2 = 0
        AND ap.phone_is_active3 = 0
        AND ap.phone_is_active4 = 0
