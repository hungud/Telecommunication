BEGIN
--
--Version=1
--
   SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_MV_PROFIT_BY_PHONES'
      ,start_date      => TO_TIMESTAMP_TZ('2014/10/23 18:15:20.372000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MONTHLY; INTERVAL=1;BYMONTHDAY=24;byhour=6;byminute=0;bysecond=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
    dbms_mview.refresh(LIST=>''COPR_MOBILE.MV_PROFIT_BY_PHONES_YEAR'', METHOD => ''C'', PARALLELISM=>3);
end;'
      ,comments        => 'ќбновление материализованного представлени€ MV_PROFIT_BY_PHONES_YEAR'
    );
  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_MV_PROFIT_BY_PHONES');
END;
/

