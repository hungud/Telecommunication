BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_SEND_GROUP_DETAIL_XML_1');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SEND_GROUP_DETAIL_XML_1'
      ,start_date      => TO_TIMESTAMP_TZ('2015/04/02 04:23:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  for rec in (
              select group_id 
                from contract_groups
               where send_detail_auto<>0
                 and send_detail_day is not null
             )
  loop
--    dbms_output.put_line(rec.group_id);
    send_group_detail_xml.send_xml(rec.group_id,93); -- TeleTie
  end loop;
end;    '
      ,comments        => NULL
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_GROUP_DETAIL_XML_1'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_GROUP_DETAIL_XML_1'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_GROUP_DETAIL_XML_1'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_GROUP_DETAIL_XML_1'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_GROUP_DETAIL_XML_1'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_GROUP_DETAIL_XML_1'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_GROUP_DETAIL_XML_1'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_GROUP_DETAIL_XML_1'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_SEND_GROUP_DETAIL_XML_1');
END;
/
