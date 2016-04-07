
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_BILL_FINANCE_FOR_CLIENTS" ("ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "BILL_SUM_OLD", "BILL_SUM_NEW", "ABON_TP_OLD", "ABON_TP_NEW", "ABON_ADD_OLD", "ABON_ADD_NEW", "DISCOUNT_OLD", "DISCOUNT_NEW", "SINGLE_PENALTI", "SINGLE_PAYMENTS_OLD", "SINGLE_PAYMENTS_NEW", "CALLS_COUNTRY", "CALLS_SITY", "CALLS_LOCAL", "CALLS_SMS_MMS", "CALLS_GPRS", "CALLS_RUS_RPP", "COMPLETE_BILL", "ROUMING_NATIONAL", "ROUMING_INTERNATIONAL", "SINGLE_OTHER", "SINGLE_TURN_ON_SERV") AS 
  SELECT T1.ACCOUNT_ID,
          T1.YEAR_MONTH,
          T1.PHONE_NUMBER,
          T1.BILL_SUM_OLD,
          CASE
             WHEN T1.BILL_SUM_OLD <> 0
             THEN
                ROUND (
                     T1.BILL_SUM_OLD
                   + CASE
                        WHEN T1.ADD_SINGLE_PENALTI_TO_BILL = 1
                        THEN
                           T1.SINGLE_PENALTI + T1.SINGLE_VIEW_BLACK_LIST
                        ELSE
                           0
                     END
                   + CASE
                        WHEN T1.ABON_MAIN > 0
                        THEN
                             T1.ABON_TP_REAL
                           * (T1.ABON_TP_FULL_NEW / T1.ABON_MAIN)
                        ELSE
                           T1.ABON_TP_FULL_NEW
                     END
                   - T1.ABON_TP_REAL
                   + CASE
                        WHEN T1.ABON_SERVICE_OLD + T1.ABON_SERVICE_ADD_COST <
                                0
                        THEN
                           0
                        ELSE
                           T1.ABON_SERVICE_OLD + T1.ABON_SERVICE_ADD_COST
                     END
                   - T1.ABON_SERVICE_OLD
                   - T1.DISCOUNTS
                   + T1.DISCOUNT_SMS_PLUS
                   + NVL (
                        (SELECT NVL (br.calls_all, 0)
                           FROM BILL_RECALC_ADD_COST br
                          WHERE     br.account_id = T1.ACCOUNT_ID
                                AND br.year_month = T1.YEAR_MONTH
                                AND br.phone_number = T1.PHONE_NUMBER
                                AND ROWNUM = 1),
                        0)
                   + CASE
                        WHEN MS_CONSTANTS.GET_CONSTANT_VALUE ('SERVER_NAME') =
                                'GSM_CORP'
                        THEN
                           0
                        ELSE
                           T1.DISCOUNT_CALL
                     END
                   + CASE                         -- услуга ДЛЯ ТП "РЕКЛАМНЫЙ"
                        WHEN     (MS_CONSTANTS.GET_CONSTANT_VALUE (
                                     'SERVER_NAME') = 'CORP_MOBILE')
                             AND (EXISTS
                                     (SELECT 1
                                        FROM V_BILL_ABON_PER_FOR_CLIENT VA
                                       WHERE     VA.ACCOUNT_ID =
                                                    T1.ACCOUNT_ID
                                             AND VA.YEAR_MONTH =
                                                    T1.YEAR_MONTH
                                             AND VA.PHONE_NUMBER =
                                                    T1.PHONE_NUMBER
                                             AND (   VA.TARIFF_ID = 1060
                                                  OR VA.TARIFF_ID = 1080)))
                        THEN
                             T1.DISCOUNT_SOVINTEL
                           * (  SELECT   (  MAX (vaa.DATE_END)
                                          - MIN (vaa.DATE_BEGIN)
                                          + 1)
                                       / TO_NUMBER (
                                            TO_CHAR (
                                               LAST_DAY (MAX (vaa.DATE_END)),
                                               'dd'))
                                  FROM V_BILL_ABON_PER_FOR_CLIENT vaa
                                 WHERE     vaa.ACCOUNT_ID = T1.ACCOUNT_ID
                                       AND vaa.YEAR_MONTH = T1.YEAR_MONTH
                                       AND vaa.PHONE_NUMBER = T1.PHONE_NUMBER
                                       AND vaa.TARIFF_ID IN (1060, 1080)
                              GROUP BY vaa.ACCOUNT_ID,
                                       vaa.YEAR_MONTH,
                                       vaa.PHONE_NUMBER)
                        ELSE
                           0
                     END,
                   4)
             ELSE
                0
          END
             AS BILL_SUM_NEW,
          T1.ABON_TP_REAL AS ABON_TP_OLD,
          ROUND (
             CASE
                WHEN T1.ABON_MAIN > 0
                THEN
                   T1.ABON_TP_REAL * (T1.ABON_TP_FULL_NEW / T1.ABON_MAIN)
                ELSE
                   T1.ABON_TP_FULL_NEW
             END,
             4)
             AS ABON_TP_NEW,                  --Определим новую абонку клиенту
          T1.ABON_SERVICE_OLD AS ABON_ADD_OLD,
          CASE
             WHEN T1.ABON_SERVICE_OLD + T1.ABON_SERVICE_ADD_COST < 0 THEN 0
             ELSE T1.ABON_SERVICE_OLD + T1.ABON_SERVICE_ADD_COST
          END
             AS ABON_ADD_NEW, -- Сумма абон платы за услугу не может падать ниже 0.
          T1.DISCOUNTS AS DISCOUNT_OLD,
            T1.DISCOUNT_SMS_PLUS
          + CASE
               WHEN MS_CONSTANTS.GET_CONSTANT_VALUE ('SERVER_NAME') =
                       'GSM_CORP'
               THEN
                  0
               ELSE
                  T1.DISCOUNT_CALL
            END
          + CASE                                  -- услуга ДЛЯ ТП "РЕКЛАМНЫЙ"
               WHEN     (MS_CONSTANTS.GET_CONSTANT_VALUE ('SERVER_NAME') =
                            'CORP_MOBILE')
                    AND (EXISTS
                            (SELECT 1
                               FROM V_BILL_ABON_PER_FOR_CLIENT VA
                              WHERE     VA.ACCOUNT_ID = T1.ACCOUNT_ID
                                    AND VA.YEAR_MONTH = T1.YEAR_MONTH
                                    AND VA.PHONE_NUMBER = T1.PHONE_NUMBER
                                    AND (   VA.TARIFF_ID = 1060
                                         OR VA.TARIFF_ID = 1080)))
               THEN
                    T1.DISCOUNT_SOVINTEL
                  * (  SELECT   (MAX (vaa.DATE_END) - MIN (vaa.DATE_BEGIN) + 1)
                              / TO_NUMBER (
                                   TO_CHAR (LAST_DAY (MAX (vaa.DATE_END)),
                                            'dd'))
                         FROM V_BILL_ABON_PER_FOR_CLIENT vaa
                        WHERE     vaa.ACCOUNT_ID = T1.ACCOUNT_ID
                              AND vaa.YEAR_MONTH = T1.YEAR_MONTH
                              AND vaa.PHONE_NUMBER = T1.PHONE_NUMBER
                              AND vaa.TARIFF_ID IN (1060, 1080)
                     GROUP BY vaa.ACCOUNT_ID,
                              vaa.YEAR_MONTH,
                              vaa.PHONE_NUMBER)
               ELSE
                  0
            END
             AS DISCOUNT_NEW,
          T1.SINGLE_PENALTI,
          T1.SINGLE_PAYMENTS - T1.SINGLE_MAIN - T1.SINGLE_ADD
             AS SINGLE_PAYMENTS_OLD,
            T1.SINGLE_PAYMENTS
          - T1.SINGLE_MAIN
          - T1.SINGLE_ADD
          + CASE
               WHEN T1.ADD_SINGLE_PENALTI_TO_BILL = 1
               THEN
                  T1.SINGLE_PENALTI + T1.SINGLE_VIEW_BLACK_LIST
               ELSE
                  0
            END
             AS SINGLE_PAYMENTS_NEW,
          T1.CALLS_COUNTRY,
          T1.CALLS_SITY CALLS_SITY,
            T1.CALLS_LOCAL
          + NVL (
               (SELECT NVL (br.calls_all, 0)
                  FROM BILL_RECALC_ADD_COST br
                 WHERE     br.account_id = T1.ACCOUNT_ID
                       AND br.year_month = T1.YEAR_MONTH
                       AND br.phone_number = T1.PHONE_NUMBER
                       AND ROWNUM = 1),
               0)
             AS CALLS_LOCAL,
          T1.CALLS_SMS_MMS,
          T1.CALLS_GPRS,
          T1.CALLS_RUS_RPP,
          T1.COMPLETE_BILL,
          T1.ROUMING_NATIONAL,
          T1.ROUMING_INTERNATIONAL,
          T1.SINGLE_OTHER,
          T1.SINGLE_TURN_ON_SERV
     FROM (SELECT NVL (a.calc_koeff_detal, 1) coef,
                  FB.ACCOUNT_ID,
                  FB.YEAR_MONTH,
                  FB.PHONE_NUMBER,
                  --FB.BILL_SUM AS BILL_SUM_OLD,
                  CASE
                     WHEN fb.BILL_SUM = 0
                     THEN
                        0
                     ELSE
                        (  FB.abon_main
                         + FB.abon_add
                         + FB.abon_other
                         + FB.single_main
                         + FB.single_add
                         + FB.single_penalti
                         + FB.single_change_tariff
                         + ROUND (
                                FB.single_turn_on_serv
                              * NVL (a.calc_koeff_detal, 1),
                              4)
                         + FB.single_correction_rouming
                         + FB.single_intra_web
                         + FB.single_view_black_list
                         + ROUND (
                                FB.single_other
                              * DECODE (SIGN (FB.single_other),
                                        -1, 1,
                                        NVL (a.calc_koeff_detal, 1)),
                              4)
                         + DECODE (FB.discounts, 0, 0, FB.discount_year)
                         + FB.discount_sms_plus
                         + FB.DISCOUNT_SOVINTEL
                         + ROUND (
                              FB.discount_call * NVL (a.calc_koeff_detal, 1),
                              4)
                         + FB.discount_count_on_phones
                         + discount_others
                         + ROUND (
                              FB.calls_country * NVL (a.calc_koeff_detal, 1),
                              4)
                         + ROUND (
                              FB.calls_sity * NVL (a.calc_koeff_detal, 1),
                              4)
                         + ROUND (
                              FB.calls_local * NVL (a.calc_koeff_detal, 1),
                              4)
                         + ROUND (
                              FB.calls_sms_mms * NVL (a.calc_koeff_detal, 1),
                              4)
                         + ROUND (
                              FB.calls_gprs * NVL (a.calc_koeff_detal, 1),
                              4)
                         + ROUND (
                              FB.calls_rus_rpp * NVL (a.calc_koeff_detal, 1),
                              4)
                         + ROUND (
                                FB.rouming_national
                              * NVL (a.calc_koeff_detal, 1),
                              4)
                         + ROUND (
                                FB.rouming_international
                              * NVL (a.calc_koeff_detal, 1),
                              4))
                  END
                     AS BILL_SUM_OLD,
                  FB.ABON_MAIN + FB.SINGLE_MAIN AS ABON_TP_REAL, --Реальная абонка по билайну
                  FB.ABON_ADD + FB.SINGLE_ADD AS ABON_SERVICE_OLD, --Реальная плата за услуги по билайну
                  CASE
                     WHEN (FB.BILL_SUM <> 0) AND (FB.ABON_MAIN > 0)
                     THEN
                        CASE
                           WHEN GET_NEW_FULL_FINANCE_ABON_TP (
                                   FB.ACCOUNT_ID,
                                   FB.YEAR_MONTH,
                                   FB.PHONE_NUMBER) > 0
                           THEN
                              GET_NEW_FULL_FINANCE_ABON_TP (FB.ACCOUNT_ID,
                                                            FB.YEAR_MONTH,
                                                            FB.PHONE_NUMBER)
                           ELSE
                              FB.ABON_MAIN
                        END
                     ELSE
                        0
                  END
                     AS ABON_TP_FULL_NEW, --Полная абонка за месяц, пересчитанная
                  CASE
                     WHEN     (FB.BILL_SUM <> 0)
                          AND (FB.CALLS = 0)
                          AND (FB.ABON_MAIN + FB.SINGLE_MAIN = 0)
                          AND (MS_CONSTANTS.GET_CONSTANT_VALUE (
                                  'SERVER_NAME') = 'CORP_MOBILE')
                          AND (   (FB.ABON_ADD + FB.SINGLE_ADD = 418.9)
                               OR (FB.ABON_ADD + FB.SINGLE_ADD = 403.56)
                               OR (FB.ABON_ADD + FB.SINGLE_ADD = 304.794))
                     THEN
                        420 - (FB.ABON_ADD + FB.SINGLE_ADD)
                     WHEN     (FB.BILL_SUM <> 0)
                          AND (FB.ABON_ADD + FB.SINGLE_ADD <> 0)
                     THEN
                        GET_TARIFF_OPTION_ADD_COST2 (FB.ACCOUNT_ID,
                                                     FB.YEAR_MONTH,
                                                     FB.PHONE_NUMBER)
                     ELSE
                        0
                  END
                     AS ABON_SERVICE_ADD_COST,    --Добавочная стоимость услуг
                  FB.ABONKA,
                  FB.CALLS,
                  FB.SINGLE_PAYMENTS,
                  FB.DISCOUNTS,
                  FB.COMPLETE_BILL,
                  FB.ABON_MAIN,
                  FB.ABON_ADD,
                  FB.ABON_OTHER,
                  FB.SINGLE_MAIN,
                  FB.SINGLE_ADD,
                  FB.SINGLE_PENALTI,
                  FB.SINGLE_CHANGE_TARIFF,
                  FB.SINGLE_VIEW_BLACK_LIST,
                  CASE
                     WHEN FB.SINGLE_PAYMENTS =
                               FB.SINGLE_MAIN
                             + FB.SINGLE_ADD
                             + FB.SINGLE_CHANGE_TARIFF
                             + ROUND (
                                    FB.SINGLE_TURN_ON_SERV
                                  * NVL (a.calc_koeff_detal, 1),
                                  4)
                             + FB.SINGLE_CORRECTION_ROUMING
                             + FB.SINGLE_INTRA_WEB
                             + ROUND (
                                    FB.SINGLE_OTHER
                                  * DECODE (SIGN (FB.single_other),
                                            -1, 1,
                                            NVL (a.calc_koeff_detal, 1)),
                                  4)
                     THEN
                        1
                     ELSE
                        0
                  END
                     AS ADD_SINGLE_PENALTI_TO_BILL,
                  FB.DISCOUNT_SMS_PLUS,
                  FB.DISCOUNT_YEAR,
                  ROUND (FB.DISCOUNT_CALL * NVL (a.calc_koeff_detal, 1), 4)
                     DISCOUNT_CALL,
                  FB.DISCOUNT_SOVINTEL,
                  ROUND (FB.CALLS_COUNTRY * NVL (a.calc_koeff_detal, 1), 4)
                     CALLS_COUNTRY,
                  ROUND (FB.CALLS_SITY * NVL (a.calc_koeff_detal, 1), 4)
                     CALLS_SITY,
                  ROUND (FB.CALLS_LOCAL * NVL (a.calc_koeff_detal, 1), 4)
                     CALLS_LOCAL,
                  ROUND (FB.CALLS_SMS_MMS * NVL (a.calc_koeff_detal, 1), 4)
                     CALLS_SMS_MMS,
                  ROUND (FB.CALLS_GPRS * NVL (a.calc_koeff_detal, 1), 4)
                     CALLS_GPRS,
                  ROUND (FB.CALLS_RUS_RPP * NVL (a.calc_koeff_detal, 1), 4)
                     CALLS_RUS_RPP,
                  ROUND (FB.rouming_national * NVL (a.calc_koeff_detal, 1),
                         4)
                     rouming_national,
                  ROUND (
                     FB.rouming_international * NVL (a.calc_koeff_detal, 1),
                     4)
                     rouming_international,
                  ROUND (
                       FB.SINGLE_OTHER
                     * DECODE (SIGN (FB.single_other),
                               -1, 1,
                               NVL (a.calc_koeff_detal, 1)),
                     4)
                     SINGLE_OTHER,
                  ROUND (
                     FB.single_turn_on_serv * NVL (a.calc_koeff_detal, 1),
                     4)
                     single_turn_on_serv,
                  c.curr_tariff_id
             FROM contracts c,
                  tariffs a,
                  (SELECT FB1.*
                     FROM DB_LOADER_FULL_FINANCE_BILL FB1,
                          BILL_FINANCE_FOR_CLIENTS_SAVED
                    WHERE     FB1.COMPLETE_BILL = 1
                          AND FB1.ACCOUNT_ID =
                                 BILL_FINANCE_FOR_CLIENTS_SAVED.ACCOUNT_ID(+)
                          AND FB1.YEAR_MONTH =
                                 BILL_FINANCE_FOR_CLIENTS_SAVED.YEAR_MONTH(+)
                          AND FB1.PHONE_NUMBER =
                                 BILL_FINANCE_FOR_CLIENTS_SAVED.PHONE_NUMBER(+)
                          AND BILL_FINANCE_FOR_CLIENTS_SAVED.PHONE_NUMBER
                                 IS NULL) FB,
                  contract_cancels cc
            WHERE     c.phone_number_federal(+) = FB.phone_number
                  AND c.curr_tariff_id = a.tariff_id(+)
                  /* and not exists
                        (select 1 from contract_cancels cc where cc.contract_id=c.contract_id)
                   and (c.contract_date =
                       (Select max(c.contract_date)
                          from contracts c, contract_cancels b
                         where c.phone_number_federal =  FB.phone_number
                           and c.contract_id = b.contract_id(+)
                         group by c.phone_number_federal)
                         or c.contract_date is null)     */
                  AND cc.CONTRACT_ID(+) = c.CONTRACT_ID
                  AND (NVL (c.contract_date, TO_DATE ('199001', 'yyyymm')) <=
                            ADD_MONTHS (TO_DATE (fb.YEAR_MONTH, 'yyyymm'), 1)
                          - 1)
                  AND NVL (cc.CONTRACT_CANCEL_DATE,
                           TO_DATE ('205012', 'yyyymm')) >=
                         TO_DATE (fb.YEAR_MONTH, 'yyyymm')) T1
   UNION ALL
   SELECT BS1.ACCOUNT_ID,
          BS1.YEAR_MONTH,
          BS1.PHONE_NUMBER,
          BS1.BILL_SUM_OLD,
          BS1.BILL_SUM_NEW,
          BS1.ABON_TP_OLD,
          BS1.ABON_TP_NEW,
          BS1.ABON_ADD_OLD,
          BS1.ABON_ADD_NEW,
          BS1.DISCOUNT_OLD,
          BS1.DISCOUNT_NEW,
          BS1.SINGLE_PENALTI,
          BS1.SINGLE_PAYMENTS_OLD,
          BS1.SINGLE_PAYMENTS_NEW,
          BS1.CALLS_COUNTRY,
          BS1.CALLS_SITY,
          BS1.CALLS_LOCAL,
          BS1.CALLS_SMS_MMS,
          BS1.CALLS_GPRS,
          BS1.CALLS_RUS_RPP,
          BS1.COMPLETE_BILL,
          NULL,
          NULL,
          NULL,
          NULL
     FROM BILL_FINANCE_FOR_CLIENTS_SAVED BS1