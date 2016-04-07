--#IF GETVERSION("HOT_BILLING_SAVE_CALL_MMS") < 1 THEN
CREATE OR REPLACE PROCEDURE HOT_BILLING_SAVE_CALL_MMS
(
  pmonth IN date
) is
--#Version=1  
-- Запуск выгрузки звонков за месяц на диск
begin
DBMS_SCHEDULER.CREATE_JOB(
job_name => 'J_SAVE_CALL_MM_1',
job_type => 'PLSQL_BLOCK',
job_action => 'begin hot_billing_save_call_mm(4,0,to_date('''||to_char(trunc(pmonth,'mm'),'dd.mm.yyyy')||''',''dd.mm.yyyy'')); DBMS_SCHEDULER.drop_job(''J_SAVE_CALL_MM_1'',false,true); end;',
start_date => SYSDATE,
repeat_interval => 'FREQ = MINUTELY; INTERVAL = 10',
enabled => TRUE
);
DBMS_SCHEDULER.CREATE_JOB(
job_name => 'J_SAVE_CALL_MM_2',
job_type => 'PLSQL_BLOCK',
job_action => 'begin hot_billing_save_call_mm(4,1,to_date('''||to_char(trunc(pmonth,'mm'),'dd.mm.yyyy')||''',''dd.mm.yyyy'')); DBMS_SCHEDULER.drop_job(''J_SAVE_CALL_MM_2'',false,true); end;',
start_date => SYSDATE,
repeat_interval => 'FREQ = MINUTELY; INTERVAL = 10',
enabled => TRUE
);
DBMS_SCHEDULER.CREATE_JOB(
job_name => 'J_SAVE_CALL_MM_3',
job_type => 'PLSQL_BLOCK',
job_action => 'begin hot_billing_save_call_mm(4,2,to_date('''||to_char(trunc(pmonth,'mm'),'dd.mm.yyyy')||''',''dd.mm.yyyy'')); DBMS_SCHEDULER.drop_job(''J_SAVE_CALL_MM_3'',false,true); end;',
start_date => SYSDATE,
repeat_interval => 'FREQ = MINUTELY; INTERVAL = 10',
enabled => TRUE
);
DBMS_SCHEDULER.CREATE_JOB(
job_name => 'J_SAVE_CALL_MM_4',
job_type => 'PLSQL_BLOCK',
job_action => 'begin hot_billing_save_call_mm(4,3,to_date('''||to_char(trunc(pmonth,'mm'),'dd.mm.yyyy')||''',''dd.mm.yyyy'')); DBMS_SCHEDULER.drop_job(''J_SAVE_CALL_MM_4'',false,true); end;',
start_date => SYSDATE,
repeat_interval => 'FREQ = MINUTELY; INTERVAL = 10',
enabled => TRUE
);
end;
--#end if