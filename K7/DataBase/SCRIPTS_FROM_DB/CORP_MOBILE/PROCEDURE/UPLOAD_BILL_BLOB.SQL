
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."UPLOAD_BILL_BLOB" (sFILENAME in varchar2,
                                             ssMONTH   in varchar2,
                                             ssLOGIN   in varchar2) IS
  v_blob blob;
  n      integer;
  sfile  varchar2(200);
  sUSER  varchar2(200);
  sCAT   varchar2(256);
begin
  select bb.filename, bb.data
    into sfile, v_blob
    from BILL_BLOB bb
   where bb.filename = sFILENAME
     and bb.smonth = ssMONTH
     and bb.slogin = ssLOGIN;
  select uu.USERNAME into sUSER from USER_USERS uu;
  sCAT := substr(MS_PARAMS.GET_PARAM_VALUE('TEMPDB_DIR'),
                 1,
                 instr(MS_PARAMS.GET_PARAM_VALUE('TEMPDB_DIR'), '\', -1));
  if lower(substr(sfile,
                  instr(sfile, '.', -1) + 1,
                  length(sfile) - instr(sfile, '.', -1))) = 'csv' then
    sfile := ssMONTH || '#' || ssLOGIN || '.csv';
  end if;
  --dbms_java.grant_permission(sUSER,
   --                          'SYS:java.io.FilePermission',
    --                         sCAT || sfile,
      --                       'write');
  n := SYS.lobutils.BLOB2file(v_blob, sCAT || sfile);
--lobutils2.BLOB2file(v_blob, sCAT || sfile);
exception
  when others then
    raise;
end;
