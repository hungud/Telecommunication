CREATE OR REPLACE PROCEDURE VIRT_ACCOUNT_TEMP_LOAD_DBF
--
--#Version=2
--
--v.2 Кочнев 02.12.2015 - Добавил два поля 
--v.1 Кочнев 25.11.2015 - Разбирает данные из dbf файла во временную таблицу виртуальных счетов 
AS
  cDIR_FILES_NEW VARCHAR2(500 char);
  cDIR_DELETE_FILES VARCHAR2(500 char);
  h                         Integer;
  err_num  NUMBER;
  err_msg  varCHAR2(256); 
 cursor new_file is
    select file_id, file_name
    from  VIRT_ACCOUNT_FILES
    where LOAD_END_DATE is null 
      and ERROR_TEXT  is null 
    order by file_id;    
BEGIN
  cDIR_FILES_NEW := MS_CONSTANTS.GET_CONSTANT_VALUE('DIR_VIRT_ACCOUNT_FILES_NEW');
   
  select DIRECTORY_PATH into cDIR_DELETE_FILES from dba_directories
      where DIRECTORY_NAME = cDIR_FILES_NEW;
  
  for rec in new_file loop
  begin
 
    update VIRT_ACCOUNT_FILES
      set LOAD_START_DATE = sysdate
    where
      file_id = rec.file_id;
    commit;
        
    dbase_pkg.load_table (
            p_dir        => cDIR_FILES_NEW,
            p_file       => rec.file_name,
            p_tname      => 'VIRT_ACCOUNT_TEMP',
            p_dbf_id     => rec.file_id,
            p_cnames     => 'INN, NAME, EMAIL, NUMBERS, SERVICE01, SERVICE02, SERVICE03, SERVICE04, SERVICE05, SERVICE06, SERVICE07, SERVICE08, SERVICE09, SERVICE10',
            p_colnames   => 'INN, NAME, EMAIL, NUMBERS, SERVICE01, SERVICE02, SERVICE03, SERVICE04, SERVICE05, SERVICE06, SERVICE07, SERVICE08, SERVICE09, SERVICE10',
            p_show       => FALSE);
            
     cDIR_DELETE_FILES := cDIR_DELETE_FILES||'\'||rec.file_name;
            
     h := PKG_TRF_FILEAPI.delete(cDIR_DELETE_FILES);
    --UTL_FILE.fremove(cDIR_FILES_NEW,rec.file_name);

    update VIRT_ACCOUNT_FILES
      set LOAD_END_DATE = sysdate
    where
      file_id = rec.file_id;
    commit;  
    

    EXCEPTION
         WHEN others
        THEN
         begin
           err_num := SQLCODE;
           err_msg := SUBSTR(SQLERRM, 1, 250);
          update VIRT_ACCOUNT_FILES
          set ERROR_TEXT = to_char(err_num) ||err_msg
          where file_id = rec.file_id;
          commit;  
        end;  

  end;  
  end loop; 

 
END;
/