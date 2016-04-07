
  CREATE OR REPLACE FUNCTION "LONTANA"."F_JOB_START_STOP" (ENB IN VARCHAR2) RETURN VARCHAR2 IS

Err CLOB;
Action VARCHAR2(30);
-- Соколов 24.02.2016 - убрал маску J_NEW_SMS_REQUEST_STREAM
-- Соколов Ю 28.07.2015
-- Заменил маску 'J_BLOCK_LOYAL_CLIENT%' на 'J_BLOCK_LOYAL_CLIENT_STREAM%'
-- Заменил маску 'J_SEND_SMS_NOTICE' на 'J_SEND_SMS_NOTICE_%'
-- Добавил маску 'J_SEND_SMS_NOTIFY_BILLS'
-- Добавил маску 'J_NEW_SMS_REQUEST_STREAM%'

cursor c is
    select job_name
    from DBA_SCHEDULER_JOBS 
    WHERE (job_name like 'J_BLOCK_CLIENT%' or job_name like 'J_BLOCK_LOYAL_CLIENT_STREAM%' or job_name like 'J_SEND_SMS_NOTICE_%' 
    or job_name='J_SEND_SMS_NOTIFY_BILLS')
    and job_name not in ('J_BLOCK_CLIENT_98','J_BLOCK_CLIENT_WITH_0_BALANCE', 'JOB J_BLOCK_LOYAL_CLIENT_225')
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