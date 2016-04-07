
  CREATE OR REPLACE FORCE VIEW "SIM_TRADE"."V_BILL_FOR_CLIENT" ("ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "DATE_BEGIN", "DATE_END", "DISCOUNT_VALUE", "ORIGIN_SUBSCRIBER_PAYMENT", "SUBSCRIBER_PAYMENT_COEF", "OPTION_CORRECT_SUM", "BILL_SUM_ORIGIN", "BILL_SUM", "SUBSCRIBER_PAYMENT_NEW", "SUBSCRIBER_PAYMENT_OLD", "TARIFF_ID", "SUBSCRIBER_PAYMENT_ADD_OLD", "SUBSCRIBER_PAYMENT_ADD_VOZVRAT", "BILL_CHECKED") AS 
  SELECT
--
--#Version=33
--
--20.09.2012 Крайнов. пОДСТАНОВКА НОМЕРА ИСКЛЮЧЕНИЯ
--10.11.2011 Крайнов. Изменен подстет изначальной абон платы.
--17.10.2011 Крайнов. Дата отлова тарифа изменена с 14 на последний день месяца
--12.10.2011 Крайнов. Добавлено прибавление добавочной стоимости тарифа(обычно у тарифов с 0 абонкой)
--10.10.2011 Крайнов. Добавлено начисление процента к итоговой сумме через RECALC_CHARGE_COST
--24.08.2011 Крайнов. SUBSCRIBER_PAYMENT_COEF теперь через DB_LOADER_ACCOUNT_PHONE_HISTS
       T1.ACCOUNT_ID, 
       T1.YEAR_MONTH, 
       T1.PHONE_NUMBER, 
       T1.DATE_BEGIN,
       T1.DATE_END, 
       T1.DISCOUNT_VALUE,
       CASE
         WHEN T1.ORIGIN_SUBSCRIBER_PAYMENT < 0 THEN 0
         ELSE T1.ORIGIN_SUBSCRIBER_PAYMENT
       END AS ORIGIN_SUBSCRIBER_PAYMENT,
       DECODE(TR.CALC_KOEFF, NULL, 1, 0, 1, TR.CALC_KOEFF) AS SUBSCRIBER_PAYMENT_COEF,
       T1.OPTION_CORRECT_SUM, 
       T1.BILL_SUM_ORIGIN,
       CASE
         WHEN T1.PHONE_NUMBER='9688082010' THEN T1.BILL_SUM_ORIGIN
         WHEN (T1.BILL_SUM_ORIGIN > 0)AND(T1.PHONE_NUMBER<>'9688082010') THEN 
           TRUNC(
             RECALC_CHARGE_COST(
               T1.PHONE_NUMBER,
               CASE
                 WHEN (NVL(TR.TARIFF_ADD_COST, 0)=0) THEN   
                   T1.BILL_SUM_ORIGIN
                     /* Скидку абоненту не отдаём! */
                     - T1.DISCOUNT_VALUE 
                     + CASE
                         WHEN MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='GSM_CORP' 
                             AND (T1.TARIFF_ID=383 OR T1.TARIFF_ID=503 OR T1.TARIFF_ID=506) THEN
                           + CASE 
                               WHEN GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                            T1.DATE_BEGIN,
                                            T1.DATE_END,
                                            T1.YEAR_MONTH,
                                            T1.TARIFF_CODE,
                                            T1.SUBSCRIBER_PAYMENT_ADD,
                                            'PLUS;SMSR300')*0.988 < T1.DISCOUNT_VALUE 
                                 THEN T1.DISCOUNT_VALUE
                               ELSE 
                                 CASE
                                   WHEN T1.SUBSCRIBER_PAYMENT_ADD=1205 THEN
                                     CASE
                                       WHEN -T1.SUBSCRIBER_PAYMENT_ADD*0.988>= T1.DISCOUNT_VALUE THEN -T1.SUBSCRIBER_PAYMENT_ADD*0.988
                                       ELSE T1.DISCOUNT_VALUE
                                     END
                                   WHEN T1.SUBSCRIBER_PAYMENT_ADD=705 THEN
                                     CASE
                                       WHEN -T1.SUBSCRIBER_PAYMENT_ADD*0.988>= T1.DISCOUNT_VALUE THEN -T1.SUBSCRIBER_PAYMENT_ADD*0.988
                                       ELSE T1.DISCOUNT_VALUE
                                     END
                                   WHEN T1.SUBSCRIBER_PAYMENT_ADD=1705.01 THEN
                                     CASE
                                       WHEN -T1.SUBSCRIBER_PAYMENT_ADD*0.988>= T1.DISCOUNT_VALUE THEN -T1.SUBSCRIBER_PAYMENT_ADD*0.988
                                       ELSE T1.DISCOUNT_VALUE
                                     END
                                   ELSE   
                                     CASE
                                       WHEN (GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                            T1.DATE_BEGIN,
                                            T1.DATE_END,
                                            T1.YEAR_MONTH,
                                            T1.TARIFF_CODE,
                                            T1.SUBSCRIBER_PAYMENT_ADD,
                                            'PLUS;SMSR300')*0.988 > T1.DISCOUNT_VALUE + 300 
                                           AND (GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                                  T1.DATE_BEGIN,
                                                  T1.DATE_END,
                                                  T1.YEAR_MONTH,
                                                  T1.TARIFF_CODE,
                                                  T1.SUBSCRIBER_PAYMENT_ADD,
                                                  'PLUS;SMSR300')*0.988 > -50))
                                            THEN  
                                         CASE
                                           WHEN -705*0.988>= T1.DISCOUNT_VALUE THEN -705*0.988
                                           ELSE T1.DISCOUNT_VALUE
                                         END 
                                       ELSE GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                            T1.DATE_BEGIN,
                                            T1.DATE_END,
                                            T1.YEAR_MONTH,
                                            T1.TARIFF_CODE,
                                            T1.SUBSCRIBER_PAYMENT_ADD,
                                            'PLUS;SMSR300')*0.988    
                                     END           
                                 END           
                             END 
                         WHEN MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE' 
                               AND (T1.TARIFF_ID=458 or T1.TARIFF_ID=459 or(T1.TARIFF_ID=478 and T1.YEAR_MONTH>=201112 and T1.ACCOUNT_ID<>1) 
                                  or T1.TARIFF_ID=599 or T1.TARIFF_ID=699 or T1.TARIFF_ID=700 or T1.TARIFF_ID=701 or T1.TARIFF_ID=820
                                  or T1.TARIFF_ID=903 or T1.TARIFF_ID=904) THEN                              
                           + CASE 
                               WHEN GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                            T1.DATE_BEGIN,
                                            T1.DATE_END,
                                            T1.YEAR_MONTH,
                                            T1.TARIFF_CODE,
                                            T1.SUBSCRIBER_PAYMENT_ADD,
                                            'PLUS;SMSR300')*0.988 < T1.DISCOUNT_VALUE 
                                 THEN T1.DISCOUNT_VALUE
                               ELSE 
                                 CASE 
                                   WHEN GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                            T1.DATE_BEGIN,
                                            T1.DATE_END,
                                            T1.YEAR_MONTH,
                                            T1.TARIFF_CODE,
                                            T1.SUBSCRIBER_PAYMENT_ADD,
                                            'PLUS;SMSR300')*0.988>-50 AND T1.SUBSCRIBER_PAYMENT_ADD >=705 
                                     THEN 
                                       CASE 
                                         WHEN -705*0.988<T1.DISCOUNT_VALUE THEN T1.DISCOUNT_VALUE
                                         ELSE -705*0.988
                                       END  
                                   ELSE GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                            T1.DATE_BEGIN,
                                            T1.DATE_END,
                                            T1.YEAR_MONTH,
                                            T1.TARIFF_CODE,
                                            T1.SUBSCRIBER_PAYMENT_ADD,
                                            'PLUS;SMSR300')*0.988         
                                 END             
                             END 
                         WHEN ms_constants.get_constant_value('SERVER_NAME')='SIM_TRADE' THEN
                           T1.BILL_SUM_ORIGIN*(0.012/1.012) + 
                           CASE
                             WHEN (t1.tariff_id=423 OR t1.tariff_id=424 OR t1.tariff_id=61)
                                   AND (t1.tariff_code = 'FS_UNL_F') THEN 
                               CASE 
                                 WHEN T1.SUBSCRIBER_PAYMENT_ADD=1205 THEN   
                                   CASE
                                     WHEN -0.988 * 1205 < t1.discount_value
                                       THEN t1.discount_value
                                     ELSE -1 * 1205
                                   END
                                 WHEN T1.SUBSCRIBER_PAYMENT_ADD=705 THEN   
                                   CASE
                                     WHEN -0.988 * 705 < t1.discount_value
                                       THEN t1.discount_value
                                     ELSE -1 * 705
                                   END                                   
                                 ELSE 
                                   CASE
                                     WHEN GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                                  T1.DATE_BEGIN,
                                                  T1.DATE_END,
                                                  T1.YEAR_MONTH,
                                                  T1.TARIFF_CODE,
                                                  T1.SUBSCRIBER_PAYMENT_ADD,
                                                  'PLUS;SMSR300')*0.988 < T1.DISCOUNT_VALUE 
                                       THEN T1.DISCOUNT_VALUE   
                                     ELSE                                  
                                       CASE 
                                         WHEN GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                                  T1.DATE_BEGIN,
                                                  T1.DATE_END,
                                                  T1.YEAR_MONTH,
                                                  T1.TARIFF_CODE,
                                                  T1.SUBSCRIBER_PAYMENT_ADD,
                                                  'PLUS;SMSR300')*0.988>-50 AND T1.SUBSCRIBER_PAYMENT_ADD >=705 AND T1.DISCOUNT_VALUE<-300
                                           THEN 
                                             CASE 
                                               WHEN -705*0.988<T1.DISCOUNT_VALUE THEN T1.DISCOUNT_VALUE
                                               ELSE -705
                                             END  
                                         ELSE GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                                  T1.DATE_BEGIN,
                                                  T1.DATE_END,
                                                  T1.YEAR_MONTH,
                                                  T1.TARIFF_CODE,
                                                  T1.SUBSCRIBER_PAYMENT_ADD,
                                                  'PLUS;SMSR300')    
                                       END 
                                   end
                               END 
                             ELSE 0
                           END                                      
                         ELSE 0
                       END
                     /* Абонплату пересчитываем по нашим тарифам */
                     + (CASE
                          WHEN T1.ORIGIN_SUBSCRIBER_PAYMENT<0 THEN 0
                          ELSE T1.ORIGIN_SUBSCRIBER_PAYMENT
                        END
                        ) * (DECODE(TR.CALC_KOEFF, NULL, 1, 0, 1, TR.CALC_KOEFF ) - 1)
                     /* Поправка на перерасчет стоимости подключенных опций */
                     + T1.OPTION_CORRECT_SUM
                 ELSE   
                   T1.BILL_SUM_ORIGIN
                     /* Скидку абоненту не отдаём! */
                     - T1.DISCOUNT_VALUE
                     /* Добавочная стоимость для тарифов(обычно к тарифам с нулевой абонкой)*/
                     + NEW_SUBSCRIBE_PAY(T1.PHONE_NUMBER, NVL(TR.TARIFF_ADD_COST, 0), T1.YEAR_MONTH)
                     + T1.OPTION_CORRECT_SUM
               END)
               --При пересчете 1.2% они на абоку идут тоже, этот код, нужен, если не нужно считать 1.2% к абонке
/*             + T1.ORIGIN_SUBSCRIBER_PAYMENT
             - RECALC_CHARGE_COST(T1.PHONE_NUMBER, T1.ORIGIN_SUBSCRIBER_PAYMENT)*/,
             2)
         ELSE 0
       END AS BILL_SUM,
       TRUNC(
         RECALC_CHARGE_COST(
           T1.PHONE_NUMBER,
           CASE
             WHEN T1.ORIGIN_SUBSCRIBER_PAYMENT>0 THEN   
               (T1.ORIGIN_SUBSCRIBER_PAYMENT) * (DECODE(TR.CALC_KOEFF, NULL, 1, 0, 1, TR.CALC_KOEFF))
             ELSE NEW_SUBSCRIBE_PAY(T1.PHONE_NUMBER, NVL(TR.TARIFF_ADD_COST, 0), T1.YEAR_MONTH)
           END),
         2) AS SUBSCRIBER_PAYMENT_NEW,
       CASE
         WHEN T1.BILL_SUM_ORIGIN=0 OR T1.ORIGIN_SUBSCRIBER_PAYMENT<0 THEN 0
         ELSE T1.ORIGIN_SUBSCRIBER_PAYMENT
       END AS SUBSCRIBER_PAYMENT_OLD,
       T1.TARIFF_ID,
       T1.SUBSCRIBER_PAYMENT_ADD AS SUBSCRIBER_PAYMENT_ADD_OLD,
       TRUNC(
        RECALC_CHARGE_COST(
           T1.PHONE_NUMBER,
           CASE
             WHEN MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='GSM_CORP' 
                   AND (T1.TARIFF_ID=383 OR T1.TARIFF_ID=503 OR T1.TARIFF_ID=506) THEN
               + CASE 
                   WHEN GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                T1.DATE_BEGIN,
                                T1.DATE_END,
                                T1.YEAR_MONTH,
                                T1.TARIFF_CODE,
                                T1.SUBSCRIBER_PAYMENT_ADD,
                                'PLUS;SMSR300')*0.988 < T1.DISCOUNT_VALUE 
                     THEN T1.DISCOUNT_VALUE
                   ELSE 
                     CASE
                       WHEN T1.SUBSCRIBER_PAYMENT_ADD=1205 THEN
                         CASE
                           WHEN -T1.SUBSCRIBER_PAYMENT_ADD*0.988>= T1.DISCOUNT_VALUE THEN -T1.SUBSCRIBER_PAYMENT_ADD*0.988
                           ELSE T1.DISCOUNT_VALUE
                         END
                       WHEN T1.SUBSCRIBER_PAYMENT_ADD=705 THEN
                         CASE
                           WHEN -T1.SUBSCRIBER_PAYMENT_ADD*0.988>= T1.DISCOUNT_VALUE THEN -T1.SUBSCRIBER_PAYMENT_ADD*0.988
                           ELSE T1.DISCOUNT_VALUE
                         END
                       WHEN T1.SUBSCRIBER_PAYMENT_ADD=1705.01 THEN
                         CASE
                           WHEN -T1.SUBSCRIBER_PAYMENT_ADD*0.988>= T1.DISCOUNT_VALUE THEN -T1.SUBSCRIBER_PAYMENT_ADD*0.988
                           ELSE T1.DISCOUNT_VALUE
                         END
                       ELSE   
                         CASE
                           WHEN (GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                T1.DATE_BEGIN,
                                T1.DATE_END,
                                T1.YEAR_MONTH,
                                T1.TARIFF_CODE,
                                T1.SUBSCRIBER_PAYMENT_ADD,
                                'PLUS;SMSR300')*0.988 > T1.DISCOUNT_VALUE + 300 
                               AND (GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                      T1.DATE_BEGIN,
                                      T1.DATE_END,
                                      T1.YEAR_MONTH,
                                      T1.TARIFF_CODE,
                                      T1.SUBSCRIBER_PAYMENT_ADD,
                                      'PLUS;SMSR300')*0.988 > -50))
                                THEN  
                             CASE
                               WHEN -705*0.988>= T1.DISCOUNT_VALUE THEN -705*0.988
                               ELSE T1.DISCOUNT_VALUE
                             END 
                           ELSE GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                T1.DATE_BEGIN,
                                T1.DATE_END,
                                T1.YEAR_MONTH,
                                T1.TARIFF_CODE,
                                T1.SUBSCRIBER_PAYMENT_ADD,
                                'PLUS;SMSR300')*0.988    
                         END           
                     END           
                 END  
             WHEN MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE' 
                   AND (T1.TARIFF_ID=458 or T1.TARIFF_ID=459 or(T1.TARIFF_ID=478 and T1.YEAR_MONTH>=201112 and T1.ACCOUNT_ID<>1) 
                      or T1.TARIFF_ID=599 or T1.TARIFF_ID=699 or T1.TARIFF_ID=700 or T1.TARIFF_ID=701) THEN                              
               + CASE 
                   WHEN GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                T1.DATE_BEGIN,
                                T1.DATE_END,
                                T1.YEAR_MONTH,
                                T1.TARIFF_CODE,
                                T1.SUBSCRIBER_PAYMENT_ADD,
                                'PLUS;SMSR300')*0.988 < T1.DISCOUNT_VALUE 
                     THEN T1.DISCOUNT_VALUE
                   ELSE
                     CASE 
                       WHEN GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                T1.DATE_BEGIN,
                                T1.DATE_END,
                                T1.YEAR_MONTH,
                                T1.TARIFF_CODE,
                                T1.SUBSCRIBER_PAYMENT_ADD,
                                'PLUS;SMSR300')*0.988>-50 AND T1.SUBSCRIBER_PAYMENT_ADD >=705 
                         THEN 
                           CASE 
                             WHEN -705*0.988<T1.DISCOUNT_VALUE THEN T1.DISCOUNT_VALUE
                             ELSE -705*0.988
                           END  
                       ELSE GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                T1.DATE_BEGIN,
                                T1.DATE_END,
                                T1.YEAR_MONTH,
                                T1.TARIFF_CODE,
                                T1.SUBSCRIBER_PAYMENT_ADD,
                                'PLUS;SMSR300')*0.988         
                     END 
                 END  
             WHEN ms_constants.get_constant_value('SERVER_NAME')='SIM_TRADE' THEN
               T1.BILL_SUM_ORIGIN * (0.012/1.012) + 
               CASE
                 WHEN (t1.tariff_id=423 OR t1.tariff_id=424 OR t1.tariff_id=61)
                       AND (t1.tariff_code = 'FS_UNL_F') THEN 
                   CASE 
                     WHEN T1.SUBSCRIBER_PAYMENT_ADD=1205 THEN   
                       CASE
                         WHEN -0.988 * 1205 < t1.discount_value
                           THEN t1.discount_value
                         ELSE -0.988 * 1205
                       END
                     WHEN T1.SUBSCRIBER_PAYMENT_ADD=705 THEN   
                       CASE
                         WHEN -0.988 * 705 < t1.discount_value
                           THEN t1.discount_value
                         ELSE -1 * 705
                       END                                   
                     ELSE 
                       CASE
                         WHEN GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                      T1.DATE_BEGIN,
                                      T1.DATE_END,
                                      T1.YEAR_MONTH,
                                      T1.TARIFF_CODE,
                                      T1.SUBSCRIBER_PAYMENT_ADD,
                                      'PLUS;SMSR300')*0.988 < T1.DISCOUNT_VALUE 
                           THEN T1.DISCOUNT_VALUE   
                         ELSE                                  
                           CASE 
                             WHEN GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                      T1.DATE_BEGIN,
                                      T1.DATE_END,
                                      T1.YEAR_MONTH,
                                      T1.TARIFF_CODE,
                                      T1.SUBSCRIBER_PAYMENT_ADD,
                                      'PLUS;SMSR300')*0.988>-50 AND T1.SUBSCRIBER_PAYMENT_ADD >=705 AND T1.DISCOUNT_VALUE<-300
                               THEN 
                                 CASE 
                                   WHEN -705*0.988<T1.DISCOUNT_VALUE THEN T1.DISCOUNT_VALUE
                                   ELSE -705
                                 END  
                             ELSE GET_TARIFF_OPTION_PERERASCHET(T1.PHONE_NUMBER,
                                      T1.DATE_BEGIN,
                                      T1.DATE_END,
                                      T1.YEAR_MONTH,
                                      T1.TARIFF_CODE,
                                      T1.SUBSCRIBER_PAYMENT_ADD,
                                      'PLUS;SMSR300')
                           END 
                       end
                   END  
                 ELSE 0
               END               
             ELSE 0
           END),
       2) AS SUBSCRIBER_PAYMENT_ADD_VOZVRAT,
       t1.BILL_CHECKED
  FROM (SELECT DB_LOADER_BILLS.ACCOUNT_ID, 
               DB_LOADER_BILLS.YEAR_MONTH,
               DB_LOADER_BILLS.PHONE_NUMBER, 
               DB_LOADER_BILLS.DATE_BEGIN,
               DB_LOADER_BILLS.DATE_END, 
               DB_LOADER_BILLS.DISCOUNT_VALUE,
               DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_ADD,
               DB_LOADER_BILLS.TARIFF_CODE,            
               DB_LOADER_BILLS.BILL_CHECKED,                  
               -- Определяем абонплату с учётом вычетов за неполный срок
               CASE
                 WHEN DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN>0 THEN 
                   CASE
                     /* Если начисления за разовые услуги минусовые, то это возврат абонплаты */ 
                     WHEN DB_LOADER_BILLS.SINGLE_PAYMENTS<0 THEN   
                       CASE 
                         WHEN DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN+DB_LOADER_BILLS.SINGLE_PAYMENTS<0
                           THEN (DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN+DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_ADD+DB_LOADER_BILLS.SINGLE_PAYMENTS)
                             /(DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN+DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_ADD)*DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN
                         ELSE DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN+DB_LOADER_BILLS.SINGLE_PAYMENTS
                       END  
                     ELSE DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN
                   END
                 ELSE 0
               END AS ORIGIN_SUBSCRIBER_PAYMENT,                  
               -- Коэффициент перерасчёта абонплаты
               CASE
                 WHEN DB_LOADER_BILLS.TARIFF_CODE IS NOT NULL THEN 
                   GET_PHONE_TARIFF_ID(DB_LOADER_BILLS.PHONE_NUMBER,
                                       DB_LOADER_BILLS.TARIFF_CODE,
                                       DB_LOADER_BILLS.DATE_END)
                 ELSE 
                   NVL(
                     (SELECT TR.TARIFF_ID
                        FROM DB_LOADER_ACCOUNT_PHONE_HISTS DP,
                             TARIFFS TR
                        WHERE DP.PHONE_NUMBER=DB_LOADER_BILLS.PHONE_NUMBER
                          AND DP.BEGIN_DATE<=LAST_DAY(TO_DATE(TO_CHAR(DB_LOADER_BILLS.YEAR_MONTH), 'YYYYMM'))
                          AND DP.END_DATE>=LAST_DAY(TO_DATE(TO_CHAR(DB_LOADER_BILLS.YEAR_MONTH), 'YYYYMM'))
                          AND TR.TARIFF_ID=GET_PHONE_TARIFF_ID(DP.PHONE_NUMBER,
                                                               DP.CELL_PLAN_CODE,
                                                               LAST_DAY(TO_DATE(TO_CHAR(DB_LOADER_BILLS.YEAR_MONTH), 'YYYYMM')))
                          AND ROWNUM<2),
                     (SELECT TR.TARIFF_ID
                        FROM DB_LOADER_ACCOUNT_PHONES DP, 
                             TARIFFS TR
                        WHERE DP.PHONE_NUMBER=DB_LOADER_BILLS.PHONE_NUMBER
                          AND DP.YEAR_MONTH=DB_LOADER_BILLS.YEAR_MONTH
                          AND TR.TARIFF_ID=GET_PHONE_TARIFF_ID(DP.PHONE_NUMBER,
                                                               DP.CELL_PLAN_CODE,
                                                               DP.LAST_CHECK_DATE_TIME)
                          AND ROWNUM < 2)
                      )
               END AS TARIFF_ID,
               -- Перерасчет поправки для стоимости опций
               GET_TARIFF_OPTION_PERERASCHET(DB_LOADER_BILLS.PHONE_NUMBER,
                                             DB_LOADER_BILLS.DATE_BEGIN,
                                             DB_LOADER_BILLS.DATE_END,
                                             DB_LOADER_BILLS.YEAR_MONTH,
                                             DB_LOADER_BILLS.TARIFF_CODE,
                                             DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_ADD) AS OPTION_CORRECT_SUM,
               DB_LOADER_BILLS.BILL_SUM BILL_SUM_ORIGIN
          FROM DB_LOADER_BILLS, BILL_FOR_CLIENTS_SAVED
          WHERE DB_LOADER_BILLS.ACCOUNT_ID=BILL_FOR_CLIENTS_SAVED.ACCOUNT_ID(+)
            AND DB_LOADER_BILLS.YEAR_MONTH=BILL_FOR_CLIENTS_SAVED.YEAR_MONTH(+)
            AND DB_LOADER_BILLS.PHONE_NUMBER=BILL_FOR_CLIENTS_SAVED.PHONE_NUMBER(+)
            AND BILL_FOR_CLIENTS_SAVED.PHONE_NUMBER IS NULL
       ) T1,
       TARIFFS TR
  WHERE T1.TARIFF_ID=TR.TARIFF_ID(+)
UNION ALL
SELECT BS1.ACCOUNT_ID, 
       BS1.YEAR_MONTH, 
       BS1.PHONE_NUMBER,
       BS1.DATE_BEGIN,
       BS1.DATE_END, 
       BS1.DISCOUNT_VALUE,
       BS1.SUBSCRIBER_PAYMENT_OLD AS ORIGIN_SUBSCRIBER_PAYMENT,
       BS1.SUBSCRIBER_PAYMENT_COEF, 
       BS1.OPTION_CORRECT_SUM,
       BS1.BILL_SUM_ORIGIN, 
       BS1.BILL_SUM, 
       BS1.SUBSCRIBER_PAYMENT_NEW,
       BS1.SUBSCRIBER_PAYMENT_OLD, 
       BS1.TARIFF_ID,
       BS1.SUBSCRIBER_PAYMENT_ADD_OLD, 
       BS1.SUBSCRIBER_PAYMENT_ADD_VOZVRAT,
       BS1.BILL_CHECKED
  FROM BILL_FOR_CLIENTS_SAVED BS1 