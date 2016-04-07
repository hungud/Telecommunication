CREATE OR REPLACE FORCE VIEW V_PHN_UNL_INET_WITH_REPRI_ABON
--version 2
--
--v2. Алексеев. Убрал проверку на месяц существования контракта.
--              Алгоритм по отсрочке абонки делаем более гибким, теперь алгоритм распространяется на номера, находящиеся в таблице PHONE_CALC_ABON_TP_UNLIM_ON
--              Добавил поле CONTRACT_DATE.
--v1. Вьюха отбирает номера по которым дана отсрочка списания абонки
AS
   SELECT VC.PHONE_NUMBER_FEDERAL,
          TR.TARIFF_NAME,
          TR.MONTHLY_PAYMENT,
          VC.CONTRACT_DATE
     FROM V_CONTRACTS VC, TARIFFS TR, DB_LOADER_ACCOUNT_PHONES D
    WHERE     VC.TARIFF_ID = TR.TARIFF_ID(+)
          AND NVL (TR.IS_AUTO_INTERNET, 0) = 1
          AND VC.CONTRACT_CANCEL_DATE IS NULL
          --AND TO_NUMBER (TO_CHAR (ADD_MONTHS (VC.CONTRACT_DATE, 1), 'YYYYMM')) = TO_NUMBER (TO_CHAR (SYSDATE, 'YYYYMM'))
          AND D.PHONE_NUMBER = VC.PHONE_NUMBER_FEDERAL
          AND D.YEAR_MONTH = TO_NUMBER (TO_CHAR (SYSDATE, 'YYYYMM'))
          AND NVL (D.PHONE_IS_ACTIVE, -1) = 1
          AND EXISTS
                 (SELECT AB.PHONE_NUMBER
                    FROM PHONE_CALC_ABON_TP_UNLIM_ON ab
                   WHERE AB.PHONE_NUMBER = VC.PHONE_NUMBER_FEDERAL
                         AND AB.YEAR_MONTH =
                                TO_NUMBER (TO_CHAR (SYSDATE, 'YYYYMM'))
                         AND AB.TARIFF_ID = TR.TARIFF_ID);