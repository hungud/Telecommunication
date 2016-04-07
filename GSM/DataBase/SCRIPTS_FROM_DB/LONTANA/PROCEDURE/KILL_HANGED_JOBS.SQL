
  CREATE OR REPLACE PROCEDURE "LONTANA"."KILL_HANGED_JOBS" 
IS
   --#Version=5
   --v.5 Афросин 26.10.2015 Убиваем рассыслку смс, ессли она работает больш 20  минут
   --v.4 Афросин 17.07.2015 Убрал лишний OR   
   --v.3 Афросин 14.07.2015 Добавил J_NEW_SMS_REQUEST_STREAM_% и J_GET_STATUS_SMS_STREAM_% и убрал J_SMS_REQUEST_STREAM_%
   --v.2 Афросин 26.03.2015 Добавил J_SMS_REQUEST_STREAM_%
   -- для каждого типа JOB задал интервал     
   --1 13.01.2014 Перенос функционала из SMS_SYSTEM_ERROR_NOTICE Овсянников

   --
   TYPE T_OBJNAME IS TABLE OF VARCHAR2 (128);

   OBJ1   T_OBJNAME;
   s1     VARCHAR2 (128);

   --max 1 sms per 12 h.
   -- Проверка зависших job, которые выполняются больше 15 минут.
   FUNCTION check_hovering_jobs
      RETURN NUMBER
   IS
      tmpCnt   NUMBER;
   BEGIN
      SELECT COUNT (*)
        INTO tmpCnt
        FROM (SELECT job_name, SYSDATE - last_start_date
                FROM DBA_SCHEDULER_JOBS
               WHERE     (   job_name LIKE 'J_LOAD_REPORT%'
                          OR job_name LIKE 'J_LOAD_PHONES%'
                          OR job_name LIKE 'J_LOAD_PAYMENTS%'
                          OR job_name LIKE 'J_BLOCK_%'
                          OR job_name LIKE 'J_UNBLOCK_%'
                          OR job_name LIKE 'J_NEW_SMS_REQUEST_STREAM_%'
                          OR job_name LIKE 'J_GET_STATUS_SMS_STREAM_%'
                          )
                     AND STATE = 'RUNNING'
                     AND (last_start_date) < SYSDATE -  20/ 1440);

      RETURN tmpCnt;
   END;
-----основной блок
BEGIN
   IF check_hovering_jobs > 0
   THEN
      BEGIN
         EXECUTE IMMEDIATE
            'select owner||''.''||job_name from DBA_SCHEDULER_JOBS 
                where ( 
                        (job_name like ''J_LOAD_REPORT%'' and (last_start_date)<sysdate-60/1440) OR 
                        (job_name like ''J_LOAD_PHONES%'' and (last_start_date)<sysdate-40/1440) OR  
                        (job_name like ''J_LOAD_PAYMENTS%'' and (last_start_date)<sysdate-30/1440) OR  
                        (job_name like ''J_BLOCK_%'' and (last_start_date)<sysdate-40/1440) OR  
                        (job_name like ''J_UNBLOCK_%'' and (last_start_date)<sysdate-40/1440) OR 
                        (
                          (
                            job_name like ''J_NEW_SMS_REQUEST_STREAM_%'' OR 
                            job_name like ''J_GET_STATUS_SMS_STREAM_%''
                          ) 
                          
                          and (last_start_date)<sysdate-20/1440)
                       ) 
                     AND STATE=''RUNNING''' 
                     
            BULK COLLECT INTO OBJ1;

         FOR A IN 1 .. OBJ1.LAST
         LOOP
            s1 := OBJ1 (A);
            s1 :=
               'begin DBMS_SCHEDULER.STOP_JOB(''' || s1 || ''', TRUE); end; ';

            --if not to_number(to_char(sysdate,'HH24')) between 0 and 8 then
            --msg:=msg||';h_j:'||s1;
            --end if;
            BEGIN
               EXECUTE IMMEDIATE s1;
            --   dbms_output.put_line(s1);
            EXCEPTION
               WHEN OTHERS
               THEN
                  DBMS_OUTPUT.put_line ('Ошибка ');
                  DBMS_OUTPUT.put_line (s1);
            END;
         END LOOP;
      END;
   END IF;
END KILL_HANGED_JOBS;