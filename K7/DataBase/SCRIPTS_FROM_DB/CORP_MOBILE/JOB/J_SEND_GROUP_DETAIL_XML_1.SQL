
  
BEGIN 
dbms_scheduler.create_job('"J_SEND_GROUP_DETAIL_XML_1"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
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
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('02-APR-2015 04.23.00.000000000 AM +03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=DAILY;INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
NULL
);
dbms_scheduler.enable('"J_SEND_GROUP_DETAIL_XML_1"');
COMMIT; 
END; 
