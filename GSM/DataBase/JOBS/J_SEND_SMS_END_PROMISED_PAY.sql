begin
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'CORP_MOBILE.J_SEND_SMS_END_PROMISED_PAY'
      ,start_date      => NULL
      ,repeat_interval => 'FREQ=HOURLY;INTERVAL=1;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
                             SEND_SMS_END_PROMISED_PAY;
                           end;'
      ,comments        => 'Рассылка смс с предупреждением об окончании обещанного платежа.'
    );
end;