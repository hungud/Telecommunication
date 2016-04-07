
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."TEMP_COMPARE_BALANCE" (pid_database number,
                                                 nnum         number) is
  PRAGMA AUTONOMOUS_TRANSACTION;
  i            number := 1;
  n            number := 0;
  balance_work number;
  balance_test number;
  phone_number number;
  balance_date date := sysdate;
  DESTSCHEME   varchar2(100);

begin

  select SCHEMA_NAME
    INTO DESTSCHEME
    FROM DATABASE_COPIES
   WHERE ID_DATABASE = pid_database;
  delete from BALANCE_COMPARE_RESULT where (id_database = pid_database);
  commit;

  select round((count(*) / 50) + 0.5)
    into n
    from temp_compare_phone
   where num = nnum
     and id_database = pid_database;

  if n <> 0 then
    for i in 1 .. n loop
    
      execute immediate 'insert into BALANCE_COMPARE_RESULT
select q.phone_number , q.id_database ,
get_abonent_balance78(q.phone_number),' || DESTSCHEME ||
                        '.GET_ABONENT_BALANCE78(q.phone_number,null,''1''), balance_date
 from temp_compare_phone q
 where q.flag=0 and rownum<51
 and num=' || nnum || '
 and id_database=' || pid_database ||
                        ' and not exists
 (select 1 from BALANCE_COMPARE_RESULT a where a.phone_number=q.phone_number and a.id_database=' ||
                        pid_database || ')';
    
      commit;
    
    end loop;
  end if;

end;
