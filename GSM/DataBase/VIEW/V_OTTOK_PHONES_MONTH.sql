CREATE OR REPLACE FORCE VIEW V_OTTOK_PHONES_MONTH
--#Version 1
-- 1. ¬о вьюхе вывод€тс€ все те номера, которые попали в отток в ме€це.  
--    ѕравила попадани€ в отток : 
--      1) ≈сли номер в блокировке с минусовым балансом 2 мес; 
--      2) ≈сли номер с положительным балансом, но не активен 3 мес€ца. (неактивность - если у номера пуста€ деталка, абонка при этом может начисл€тьс€)
AS 
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
          AND ( -- ниже блок, в котором вычисл€ютс€ те номер, которые попали в отток наход€сь 2 мес€це в минусе с и заблокированы
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
                  AND EXISTS -- дл€ того, чтобы те номера, которые уже попали в отток в предыдущем мес€це, не попадали в отток в следующем мес€це
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
                  AND EXISTS -- дл€ того, чтобы те номера, которые уже попали в отток в предыдущем мес€це, не попадали в отток в следующем мес€це
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
               OR -- Ќиже считаютс€ те номера, которые были неактивны в течении 3-х мес€цев подр€д
                  (    NOT EXISTS
                              (SELECT 1
                                 FROM CALL_SUMMARY cs        -- пуста€ деталка
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
                                 FROM DB_LOADER_FULL_FINANCE_BILL ffb -- и на вс€кий случай
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
                   -- но за 4 мес€ца наблюдалась активность (иначе один и тот же номер будет попадать подр€д каждый мес€ц)
                   AND EXISTS
                          (SELECT 1
                             FROM CALL_SUMMARY cs            -- пуста€ деталка
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
                             FROM DB_LOADER_FULL_FINANCE_BILL ffb -- и на вс€кий случай
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
                                  AND FFB.CALLS <> 0)));

GRANT SELECT ON V_OTTOK_PHONES_MONTH TO CORP_MOBILE_ROLE;

GRANT SELECT ON V_OTTOK_PHONES_MONTH TO CORP_MOBILE_ROLE_RO;