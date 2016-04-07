
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_CALL_BACK_TXT" (pPHONEA IN VARCHAR2,
pPHONEB IN VARCHAR2)
  RETURN varchar2 IS
  --#Version=1
  PRAGMA AUTONOMOUS_TRANSACTION;
  CALL_BACK_TXT  VARCHAR2(300 CHAR);
  flag integer;
BEGIN
  select count(*) into flag from CALL_BACK_REQUEST cbr
  where cbr.phonea=pPHONEA;
  if flag=0 then
     insert into CALL_BACK_REQUEST values(pPHONEA,pPHONEB,null,null,null);
     commit;
     CALL_BACK_TXT:='Ваша заявка добавлена в очередь.';
  else
    CALL_BACK_TXT:='Запрос не выполнен. Ваша предыдущая заявка еще не обработана.';
  end if;
  return CALL_BACK_TXT;
end;
