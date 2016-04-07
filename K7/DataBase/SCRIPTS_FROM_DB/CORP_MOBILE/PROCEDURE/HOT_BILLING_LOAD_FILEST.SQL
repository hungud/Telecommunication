
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HOT_BILLING_LOAD_FILEST" IS
  cursor curf is
    select rowid, hbf.file_name,hbf.hbf_id
      from HOT_BILLING_FILES hbf
     where hbf.load_edate between trunc(sysdate,'mm') and to_date('14.09.2012','dd.mm.yyyy')
     and not exists(select 1 from hot_billing hb
     where hb.hbf_id=hbf.hbf_id)
;
  rowi  rowid;
  filen varchar2(50);
  phbf_id integer;
BEGIN
  open curf;
  loop
    FETCH curf
      into rowi, filen,phbf_id;
    EXIT WHEN curf%NOTFOUND;
    update HOT_BILLING_FILES hbf
       set hbf.load_sdate = sysdate
     where rowid = rowi;
    commit;
    delete HOT_BILLING hb
    where hb.hbf_id=phbf_id;
    commit;
    HOT_BILLING_LOAD_FILET(filen);
    update HOT_BILLING_FILES hbf
       set hbf.load_edate = sysdate
     where rowid = rowi;
    commit;
  end loop;
  close curf;
end;
