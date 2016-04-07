
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."F_JOB_START_STOP" (ENB IN VARCHAR2) RETURN VARCHAR2 IS

Err CLOB;
Action VARCHAR2(30);

cursor c is
    select job_name
    from DBA_SCHEDULER_JOBS 
    WHERE job_name like 'J_BLOCK_CLIENT%'
    and job_name not in ('J_BLOCK_CLIENT_98','J_BLOCK_CLIENT_WITH_0_BALANCE')
    and enabled= ENB;
    
r c%rowtype;

BEGIN
Err := NULL;
for r in c
  loop
    BEGIN
        if ENB = 'FALSE' then
         dbms_scheduler.ENABLE(r.job_name);
        Action := 'Включение';
        else  dbms_scheduler.DISABLE(r.job_name, TRUE);
         dbms_scheduler.stop_job(r.job_name, TRUE);
        Action := 'Выключение';
        end if;
    EXCEPTION
    WHEN OTHERS THEN 
    if instr(SQLERRM,'is not running') > 0 or instr(SQLERRM,'не запущено') > 0 then NULL;
    else Err := Err || r.job_name || ': ' || SUBSTR(SQLERRM, 1, 200) || chr(10);
    end if;
    END;
  end loop;

INSERT INTO JOB_START_STOP_LOG (USER_SS, DATE_TIME, START_STOP, ERROR_MESSAGE) VALUES (USER, SYSDATE, Action, Err);
RETURN Err;
END F_JOB_START_STOP;