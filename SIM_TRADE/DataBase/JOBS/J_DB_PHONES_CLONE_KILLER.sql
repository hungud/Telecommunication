BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'CORP_MOBILE.J_DB_PHONES_CLONE_KILLER'
      ,start_date      => TO_TIMESTAMP_TZ('2014/02/10 14:14:48.292000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
  -- Test statements here
  for c in (
            select ph.phone_number,count(ph.phone_number) from db_loader_account_phones ph where ph.year_month=to_char(sysdate,''YYYYMM'')
            group by ph.phone_number
            having count(ph.phone_number)>1
           )loop
                delete from db_loader_account_phones p where p.phone_number=c.phone_number and p.year_month=to_char(sysdate,''YYYYMM'') and 
                                                             p.last_check_date_time=(select min(t.last_check_date_time) from db_loader_account_phones t 
                                                                                                  where t.phone_number=c.phone_number
                                                                                                  and t.year_month=to_char(sysdate,''YYYYMM'')
                                                                                     );
                                                                                     
                commit;
            end loop;
end;'
      ,comments        => NULL
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_DB_PHONES_CLONE_KILLER'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'CORP_MOBILE.J_DB_PHONES_CLONE_KILLER'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'CORP_MOBILE.J_DB_PHONES_CLONE_KILLER'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'CORP_MOBILE.J_DB_PHONES_CLONE_KILLER'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_DB_PHONES_CLONE_KILLER'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'CORP_MOBILE.J_DB_PHONES_CLONE_KILLER'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_DB_PHONES_CLONE_KILLER'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;
/
