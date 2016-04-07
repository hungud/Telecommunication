
  CREATE MATERIALIZED VIEW "LONTANA"."V_MONITOR_STRINGS_MAT" ("DAT", "ERR", "COLOR")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 0 INITRANS 2 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH COMPLETE ON DEMAND START WITH sysdate+0 NEXT SYSDATE + NUMTODSINTERVAL(5, 'MINUTE')
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  USING ENFORCED CONSTRAINTS DISABLE QUERY REWRITE
  AS WITH KOL_SMS
     AS (SELECT COUNT (*) SMS, MAX (date_send) sms_date
           FROM log_send_sms
          WHERE TRUNC (date_send) = TRUNC (SYSDATE) AND note IS NULL)
SELECT 'Количество отправленных смс в день, время последней смс',
          'Всего: '
       || TO_CHAR (sms)
       || '. Последняя отправленная смс: '
       || TO_CHAR (sms_date, 'HH24:mi'),
       CASE
          WHEN (SMS < 2000) AND (sms_date > (SYSDATE - 10 / 1440))
          THEN
             'GREEN'
          WHEN (    (SMS > 2000)
                AND (SMS < 10000)
                AND (sms_date > (SYSDATE - 40 / 1440)))
          THEN
             'YELLOW'
          ELSE
             'RED'
       END
          color
  FROM KOL_SMS
UNION ALL
SELECT "DAT", "ERR", "COLOR"
  FROM (WITH BLOCKED_PHONES
             AS (SELECT COUNT (*) blocked,
                        MAX (block_date_time) last_time_block
                   FROM auto_blocked_phone ab, db_loader_account_phones dba
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
                  WHEN blocked < 2000 THEN 'GREEN'
                  WHEN ( (blocked > 2000) AND (blocked < 3000)) THEN 'YELLOW'
                  ELSE 'RED'
               END
                  color
          FROM BLOCKED_PHONES)
UNION ALL
SELECT "DAT", "ERR", "COLOR"
  FROM (WITH UNBLOCKED_PHONES
             AS (SELECT COUNT (*) unblocked,
                        MAX (unblock_date_time) last_time_unblock
                   FROM auto_unblocked_phone ab, db_loader_account_phones dba
                  WHERE     TRUNC (unblock_date_time) = TRUNC (SYSDATE)
                        AND note LIKE '%№%'
                        AND DBA.PHONE_NUMBER(+) = AB.PHONE_NUMBER
                        AND dba.account_id <> 93
                        AND DBA.YEAR_MONTH = TO_CHAR (SYSDATE, 'yyyymm'))
        SELECT 'Количество разблокированных номеров в день, время последней блокировки'
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