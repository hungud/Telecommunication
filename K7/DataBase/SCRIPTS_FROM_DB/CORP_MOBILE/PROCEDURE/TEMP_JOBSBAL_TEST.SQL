
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."TEMP_JOBSBAL_TEST" (sessionid number)
is
 vJobn binary_integer;
 vWhat varchar2(32767);
begin

for i in (select distinct num from testbalance_phone1_test where session_id=sessionid) loop

vWhat := ' temp_deltabal_test(' || i.num  || ',' ||sessionid || ');';
     dbms_job.submit(vJobn, vWhat, Sysdate, null, false, 0);
/*insert into testbalance_phone (num,tarif_id)
select i.num, sessionid from dual;*/
     commit;

   end loop;

   end;