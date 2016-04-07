
  CREATE OR REPLACE TRIGGER "LONTANA"."TIU_ACCOUNTS" 
BEFORE INSERT OR UPDATE
ON LONTANA.ACCOUNTS 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.ACCOUNT_ID, 0) = 0 then
      :NEW.ACCOUNT_ID := NEW_ACCOUNT_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
    -- Добавим JOB
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_PAYMENTS_'||:NEW.ACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; loader_call_pckg_n.LOAD_ACCOUNT_PAYMENTS('||:NEW.ACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 0'||REPLACE(ROUND(60*NVL(:NEW.PAY_LOAD_INTERVAL, 1)), ',', '.'),
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_DETAILS_'||:NEW.ACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; LOADER2_PCKG.LOAD_ACCOUNT_DATA('||:NEW.ACCOUNT_ID || ',2); END;',
      start_date => SYSDATE+10/24/60,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 0'||REPLACE(ROUND(60*NVL(:NEW.LOAD_INTERVAL, 1)), ',', '.'),
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_SEND_END_MONTH_NOTICE_'||:NEW.ACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; SEND_SMS_NOTICE_END_MONTH2('||:NEW.ACCOUNT_ID ||'); END;',
      start_date => SYSDATE+60/24/60,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 60',
      enabled    => FALSE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_PHONES_'||:NEW.ACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; loader_call_pckg_n.UPDATE_ACCOUNT_PHONES_STATE('||:NEW.ACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 5',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_REPORT_DATA_'||:NEW.ACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; loader_call_pckg_n.LOAD_REPORT_DATA('||:NEW.ACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 15',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_PHONE_OPTIONS_'||:NEW.ACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; loader_call_pckg_n.LOAD_PHONES_OPTIONS('||:NEW.ACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,
      repeat_interval => 'FREQ = HOURLY; INTERVAL = 12',
      enabled    => TRUE
      );      
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_BILLS_'||:NEW.ACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; LOADER2_PCKG.LOAD_ACCOUNT_DATA('||:NEW.ACCOUNT_ID || ',5); END;',
      start_date => SYSDATE+2/24/60,
      repeat_interval => 'FREQ = DAILY; INTERVAL = 1',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_BLOCK_CLIENT_'||:NEW.ACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; BLOCK_CLIENT_WTH_0_BAL2('||:NEW.ACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 15',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_UNBLOCK_CLIENT_'||:NEW.ACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; UNBLOCK_CLIENT_WTH_PLUS_BAL2('||:NEW.ACCOUNT_ID || '); END;',
      start_date => SYSDATE+2/24/60,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 15',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_BILL_DETAILS_'||:NEW.ACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; LOADER2_PCKG.LOAD_ACCOUNT_DATA('||:NEW.ACCOUNT_ID || ', 7); END;',
      start_date => SYSDATE+2/24/60,   --2 МИН
      repeat_interval => 'FREQ = HOURLY; INTERVAL = 1',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_BILL_DETAILS_REV_'||:NEW.ACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; LOADER2_PCKG.LOAD_ACCOUNT_DATA('||:NEW.ACCOUNT_ID || ', 7); END;',
      start_date => SYSDATE+32/24/60,   --32 МИН
      repeat_interval => 'FREQ = HOURLY; INTERVAL = 1',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_BEELINE_BILLS_'||:NEW.ACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; P_LOAD_BEELINE_BILLS('||:NEW.ACCOUNT_ID || '); END;',
      start_date => SYSDATE+32/24/60,   --32 ???
      repeat_interval => 'FREQ = HOURLY; INTERVAL = 1',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_OBJ_ID_'||:NEW.ACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; LOADER_CALL_PCKG_N.LOAD_OBJ_ID('||:NEW.ACCOUNT_ID || '); END;',
      start_date => SYSDATE+32/24/60,   --32 ???
      repeat_interval => 'FREQ = DAILY; INTERVAL = 7',
      enabled    => TRUE
      );
      
    DBMS_SCHEDULER.CREATE_JOB
      (
         job_name        => 'J_GET_SIM_LIST_BY_ACCOUNT_'||:NEW.ACCOUNT_ID 
        ,start_date      => sysdate
        ,repeat_interval => 'Freq=HOURLY;Interval=6'
        ,end_date        => NULL
        ,job_class       => 'DEFAULT_JOB_CLASS'
        ,job_type        => 'PLSQL_BLOCK'
        ,job_action      => 'begin 
                               STOP_JOB_PCKG.CHECK_WORK_JOB;
                               GET_SIM_LIST_BY_ACCOUNT('||:NEW.ACCOUNT_ID ||'); 
                             end;'
        ,comments        => 'Получение списка телефонных номеров c нормерами Sim карт по счету '||:NEW.ACCOUNT_ID
        , enabled    => TRUE 
      );
      
    IF MS_CONSTANTS.GET_CONSTANT_VALUE('USE_LOYAL_SYSTEM') = '1' THEN  
      DBMS_SCHEDULER.CREATE_JOB(
        job_name   => 'J_BLOCK_LOYAL_CLIENT_'||:NEW.ACCOUNT_ID,
        job_type   => 'PLSQL_BLOCK',
        job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; BLOCK_LOYAL_WITH_0_BALANCE2('||:NEW.ACCOUNT_ID || '); END;',
        start_date => SYSDATE+32/24/60,   
        repeat_interval => 'FREQ=MINUTELY; INTERVAL=10',
        enabled    => TRUE
        );
    END IF;    
  ELSIF UPDATING THEN
  -- 13.05.2015 - Матюнин - убрал, атк как деталка сейачс грузится в разделении по Stream
--    DBMS_SCHEDULER.SET_ATTRIBUTE(
--      name      => 'J_LOAD_DETAILS_'||:NEW.ACCOUNT_ID,
--      attribute => 'repeat_interval',
--      value     => 'FREQ = MINUTELY; INTERVAL = 0'||REPLACE(ROUND(60*NVL(:NEW.LOAD_INTERVAL, 1)), ',', '.')
--      );
    DBMS_SCHEDULER.SET_ATTRIBUTE(
      name      => 'J_LOAD_PAYMENTS_'||:NEW.ACCOUNT_ID,
      attribute => 'repeat_interval',
      value     => 'FREQ = MINUTELY; INTERVAL = 0'||REPLACE(ROUND(60*NVL(:NEW.PAY_LOAD_INTERVAL, 1)), ',', '.')
      );
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;
ALTER TRIGGER "LONTANA"."TIU_ACCOUNTS" ENABLE