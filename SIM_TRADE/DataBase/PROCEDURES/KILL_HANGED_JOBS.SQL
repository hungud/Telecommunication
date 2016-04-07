--#if GetVersion("KILL_HANGED_JOBS") < 1 then
CREATE OR REPLACE PROCEDURE KILL_HANGED_JOBS IS
--#Version=1
--1 13.01.2014 Перенос функционала из SMS_SYSTEM_ERROR_NOTICE Овсянников
  msg varchar2(300);--текст смс-сообщения;
  msgK7 varchar2(300);--текст смс-сообщения;
  F_TELETIE_TEST1 integer :=-1;
  f_ussd_test1 integer :=-1;
  f_sms_down_balance integer :=-1;
  --
  list_change_pas varchar2(200);
  null_var varchar2(3000);
  err1 varchar2(3000);
  --
  Sresponce varchar2(3000);
 -- err1 varchar2(3000);
  --
  TYPE T_OBJNAME IS TABLE OF VARCHAR2(128);
  OBJ1 T_OBJNAME;
  s1 varchar2(128);
  type Serv_table is table of varchar2(1000) INDEX BY binary_integer;TsiteAddr Serv_table;
  TempField varchar2(600);
--max 1 sms per 12 h.
    -- Проверка зависших job, которые выполняются больше 15 минут.
    function check_hovering_jobs return number is
     tmpCnt Number;
    begin
      select count(*) INTO tmpCnt from  (select job_name, sysdate-last_start_date from DBA_SCHEDULER_JOBS where (job_name like 'J_LOAD_REPORT%' OR job_name like 'J_LOAD_PHONES%' OR job_name like 'J_LOAD_PAYMENTS%' OR job_name like 'J_BLOCK_CLIENT%' OR job_name like 'J_UNBLOCK_CLIENT%' OR job_name like 'J_SEND_MAIL_PHONE_FOR_SAVE3' OR job_name like 'J_SEND_SMS_NOTICE') AND STATE='RUNNING' AND (last_start_date)<sysdate-40/1440);
      return tmpCnt;
    end;


-----основной блок
begin

if check_hovering_jobs>0 then begin
 --select username INTO SCHEMA_ from v$session WHERE AUDSID = USERENV('sessionid');
 --execute immediate 'select ''exec DBMS_SCHEDULER.DISABLE('''||chr(39)||job_name||chr(39)||''', TRUE);'' from DBA_SCHEDULER_JOBS where OWNER=''CORP_MOBILE''' BULK COLLECT INTO OBJ1;
 execute immediate 'select owner||''.''||job_name from DBA_SCHEDULER_JOBS where (job_name like ''J_LOAD_REPORT%'' OR job_name like ''J_LOAD_PHONES%'' OR job_name like ''J_LOAD_PAYMENTS%'' OR job_name like ''J_BLOCK_CLIENT%'' OR job_name like ''J_UNBLOCK_CLIENT%'' OR job_name like ''J_SEND_MAIL_PHONE_FOR_SAVE3'' OR job_name like ''J_SEND_SMS_NOTICE'') AND STATE=''RUNNING'' AND (last_start_date)<sysdate-25/1440' BULK COLLECT INTO OBJ1;
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

--#end if
