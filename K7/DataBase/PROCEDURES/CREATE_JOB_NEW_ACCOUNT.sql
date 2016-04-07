CREATE OR REPLACE PROCEDURE CREATE_JOB_NEW_ACCOUNT
(
  pACCOUNT_ID IN INTEGER,
  pPAY_LOAD_INTERVAL IN NUMBER DEFAULT NULL,
  pLOAD_INTERVAL IN NUMBER DEFAULT NULL,
  pINSERT IN INTEGER DEFAULT 0
  )
IS

job_count integer;
-- --#Version=1 Соколов 19.08.2015 Процедура создание джобов при добавление нового счета в таблицу ACCOUNTS
BEGIN
  IF pINSERT = 1 THEN 
  -- Добавим JOB
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_PAYMENTS_'||pACCOUNT_ID, 
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; loader_call_pckg_n.LOAD_ACCOUNT_PAYMENTS('||pACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 0'||REPLACE(ROUND(60*NVL(pPAY_LOAD_INTERVAL, 1)), ',', '.'),
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_DETAILS_'||pACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; LOADER2_PCKG.LOAD_ACCOUNT_DATA('||pACCOUNT_ID || ',2); END;',
      start_date => SYSDATE+10/24/60,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 0'||REPLACE(ROUND(60*NVL(pLOAD_INTERVAL, 1)), ',', '.'),
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_PHONES_'||pACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; loader_call_pckg_n.UPDATE_ACCOUNT_PHONES_STATE('||pACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 5',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_REPORT_DATA_'||pACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; loader_call_pckg_n.LOAD_REPORT_DATA('||pACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 15',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_PHONE_OPTIONS_'||pACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; loader_call_pckg_n.LOAD_PHONES_OPTIONS('||pACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,
      repeat_interval => 'FREQ = HOURLY; INTERVAL = 12',
      enabled    => TRUE
      );      
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_BILLS_'||pACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; LOADER2_PCKG.LOAD_ACCOUNT_DATA('||pACCOUNT_ID || ',5); END;',
      start_date => SYSDATE+2/24/60,
      repeat_interval => 'FREQ = DAILY; INTERVAL = 1',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_BLOCK_CLIENT_'||pACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; BLOCK_CLIENT_WTH_0_BAL2('||pACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 15',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_UNBLOCK_CLIENT_'||pACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; UNBLOCK_CLIENT_WTH_PLUS_BAL2('||pACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 15',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_BILL_DETAILS_'||pACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; LOADER2_PCKG.LOAD_ACCOUNT_DATA('||pACCOUNT_ID || ', 7); END;',
      start_date => SYSDATE+2/24/60,   --2 МИН
      repeat_interval => 'FREQ = HOURLY; INTERVAL = 1',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_BILL_DETAILS_REV_'||pACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; LOADER2_PCKG.LOAD_ACCOUNT_DATA('||pACCOUNT_ID || ', 7); END;',
      start_date => SYSDATE+32/24/60,   --32 МИН
      repeat_interval => 'FREQ = HOURLY; INTERVAL = 1',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_API_CHECK_TICKETS_'||pACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; API_CHECK_TICKETS2('||pACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,   --2 МИН
      repeat_interval => 'FREQ=MINUTELY;INTERVAL=2',
      enabled    => TRUE
      );  
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_BEELINE_BILLS_'||pACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; P_LOAD_BEELINE_BILLS('||pACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,   --2 МИН
      repeat_interval => 'FREQ=HOURLY;INTERVAL=4',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_OBJ_ID_'||pACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; loader_call_pckg_n.LOAD_OBJ_ID('||pACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,   --2 МИН
      repeat_interval => 'FREQ=DAILY;INTERVAL=7',
      enabled    => TRUE
      );  
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_UPDATE_ACCOUNT_TRF_'||pACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; loader_call_pckg_n.update_account_tariffs('||pACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,   --2 МИН
      repeat_interval => 'FREQ=DAILY;INTERVAL=7',
      enabled    => TRUE
      );
   ELSIF pINSERT = 0 THEN 
    
    select count(*) into job_count from USER_SCHEDULER_JOBS
      where JOB_NAME = 'J_LOAD_DETAILS_'||pACCOUNT_ID;
    
    if job_count > 0 then
      DBMS_SCHEDULER.SET_ATTRIBUTE(
        name      => 'J_LOAD_DETAILS_'||pACCOUNT_ID,
        attribute => 'repeat_interval',
        value     => 'FREQ = MINUTELY; INTERVAL = 0'||REPLACE(ROUND(60*NVL(pLOAD_INTERVAL, 1)), ',', '.')
      );
    end if;
    if pACCOUNT_ID not in (93,99) then
    DBMS_SCHEDULER.SET_ATTRIBUTE(
      name      => 'J_LOAD_PAYMENTS_'||pACCOUNT_ID,
      attribute => 'repeat_interval',
      value     => 'FREQ = MINUTELY; INTERVAL = 0'||REPLACE(ROUND(60*NVL(pPAY_LOAD_INTERVAL, 1)), ',', '.')
      );
    end if;
  END IF;  
END;
/
