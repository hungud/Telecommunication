CREATE OR REPLACE FUNCTION GET_MOB_PAY_TXT(pPHONEA IN VARCHAR2)
  RETURN varchar2 IS
  --#Version=1
  PRAGMA AUTONOMOUS_TRANSACTION;
  MOB_PAY_TXT  VARCHAR2(300 CHAR);
  flag integer;
  s_pay number;
BEGIN
  select count(*) into flag from MOB_PAY_REQUEST cbr
  where cbr.phone=pPHONEA;
  if flag=0 then
    begin
    select mp.sum_pay into s_pay from mob_pay mp
    where mp.phone=pPHONEA
    and mp.date_pay is null;
     insert into MOB_PAY_REQUEST values(pPHONEA,s_pay,null,null,null);
     commit;
     MOB_PAY_TXT:='Ваша заявка добавлена в очередь.';
    exception
      when others then
      MOB_PAY_TXT:='Неверный запрос.';
    end;
  else
    MOB_PAY_TXT:='Запрос не выполнен. Ваша предыдущая заявка еще не обработана.';
  end if;
  return MOB_PAY_TXT;
end;


grant execute on GET_MOB_PAY_TXT to CORP_MOBILE_ROLE_RO;
grant execute on GET_MOB_PAY_TXT to CORP_MOBILE_ROLE;