BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_GET_ACTIV_PHONES'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=MONTHLY; INTERVAL=1; BYMONTHDAY=1; BYHOUR=5; BYMINUTE=0; BYSECOND=0'
      ,end_date        => NULL
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             GET_ACTIV_PHONES(to_number(to_char(ADD_MONTHS(sysdate, -1), ''yyyymm''))); 
                           END;'
      ,comments        => 'Получение списка активных номеров для отчета Фин.Отчеты -> списки активных номеров'
    );
  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_GET_ACTIV_PHONES');
END;
/
