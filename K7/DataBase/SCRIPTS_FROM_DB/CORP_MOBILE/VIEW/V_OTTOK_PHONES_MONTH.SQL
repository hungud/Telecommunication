
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_OTTOK_PHONES_MONTH" ("PHONE_NUMBER_FEDERAL", "CONTRACT_ID", "CONTRACT_DATE", "CONTRACT_CANCEL_DATE", "ACCOUNT_ID", "YEAR_MONTH") AS 
  SELECT DISTINCT VC.PHONE_NUMBER_FEDERAL,
                   VC.CONTRACT_ID,
                   VC.CONTRACT_DATE,
                   VC.CONTRACT_CANCEL_DATE,                   
                   Q.ACCOUNT_ID,
                   Q.YEAR_MONTH                                        -- 4697
     FROM v_contracts vc, DB_LOADER_ACCOUNT_PHONES q    
    WHERE     TO_NUMBER (TO_CHAR (VC.CONTRACT_DATE, 'YYYYMM')) <= Q.YEAR_MONTH
          AND TO_NUMBER ( TO_CHAR (NVL (VC.CONTRACT_CANCEL_DATE, SYSDATE), 'YYYYMM')) >= Q.YEAR_MONTH
          AND VC.PHONE_NUMBER_FEDERAL = q.PHONE_NUMBER
          AND ( -- ниже блок, в котором вычисляются те номер, которые попали в отток находясь 2 месяце в минусе с и заблокированы
                (     NOT EXISTS
                             (SELECT 1
                                FROM DB_LOADER_ACCOUNT_PHONE_HISTS dla
                               WHERE     DLA.PHONE_NUMBER =
                                            VC.PHONE_NUMBER_FEDERAL
                                     AND DLA.PHONE_IS_ACTIVE = 1
                                     AND DLA.BEGIN_DATE <
                                            ADD_MONTHS (
                                               TO_DATE (Q.YEAR_MONTH,
                                                        'YYYYmm'),
                                               1)
                                     AND DLA.END_DATE >=
                                            ADD_MONTHS (
                                               TO_DATE (Q.YEAR_MONTH,
                                                        'YYYYmm'),
                                               -2)              --Q.YEAR_MONTH
                                                  )
                  AND NOT EXISTS
                             (SELECT 1
                                FROM IOT_BALANCE_HISTORY bh
                               WHERE     BH.PHONE_NUMBER =
                                            VC.PHONE_NUMBER_FEDERAL
                                     AND BH.BALANCE > 0
                                     AND BH.LAST_UPDATE >=
                                            ADD_MONTHS (
                                               TO_DATE (Q.YEAR_MONTH,
                                                        'YYYYmm'),
                                               -2)
                                     AND BH.LAST_UPDATE <=
                                            TO_DATE (Q.YEAR_MONTH, 'YYYYmm'))
                  AND EXISTS -- для того, чтобы те номера, которые уже попали в отток в предыдущем месяце, не попадали в отток в следующем месяце
                         (SELECT 1
                            FROM DB_LOADER_ACCOUNT_PHONE_HISTS dla
                           WHERE     DLA.PHONE_NUMBER =
                                        VC.PHONE_NUMBER_FEDERAL
                                 AND DLA.PHONE_IS_ACTIVE = 1
                                 AND DLA.BEGIN_DATE <
                                        ADD_MONTHS (
                                           TO_DATE (Q.YEAR_MONTH, 'YYYYmm'),
                                           1)
                                 AND DLA.END_DATE >=
                                        ADD_MONTHS (
                                           TO_DATE (Q.YEAR_MONTH, 'YYYYmm'),
                                           -3)                  --Q.YEAR_MONTH
                                              )
                  AND EXISTS -- для того, чтобы те номера, которые уже попали в отток в предыдущем месяце, не попадали в отток в следующем месяце
                         (SELECT 1
                            FROM IOT_BALANCE_HISTORY bh
                           WHERE     BH.PHONE_NUMBER =
                                        VC.PHONE_NUMBER_FEDERAL
                                 AND BH.BALANCE > 0
                                 AND BH.LAST_UPDATE >=
                                        ADD_MONTHS (
                                           TO_DATE (Q.YEAR_MONTH, 'YYYYmm'),
                                           -3)
                                 AND BH.LAST_UPDATE <=
                                        TO_DATE (Q.YEAR_MONTH, 'YYYYmm')))
               OR -- Ниже считаются те номера, которые были неактивны в течении 3-х месяцев подряд
                  (    NOT EXISTS
                              (SELECT 1
                                 FROM CALL_SUMMARY cs        -- пустая деталка
                                WHERE     CS.YEAR_MONTH <= Q.YEAR_MONTH
                                      AND CS.YEAR_MONTH >=
                                             TO_NUMBER (
                                                TO_CHAR (
                                                   ADD_MONTHS (
                                                      TO_DATE (Q.YEAR_MONTH,
                                                               'YYYYMM'),
                                                      -2),
                                                   'YYYYMM'))
                                      AND CS.SUBSCR_NO =
                                             VC.PHONE_NUMBER_FEDERAL)
                   AND NOT EXISTS
                              (SELECT 1
                                 FROM DB_LOADER_FULL_FINANCE_BILL ffb -- и на всякий случай
                                WHERE     FFB.YEAR_MONTH <= Q.YEAR_MONTH
                                      AND FFB.YEAR_MONTH >=
                                             TO_NUMBER (
                                                TO_CHAR (
                                                   ADD_MONTHS (
                                                      TO_DATE (Q.YEAR_MONTH,
                                                               'YYYYMM'),
                                                      -2),
                                                   'YYYYMM'))
                                      AND FFB.PHONE_NUMBER =
                                             VC.PHONE_NUMBER_FEDERAL
                                      AND FFB.CALLS <> 0)
                   -- но за 4 месяца наблюдалась активность (иначе один и тот же номер будет попадать подряд каждый месяц)
                   AND EXISTS
                          (SELECT 1
                             FROM CALL_SUMMARY cs            -- пустая деталка
                            WHERE     CS.YEAR_MONTH <= Q.YEAR_MONTH
                                  AND CS.YEAR_MONTH >=
                                         TO_NUMBER (
                                            TO_CHAR (
                                               ADD_MONTHS (
                                                  TO_DATE (Q.YEAR_MONTH,
                                                           'YYYYMM'),
                                                  -3),
                                               'YYYYMM'))
                                  AND CS.SUBSCR_NO = VC.PHONE_NUMBER_FEDERAL)
                   AND EXISTS
                          (SELECT 1
                             FROM DB_LOADER_FULL_FINANCE_BILL ffb -- и на всякий случай
                            WHERE     FFB.YEAR_MONTH <= Q.YEAR_MONTH
                                  AND FFB.YEAR_MONTH >=
                                         TO_NUMBER (
                                            TO_CHAR (
                                               ADD_MONTHS (
                                                  TO_DATE (Q.YEAR_MONTH,
                                                           'YYYYMM'),
                                                  -3),
                                               'YYYYMM'))
                                  AND FFB.PHONE_NUMBER =
                                         VC.PHONE_NUMBER_FEDERAL
                                  AND FFB.CALLS <> 0)))