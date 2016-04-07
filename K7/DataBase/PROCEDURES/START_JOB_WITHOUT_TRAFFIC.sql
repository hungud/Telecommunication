CREATE OR REPLACE PROCEDURE START_JOB_WITHOUT_TRAFFIC AS
  ct integer;
begin
  select count(*)  into ct 
                   from
                    user_scheduler_jobs t 
                   where
                    t.job_name like 'J_PHONE_WITHOUT_TRAFFIC_ST_0%';
  
  if ct > 0 then
    for i in 0..ct-1 loop
      dbms_scheduler.run_job('J_PHONE_WITHOUT_TRAFFIC_ST_0'||i, FALSE);                  
    end loop;
  end if;
end;

GRANT EXECUTE ON START_JOB_WITHOUT_TRAFFIC TO CORP_MOBILE_ROLE;
GRANT EXECUTE ON START_JOB_WITHOUT_TRAFFIC TO CORP_MOBILE_ROLE_RO;