
  
BEGIN 
dbms_scheduler.create_job('"J_API_TICKET_CHECK"',
job_type=>'PLSQL_BLOCK', job_action=>
'declare
res varchar2(1000);
counts number;
begin
STOP_JOB_PCKG.CHECK_WORK_JOB;
dbms_output.enable(10000);
  for c in (select t.account_id,t.ticket_id from beeline_tickets t where t.account_id!=93 and t.answer is null)
    loop
     res:=beeline_api_pckg.get_ticket_status(c.account_id,c.ticket_id);
     counts:=counts+1;
    end loop;
dbms_output.put_line(''итого:''||counts);    
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('30-NOV-2013 07.10.00.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'проверяет статус заявки'
);
dbms_scheduler.enable('"J_API_TICKET_CHECK"');
COMMIT; 
END; 
