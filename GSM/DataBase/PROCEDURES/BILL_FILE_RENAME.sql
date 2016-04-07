--#if GetVersion("BILL_FILE_RENAME") < 1 then 
CREATE OR REPLACE PROCEDURE BILL_FILE_RENAME (RAS in varchar2) IS
--#Version=1
--Процедура переименования заархевированных файлов детализации из счета
 cursor cur_g is
  select bb.filename,smonth,slogin from BILL_BLOB bb
  where lower(substr(bb.filename,instr(bb.filename,'.',-1)+1,length(bb.filename)-instr(bb.filename,'.',-1)))=RAS;
  sfile varchar2(200);
  ssmonth varchar2(7);
  sslogin varchar2(20);
  sCAT  varchar2(256);
begin
  sCAT:=substr(MS_PARAMS.GET_PARAM_VALUE('TEMPDB_DIR'),1,instr(MS_PARAMS.GET_PARAM_VALUE('TEMPDB_DIR'),'\',-1));
    open cur_g;
  loop
    FETCH cur_g
      into sfile,ssmonth,sslogin;
    EXIT WHEN cur_g%NOTFOUND;
    sfile:=substr(sfile,1,instr(sfile,'.',-1))||'csv';
     if pkg_fileutil.fn_FileExists(sCAT||sfile)=1 then
       pkg_fileutil.pr_FileRename(sCAT||sfile,sCAT||ssMONTH||'_'||ssLOGIN||'.csv');
    --   pkg_fileutil.pr_FileDelete(sCAT||sfile);
     end if;
   end loop;
end;
--GRANT EXECUTE ON BILL_FILE_RENAME TO CORP_MOBILE_ROLE;
--GRANT EXECUTE ON BILL_FILE_RENAME TO CORP_MOBILE_ROLE_RO;
--#end if
/
