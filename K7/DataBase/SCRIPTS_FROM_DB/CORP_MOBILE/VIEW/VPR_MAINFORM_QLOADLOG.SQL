
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."VPR_MAINFORM_QLOADLOG" ("ACCOUNT_ID", "LOGIN", "ISCOLLECTOR", "ACCOUNT_LOAD_TYPE_ID", "IS_SUCCESS", "CNT") AS 
  WITH PARM AS (select (select MS_PARAMS.GET_PARAM_VALUE('LOAD_LOGS_TIME_ERR') from dual) AS LOAD_LOGS_TIME_ERR, (select MS_PARAMS.GET_PARAM_VALUE('DAY_LOAD_BILLS_ERR') from dual) AS DAY_LOAD_BILLS_ERR from dual)
SELECT
--#Version=3
-- Удаление из списка accoun_id 96 и 98
-- 2 Удаление коллектора из мониторинга по 2-м отчётам
-- 1 Перенос из формы Delphi
a.account_id, a.login, a.iscollector, a.account_load_type_id, load16.is_success,
       CASE
         WHEN a.account_load_type_id IN (1,6)
           THEN NVL(load16.cnt,0)
         WHEN a.account_load_type_id IN (5,7)
            THEN NVL(load57.cnt,0)
       END cnt
FROM (SELECT account_id, account_load_type_id, SUM(is_success) is_success, COUNT(*) cnt
      FROM account_load_logs
      WHERE account_load_type_id IN (1,6)
      AND load_date_time > SYSDATE-2/24
      GROUP BY account_id, account_load_type_id
      ) load16,
      (SELECT account_id, account_load_type_id, COUNT(*) cnt
       FROM account_load_logs
       WHERE account_load_type_id IN (5,7)
       AND load_date_time > TRUNC(SYSDATE,'month')
       GROUP BY account_id, account_load_type_id) load57,
      (SELECT account_id, login,nvl(IS_COLLECTOR,0) iscollector, load_type.account_load_type_id
       FROM accounts,(SELECT 1 account_load_type_id FROM dual
                      UNION ALL
                      SELECT 5 FROM dual
                      UNION ALL
                      SELECT 6 FROM dual
                      UNION ALL
                      SELECT 7 FROM dual)load_type
       WHERE do_auto_load_data = 1
       )a
WHERE a.account_id = load16.account_id(+)
AND a.account_id = load57.account_id(+)
AND a.account_load_type_id = load16.account_load_type_id(+)
AND a.account_load_type_id = load57.account_load_type_id(+)
AND ( (a.account_load_type_id=1 AND load16.cnt IS NULL AND a.iscollector=0) OR
      (a.account_load_type_id=6 AND load16.cnt IS NULL AND a.iscollector=0 and a.account_id<>98 ) OR
      (a.account_load_type_id IN (1,6) AND load16.cnt IS NOT NULL AND load16.is_success = 0) OR
      (a.account_load_type_id IN (1,6) AND load16.cnt IS NOT NULL AND load16.is_success = 0) 
      --закоментировано, пока не переделается технология определения загрузки счетов
      --OR
      --(a.account_load_type_id =5 AND load57.cnt IS NULL AND TO_NUMBER(TO_CHAR(SYSDATE,'DD')) >= (select DAY_LOAD_BILLS_ERR FROM PARM) AND a.account_id <>98) OR
      --(a.account_load_type_id =7 AND load57.cnt IS NULL AND TO_NUMBER(TO_CHAR(SYSDATE,'DD')) >= (select DAY_LOAD_BILLS_ERR FROM PARM) AND a.account_id not in (93,98,99))
     )
UNION ALL
SELECT TO_NUMBER (REGEXP_SUBSTR (jj.job_name, '\d+')) account_id,
          job_name login,
          NVL (is_collector, 0) AS is_collector,
          NULL account_load_type_id,
          NULL is_success,
          NULL cnt
     FROM DBA_SCHEDULER_JOBS JJ, ACCOUNTS AA
    WHERE     STATE = 'DISABLED'
          AND AA.ACCOUNT_ID = REGEXP_SUBSTR (jj.job_name, '\d+')
          AND          --substr(jj.job_name,instr(JJ.job_name,'_',-1)+1,3) AND
              (   (    JJ.job_name LIKE 'J_BLOCK%CLIENT%'
                   AND JJ.job_name NOT LIKE 'J_%LOCK%CLIENT%WITH%'
                   AND JJ.job_name NOT LIKE 'J_BLOCK_FRAUD%'
                   AND JJ.job_name NOT LIKE '%_96'
                   AND JJ.job_name NOT LIKE '%_98')
               OR (   (JJ.job_name LIKE 'J_UNBLOCK_CLIENT%'
                       AND JJ.job_name NOT LIKE '%_96'
                       AND JJ.job_name NOT LIKE '%_98')
                   OR (    (   JJ.job_name LIKE 'J_LOAD_PAYMENTS%'
                            OR (JJ.job_name LIKE 'J_LOAD_PHONES%'
                                AND JJ.job_name NOT LIKE '%_96'
                   AND          JJ.job_name NOT LIKE '%_98' ))
                       AND NVL (aa.is_collector, 0) = 0)))
          AND JJ.OWNER =
                 (SELECT SYS_CONTEXT ('userenv', 'CURRENT_SCHEMA') FROM DUAL)
ORDER BY 1