CREATE OR REPLACE FORCE VIEW V_STAT_SMS_PREV_DAY
AS
   SELECT 'Общее количество смс' NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
   UNION ALL
   --общее количество досталвенных. Статус DELIVERED
   SELECT 'Общее количество доставленных (статус DELIVERED)'
             NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1) AND SM.STATUS_CODE = 2
   UNION ALL
   --общее количество не досталвенных. Статус DELIVERED
   SELECT 'Общее количество недоставленных (статус <> DELIVERED)'
             NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND (SM.STATUS_CODE <> 2 OR SM.STATUS_CODE IS NULL)
   UNION ALL
   --количество не досталвенных по причине превышения попыток отправки
   SELECT 'Количество не доставленных по причине превышения попыток отправки'
             NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND SM.STATUS = 'Max request count:'
   UNION ALL
   --количество не досталвенных по причине превышения попыток отправки со статусом ENROUTE
   SELECT 'Количество не доставленных по причине превышения попыток отправки со статусом ENROUTE'
             NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE     TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND SM.STATUS_CODE = 1
          AND SM.STATUS = 'Max request count:'
   UNION ALL
   --количество не досталвенных по причине превышения попыток отправки со статусом EXPIRED
   SELECT 'Количество не доставленных по причине превышения попыток отправки со статусом EXPIRED'
             NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE     TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND SM.STATUS_CODE = 3
          AND SM.STATUS = 'Max request count:'
   UNION ALL
   --количество не досталвенных по причине превышения попыток отправки DELETED
   SELECT 'Количество не доставленных по причине превышения попыток отправки со статусом DELETED'
             NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE     TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND SM.STATUS_CODE = 4
          AND SM.STATUS = 'Max request count:'
   UNION ALL
   --количество не досталвенных по причине превышения попыток отправки DELETED
   SELECT 'Количество не доставленных по причине превышения попыток отправки со статусом UNDELIVERABLE'
             NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE     TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND SM.STATUS_CODE = 5
          AND SM.STATUS = 'Max request count:'
   UNION ALL
   --количество не досталвенных по причине превышения попыток отправки ACCEPTED
   SELECT 'Количество не доставленных по причине превышения попыток отправки со статусом ACCEPTED'
             NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE     TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND SM.STATUS_CODE = 6
          AND SM.STATUS = 'Max request count:'
   UNION ALL
   --количество не досталвенных по причине превышения попыток отправки со статусом UNKNOWN
   SELECT 'Количество не доставленных по причине превышения попыток отправки со статусом UNKNOWN'
             NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE     TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND SM.STATUS_CODE = 7
          AND SM.STATUS = 'Max request count:'
   UNION ALL
   --количество не досталвенных по причине превышения попыток отправки со статусом REJECTED
   SELECT 'Количество не доставленных по причине превышения попыток отправки со статусом REJECTED'
             NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE     TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND SM.STATUS_CODE = 8
          AND SM.STATUS = 'Max request count:'
   UNION ALL
   --количество недоставленных со статусом ENROUTE
   SELECT 'Количество со статусом ENROUTE' NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE     TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND SM.STATUS_CODE = 1
          AND SM.STATUS <> 'Max request count:'
   UNION ALL
   --количество недоставленных со статусом EXPIRED
   SELECT 'Количество со статусом EXPIRED' NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE     TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND SM.STATUS_CODE = 3
          AND SM.STATUS <> 'Max request count:'
   UNION ALL
   --количество недоставленных со статусом DELETED
   SELECT 'Количество со статусом DELETED' NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE     TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND SM.STATUS_CODE = 4
          AND SM.STATUS <> 'Max request count:'
   UNION ALL
   --количество недоставленных со статусом DELETED
   SELECT 'Количество со статусом UNDELIVERABLE'
             NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE     TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND SM.STATUS_CODE = 5
          AND SM.STATUS <> 'Max request count:'
   UNION ALL
   --количество недоставленных со статусом ACCEPTED
   SELECT 'Количество со статусом ACCEPTED' NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE     TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND SM.STATUS_CODE = 6
          AND SM.STATUS <> 'Max request count:'
   UNION ALL
   --количество недоставленных со статусом UNKNOWN
   SELECT 'Количество со статусом UNKNOWN' NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE     TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND SM.STATUS_CODE = 7
          AND SM.STATUS <> 'Max request count:'
   UNION ALL
   --количество недоставленных со статусом REJECTED
   SELECT 'Количество со статусом REJECTED' NAME_PARAM,
          COUNT (*) VALUE_PARAM
     FROM sms_log sm
    WHERE     TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
          AND SM.STATUS_CODE = 8
          AND SM.STATUS <> 'Max request count:'
   --количество недоставленных с ошибкой
   UNION ALL
     SELECT 'Количество недоставленных (ошибка: '
            || SM.SLERROR
            || ')'
               NAME_PARAM,
            COUNT (*) VALUE_PARAM
       FROM sms_log sm
      WHERE TRUNC (SM.DATE_START) = TRUNC (SYSDATE - 1)
            AND SM.STATUS_CODE IS NULL
   GROUP BY SM.SLERROR;