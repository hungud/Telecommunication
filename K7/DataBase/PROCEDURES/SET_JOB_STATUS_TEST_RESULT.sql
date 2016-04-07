CREATE OR REPLACE PROCEDURE SET_JOB_STATUS_TEST_RESULT as
--
--#Version=1
--
--v.1 Афросин 26.11.2015 - Процедура для тестирования получения количества зависших джобов
begin
  merge into RESULT_FOR_HOST_MONITOR_TEST tt
    using (
            select
              'HANGED_JOB_COUNT' TEST_NAME_ENG,
               count(*) res
            from(
              select
                job_name,
                sysdate-last_start_date
              from
                DBA_SCHEDULER_JOBS
              where
                (
                  job_name like 'J_LOAD_REPORT%'OR
                  job_name like 'J_LOAD_PHONES%' OR
                  job_name like 'J_LOAD_PAYMENTS%' OR
                  job_name like 'J_BLOCK_CLIENT%' OR
                  job_name like 'J_UNBLOCK_CLIENT%'
                )
                AND STATE='RUNNING'
                AND (last_start_date)<sysdate-100/1440
               )
          )t
    on (tt.TEST_NAME_ENG = t.TEST_NAME_ENG)        
    when matched then
      update
        set
        tt.TEST_RESULT = t.res
    when not matched then
      insert (tt.TEST_NAME_ENG, tt.TEST_RESULT)
      values (t.TEST_NAME_ENG, t.RES);
    
    commit;                    
end;
/