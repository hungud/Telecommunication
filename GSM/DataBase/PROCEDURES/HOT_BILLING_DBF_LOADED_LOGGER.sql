CREATE OR REPLACE PROCEDURE HOT_BILLING_DBF_LOADED_LOGGER
AS
--#Version=2
--
--v.2 26.05.2015 Афросин - мелкий рефакторинг(добавил константу DBF_FILE_EXT и переменную v_dir)
--v.1 09.10.2014 Афросин - Добавил процедуру
   DBF_FILE_EXT CONSTANT VARCHAR2(4) := '.dbf';
   --DBF_FILE_EXT CONSTANT VARCHAR2(4) := '.txt';
 
   v_list         VARCHAR2 (2000);
   v_tmp          INTEGER;
   v_list_array   apex_application_global.vc_arr2;
   v_dir varchar2(200);
 
BEGIN
   
   select DIRECTORY_PATH into v_dir from dba_directories
      where DIRECTORY_NAME = 'DBF_FILES_NEW_DBF';
      
   v_list := PKG_TRF_FILEAPI.list (v_dir);

   v_list_array := APEX_UTIL.string_to_table (v_list, ',');

   FOR i IN 1 .. v_list_array.COUNT
   LOOP
      IF     REGEXP_LIKE (v_list_array (i), DBF_FILE_EXT, 'i')
         AND NOT (REGEXP_LIKE (v_list_array (i), DBF_FILE_EXT||'.', 'i'))
      THEN
         HOT_BILLING_DBF_LOADED (v_list_array (i));
         v_tmp := PKG_TRF_FILEAPI.delete (v_dir || '\' || v_list_array (i)); -- '
      END IF;
   END LOOP;

   RETURN;
END;
/
