
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SAVE_DETAILJ" (phonen   in varchar2,
                                                     smonth in varchar2) IS
BEGIN
  if phonen='Все' then
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_SAVE_DETAIL_1',
      job_type   => 'PLSQL_BLOCK',
      job_action =>  'begin hot_billing_save_details(4,0,to_date('''||smonth||''',''dd.mm.yyyy'')); DBMS_SCHEDULER.drop_job(''J_SAVE_DETAIL_1'',false,true); end;',
      start_date => SYSDATE,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 60',
      enabled    => TRUE
      );
   DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_SAVE_DETAIL_2',
      job_type   => 'PLSQL_BLOCK',
      job_action =>  'begin hot_billing_save_details(4,1,to_date('''||smonth||''',''dd.mm.yyyy'')); DBMS_SCHEDULER.drop_job(''J_SAVE_DETAIL_2'',false,true); end;',
      start_date => SYSDATE,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 60',
      enabled    => TRUE
      );
      DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_SAVE_DETAIL_3',
      job_type   => 'PLSQL_BLOCK',
      job_action =>  'begin hot_billing_save_details(4,2,to_date('''||smonth||''',''dd.mm.yyyy'')); DBMS_SCHEDULER.drop_job(''J_SAVE_DETAIL_3'',false,true); end;',
      start_date => SYSDATE,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 60',
      enabled    => TRUE
      );
      DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_SAVE_DETAIL_4',
      job_type   => 'PLSQL_BLOCK',
      job_action =>  'begin hot_billing_save_details(4,3,to_date('''||smonth||''',''dd.mm.yyyy'')); DBMS_SCHEDULER.drop_job(''J_SAVE_DETAIL_4'',false,true); end;',
      start_date => SYSDATE,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 60',
      enabled    => TRUE
      );

  else
    --DBMS_SCHEDULER.drop_job(''J_SAVE_DETAIL_'||phonen||''',false,true);
 DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_SAVE_DETAIL_'||phonen,
      job_type   => 'PLSQL_BLOCK',
      job_action =>  'begin hot_billing_save_details('||phonen||',0,to_date('''||smonth||''',''dd.mm.yyyy'')); DBMS_SCHEDULER.drop_job(''J_SAVE_DETAIL_'||phonen||''',false,true); end;',
      start_date => SYSDATE,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 60',
      enabled    => TRUE,
      auto_drop => TRUE
      );
 end if;
END;
