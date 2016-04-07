--#if GetVersion("DEBUG_OUT") < 1 then
CREATE OR REPLACE procedure debug_out(text varchar2) is
--#Version=1
--
-- ƒобавление записей в таблицу отладки
--
  pragma autonomous_transaction;
  vID integer;
begin
  select s_debug_texts.nextval into vID from dual;
  insert into debug_texts
    (id, out_date, text)
  values
    (vID, sysdate, SUBSTR(text, 1, 4000));
  commit;
end;
/
--#end if
