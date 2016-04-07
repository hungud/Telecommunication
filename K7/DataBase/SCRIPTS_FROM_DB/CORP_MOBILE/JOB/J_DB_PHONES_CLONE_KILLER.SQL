
  
BEGIN 
dbms_scheduler.create_job('"J_DB_PHONES_CLONE_KILLER"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
  STOP_JOB_PCKG.CHECK_WORK_JOB;
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
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('10-FEB-2014 02.14.48.292000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY;INTERVAL=10'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Удаление дублей номеров '
);
dbms_scheduler.enable('"J_DB_PHONES_CLONE_KILLER"');
COMMIT; 
END; 
