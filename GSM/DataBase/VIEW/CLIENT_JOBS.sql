CREATE OR REPLACE VIEW CLIENT_JOBS
AS
--
--#Version=1
--
--v.1 16.02.2015 Афросин - Создал вьюху для полученеия списка job, работающих с клиентами
--
select 
  q.JOB_NAME, 
  case
    when q.AccountID = to_char(-1) then 'смс опопвещение' 
    else (SELECT to_char(ACCOUNT_NUMBER)
            FROM ACCOUNTS
            WHERE ACCOUNT_ID = q.AccountID)
  end sACCOUNT_NUM,
  q.STATE
from 
(select 
 case 
  when substr(T.JOB_NAME,1,27)='J_BLOCK_LOYAL_CLIENT_STREAM' then 'блокировка лояльных клиентов по счетам '
  when substr(T.JOB_NAME,1,13)='J_BLOCK_LOYAL' then 'блокировка лояльных клиентов по счету ' 
  when substr(T.JOB_NAME,1,14)='J_BLOCK_CLIENT' then 'блокировка клиентов по счету ' 
  else 'смс опопвещение' 
 end JOB_NAME,
 
 case 
  when substr(T.JOB_NAME,1,27)='J_BLOCK_LOYAL_CLIENT_STREAM' then to_char(- 1)
  when substr(T.JOB_NAME,1,13)='J_BLOCK_LOYAL' then regexp_substr(job_name,'[^_]+',1,5) 
  when substr(T.JOB_NAME,1,14)='J_BLOCK_CLIENT' then regexp_substr(job_name,'[^_]+',1,4) 
  else to_char(- 1)
 end AccountID,

 T.STATE from DBA_SCHEDULER_JOBS t
where (job_name like 'J_BLOCK_CLIENT%' or job_name like 'J_BLOCK_LOYAL_CLIENT%' or job_name = 'J_SEND_SMS_NOTICE')
    and job_name not in ('J_BLOCK_CLIENT_98','J_BLOCK_CLIENT_WITH_0_BALANCE', 'JOB J_BLOCK_LOYAL_CLIENT_225')
    and OWNER=(select sys_context('userenv','CURRENT_SCHEMA') from dual)) q
