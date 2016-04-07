
  CREATE OR REPLACE PROCEDURE "LONTANA"."HOT_BILLING_END_LF" (pfile_name in varchar2) is
  --#Version=1
  -- Начало загрузки CSV
BEGIN
  update hot_billing_temp_call hb
     set hb.dbf_id =
         (select hbf.hbf_id
            from hot_billing_files hbf
           where hbf.file_name = Pkg_Fileutil.fn_ExtractFileName(pfile_name))
   where hb.dbf_id = 70535;
  commit;
  update hot_billing_files hbf
     set hbf.load_edate = sysdate
   where hbf.file_name = Pkg_Fileutil.fn_ExtractFileName(pfile_name);
  commit;
exception
  when others then
    null;
end;
