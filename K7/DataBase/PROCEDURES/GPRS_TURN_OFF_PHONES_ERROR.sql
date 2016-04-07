CREATE OR REPLACE PROCEDURE GPRS_TURN_OFF_PHONES_ERROR AS

  --Version 1
  --
  --v.1 Алексеев 28.01.2016 Процедура отключения интернет-опций в конце мнсяца на активных номерах, по которым были ошибки отключения
  
  pCountJob integer;
  pCountJobOK integer;
  pCountLog integer;
  pID integer;
begin
  --работаем только в последний день месяца
  if TO_CHAR(SYSDATE+1, 'MM')<>TO_CHAR(SYSDATE, 'MM')  then
    --определяем количество механизмов отключеняи пакетов
    --запускаем текущий механизм только после отработка механизмов отключеняи пакетов
    select count(*)
       into pCountJob
      from DBA_SCHEDULER_JOBS jb
    where  jb.job_name like 'J_GPRS_CHECK_FLOW_1_TURN_OFF%'
        and jb.owner = 'CORP_MOBILE';
        
    --определяем количество механизмов отключеняи пакетов, которые отработали корректно
    select count(*)
       into pCountJobOK
      from DBA_SCHEDULER_JOBS jb
    where jb.job_name like 'J_GPRS_CHECK_FLOW_1_TURN_OFF%'
        and jb.owner = 'CORP_MOBILE'
        and trunc(cast(jb.last_start_date as date)) = trunc(sysdate)
        and jb.state = 'SCHEDULED'
        and exists (
                            select 1
                              from USER_SCHEDULER_JOB_RUN_DETAILS dt
                            where dt.job_name = jb.job_name
                                and dt.owner = jb.owner
                                and dt.actual_start_date = (
                                                                          select max(RS.ACTUAL_START_DATE)
                                                                            from USER_SCHEDULER_JOB_RUN_DETAILS rs
                                                                           where RS.JOB_NAME = dt.job_name
                                                                             and rs.owner = dt.owner
                                                                       )
                                and dt.status = 'SUCCEEDED'
                        );
                        
    --определяем количество записей за текущий день в логе job J_GPRS_TURN_OFF_PHONES_ERROR. Должно быть 2
    select count(*)
       into pCountLog
      from JOB_GPRS_TURN_OFF_PHN_ERR_LOG lg
    where trunc(lg.DATE_INSERT) = trunc(sysdate);                        
                        
    --если все отработалло корректно, то запускаем отключение ошибок
    if (pCountJob = pCountJobOK) and (pCountLog <= 1) then
      --заносим в лог запись начала работы job
      pID := S_GPRS_TURN_OFF_PHN_ERR_ID.NEXTVAL;
      INSERT INTO JOB_GPRS_TURN_OFF_PHN_ERR_LOG (GPRS_TURN_OFF_PHN_ERR_ID, DATE_BEGIN, DATE_INSERT) 
        VALUES (pID, sysdate, sysdate);
      commit;
      
      --отключаем опции
      BEELINE_REST_API_PCKG.gprs_opts_turn_off_phone_err;
      
      --обновляем дату окончания работы job
      UPDATE JOB_GPRS_TURN_OFF_PHN_ERR_LOG
            SET DATE_END = sysdate
      WHERE GPRS_TURN_OFF_PHN_ERR_ID = pID;
      commit;
    end if;                        
  end if;
end;