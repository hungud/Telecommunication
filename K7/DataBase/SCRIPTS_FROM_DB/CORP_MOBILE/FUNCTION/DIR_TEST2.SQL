
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."DIR_TEST2" return varchar2 is

  callv varchar2(4000);
  cf    utl_file.file_type;
begin
    cf := utl_file.fopen('DBF_FILES1', 'sequence.txt', 'R');
   utl_file.get_line(cf, callv);
  -- dbms_output.put_line(callv);
  utl_file.fclose(cf);
  return callv;
exception
   WHEN others THEN
--    dbms_output.put_line(SQLERRM);
  return SQLERRM;
end;