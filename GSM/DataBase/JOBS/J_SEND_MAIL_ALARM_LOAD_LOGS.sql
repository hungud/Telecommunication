begin
sys.dbms_scheduler.create_job(job_name => 'LONTANA.J_SEND_MAIL_ALARM_LOAD_LOGS',
                                  job_type => 'PLSQL_BLOCK',
                                  job_action => 'BEGIN
                                                   STOP_JOB_PCKG.CHECK_WORK_JOB;
                                                   P_SEND_MAIL_ALARM_LOAD_LOGS;
                                                END;',
                                  start_date => sysdate,
                                  repeat_interval => 'Freq=MINUTELY;Interval=10',
                                  end_date => to_date(null),
                                  job_class => 'DEFAULT_JOB_CLASS',
                                  enabled => true,
                                  auto_drop => false,
                                  comments => 'Процедура для рассылки оповещений с ошибками авторизазии в личный кабинет билайна'
                                 );
end;