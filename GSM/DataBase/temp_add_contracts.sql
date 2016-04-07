declare
dis_lim integer;
begin
  for rec in (
    select *
      from temp4
      )
  loop
  dis_lim:=case
            when rec.str7=-10000 then rec.str7
            else null
            end;
    insert into contracts(CONTRACT_DATE, FILIAL_ID, OPERATOR_ID, PHONE_NUMBER_FEDERAL, PHONE_NUMBER_TYPE, TARIFF_ID, DISCONNECT_LIMIT, ABONENT_ID, START_BALANCE, HAND_BLOCK)
      values(to_date('01012013','ddmmyyyy'), 49,    3,           rec.STR1,             rec.ttype,         rec.tid,   dis_lim,          rec.aid,    0,             0);
  end loop;    
  commit;
end;