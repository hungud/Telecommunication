/* Formatted on 09/10/2014 17:35:43 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE PROCEDURE HOT_BILLING_DBF_LOADED_LOGGER (p_dir IN VARCHAR2)
AS
   v_list         VARCHAR2 (2000);
   v_tmp          INTEGER;
   v_list_array   apex_application_global.vc_arr2;
--#Version=1
--
--v.1 09.10.2014 Афросин - Добавил процедуру   
BEGIN
   v_list := PKG_TRF_FILEAPI.list (p_dir);

   v_list_array := APEX_UTIL.string_to_table (v_list, ',');

   FOR i IN 1 .. v_list_array.COUNT
   LOOP
      IF     REGEXP_LIKE (v_list_array (i), '.dbf', 'i')
         AND NOT (REGEXP_LIKE (v_list_array (i), '.dbf.', 'i'))
      THEN
         HOT_BILLING_DBF_LOADED (v_list_array (i));
         v_tmp := PKG_TRF_FILEAPI.delete (p_dir || '\' || v_list_array (i)); -- '
      END IF;
   END LOOP;

   RETURN;
END;
/
