declare
dis_lim integer;
begin
  for rec in (
    select *
      from temp4
      )
  loop
    insert into phone_balances(PHONE_NUMBER, BALANCE_DATE, BALANCE_VALUE)
      values(rec.str3, to_date('23032012','ddmmyyyy'), rec.str4);
  end loop;    
  commit;
end;