CREATE OR REPLACE TRIGGER TIU_ACCOUNTS
BEFORE INSERT OR UPDATE
ON ACCOUNTS
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
    -- ??????? JOB
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
      start_date => SYSDATE+2/24/60,   --2 ???
      repeat_interval => 'FREQ = HOURLY; INTERVAL = 1',
      enabled    => TRUE
      );
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_LOAD_BILL_DETAILS_REV_'||:NEW.ACCOUNT_ID,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; LOADER2_PCKG.LOAD_ACCOUNT_DATA('||:NEW.ACCOUNT_ID || ', 7); END;',
      start_date => SYSDATE+32/24/60,   --32 ???
      repeat_interval => 'FREQ = HOURLY; INTERVAL = 1',
      enabled    => TRUE
      );
  ELSIF UPDATING THEN
    DBMS_SCHEDULER.SET_ATTRIBUTE(
      name      => 'J_LOAD_DETAILS_'||:NEW.ACCOUNT_ID,
      attribute => 'repeat_interval',
      value     => 'FREQ = MINUTELY; INTERVAL = 0'||REPLACE(ROUND(60*NVL(:NEW.LOAD_INTERVAL, 1)), ',', '.')
      );
    if :NEW.ACCOUNT_ID not in (93,99) then
    DBMS_SCHEDULER.SET_ATTRIBUTE(
      name      => 'J_LOAD_PAYMENTS_'||:NEW.ACCOUNT_ID,
      attribute => 'repeat_interval',
      value     => 'FREQ = MINUTELY; INTERVAL = 0'||REPLACE(ROUND(60*NVL(:NEW.PAY_LOAD_INTERVAL, 1)), ',', '.')
      );
    end if;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;
/