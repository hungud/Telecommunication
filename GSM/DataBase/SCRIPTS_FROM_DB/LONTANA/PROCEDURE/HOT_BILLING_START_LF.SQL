
  CREATE OR REPLACE PROCEDURE "LONTANA"."HOT_BILLING_START_LF" (pfile_name in varchar2) is
  --#Version=1
  -- Начало загрузки CSV
  dir_name   varchar2(100);
  cf         utl_file.file_type;
  phbf_id    integer;
BEGIN
  select hbf.hbf_id
    into phbf_id
    from hot_billing_files hbf
   where hbf.file_name = Pkg_Fileutil.fn_ExtractFileName(pfile_name);
/*  dir_name := 'HBSLF';-- ||
--              UPPER(Pkg_Fileutil.fn_extractfilenamevfe(file_name));
  EXECUTE IMMEDIATE ' CREATE OR REPLACE DIRECTORY ' || dir_name || ' AS ' || '''' ||
                    UPPER(Pkg_Fileutil.fn_extractfiledir(pfile_name)) || '''';
  utl_file.FCOPY(dir_name, 'LOAD_CSVP.ctl', dir_name, 'LOAD_CSV.ctl');
  cf := utl_file.fopen(dir_name, 'LOAD_CSV.ctl', 'A');
  utl_file.put_line(cf,
                    'DBF_ID CONSTANT ' || to_char(phbf_id) || ')',
                    true);
  utl_file.fclose(cf);
  EXECUTE IMMEDIATE ' DROP DIRECTORY ' || dir_name;*/
  update hot_billing_files hbf
     set hbf.load_sdate = sysdate
   where hbf.hbf_id = phbf_id;
  commit;
/*exception
  when others then
    null;*/
end; 
