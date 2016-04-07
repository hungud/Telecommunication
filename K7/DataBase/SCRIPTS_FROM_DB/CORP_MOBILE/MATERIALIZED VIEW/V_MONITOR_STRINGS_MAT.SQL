
  CREATE MATERIALIZED VIEW "CORP_MOBILE"."V_MONITOR_STRINGS_MAT" ("DAT", "ERR", "COLOR")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH COMPLETE ON DEMAND START WITH sysdate+0 NEXT SYSDATE + NUMTODSINTERVAL(10, 'MINUTE')
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  USING ENFORCED CONSTRAINTS DISABLE QUERY REWRITE
  AS WITH KOL_SMS
     AS (SELECT COUNT (*) SMS
           FROM log_send_sms
          WHERE TRUNC (date_send) = TRUNC (SYSDATE))
SELECT 'Количество отправленных смс в день' Dat,
       TO_CHAR (SMS) ERR,
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
             AS (SELECT COUNT (*) blocked,
                        MAX (block_date_time) last_time_block
                   FROM auto_blocked_phone ab, db_loader_account_phones dba
                  WHERE     TRUNC (block_date_time) = TRUNC (SYSDATE)
                        AND note LIKE '%№%'
                        AND DBA.PHONE_NUMBER(+) = AB.PHONE_NUMBER
                        AND dba.account_id = 93
                        AND DBA.YEAR_MONTH = TO_CHAR (SYSDATE, 'yyyymm'))
        SELECT 'Количество блокированных номеров в день по коллектору, время последней блокировки'
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
                        AND dba.account_id = 93
                        AND DBA.YEAR_MONTH = TO_CHAR (SYSDATE, 'yyyymm'))
        SELECT 'Количество разблокированных номеров в день по коллектору'
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
        SELECT 'Количество блокированных номеров в день кроме коллектора, время последней блокировки'
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
UNION ALL
SELECT "DAT", "ERR", "COLOR"
  FROM (WITH PHONE_OPTIONS
             AS (SELECT COUNT (DISTINCT phone_number)
                           updated_collector_options
                   FROM DB_LOADER_ACCOUNT_PHONE_OPTS d
                  WHERE     year_month = TO_CHAR (SYSDATE, 'yyyymm')
                        AND account_id = 93
                        AND TRUNC (last_check_date_time) = TRUNC (SYSDATE))
        SELECT 'Количество обновлённых сегодня телефонов в разрезе опций по коллектору'
                  Dat,
               TO_CHAR (updated_collector_options) ERR,
               CASE
                  WHEN updated_collector_options > 15000
                  THEN
                     'GREEN'
                  WHEN (    (updated_collector_options < 15000)
                        AND (updated_collector_options > 13000))
                  THEN
                     'YELLOW'
                  ELSE
                     'RED'
               END
                  color
          FROM PHONE_OPTIONS)
UNION ALL
SELECT "DAT", "ERR", "COLOR"
  FROM (WITH PHONE_OPTIONS
             AS (SELECT COUNT (DISTINCT phone_number)
                           updated_collector_options
                   FROM DB_LOADER_ACCOUNT_PHONE_OPTS d
                  WHERE     year_month = TO_CHAR (SYSDATE, 'yyyymm')
                        AND account_id <> 93
                        AND TRUNC (last_check_date_time) = TRUNC (SYSDATE))
        SELECT 'Количество обновлённых сегодня телефонов в разрезе опций кроме коллектора коллектору'
                  Dat,
               TO_CHAR (updated_collector_options) ERR,
               CASE
                  WHEN updated_collector_options > 100000
                  THEN
                     'GREEN'
                  WHEN (    (updated_collector_options < 100000)
                        AND (updated_collector_options > 90000))
                  THEN
                     'YELLOW'
                  ELSE
                     'RED'
               END
                  color
          FROM PHONE_OPTIONS)
UNION ALL
SELECT "DAT", "ERR", "COLOR"
    FROM (WITH BLOCK_ROUND
                AS (SELECT COUNT (PHONE_NUMBER_FEDERAL) PNF
                        FROM V_PHONE_NUMBERS_FOR_BLOCK_MON V
                        WHERE NVL(V.IS_COLLECTOR,0)=0)
            SELECT 'Количество на блокировку кроме коллектора'
                  Dat,
               TO_CHAR (PNF) ERR,
               CASE
                  WHEN PNF < 10
                  THEN
                     'GREEN'
                  WHEN (    (PNF >= 10)
                        AND (PNF < 20))
                  THEN
                     'YELLOW'
                  ELSE
                     'RED'
               END
                  color
          FROM BLOCK_ROUND)
UNION ALL
SELECT "DAT", "ERR", "COLOR"
    FROM (WITH BLOCK_ROUND_COL
                AS (SELECT COUNT (PHONE_NUMBER_FEDERAL) PNF
                        FROM V_PHONE_NUMBERS_FOR_BLOCK_MON V
                        WHERE NVL(V.IS_COLLECTOR,0)=1)
            SELECT 'Количество на блокировку по коллектору'
                  Dat,
               TO_CHAR (PNF) ERR,
               CASE
                  WHEN PNF < 10
                  THEN
                     'GREEN'
                  WHEN (    (PNF >= 10)
                        AND (PNF < 20))
                  THEN
                     'YELLOW'
                  ELSE
                     'RED'
               END
                  color
          FROM BLOCK_ROUND_COL)
UNION ALL
SELECT "DAT", "ERR", "COLOR"
    FROM (WITH UNLOCK_ROUND
                AS (SELECT COUNT (PHONE_NUMBER_FEDERAL) PNF
                        FROM V_PHONE_NUMBERS_FOR_UNLOCK_MON V
                        WHERE V.ACCOUNT_ID<>93)
            SELECT 'Количество на разблокировку кроме коллектора'
                  Dat,
               TO_CHAR (PNF) ERR,
               CASE
                  WHEN PNF < 10
                  THEN
                     'GREEN'
                  WHEN (    (PNF >= 10)
                        AND (PNF < 20))
                  THEN
                     'YELLOW'
                  ELSE
                     'RED'
               END
                  color
          FROM UNLOCK_ROUND)
UNION ALL
SELECT "DAT", "ERR", "COLOR"
    FROM (WITH UNLOCK_ROUND_COL
                AS (SELECT COUNT (PHONE_NUMBER_FEDERAL) PNF
                        FROM V_PHONE_NUMBERS_FOR_UNLOCK_MON V
                        WHERE V.ACCOUNT_ID=93)
            SELECT 'Количество на разблокировку по коллектору'
                  Dat,
               TO_CHAR (PNF) ERR,
               CASE
                  WHEN PNF < 10
                  THEN
                     'GREEN'
                  WHEN (    (PNF >= 10)
                        AND (PNF < 20))
                  THEN
                     'YELLOW'
                  ELSE
                     'RED'
               END
                  color
          FROM UNLOCK_ROUND_COL)