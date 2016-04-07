BEGIN
  
  
  for rec in (select account_id
              from accounts
              where account_id <> 225 --убираем экомобайл
            )
  loop
    
    SYS.DBMS_SCHEDULER.CREATE_JOB
      (
         job_name        => 'J_GET_SIM_LIST_BY_ACCOUNT_'||to_char(rec.account_id)
        ,start_date      => sysdate
        ,repeat_interval => 'Freq=HOURLY;Interval=6'
        ,end_date        => NULL
        ,job_class       => 'DEFAULT_JOB_CLASS'
        ,job_type        => 'PLSQL_BLOCK'
        ,job_action      => 'begin 
                               STOP_JOB_PCKG.CHECK_WORK_JOB;
                               GET_SIM_LIST_BY_ACCOUNT('||to_char(rec.account_id)||'); 
                             end;'
        ,comments        => 'Получение списка телефонных номеров c нормерами Sim карт по счету '||to_char(rec.account_id)
      );
      
  end loop;
END;