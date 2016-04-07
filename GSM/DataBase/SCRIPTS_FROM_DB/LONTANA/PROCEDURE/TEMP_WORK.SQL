
  CREATE OR REPLACE PROCEDURE "LONTANA"."TEMP_WORK" is
begin
  for rec in (select l.rowid from ACCOUNT_LOAD_LOGS l where l.ACCOUNT_ID = 165) 
  loop
    delete ACCOUNT_LOAD_LOGS l
      where l.rowid = rec.rowid;
    commit;
  end loop;
end; 