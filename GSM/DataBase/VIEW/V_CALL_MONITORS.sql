DROP VIEW V_CALL_MONITORS;

/* Formatted on 07.05.2015 10:00:27 (QP5 v5.252.13127.32867) */
CREATE OR REPLACE FORCE VIEW V_CALL_MONITORS
AS
     SELECT V.CONTRACT_ID,
            V.PHONE_NUMBER_FEDERAL,
            V.CONTRACT_DATE,
            (SELECT CC.CONTRACT_CANCEL_DATE
               FROM CONTRACT_CANCELS cc
              WHERE CC.CONTRACT_ID = V.CONTRACT_ID)
               CONTRACT_CANCEL_DATE,
            TAR.TARIFF_NAME,
            TAR.TARIFF_ID,
            TRUNC (SUM (NVL (q.DURATION_OUT_NO_PAID, 0)), 2)
               DURATION_OUT_NO_PAID,
            TRUNC (SUM (NVL (q.DURATION_OUT_NO_PAID_ONLY_BEE, 0)), 2)
               DURATION_OUT_NO_PAID_ONLY_BEE,
            TRUNC (SUM (NVL (q.DURATION_IN_NO_PAID, 0)), 2) DURATION_IN_NO_PAID,
            TRUNC (SUM (NVL (q.DURATION_IN_NO_PAID_ONLY_BEE, 0)), 2)
               DURATION_IN_NO_PAID_ONLY_BEE,
            TRUNC (SUM (NVL (q.DURATION_IN_YES_PAID, 0)), 2)
               DURATION_IN_YES_PAID,
            TRUNC (SUM (NVL (q.DURATION_IN_YES_PAID_ONLY_BEE, 0)), 2)
               DURATION_IN_YES_PAID_ONLY_BEE,
            TRUNC (SUM (NVL (q.DURATION_OUT_YES_PAID, 0)), 2)
               DURATION_OUT_YES_PAID,
            TRUNC (SUM (NVL (q.DURATION_OUT_YES_PAID_ONLY_BEE, 0)), 2)
               DURATION_OUT_YES_PAID_ONLY_BEE,
            TRUNC (SUM (NVL (q.INTERNET_TRAFFIC, 0)), 2) INTERNET_TRAFFIC,
            SUM (NVL (Q.SMS_OUT, 0)) SMS_OUT,
            SUM (NVL (Q.MMS_OUT, 0)) MMS_OUT,
            DECODE (DLA.PHONE_IS_ACTIVE,
                    0, 'Не активен',
                    1, 'Активен',
                    'Отсутствует')
               PHONE_IS_ACTIVE
       FROM                                              --      v_contracts v
           contracts v,
            DB_LOADER_ACCOUNT_PHONES dla,
            TARIFFS tar,
            CALL_SUMMARY_STAT q
      WHERE     q.CONTRACT_ID = V.CONTRACT_ID
            AND V.CONTRACT_DATE =
                   (  SELECT MAX (CN.CONTRACT_DATE)
                        FROM contracts cn
                       WHERE CN.PHONE_NUMBER_FEDERAL = V.PHONE_NUMBER_FEDERAL
                    GROUP BY CN.PHONE_NUMBER_FEDERAL)
            AND V.PHONE_NUMBER_FEDERAL = DLA.PHONE_NUMBER
            AND DLA.YEAR_MONTH = TO_NUMBER (TO_CHAR (SYSDATE, 'yyyymm'))
            AND DLA.YEAR_MONTH = Q.YEAR_MONTH
            --and V.TARIFF_ID = TAR.TARIFF_ID
            AND V.CURR_TARIFF_ID = TAR.TARIFF_ID
   --and V.PHONE_NUMBER_FEDERAL = '9670963090'
   GROUP BY V.CONTRACT_ID,
            V.PHONE_NUMBER_FEDERAL,
            V.CONTRACT_DATE                --         , V.CONTRACT_CANCEL_DATE
                           ,
            TAR.TARIFF_ID,
            TAR.TARIFF_NAME,
            DLA.PHONE_IS_ACTIVE;


GRANT SELECT ON V_CALL_MONITORS TO LONTANA_ROLE;

GRANT SELECT ON V_CALL_MONITORS TO LONTANA_ROLE_RO;
