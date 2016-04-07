DROP VIEW V_MONITOR_OUTCALL_DATA;

/* Formatted on 07/05/2015 17:37:27 (QP5 v5.252.13127.32867) */
CREATE OR REPLACE FORCE VIEW V_MONITOR_OUTCALL_DATA
AS
--Version=4
--v4. Матюнин 08.05.2015 - добавлены дополнительные поля в правила (Все исходящие платные, Все исходящие бесплатные).
--v3. Матюнин 07.05.2015 - добавлены дополнительные поля в правила (заменены страые поля).  
--v2
--v.1 Афросин 05.05.2015 Создал вьюху для отображения данных для Монитор -> Монитор исходящей связи
--                      Переделал проверку условий с AND на OR
--
   SELECT V.CONTRACT_DATE,
          V.CONTRACT_CANCEL_DATE,
          V.CONTRACT_ID,
          V.TARIFF_ID,
          V.DURATION_OUT_NO_PAID,
          V.DURATION_OUT_NO_PAID_ONLY_BEE,
          V.DURATION_IN_NO_PAID,
          V.DURATION_IN_NO_PAID_ONLY_BEE,
          V.DURATION_IN_YES_PAID,
          V.DURATION_IN_YES_PAID_ONLY_BEE,
          V.DURATION_OUT_YES_PAID,
          V.DURATION_OUT_YES_PAID_ONLY_BEE,
          TRUNC (V.INTERNET_TRAFFIC / (1024 * 1024), 3) INTERNET_TRAFFIC, -- указываем в Гигабайтах
          V.SMS_OUT,
          V.MMS_OUT,
          V.PHONE_NUMBER_FEDERAL,
          V.TARIFF_NAME,
          V.PHONE_IS_ACTIVE,
          R.RULE_FOR_CALLS_MONITOR_ID
     FROM V_CALL_MONITORS v, RULE_FOR_CALLS_MONITOR r
    WHERE     V.TARIFF_ID = R.TARIFF_ID
          AND (   V.INTERNET_TRAFFIC >= (R.LIMIT_INET_TRAFFIC * 1024 * 1024)
               OR V.DURATION_OUT_NO_PAID_ONLY_BEE >= R.LIMIT_OUT_CALL_NO_PAY_ONLY_BEE
               OR V.DURATION_OUT_YES_PAID_ONLY_BEE >= R.LIMIT_OUT_CALL_PAY_ONLY_BEE
               OR ( NVL(V.DURATION_OUT_NO_PAID, 0) - NVL(V.DURATION_OUT_NO_PAID_ONLY_BEE, 0) ) >= R.LIMIT_OUT_CALL_NO_PAY_OTHER
               OR ( NVL(V.DURATION_OUT_YES_PAID, 0) - NVL(V.DURATION_OUT_YES_PAID_ONLY_BEE, 0) ) >= R.LIMIT_OUT_CALL_PAY_OTHER
               OR V.SMS_OUT >= R.LIMIT_OUT_SMS
               OR V.DURATION_OUT_NO_PAID >= R.LIMIT_OUT_CALL_NO_PAY_ALL
               OR V.DURATION_OUT_YES_PAID >= R.LIMIT_OUT_CALL_PAY_ALL
              )
          AND R.TURN_ON = 1;


GRANT SELECT ON V_MONITOR_OUTCALL_DATA TO LONTANA_ROLE;

GRANT SELECT ON V_MONITOR_OUTCALL_DATA TO LONTANA_ROLE_RO;
