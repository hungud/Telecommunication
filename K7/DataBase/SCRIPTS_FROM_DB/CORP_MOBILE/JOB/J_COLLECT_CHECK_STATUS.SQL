
  
BEGIN 
dbms_scheduler.create_job('"J_COLLECT_CHECK_STATUS"',
job_type=>'PLSQL_BLOCK', job_action=>
'declare
  tmp varchar(500);
begin 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  for c in (
            select t.phone_number from v_collect_check_status t
           )
  loop
    begin
      tmp := beeline_api_pckg.phone_status(c.phone_number);
    exception
      when others then
        null;
    end;
  end loop;
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('17-APR-2014 10.21.24.407000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY;INTERVAL=7'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Обновляет статусы недавно разблоченных, заблоченных номеров коллектора.'
);
dbms_scheduler.enable('"J_COLLECT_CHECK_STATUS"');
COMMIT; 
END; 
