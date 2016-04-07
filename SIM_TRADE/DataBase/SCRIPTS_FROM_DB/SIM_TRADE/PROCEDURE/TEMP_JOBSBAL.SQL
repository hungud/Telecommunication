
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."TEMP_JOBSBAL" (sessionid number)
is
 vJobn binary_integer;
 vWhat varchar2(32767);
begin

for i in (select distinct num from testbalance_phone1 where session_id=sessionid) loop

vWhat := ' temp_deltabal(' || i.num  || ',' ||sessionid || ');';
     dbms_job.submit(vJobn, vWhat, Sysdate, null, false, 0);
/*insert into testbalance_phone (num,tarif_id)
select i.num, sessionid from dual;*/
     commit;

   end loop;

   end;

