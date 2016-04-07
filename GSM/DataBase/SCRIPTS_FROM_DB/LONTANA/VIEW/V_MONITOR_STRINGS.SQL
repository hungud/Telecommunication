
  CREATE OR REPLACE FORCE VIEW "LONTANA"."V_MONITOR_STRINGS" ("DAT", "ERR", "COLOR") AS 
  WITH KOL_SMS
        AS (SELECT COUNT (*) SMS, max(date_send) sms_date
              FROM log_send_sms
             WHERE TRUNC (date_send) = TRUNC (SYSDATE)  and note is null)
   SELECT 'Количество отправленных смс в день, время последней смс',
             'Всего: '||to_char(sms)||'. Последняя отправленная смс: '|| TO_CHAR (sms_date, 'HH24:mi'),
          CASE
             WHEN (SMS < 2000) AND (sms_date > (SYSDATE - 10 / 1440)) THEN 'GREEN'
             WHEN ( (SMS > 2000) AND (SMS < 10000) AND (sms_date>(sysdate-40/1440)) ) THEN 'YELLOW'
             ELSE 'RED'
          END
             color
     FROM KOL_SMS
   UNION ALL
   SELECT "DAT", "ERR", "COLOR"
     FROM (WITH BLOCKED_PHONES
                AS (SELECT COUNT (*) blocked,
                           MAX (block_date_time) last_time_block
                      FROM auto_blocked_phone ab,
                           db_loader_account_phones dba
                     WHERE     TRUNC (block_date_time) = TRUNC (SYSDATE)
                           AND note LIKE '%№%'
                           AND DBA.PHONE_NUMBER(+) = AB.PHONE_NUMBER
                           AND dba.account_id <> 93
                           AND DBA.YEAR_MONTH = TO_CHAR (SYSDATE, 'yyyymm'))
           SELECT 'Количество блокированных номеров в день, время последней блокировки'
                     Dat,
                     'Итого '
                  || TO_CHAR (blocked)
                  || ' . Последняя блокировка: '
                  || TO_CHAR (last_time_block, 'HH24:mi')
                     ERR,
                  CASE
                     WHEN blocked < 2000
                     THEN
                        'GREEN'
                     WHEN ( (blocked > 2000) AND (blocked < 3000))
                     THEN
                        'YELLOW'
                     ELSE
                        'RED'
                  END
                     color
             FROM BLOCKED_PHONES)
   UNION ALL
   SELECT "DAT", "ERR", "COLOR"
     FROM (WITH UNBLOCKED_PHONES
                AS (SELECT COUNT (*) unblocked,
                           MAX (unblock_date_time) last_time_unblock
                      FROM auto_unblocked_phone ab,
                           db_loader_account_phones dba
                     WHERE     TRUNC (unblock_date_time) = TRUNC (SYSDATE)
                           AND note LIKE '%№%'
                           AND DBA.PHONE_NUMBER(+) = AB.PHONE_NUMBER
                           AND dba.account_id <> 93
                           AND DBA.YEAR_MONTH = TO_CHAR (SYSDATE, 'yyyymm'))
           SELECT 'Количество разблокированных номеров в день кроме коллектора, время последней блокировки'
                     Dat,
                     'Итого '
                  || TO_CHAR (unblocked)
                  || ' . Последняя разблокировка: '
                  || TO_CHAR (last_time_unblock, 'HH24:mi')
                     ERR,
                  CASE
                     WHEN unblocked < 2000
                     THEN
                        'GREEN'
                     WHEN ( (unblocked > 2000) AND (unblocked < 3000))
                     THEN
                        'YELLOW'
                     ELSE
                        'RED'
                  END
                     color
             FROM UNBLOCKED_PHONES)