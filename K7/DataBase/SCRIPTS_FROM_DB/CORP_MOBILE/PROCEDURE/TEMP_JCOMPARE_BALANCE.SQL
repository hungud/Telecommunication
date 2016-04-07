
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."TEMP_JCOMPARE_BALANCE" (pid_database number,
                                                  pc_part      number default 0) is
  i        integer;
  k        integer := 1;
  date_bal date := sysdate;

  c_part number; -- кол-во абонентов в одной нитке

  vJobn binary_integer;
  vWhat varchar2(32767);
begin
  if pc_part = 0 then
    c_part := nvl(ms_constants.GET_CONSTANT_VALUE('TEMP_JCOMPARE'), 1);
  end if;

  if pc_part <> 0 then
    c_part := pc_part;
  end if;

  delete from temp_compare_phone where (id_database = pid_database);
  commit;

  for x in (select tt.phone_number,
                   ceil(tt.rn / c_part) db_loader_account_phones
              from (select row_number() over(order by phone_number) rn, t.*
                      from (select distinct phone_number
                              from db_loader_account_phones --where rownum<1001
                            ) t) tt) loop
  
    insert into temp_compare_phone
      (phone_number, balance_date, num, flag, id_database)
    values
      (x.phone_number,
       date_bal,
       x.db_loader_account_phones,
       0,
       pid_database);
  
    commit;
  
  end loop;
  -- запуск джобов
  for i in (select distinct num
              from temp_compare_phone
             where id_database = pid_database) loop
  
    vWhat := ' temp_compare_balance(' || pid_database || ',' || i.num || ');';
    dbms_job.submit(vJobn, vWhat, Sysdate, null, false, 0);
    commit;
  
  end loop;

end;

  /*select * from BALANCE_COMPARE_RESULT
  create table temp_compare_phone as select * from testbalance_phone*/
