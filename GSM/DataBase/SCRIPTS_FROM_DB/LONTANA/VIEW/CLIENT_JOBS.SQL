
  CREATE OR REPLACE FORCE VIEW "LONTANA"."CLIENT_JOBS" ("JOB_NAME", "SACCOUNT_NUM", "STATE") AS 
  SELECT q.JOB_NAME,
          CASE
             WHEN q.AccountID = TO_CHAR (-2)
             THEN
                'смс опопвещение'
             WHEN q.AccountID = TO_CHAR (-1)
             THEN
                'все счета'
             ELSE
                (SELECT TO_CHAR (ACCOUNT_NUMBER)
                   FROM ACCOUNTS
                  WHERE ACCOUNT_ID = q.AccountID)
          END
             sACCOUNT_NUM,
          q.STATE
     FROM (SELECT CASE
                     WHEN SUBSTR (T.JOB_NAME, 1, 27) =
                             'J_BLOCK_LOYAL_CLIENT_STREAM'
                     THEN
                        'блокировка лояльных клиентов по счетам '
                     WHEN SUBSTR (T.JOB_NAME, 1, 13) = 'J_BLOCK_LOYAL'
                     THEN
                        'блокировка лояльных клиентов по счету '
                     WHEN SUBSTR (T.JOB_NAME, 1, 14) = 'J_BLOCK_CLIENT'
                     THEN
                        'блокировка клиентов по счету '
                     ELSE
                        'смс опопвещение'
                  END
                     JOB_NAME,
                  CASE
                     WHEN SUBSTR (T.JOB_NAME, 1, 27) =
                             'J_BLOCK_LOYAL_CLIENT_STREAM'
                     THEN
                        TO_CHAR (-1)
                     WHEN SUBSTR (T.JOB_NAME, 1, 13) = 'J_BLOCK_LOYAL'
                     THEN
                        REGEXP_SUBSTR (job_name,
                                       '[^_]+',
                                       1,
                                       5)
                     WHEN SUBSTR (T.JOB_NAME, 1, 14) = 'J_BLOCK_CLIENT'
                     THEN
                        REGEXP_SUBSTR (job_name,
                                       '[^_]+',
                                       1,
                                       4)
                     ELSE
                        TO_CHAR (-2)
                  END
                     AccountID,
                  T.STATE
             FROM DBA_SCHEDULER_JOBS t
            WHERE (job_name LIKE 'J_BLOCK_CLIENT%'
                   OR job_name LIKE 'J_BLOCK_LOYAL_CLIENT_STREAM%'
                   OR job_name = 'J_SEND_SMS_NOTICE')
                  AND job_name NOT IN
                         ('J_BLOCK_CLIENT_98',
                          'J_BLOCK_CLIENT_WITH_0_BALANCE',
                          'JOB J_BLOCK_LOYAL_CLIENT_225')
                  AND OWNER =
                         (SELECT SYS_CONTEXT ('userenv', 'CURRENT_SCHEMA')
                            FROM DUAL)) q