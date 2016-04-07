BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_API_TICKET_CHECK'
      ,start_date      => TO_TIMESTAMP_TZ('2013/11/30 19:15:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
							STOP_JOB_PCKG.CHECK_WORK_JOB; 
							API_CHECK_TICKETS2(1); 
						   end;
/*declare
res varchar2(1000);
counts number;
begin
dbms_output.enable(10000);
  for c in (select t.account_id,t.ticket_id from beeline_tickets t where t.account_id!=93 and t.answer is null)
    loop
     res:=beeline_api_pckg.get_ticket_status(c.account_id,c.ticket_id);
     counts:=counts+1;
    end loop;
dbms_output.put_line(''итого:''||counts);    
end;    */'
      ,comments        => 'проверяет статус заявки'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_API_TICKET_CHECK'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_API_TICKET_CHECK'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_API_TICKET_CHECK'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_API_TICKET_CHECK'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_API_TICKET_CHECK'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_API_TICKET_CHECK'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_API_TICKET_CHECK'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_API_TICKET_CHECK'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_API_TICKET_CHECK');
END;
/
