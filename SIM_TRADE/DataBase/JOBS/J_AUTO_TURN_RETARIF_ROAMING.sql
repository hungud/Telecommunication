BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_AUTO_TURN_RETARIF_ROAMING'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=5'
      ,end_date        => NULL
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN P_AUTO_TURN_RETARIF_ROAMING; END;'
      ,comments        => 'Подключение ретарификации роуминга'
    );
  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_AUTO_TURN_RETARIF_ROAMING');
END;
/
