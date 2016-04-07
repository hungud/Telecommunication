
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."BILL_FILE_DELETE" (sF in varchar2,
                                             sM in varchar2,
                                             sL in varchar2) IS
  sfile varchar2(256);
  sCAT  varchar2(256);
begin
  sfile := sM || '#' || sL || '.csv';
  sCAT  := substr(MS_PARAMS.GET_PARAM_VALUE('TEMPDB_DIR'),
                  1,
                  instr(MS_PARAMS.GET_PARAM_VALUE('TEMPDB_DIR'), '\', -1));
  if pkg_fileutil.fn_FileExists(sCAT || sfile) = 1 then
    pkg_fileutil.pr_FileDelete(sCAT || sfile);
  end if;
  if lower(substr(sf,
                  instr(sf, '.', -1) + 1,
                  length(sf) - instr(sf, '.', -1))) <> 'csv' then
    if pkg_fileutil.fn_FileExists(sCAT || sf) = 1 then
      pkg_fileutil.pr_FileDelete(sCAT || sf);
    end if;
  end if;
  delete bill_blob bb
   where bb.filename = sf
     and bb.smonth = sm
     and bb.slogin = sl;
  commit;
end;
