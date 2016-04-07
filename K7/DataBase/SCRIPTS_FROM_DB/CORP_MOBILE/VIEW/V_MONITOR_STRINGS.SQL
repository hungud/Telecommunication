
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_MONITOR_STRINGS" ("DAT", "ERR", "COLOR") AS 
  WITH KOL_SMS
        AS (SELECT COUNT (*) SMS
              FROM log_send_sms
             WHERE date_send >= TRUNC (SYSDATE))
   SELECT 'Количество отправленных смс в день'
             Dat,
          to_char(SMS) ERR,
          CASE
             WHEN SMS < 7000 THEN 'GREEN'
             WHEN ( (SMS > 7000) AND (SMS < 10000)) THEN 'YELLOW'
             ELSE 'RED'
          END
             color
     FROM KOL_SMS
   UNION ALL
   SELECT "DAT", "ERR", "COLOR"
     FROM (WITH BLOCKED_PHONES
                AS (SELECT COUNT (*) blocked, max(block_date_time) last_time_block 
                      FROM auto_blocked_phone ab,
                           db_loader_account_phones dba
                     WHERE block_date_time >= TRUNC (SYSDATE)
                           AND note LIKE '%№%'
                           AND DBA.PHONE_NUMBER(+) = AB.PHONE_NUMBER
                           AND dba.account_id = 93
                           AND DBA.YEAR_MONTH = TO_CHAR (SYSDATE, 'yyyymm'))
           SELECT 'Количество блокированных номеров в день по коллектору, время последней блокировки'
                     Dat,
                  'Итого '||to_char(blocked) || ' . Последняя блокировка: '||to_char(last_time_block,'HH24:mi') ERR,
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
                AS (SELECT COUNT (*) unblocked, max(unblock_date_time) last_time_unblock
                      FROM auto_unblocked_phone ab,
                           db_loader_account_phones dba
                     WHERE unblock_date_time >= TRUNC (SYSDATE)
                           AND note LIKE '%№%'
                           AND DBA.PHONE_NUMBER(+) = AB.PHONE_NUMBER
                           AND dba.account_id = 93
                           AND DBA.YEAR_MONTH = TO_CHAR (SYSDATE, 'yyyymm'))
           SELECT 'Количество разблокированных номеров в день по коллектору'
                     Dat,
                  'Итого '||to_char(unblocked) || ' . Последняя разблокировка: '||to_char(last_time_unblock,'HH24:mi') ERR,
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
   UNION ALL
   SELECT "DAT", "ERR", "COLOR"
     FROM (WITH BLOCKED_PHONES
                AS (SELECT COUNT (*) blocked,max(block_date_time) last_time_block
                      FROM auto_blocked_phone ab,
                           db_loader_account_phones dba
                     WHERE block_date_time >= TRUNC(SYSDATE)
                           AND note LIKE '%№%'
                           AND DBA.PHONE_NUMBER(+) = AB.PHONE_NUMBER
                           AND dba.account_id <> 93
                           AND DBA.YEAR_MONTH = TO_CHAR (SYSDATE, 'yyyymm'))
           SELECT 'Количество блокированных номеров в день кроме коллектора, время последней блокировки'
                     Dat,
                  'Итого '||to_char(blocked) || ' . Последняя блокировка: '||to_char(last_time_block,'HH24:mi') ERR,
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
                AS (SELECT COUNT (*) unblocked, max(unblock_date_time) last_time_unblock
                      FROM auto_unblocked_phone ab,
                           db_loader_account_phones dba
                     WHERE unblock_date_time >= TRUNC (SYSDATE)
                           AND note LIKE '%№%'
                           AND DBA.PHONE_NUMBER(+) = AB.PHONE_NUMBER
                           AND dba.account_id <> 93
                           AND DBA.YEAR_MONTH = TO_CHAR (SYSDATE, 'yyyymm'))
           SELECT 'Количество разблокированных номеров в день кроме коллектора, время последней блокировки'
                     Dat,
                  'Итого '||to_char(unblocked) || ' . Последняя разблокировка: '||to_char(last_time_unblock,'HH24:mi') ERR,
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