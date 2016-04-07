CREATE OR REPLACE PROCEDURE CHECK_REPORT_PHONE_INACTIVE AS

  --version 1
  --
  --v.1 Алексеев. Процедура проверки работы job
  
  vCount INTEGER;
  vStatus VARCHAR2(50 char);
begin
  --проверяем наличие логов, если логи есть, то идем дальше, иначе ничего не делаем
  --проверяем чтобы job запущен не был, если запущен, то ничего не делаем
  vCount := 0;
  
  select count(*)
     into vCount
    from user_scheduler_job_log js
  where js.job_name = 'J_REPORT_PHONE_INACTIVE'
      and js.log_date = (select max(lg.log_date)
                                   from user_scheduler_job_log lg
                                 where lg.job_name = js.job_name)
      and not exists (
                               select *
                                 from DBA_SCHEDULER_JOBS t
                               where t.job_name = js.job_name
                                   and t.STATE='RUNNING'
                           );

  if nvl(vCount, 0) > 0 then
    --получаем крайний статус
    select JS.STATUS
       into vStatus
      from user_scheduler_job_log js
    where js.job_name = 'J_REPORT_PHONE_INACTIVE'
        and js.log_date = (select max(lg.log_date)
                                     from user_scheduler_job_log lg
                                   where lg.job_name = js.job_name);
                                   
    if vStatus <> 'SUCCEEDED' then
      --стопаем job и запускаем его
      begin
        dbms_scheduler.stop_job(job_name=>'J_REPORT_PHONE_INACTIVE',force=>true);
      exception
        when others then 
          null;
      end;
      
      --запускаем job
      dbms_scheduler.run_job(job_name=>'J_REPORT_PHONE_INACTIVE');
    end if;
  end if;
end;