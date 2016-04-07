
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_MOB_PAY_DELTXT" (pPHONEA IN VARCHAR2)
  RETURN varchar2 IS
  --#Version=1
  PRAGMA AUTONOMOUS_TRANSACTION;
  MOB_PAY_TXT VARCHAR2(300 CHAR);
  f           integer;
BEGIN
  select count(*)
    into f
    from mob_pay mp
   where mp.phone = pPHONEA
     and mp.date_pay is null;
  if f > 0 then
    update mob_pay mp
       set mp.date_pay = sysdate
     where mp.phone = pPHONEA
       and mp.date_pay is null;
    commit;
    MOB_PAY_TXT := 'Номер удален из списка.';
  else
    MOB_PAY_TXT := 'Ошибка. Номера нет в списке.';
  end if;
  return MOB_PAY_TXT;
end;
