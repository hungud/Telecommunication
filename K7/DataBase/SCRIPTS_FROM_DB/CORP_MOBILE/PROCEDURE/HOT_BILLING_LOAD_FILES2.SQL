
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HOT_BILLING_LOAD_FILES2" IS
  cursor curf is
    select rowid, hbf.file_name
      from HOT_BILLING_FILES hbf
     where hbf.load_sdate is null
     and mod(hbf.hbf_id,4)=2
     and substr(hbf.file_name,-3)='csv'
     order by hbf.file_name;
  rowi  rowid;
  filen varchar2(50);
BEGIN
  open curf;
  loop
    FETCH curf
      into rowi, filen;
    EXIT WHEN curf%NOTFOUND;
    update HOT_BILLING_FILES hbf
       set hbf.load_sdate = sysdate
     where rowid = rowi;
    commit;
    HOT_BILLING_LOAD_FILE(filen,'2');
    update HOT_BILLING_FILES hbf
       set hbf.load_edate = sysdate
     where rowid = rowi;
    commit;
  end loop;
  close curf;
end;
