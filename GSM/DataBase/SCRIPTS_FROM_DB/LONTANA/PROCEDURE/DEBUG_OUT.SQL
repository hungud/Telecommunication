
  CREATE OR REPLACE PROCEDURE "LONTANA"."DEBUG_OUT" (text varchar2) is
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