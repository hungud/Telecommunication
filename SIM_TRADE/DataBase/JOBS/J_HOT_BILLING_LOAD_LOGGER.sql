
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        job_name => 'J_HOT_BILLING_LOAD_LOGGER',
        job_type => 'PLSQL_BLOCK',
        job_action => '--
--#Version=1
--
--v.1 09.10.2014 Афросин - Добавил джоб
--BEGIN  HOT_BILLING_DBF_LOADED_LOGGER(MS_PARAMS.GET_PARAM_VALUE(''HOT_BILL_NEW_DBF_FILE_PATH''));   END;',  -- '
        start_date => SYSDATE,
        repeat_interval => 'FREQ = MINUTELY; INTERVAL = 1',
        enabled => TRUE
);
END;