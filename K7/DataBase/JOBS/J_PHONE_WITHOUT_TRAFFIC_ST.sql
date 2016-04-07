BEGIN
  --в процедуре PHONE_WITHOUT_TRAFFIC максимальное количество потоков = 10
  for rec in 0..9
  loop
    
    SYS.DBMS_SCHEDULER.CREATE_JOB
      (
         job_name        => 'J_PHONE_WITHOUT_TRAFFIC_ST_0'||to_char(rec)
        ,start_date      => sysdate+rec/24
        ,repeat_interval => 'Freq=Daily;Interval=1;ByHour=17;ByMinute=00'
        ,end_date        => NULL
        ,job_class       => 'DEFAULT_JOB_CLASS'
        ,job_type        => 'PLSQL_BLOCK'
        ,job_action      => 'begin 
                                       STOP_JOB_PCKG.CHECK_WORK_JOB;
                                       P_GET_PHONE_WITHOUT_TRAFFIC('||to_char(rec)||', 10); 
                                   end;'
        ,comments        => 'Формирование отчета номера без трафика в потоках '||to_char(rec+1)
      );
  end loop;
END;