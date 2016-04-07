--#if GetVersion("VPR_MAINFORM_QLOADLOG") < 2
CREATE OR REPLACE VIEW VPR_MAINFORM_QLOADLOG AS
WITH PARM AS (select (select MS_PARAMS.GET_PARAM_VALUE('LOAD_LOGS_TIME_ERR') from dual) AS LOAD_LOGS_TIME_ERR, (select MS_PARAMS.GET_PARAM_VALUE('DAY_LOAD_BILLS_ERR') from dual) AS DAY_LOAD_BILLS_ERR from dual)
SELECT 
--#Version=2
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
AND ( (a.account_load_type_id IN (1,6) AND load16.cnt IS NULL AND a.iscollector=0 ) OR 
      (a.account_load_type_id IN (1,6) AND load16.cnt IS NOT NULL AND load16.is_success = 0) OR
      (a.account_load_type_id IN (5,7) AND load57.cnt IS NULL AND TO_NUMBER(TO_CHAR(SYSDATE,'DD')) >= (select DAY_LOAD_BILLS_ERR FROM PARM) )
     )
UNION ALL
SELECT to_number(regexp_substr(jj.job_name,'\d+')) account_id, job_name login,nvl(is_collector,0) AS is_collector , null account_load_type_id, null is_success, null cnt
FROM DBA_SCHEDULER_JOBS JJ, ACCOUNTS AA
WHERE STATE='DISABLED' AND
AA.ACCOUNT_ID=regexp_substr(jj.job_name,'\d+') and--substr(jj.job_name,instr(JJ.job_name,'_',-1)+1,3) AND 
(
  (JJ.job_name like 'J_BLOCK%CLIENT%' AND JJ.job_name not like 'J_%LOCK%CLIENT%WITH%' AND JJ.job_name not like 'J_BLOCK_FRAUD%') 
  OR 
  (JJ.job_name like 'J_UNBLOCK_CLIENT%' 
            OR ((JJ.job_name like 'J_LOAD_PAYMENTS%' OR JJ.job_name like 'J_LOAD_PHONES%') AND nvl(aa.is_collector,0)=0)
                                                  )
) 
AND JJ.OWNER=(select sys_context('userenv','CURRENT_SCHEMA') from dual)
ORDER BY 1
--#end if

--#Execute MAIN_SCHEMA=IsClient("")
--#if not GrantExists("VPR_MAINFORM_QLOADLOG", "ROLE", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON VPR_MAINFORM_QLOADLOG TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("VPR_MAINFORM_QLOADLOG", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON VPR_MAINFORM_QLOADLOG TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if


