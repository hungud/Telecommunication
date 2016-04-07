CREATE OR REPLACE PROCEDURE KILL_HANGED_JOBS IS

<<<<<<< .mine
  --#Version=8
  --8 07.12.2015 Матюнин  Кто-то добавил условие (dsj.job_name not like 'J_LOAD_PHONES_COLLECT%' AND (last_start_date)<sysdate-4/24 ) 
  --                      и это нихера не работало для остальных джобов прописанных в исключении. Поправилена ситуация добавлением исключений
  --7 20.08.2015 Афросин Добавил таблицу с исключениями для джобов
  --6 19.08.2015 Алексеев Добавил проверку на наличие записей в OBJ1 (OBJ1.COUNT > 0). Поправил код на читабельность
  --5 19.08.2015 Алексеев увеличил размерность OBJ1 и s1
  --4 18.08.2015 Алексеев Исключил из выборки job J_MV_PROFIT_BY_PHONES (в функции check_hovering_jobs).
  --3 14.08.2015 Алексеев Исключил job J_MV_PROFIT_BY_PHONES из алгоритма. Теперь J_KILL_HANGED_JOBS его не стопает.
  --2 07.07.2015 Для каждого типа JOB задал интервал
  --1 13.01.2014 Перенос функционала из SMS_SYSTEM_ERROR_NOTICE Овсянников
=======
  --#Version=7
  --7 20.08.2015 Афросин Добавил таблицу с исключениями для джобов
  --6 19.08.2015 Алексеев Добавил проверку на наличие записей в OBJ1 (OBJ1.COUNT > 0). Поправил код на читабельность
  --5 19.08.2015 Алексеев увеличил размерность OBJ1 и s1
  --4 18.08.2015 Алексеев Исключил из выборки job J_MV_PROFIT_BY_PHONES (в функции check_hovering_jobs).
  --3 14.08.2015 Алексеев Исключил job J_MV_PROFIT_BY_PHONES из алгоритма. Теперь J_KILL_HANGED_JOBS его не стопает.
  --2 07.07.2015 Для каждого типа JOB задал интервал
  --1 13.01.2014 Перенос функционала из SMS_SYSTEM_ERROR_NOTICE Овсянников
>>>>>>> .r10866

  s1 varchar2(500 char);
    
  cursor hovering_jobs is
    select
      owner||'.'||dsj.job_name full_job_name
    from
      DBA_SCHEDULER_JOBS dsj
    where
       STATE='RUNNING'and
      (
        (
<<<<<<< .mine
          (
            dsj.job_name like 'J_LOAD_REPORT%' 
            OR (dsj.job_name like 'J_LOAD_PHONES%' and dsj.job_name not like 'J_LOAD_PHONES_COLLECT%') 
            OR dsj.job_name like 'J_LOAD_PAYMENTS%' 
            OR dsj.job_name like 'J_BLOCK_CLIENT%' 
            OR dsj.job_name like 'J_UNBLOCK_CLIENT%' 
          )
           AND (last_start_date)<sysdate-25/1440
        )
--        OR
--        (dsj.job_name not like 'J_LOAD_PHONES_COLLECT%' AND (last_start_date)<sysdate-4/24)
        OR
        exists
        (
            select 1 from KILL_JOBS_EXCEPTION k
            where K.JOB_NAME = dsj.job_name
            --переводим минуты в часы
            and last_start_date < sysdate - (K.JOB_RUNNING_TIME/60) /24
        ) 
        or 
        ( not exists -- номера нет в ислкючениях и в других условиях не попал, то есть все оставшиеся джобы убиваются после 4 часов работы   
          (
           select 1 from KILL_JOBS_EXCEPTION k
            where K.JOB_NAME = dsj.job_name    
              and K.JOB_RUNNING_TIME is not null                
          )
          and (last_start_date)<sysdate-4/24
        )
      )
      --откидываем джобы, которые не надо стопать
      and not exists
        (
            select 1 from KILL_JOBS_EXCEPTION k
            where K.JOB_NAME = dsj.job_name
            and K.JOB_RUNNING_TIME is null
        ); 
=======
          (
            dsj.job_name like 'J_LOAD_REPORT%' 
            OR (dsj.job_name like 'J_LOAD_PHONES%' and dsj.job_name not like 'J_LOAD_PHONES_COLLECT%') 
            OR dsj.job_name like 'J_LOAD_PAYMENTS%' 
            OR dsj.job_name like 'J_BLOCK_CLIENT%' 
            OR dsj.job_name like 'J_UNBLOCK_CLIENT%' 
          )
           AND (last_start_date)<sysdate-25/1440
        )
        OR
        (dsj.job_name not like 'J_LOAD_PHONES_COLLECT%' AND (last_start_date)<sysdate-4/24 )
        OR
        exists
        (
            select 1 from KILL_JOBS_EXCEPTION k
            where K.JOB_NAME = dsj.job_name
            --переводим минуты в часы
            and last_start_date < sysdate - (K.JOB_RUNNING_TIME/60) /24
        ) 
      )
      --откидываем джобы, которые не надо стопать
      and not exists
        (
            select 1 from KILL_JOBS_EXCEPTION k
            where K.JOB_NAME = dsj.job_name
            and K.JOB_RUNNING_TIME is null
        ); 
>>>>>>> .r10866

-----основной блок
BEGIN
  
  for cur in hovering_jobs loop
    s1:='begin DBMS_SCHEDULER.STOP_JOB('''||cur.full_job_name||''', TRUE); end; ';

    BEGIN
      execute immediate s1;
      
      INSERT INTO KILL_JOB_LOG (JOB_NAME, DATE_INSERT)
      VALUES (cur.full_job_name, sysdate);
      
    EXCEPTION
      WHEN OTHERS THEN
        null;
    END;   

<<<<<<< .mine
  end loop;
  
  commit;
    
END KILL_HANGED_JOBS;
/
=======
  end loop;
  
  commit;
    
END KILL_HANGED_JOBS;>>>>>>> .r10866
