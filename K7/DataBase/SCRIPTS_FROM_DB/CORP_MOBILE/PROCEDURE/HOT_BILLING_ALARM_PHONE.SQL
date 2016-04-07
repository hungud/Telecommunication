
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HOT_BILLING_ALARM_PHONE" (subscr    IN VARCHAR2,
                                                     PDBF_ID   IN INTEGER)
--
--Version=2
--
--v2 Афросин добавил преобразование строки в число to_number(htc.data_vol, '99999999999D99',' NLS_NUMERIC_CHARACTERS = '',.''') != 0
--                                                     
IS
   flag                  INTEGER;
   SMS                   VARCHAR2 (2000);
   tarif_id              INT;
   SMS_TEXT_MN_ROAMING   VARCHAR2 (140);
   RESULT_CLOB           CLOB;

   TYPE T_ALARM_PHONE_LOG_CACHE IS TABLE OF VARCHAR2 (1)
      INDEX BY PLS_INTEGER;

   ALARM_CACHE           T_ALARM_PHONE_LOG_CACHE;

   PROCEDURE ALARM_INSERT (subscrp IN VARCHAR2, typep IN INTEGER)
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      INSERT INTO ALARM_PHONE_LOG
           VALUES (subscrp, NULL, typep);

      COMMIT;
   END;
BEGIN
   --кэш тарифа абонента
   BEGIN
      SELECT GET_PHONE_TARIFF_ID (phone_number, DD.CELL_PLAN_CODE)
        INTO tarif_id
        FROM db_loader_account_phones DD
       WHERE     phone_number = subscr
             AND year_month = TO_CHAR (SYSDATE, 'YYYYMM');
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         tarif_id := 0;
   END;

   --кэш алармов текущего месяца
   FOR rec
      IN (SELECT DISTINCT apl.type_alarm
            FROM ALARM_PHONE_LOG apl
           WHERE     apl.phone = subscr
                 AND TRUNC (apl.date_insert, 'mm') = TRUNC (SYSDATE, 'mm'))
   LOOP
      ALARM_CACHE (rec.type_alarm) := '1';
   END LOOP;

   IF     NOT ALARM_CACHE.EXISTS (1)
      AND INSTR (',' || MS_params.GET_PARAM_VALUE ('TP_NOTIFY_GPRS') || ',',
                 ',' || TO_CHAR (tarif_id) || ',') > 0
   THEN
      SELECT COUNT (*)
        INTO flag
        FROM hot_billing_temp_call htc
       WHERE     (   (INSTR (LOWER (AT_FT_DESC), 'internet') > 0)
                  OR (INSTR (LOWER (AT_FT_DESC), 'gprs') > 0)
                  OR (INSTR (LOWER (AT_FT_DESC), 'интернет') > 0)
                  OR (INSTR (LOWER (AT_FT_DESC), 'wap') > 0))
             AND TO_NUMBER (
                    SUBSTR (
                       AT_CHG_AMT,
                       0,
                       DECODE (INSTR (AT_CHG_AMT, ',00') - 1,
                               -1, LENGTH (AT_CHG_AMT),
                               INSTR (AT_CHG_AMT, ',00') - 1)),
                    '999999D99',
                    ' NLS_NUMERIC_CHARACTERS = '',.''') > 0
             AND htc.subscr_no = subscr
             AND htc.dbf_id = PDBF_ID
             AND ROWNUM <= 1;

      IF flag > 0
      THEN
         IF INSTR (
                  ','
               || MS_params.GET_PARAM_VALUE ('TP_NOTIFY_GPRS_ISKL')
               || ',',
               ',' || TO_CHAR (tarif_id) || ',') > 0
         THEN
            SMS :=
               LOADER3_pckg.SEND_SMS (
                  subscr,
                  'SMS-info',
                  MS_params.GET_PARAM_VALUE ('MES_NOTIFY_GPRS_ISKL'));
         ELSE
            SMS :=
               LOADER3_pckg.SEND_SMS (
                  subscr,
                  'SMS-info',
                  MS_params.GET_PARAM_VALUE ('MES_NOTIFY_GPRS'));
         END IF;

         ALARM_INSERT (subscr, 1);
      END IF;
   END IF;

   IF     NOT ALARM_CACHE.EXISTS (5)
      AND INSTR (',' || MS_params.GET_PARAM_VALUE ('TP_NOTIFY_PAID') || ',',
                 ',' || TO_CHAR (tarif_id) || ',') > 0
   THEN
      SELECT COUNT (*)
        INTO flag
        FROM hot_billing_temp_call htc
       WHERE     INSTR (LOWER (AT_FT_DESC), 'звонки') > 0
             AND LENGTH (CELL_ID) < 6
             AND MOD (TO_NUMBER (AT_CHG_AMT, 999999999.99), 1.7) = 0
             AND htc.subscr_no = subscr
             AND htc.dbf_id = PDBF_ID
             AND ROWNUM <= 1;

      IF flag > 0
      THEN
         SMS :=
            LOADER3_pckg.SEND_SMS (
               subscr,
               'SMS-info',
               MS_params.GET_PARAM_VALUE ('MES_NOTIFY_PAID'));
         ALARM_INSERT (subscr, 5);
      END IF;
   END IF;

   IF     NOT ALARM_CACHE.EXISTS (2)
      AND INSTR (',' || MS_params.GET_PARAM_VALUE ('TP_NOTIFY_CALL') || ',',
                 ',' || TO_CHAR (tarif_id) || ',') > 0
   THEN
      SELECT COUNT (*)
        INTO flag
        FROM hot_billing_temp_call htc
       WHERE     INSTR (LOWER (AT_FT_DESC), 'sms') = 0
             AND INSTR (LOWER (AT_FT_DESC), 'смс') = 0
             AND INSTR (LOWER (AT_FT_DESC),
                        'короткие сообщения') = 0
             AND INSTR (LOWER (AT_FT_DESC), 'mms') = 0
             AND INSTR (LOWER (AT_FT_DESC), 'ммс') = 0
             AND INSTR (LOWER (AT_FT_DESC), 'internet') = 0
             AND INSTR (LOWER (AT_FT_DESC), 'gprs') = 0
             AND INSTR (LOWER (AT_FT_DESC), 'интернет') = 0
             AND INSTR (LOWER (AT_FT_DESC), 'wap') = 0
             AND TO_NUMBER (
                    SUBSTR (
                       AT_CHG_AMT,
                       0,
                       DECODE (INSTR (AT_CHG_AMT, ',00') - 1,
                               -1, LENGTH (AT_CHG_AMT),
                               INSTR (AT_CHG_AMT, ',00') - 1)),
                    '999999D99',
                    ' NLS_NUMERIC_CHARACTERS = '',.''') > 0
             AND MOD (
                    TO_NUMBER (
                       SUBSTR (
                          AT_CHG_AMT,
                          0,
                          DECODE (INSTR (AT_CHG_AMT, ',00') - 1,
                                  -1, LENGTH (AT_CHG_AMT),
                                  INSTR (AT_CHG_AMT, ',00') - 1)),
                       '999999D99',
                       ' NLS_NUMERIC_CHARACTERS = '',.'''),
                    5) = 0
             AND htc.subscr_no = subscr
             AND htc.dbf_id = PDBF_ID
             AND ROWNUM <= 1;

      IF flag > 0
      THEN
         SELECT COUNT (*)
           INTO flag
           FROM hot_billing_temp_call htc
          WHERE     INSTR (LOWER (AT_FT_DESC), 'sms') = 0
                AND INSTR (LOWER (AT_FT_DESC), 'смс') = 0
                AND INSTR (LOWER (AT_FT_DESC),
                           'короткие сообщения') = 0
                AND INSTR (LOWER (AT_FT_DESC), 'mms') = 0
                AND INSTR (LOWER (AT_FT_DESC), 'ммс') = 0
                AND INSTR (LOWER (AT_FT_DESC), 'internet') = 0
                AND INSTR (LOWER (AT_FT_DESC), 'gprs') = 0
                AND INSTR (LOWER (AT_FT_DESC), 'интернет') = 0
                AND INSTR (LOWER (AT_FT_DESC), 'wap') = 0
                AND INSTR (NVL ( (SELECT sv.feature_de
                                    FROM services sv
                                   WHERE sv.feature_co = AT_FT_CODE),
                                AT_FT_DESC),
                           'CF') > 0
                AND TO_NUMBER (
                       SUBSTR (
                          AT_CHG_AMT,
                          0,
                          DECODE (INSTR (AT_CHG_AMT, ',00') - 1,
                                  -1, LENGTH (AT_CHG_AMT),
                                  INSTR (AT_CHG_AMT, ',00') - 1)),
                       '999999D99',
                       ' NLS_NUMERIC_CHARACTERS = '',.''') > 0
                AND MOD (
                       TO_NUMBER (
                          SUBSTR (
                             AT_CHG_AMT,
                             0,
                             DECODE (INSTR (AT_CHG_AMT, ',00') - 1,
                                     -1, LENGTH (AT_CHG_AMT),
                                     INSTR (AT_CHG_AMT, ',00') - 1)),
                          '999999D99',
                          ' NLS_NUMERIC_CHARACTERS = '',.'''),
                       5) = 0
                AND htc.subscr_no = subscr
                AND htc.dbf_id = PDBF_ID
                AND ROWNUM <= 1;

         IF flag = 0
         THEN
            RESULT_CLOB :=
                  'У абонента '
               || subscr
               || ' закончился пакет PLUS.';
            MAIl_REQ_ADD ('Пакет PLUS', RESULT_CLOB, 'MAIL_ALARM_PHONE');
            ALARM_INSERT (subscr, 2);
         ELSIF NOT ALARM_CACHE.EXISTS (3)
         THEN
            SMS :=
               LOADER3_pckg.SEND_SMS (
                  subscr,
                  'SMS-info',
                  MS_params.GET_PARAM_VALUE ('MES_NOTIFY_CALL'));
            ALARM_INSERT (subscr, 3);
         END IF;
      END IF;
   END IF;

   -- МН роуминг без санкции
   SELECT COUNT (*)
     INTO flag
     FROM hot_billing_temp_call htc, contracts c, roaming_svc_ref r
    WHERE htc.ch_seiz_dt IS NOT NULL 
    and htc.subscr_no = subscr
          AND htc.dbf_id = PDBF_ID
          AND c.phone_number_federal = htc.subscr_no
--          AND htc.data_vol != 0
          AND to_number(htc.data_vol, '99999999999D99',' NLS_NUMERIC_CHARACTERS = '',.''') != 0
          AND NVL (c.mn_roaming, 0) = 0
          AND r.roaming_svc_cod = htc.at_ft_code
          AND ROWNUM <= 1;

   IF flag > 0
   THEN
      SMS_TEXT_MN_ROAMING :=
         REPLACE (MS_params.GET_PARAM_VALUE ('SEND_TEXT_MN_ROAMING'),
                  '%%',
                  subscr);
      RESULT_CLOB := SMS_TEXT_MN_ROAMING;
      MAIl_REQ_ADD ('МН роуминг без санкции',
                    RESULT_CLOB,
                    'MAIL_ALARM_PHONE');
      ALARM_INSERT (subscr, 4);
   END IF;
END;