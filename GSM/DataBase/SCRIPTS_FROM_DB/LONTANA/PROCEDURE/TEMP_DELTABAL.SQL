
  CREATE OR REPLACE PROCEDURE "LONTANA"."TEMP_DELTABAL" (
  nnum number, 
  sessionid number
  ) is
--
-- Version = 1
--
-- 1. 2015.08.13. Крайнов. Отформатировал, добавил столбик.
PRAGMA AUTONOMOUS_TRANSACTION;
  i number:=1;
  n number:=0;
  balance_work number;
  balance_test number;
  phone_number number;
  balance_date date:=sysdate;
begin
  select round((count(*)/20)+0.5) into n 
    from testbalance_phone1 
    where num=nnum 
      and session_id=sessionid;
  if n<>0 then
    for i in 1..n 
    loop
      insert into testdelta_balance(PHONE_NUMBER, BALANCE_DATE, SUMM, SUMM_COPY, SUMM1, 
                                    SUMM_COPY1, TARIFF_ID, TARIFF_NAME, SESSION_ID, IS_REF_CONSERVATION)
        select q.phone_number, balance_date, 
               get_abonent_balance(q.phone_number),
               0,0,0, q.tarif_id, q.tarif_name, q.session_id,
               NVL((SELECT 1 FROM NUMBER_BLOCK_IN_SAVE N
                      WHERE N.PHONE_NUMBER = Q.PHONE_NUMBER
                        AND ROWNUM <=1), 0) IS_REF_CONSERVATION
          from testbalance_phone1 q
            where q.flag=0 
              and rownum<51
              and num=nnum
              and session_id=sessionid
              and not exists (select 1 
                              from testdelta_balance a 
                              where a.phone_number=q.phone_number 
                                and session_id=sessionid);
      commit;
    end loop;
  end if;
end; 