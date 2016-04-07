CREATE OR REPLACE VIEW V_BILL_FOR_CLIENT AS
SELECT
--
--#Version=8
--
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
    WHEN T1.ORIGIN_SUBSCRIBER_PAYMENT< 0 THEN 0
    ELSE T1.ORIGIN_SUBSCRIBER_PAYMENT
  END as ORIGIN_SUBSCRIBER_PAYMENT,  
  DECODE(TR.CALC_KOEFF, NULL, 1, 0, 1, TR.CALC_KOEFF) AS SUBSCRIBER_PAYMENT_COEF,
  T1.OPTION_CORRECT_SUM,
  T1.BILL_SUM_ORIGIN,
  TRUNC(
    RECALC_CHARGE_COST(
      T1.PHONE_NUMBER, 
      CASE 
        WHEN NVL(TR.TARIFF_ADD_COST, 0)=0 THEN
          T1.BILL_SUM_ORIGIN 
            /* Скидку абоненту не отдаём! */
            - T1.DISCOUNT_VALUE
            /* Абонплату пересчитываем по нашим тарифам */
            + (CASE 
                WHEN T1.ORIGIN_SUBSCRIBER_PAYMENT< 0 THEN 0
                ELSE T1.ORIGIN_SUBSCRIBER_PAYMENT
              END) * (DECODE(TR.CALC_KOEFF, NULL, 1, 0, 1, TR.CALC_KOEFF) - 1)
            /* Поправка на перерасчет стоимости подключенных опций */
            + T1.OPTION_CORRECT_SUM    
        ELSE
          CASE
            WHEN T1.BILL_SUM_ORIGIN>0 THEN
              T1.BILL_SUM_ORIGIN 
                /* Скидку абоненту не отдаём! */
                - T1.DISCOUNT_VALUE
                /* Добавочная стоимость для тарифов(обычно к тарифам с нулевой абонкой)*/
                + NEW_SUBSCRIBE_PAY(T1.PHONE_NUMBER, NVL(TR.TARIFF_ADD_COST, 0), T1.YEAR_MONTH)
                + T1.OPTION_CORRECT_SUM
            ELSE 0    
          END  
      END), 
    2)
  AS BILL_SUM,
  ROUND(
    CASE
      WHEN T1.ORIGIN_SUBSCRIBER_PAYMENT>0 THEN
        T1.ORIGIN_SUBSCRIBER_PAYMENT * (DECODE(TR.CALC_KOEFF, NULL, 1, 0, 1, TR.CALC_KOEFF))
      ELSE  
        NEW_SUBSCRIBE_PAY(T1.PHONE_NUMBER, NVL(TR.TARIFF_ADD_COST, 0), T1.YEAR_MONTH)
    END,     
    2) AS SUBSCRIBER_PAYMENT_NEW,
  T1.TARIFF_ID        
FROM (SELECT db_loader_bills.ACCOUNT_ID,
             db_loader_bills.YEAR_MONTH,
             db_loader_bills.phone_number, 
             db_loader_bills.date_begin,
             db_loader_bills.date_end,
             DB_LOADER_BILLS.DISCOUNT_VALUE,
             DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_ADD,
             -- Определяем абонплату с учётом вычетов за неполный срок
             CASE
               WHEN DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN>0 THEN
                 CASE                  
                   /* Если начисления за разовые услуги минусовые, то это возврат абонплаты */
                   WHEN DB_LOADER_BILLS.SINGLE_PAYMENTS < 0 THEN 
                     DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN + DB_LOADER_BILLS.SINGLE_PAYMENTS
                   ELSE DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN
                 END
               ELSE 0
             END      
             as ORIGIN_SUBSCRIBER_PAYMENT,
             -- Коэффициент перерасчёта абонплаты
             NVL(
               (SELECT TR.TARIFF_ID 
                  FROM DB_LOADER_ACCOUNT_PHONE_HISTS DP, TARIFFS TR
                  WHERE DP.PHONE_NUMBER = DB_LOADER_BILLS.PHONE_NUMBER
                    AND DP.BEGIN_DATE <= LAST_DAY(TO_DATE(TO_CHAR(DB_LOADER_BILLS.YEAR_MONTH),'YYYYMM'))
                    AND DP.END_DATE >= LAST_DAY(TO_DATE(TO_CHAR(DB_LOADER_BILLS.YEAR_MONTH),'YYYYMM'))
                    AND TR.TARIFF_ID = GET_PHONE_TARIFF_ID(DP.PHONE_NUMBER,
                                                           DP.CELL_PLAN_CODE,
                                                           LAST_DAY(TO_DATE(TO_CHAR(DB_LOADER_BILLS.YEAR_MONTH),'YYYYMM')))
                    AND ROWNUM < 2),
               (SELECT TR.TARIFF_ID 
                  FROM DB_LOADER_ACCOUNT_PHONES DP, TARIFFS TR
                  WHERE DP.PHONE_NUMBER = DB_LOADER_BILLS.PHONE_NUMBER
                    AND DP.YEAR_MONTH = DB_LOADER_BILLS.YEAR_MONTH
                    AND TR.TARIFF_ID = GET_PHONE_TARIFF_ID(DP.PHONE_NUMBER,
                                                           DP.CELL_PLAN_CODE,
                                                           DP.LAST_CHECK_DATE_TIME)
                    AND ROWNUM < 2)
               ) as TARIFF_ID,  
             -- Перерасчет поправки для стоимости опций    
             GET_TARIFF_OPTION_PERERASCHET(PHONE_NUMBER, DATE_BEGIN, DATE_END, YEAR_MONTH, SUBSCRIBER_PAYMENT_ADD) AS OPTION_CORRECT_SUM,
             db_loader_bills.bill_sum bill_sum_origin
        FROM db_loader_bills
      ) T1, TARIFFS TR
  WHERE T1.TARIFF_ID=TR.TARIFF_ID(+)  
/
