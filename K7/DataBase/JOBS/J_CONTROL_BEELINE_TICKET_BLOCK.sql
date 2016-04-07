BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_CONTROL_BEELINE_TICKET_BLOCK'
      ,start_date      => sysdate
      ,repeat_interval => 'Freq=Minutely;Interval=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             control_beeline_tickets_block;
                           end;'
      ,comments        => 'Отправка номеров на переблокировку, если блокировка была вызвана из программы'
    );
END;
/
