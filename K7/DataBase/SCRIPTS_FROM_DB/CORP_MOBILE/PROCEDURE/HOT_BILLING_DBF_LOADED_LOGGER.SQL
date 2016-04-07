
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HOT_BILLING_DBF_LOADED_LOGGER" (
  p_dir IN VARCHAR2
  ) AS
--#Version=2
--
-- 2015.10.21. Крайнов. Сменил код, чтобы не упиралось в 2000 char.
-- 2014.10.09. Афросин - Добавил процедуру   
   v_list         VARCHAR2 (2000);
   v_tmp          INTEGER;
   v_list_array   apex_application_global.vc_arr2;
BEGIN
/*  v_list := PKG_TRF_FILEAPI.list (p_dir);
  v_list_array := APEX_UTIL.string_to_table (v_list, ',');*/
  v_list_array:=APEX_UTIL.string_to_table(PKG_TRF_FILEAPI.list(p_dir), ',');
  FOR i IN 1 .. v_list_array.COUNT
  LOOP
    IF REGEXP_LIKE (v_list_array (i), '.dbf', 'i')
        AND NOT (REGEXP_LIKE (v_list_array (i), '.dbf.', 'i')) THEN
      HOT_BILLING_DBF_LOADED (v_list_array (i));
      v_tmp := PKG_TRF_FILEAPI.delete (p_dir || '\' || v_list_array (i)); -- '
    END IF;
  END LOOP;
END; 