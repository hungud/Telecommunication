CREATE OR REPLACE PROCEDURE KILL_HANGED_JOBS IS
--#Version=1
--1 13.01.2014 Перенос функционала из SMS_SYSTEM_ERROR_NOTICE Овсянников

  --
  TYPE T_OBJNAME IS TABLE OF VARCHAR2(128);
  OBJ1 T_OBJNAME;
  s1 varchar2(128);
--max 1 sms per 12 h.
    -- Проверка зависших job, которые выполняются больше 15 минут.
    function check_hovering_jobs return number is
     tmpCnt Number;
    begin
      select count(*) INTO tmpCnt from  (select job_name, sysdate-last_start_date from DBA_SCHEDULER_JOBS where (job_name like 'J_LOAD_REPORT%' OR job_name like 'J_LOAD_PHONES%' OR job_name like 'J_LOAD_PAYMENTS%' OR job_name like 'J_BLOCK_%' OR job_name like 'J_UNBLOCK_%' ) AND STATE='RUNNING' AND (last_start_date)<sysdate-40/1440);
      return tmpCnt;
    end;


-----основной блок
begin

if check_hovering_jobs>0 then begin
 --select username INTO SCHEMA_ from v$session WHERE AUDSID = USERENV('sessionid');
 --execute immediate 'select ''exec DBMS_SCHEDULER.DISABLE('''||chr(39)||job_name||chr(39)||''', TRUE);'' from DBA_SCHEDULER_JOBS where OWNER=''CORP_MOBILE''' BULK COLLECT INTO OBJ1;
 execute immediate 'select owner||''.''||job_name from DBA_SCHEDULER_JOBS where (job_name like ''J_LOAD_REPORT%'' OR job_name like ''J_LOAD_PHONES%'' OR job_name like ''J_LOAD_PAYMENTS%'' OR job_name like ''J_BLOCK_%'' OR job_name like ''J_UNBLOCK_%'') AND STATE=''RUNNING'' AND (last_start_date)<sysdate-25/1440' BULK COLLECT INTO OBJ1;
 for A IN 1..OBJ1.LAST LOOP
  s1:=OBJ1(A);
  s1:='begin DBMS_SCHEDULER.STOP_JOB('''||s1||''', TRUE); end; ';
  --if not to_number(to_char(sysdate,'HH24')) between 0 and 8 then
   --msg:=msg||';h_j:'||s1;
  --end if;
  begin
   execute immediate s1;
--   dbms_output.put_line(s1);
  EXCEPTION
   WHEN OTHERS THEN
   dbms_output.put_line('Ошибка ');
   dbms_output.put_line(s1);
  END;
 END LOOP;
end;
end if;


END KILL_HANGED_JOBS;
/
