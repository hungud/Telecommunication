declare
  vStreamCount INteger;
BEGIN
  --в процедуре J_UPDATE_HISTORY максимальное количество потоков = 5
  vStreamCount := 5;
  for rec in 0..vStreamCount - 1
  loop
    
    SYS.DBMS_SCHEDULER.CREATE_JOB
      (
         job_name        => 'J_UPDATE_HISTORY_ST_0'||to_char(rec)
        ,start_date      => sysdate+rec/24
        ,repeat_interval => 'Freq=Minutely;Interval=1'
        ,end_date        => NULL
        ,job_class       => 'DEFAULT_JOB_CLASS'
        ,job_type        => 'PLSQL_BLOCK'
        ,job_action      => 'begin 
                               STOP_JOB_PCKG.CHECK_WORK_JOB;
                               SET_PHONE_HISTORY('||to_char(rec)||', '||vStreamCount||'); 
                             end;'
        ,comments        => 'Обновление истории смены статусов '||to_char(rec+1)
      );
  end loop;
END;