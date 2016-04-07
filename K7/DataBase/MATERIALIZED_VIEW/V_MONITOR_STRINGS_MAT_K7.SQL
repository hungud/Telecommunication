DROP MATERIALIZED VIEW CORP_MOBILE.V_MONITOR_STRINGS_MAT;
CREATE MATERIALIZED VIEW CORP_MOBILE.V_MONITOR_STRINGS_MAT (DAT,ERR,COLOR)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOCACHE
LOGGING
NOCOMPRESS
NOPARALLEL
BUILD IMMEDIATE
REFRESH COMPLETE
START WITH TO_DATE('17-фев-2014 12:33:12','dd-mon-yyyy hh24:mi:ss')
NEXT SYSDATE + NUMTODSINTERVAL(5, 'MINUTE')  
WITH PRIMARY KEY
AS 
--#Version=1
--1. Мониторинг смс, разблокированных, блокированных телефонов, обновление опций телефонов, в разрезе коллектора
WITH KOL_SMS
        AS (SELECT COUNT (*) SMS
              FROM log_send_sms
             WHERE TRUNC (date_send) = TRUNC (SYSDATE))
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
                     WHERE     TRUNC (block_date_time) = TRUNC (SYSDATE)
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
                     WHERE     TRUNC (unblock_date_time) = TRUNC (SYSDATE)
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
                     WHERE     TRUNC (block_date_time) = TRUNC (SYSDATE)
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
                     WHERE     TRUNC (unblock_date_time) = TRUNC (SYSDATE)
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
   UNION ALL
   SELECT "DAT", "ERR", "COLOR"
     FROM (WITH PHONE_OPTIONS
                AS (select count(distinct phone_number) updated_collector_options from DB_LOADER_ACCOUNT_PHONE_OPTS d where year_month=to_char(sysdate,'yyyymm') and account_id=93 and trunc(last_check_date_time)=trunc(sysdate)
                )
           SELECT 'Количество обновлённых сегодня телефонов в разрезе опций по коллектору'
                     Dat,
                  to_char(updated_collector_options) ERR,
                  CASE
                     WHEN updated_collector_options > 15000
                     THEN
                        'GREEN'
                     WHEN ( (updated_collector_options < 15000) and (updated_collector_options > 13000))
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
                AS (select count(distinct phone_number) updated_collector_options from DB_LOADER_ACCOUNT_PHONE_OPTS d where year_month=to_char(sysdate,'yyyymm') and account_id<>93 and trunc(last_check_date_time)=trunc(sysdate)
                )
           SELECT 'Количество обновлённых сегодня телефонов в разрезе опций кроме коллектора коллектору'
                     Dat,
                  to_char(updated_collector_options) ERR,
                  CASE
                     WHEN updated_collector_options > 100000
                     THEN
                        'GREEN'
                     WHEN ( (updated_collector_options < 100000) and (updated_collector_options > 90000))
                     THEN
                        'YELLOW'
                     ELSE
                        'RED'
                  END
                     color
             FROM PHONE_OPTIONS);
                                                    

COMMENT ON MATERIALIZED VIEW CORP_MOBILE.V_MONITOR_STRINGS_MAT IS 'snapshot table for snapshot CORP_MOBILE.V_MONITOR_STRINGS_MAT';

CREATE OR REPLACE SYNONYM CRM_USER.V_MONITOR_STRINGS_MAT FOR CORP_MOBILE.V_MONITOR_STRINGS_MAT;

GRANT SELECT ON CORP_MOBILE.V_MONITOR_STRINGS_MAT TO CRM_USER;
