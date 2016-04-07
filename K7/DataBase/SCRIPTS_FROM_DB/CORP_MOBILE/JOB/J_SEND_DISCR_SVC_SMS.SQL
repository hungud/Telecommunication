
  
BEGIN 
dbms_scheduler.create_job('"J_SEND_DISCR_SVC_SMS"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  send_discr_svc_sms;
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('27-DEC-2013 12.30.00.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'Freq=Monthly;ByMonthDay=-3,-2,-1;BYHOUR=10,15,20'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'отправление смс по списанию дискретных услуг и необходимости пополнения средст'
);
COMMIT; 
END; 
