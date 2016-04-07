
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."BILL_FILE_RENAME" (RAS in varchar2) IS
  efile   varchar2(200);
  sfile   varchar2(200);
  ssmonth varchar2(7);
  sslogin varchar2(20);
  sCAT    varchar2(256);
  callv   varchar2(4000);
  cf      utl_file.file_type;
begin
  sCAT := substr(MS_PARAMS.GET_PARAM_VALUE('TEMPDB_DIR'),
                 1,
                 instr(MS_PARAMS.GET_PARAM_VALUE('TEMPDB_DIR'), '\', -1));
  execute immediate 'create or replace directory TEMPDBLOGDIR  as '''||sCAT||'''';
  cf   := utl_file.fopen('TEMPDBLOGDIR', RAS || '.log', 'R');
  utl_file.get_line(cf, callv);
  utl_file.get_line(cf, callv);
  utl_file.get_line(cf, callv);
  utl_file.get_line(cf, callv);
  efile := pkg_fileutil.fn_ExtractFileName(substr(callv,
                                                  21,
                                                  length(callv) - 20));
  utl_file.get_line(cf, callv);
  utl_file.get_line(cf, callv);
  sfile := substr(callv, 13, length(callv) - 12);
  utl_file.fclose(cf);

  select smonth, slogin
    into ssmonth, sslogin
    from BILL_BLOB bb
   where bb.filename = efile;
  pkg_fileutil.pr_FileRename(sCAT || sfile,
                             sCAT || ssMONTH || '#' || ssLOGIN || '.csv');
end;
