CREATE OR REPLACE VIEW V_PHONE_NUMBERS_FOR_UNLOCK AS

--VERSION 3
--v.3 30.10.2015 Алексеев. Добавил доп. проверку при определении порога разблока
--                         Исп. нулевой порог разблока если:
--                         - тариф с дискретным списание 
--                         - идет имеено дискретное списание (учет сдвига) 
--                         - абонка по тарифу зафиксирована, т.е. списана.
--                         Иначе оставляем прежнюю логику
--v.2 20.01.2015 Алексеев. Добавил учет обещанных платежей
--v.1
   SELECT V.PHONE_NUMBER_FEDERAL,
          GET_ABONENT_BALANCE (V.PHONE_NUMBER_FEDERAL) BALANCE,
          V.SURNAME || ' ' || NAME || ' ' || PATRONYMIC FIO,
          V.DISCONNECT_LIMIT,
          V.ACCOUNT_ID,
          v.HAND_BLOCK
     FROM v_abonent_balances_2 V, TARIFFS
    WHERE loader_script_name IS NOT NULL
          AND TARIFFS.TARIFF_ID(+) = V.TARIFF_ID
          AND GET_ABONENT_BALANCE (V.PHONE_NUMBER_FEDERAL)
              - NVL (V.DISCONNECT_LIMIT, 0) >
                 NVL (
                    V.CONNECT_LIMIT,
                    NVL (
                       CASE
                          WHEN NVL (V.IS_CREDIT_CONTRACT, 0) = 1
                          THEN
                             CASE
                                WHEN (NVL (TARIFFS.DISCR_SPISANIE, 0) = 1)
                                     AND --если дискретное списание абон. платы по тарифу
                                         (TO_NUMBER (
                                             TO_CHAR (SYSDATE, 'YYYYMM')) >=
                                             TO_NUMBER (
                                                TO_CHAR (
                                                   ADD_MONTHS (
                                                      V.CONTRACT_DATE,
                                                      NVL (
                                                         TARIFFS.
                                                          SDVIG_DISCR_SPISANIE,
                                                         0)),
                                                   'YYYYMM')))
                                     AND --учитываем сдвиг дискретного списания
                                         (CHECK_DISCR_SPISANIE_ABON (
                                             V.PHONE_NUMBER_FEDERAL) = 1)
                                THEN       --проверяем наличие списания абонки
                                   0
                                ELSE
                                   TARIFFS.BALANCE_UNBLOCK_CREDIT
                             END
                          ELSE
                             CASE
                                WHEN (NVL (TARIFFS.DISCR_SPISANIE, 0) = 1)
                                     AND --если дискретное списание абон. платы по тарифу
                                         (TO_NUMBER (
                                             TO_CHAR (SYSDATE, 'YYYYMM')) >=
                                             TO_NUMBER (
                                                TO_CHAR (
                                                   ADD_MONTHS (
                                                      V.CONTRACT_DATE,
                                                      NVL (
                                                         TARIFFS.
                                                          SDVIG_DISCR_SPISANIE,
                                                         0)),
                                                   'YYYYMM')))
                                     AND --учитываем сдвиг дискретного списания
                                         (CHECK_DISCR_SPISANIE_ABON (
                                             V.PHONE_NUMBER_FEDERAL) = 1)
                                THEN       --проверяем наличие списания абонки
                                   0
                                ELSE
                                   TARIFFS.BALANCE_UNBLOCK
                             END
                       END,
                       0))
          --AND  rownum <= 1
          AND V.PHONE_IS_ACTIVE_CODE = 0
          AND v.HAND_BLOCK = 0
          AND v.CONSERVATION = 0
          AND V.DOP_STATUS IS NULL
          AND EXISTS
                 (SELECT 1
                    FROM DB_LOADER_ACCOUNT_PHONES
                   WHERE V.PHONE_NUMBER_FEDERAL =
                            DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER
                         AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH >=
                                TO_NUMBER (TO_CHAR (SYSDATE - 5, 'yyyymm'))
                         AND DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME >
                                SYSDATE - 5)
          AND NOT EXISTS
                     (SELECT 1
                        FROM fraud_blocked_phone fb
                       WHERE fb.phone_number = V.PHONE_NUMBER_FEDERAL
                             AND fb.status = 1
                             AND fb.date_block >=
                                    (SELECT MAX (abp.block_date_time)
                                       FROM AUTO_BLOCKED_PHONE abp
                                      WHERE abp.phone_number =
                                               V.PHONE_NUMBER_FEDERAL))
          AND NOT EXISTS
                     (SELECT 1
                        FROM DB_LOADER_ACCOUNT_PHONES dl
                       WHERE dl.phone_number = V.PHONE_NUMBER_FEDERAL
                             AND dl.system_block = 1
                             AND dl.year_month =
                                    (SELECT MAX (dl1.year_month)
                                       FROM DB_LOADER_ACCOUNT_PHONES dl1
                                      WHERE dl1.phone_number =
                                               V.PHONE_NUMBER_FEDERAL))
          AND NOT EXISTS
                     (SELECT 1
                        FROM AUTO_UNBLOCKED_PHONE
                       WHERE V.PHONE_NUMBER_FEDERAL =
                                AUTO_UNBLOCKED_PHONE.PHONE_NUMBER
                             AND (AUTO_UNBLOCKED_PHONE.UNBLOCK_DATE_TIME >
                                     SYSDATE - 6 / 24)               -- 6 HOUR
                             AND AUTO_UNBLOCKED_PHONE.Note IS NULL)
          AND (EXISTS
                  (SELECT 1
                     FROM DB_LOADER_PAYMENTS DP
                    WHERE DP.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                          AND DP.PAYMENT_DATE > SYSDATE - 3)
               OR EXISTS
                     (SELECT 1
                        FROM RECEIVED_PAYMENTS RP
                       WHERE RP.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                             AND RP.PAYMENT_DATE_TIME > SYSDATE - 3)
               OR EXISTS
                     (SELECT 1
                        FROM V_ACTIVE_PROMISED_PAYMENTS PP
                       WHERE PP.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL));
