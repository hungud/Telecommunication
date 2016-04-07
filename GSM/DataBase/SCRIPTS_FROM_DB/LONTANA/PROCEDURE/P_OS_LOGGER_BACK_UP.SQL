
  CREATE OR REPLACE PROCEDURE "LONTANA"."P_OS_LOGGER_BACK_UP" 
AS
  --
  --#Version=6
  -- V.6 28.12.2015 Алексеев А.П. Убрал выгрузку по BEELINE_SOAP_API_LOG. Для BEELINE_SOAP_API_LOG крутится отдельный job
  -- V.5 27.09.2015 Афросин А.Ю. Добавил остановку ждобов перед TRUNCATE таблицы beeline_soap_api_log и очистку лоб сегментов
  -- V.4 18.03.2015 Афросин А.Ю. Добавил разделитель для директорий
  -- V.3 26.02.2015 Афросин А.Ю. Добавил архивирование и удаление выгруженных файлов, и архивов старше 5 дней
  -- V.2 06.02.2015 Афросин А.Ю. Добавил проверку на существование таблицы
  -- V.1 05.02.2015 Афросин А.Ю. Выгрузка таблиц с логами во внешние файлы
   
  DIRECTORY_SEPARATOR CONSTANT CHAR(1) := '\';
  ssql                            VARCHAR2 (1000);
  table_ext                       INTEGER;
  arch_res                        VARCHAR2 (1000);
  ext_file_name                   VARCHAR2 (50);
--  path_loader_call_n_log          VARCHAR2 (1000);
--  path_ext_beeline_soap_api_log   VARCHAR2 (1000);
--  del_res                         INTEGER;
  vCount integer;

  PROCEDURE TRANC_DROP_TABLE (pTABLE_NAME    VARCHAR2,
                             UseDrop        INTEGER DEFAULT 0)
  AS
    table_ext   INTEGER;
  BEGIN
    SELECT COUNT (*)
      INTO table_ext
    FROM dba_tables
    WHERE UPPER (table_name) = UPPER (pTABLE_NAME);

    IF table_ext = 1 THEN
      
      IF UseDrop = 1 THEN
        EXECUTE IMMEDIATE 'drop table ' || pTABLE_NAME || ' cascade constraints';
      ELSE
        EXECUTE IMMEDIATE 'truncate table ' || pTABLE_NAME;
      END IF;
      
    END IF;
    
  END;
BEGIN
  TRANC_DROP_TABLE ('temp_loader_call_n_log');

  INSERT INTO temp_loader_call_n_log(
                                      SELECT *
                                      FROM loader_call_n_log t
                                      WHERE t.load_date > SYSDATE - 1 / 24
                                    );

  COMMIT;


  --TRANC_DROP_TABLE ('EXT_BEELINE_SOAP_API_LOG', 1);
  TRANC_DROP_TABLE ('EXT_LOADER_CALL_N_LOG', 1);

/*
  SELECT DIRECTORY_PATH
   INTO path_loader_call_n_log
  FROM dba_directories
  WHERE DIRECTORY_NAME = 'E_CARE_BACKUP';

  SELECT DIRECTORY_PATH
   INTO path_ext_beeline_soap_api_log
  FROM dba_directories
  WHERE DIRECTORY_NAME = 'SOAPAPI_BACKUP';

*/

  ext_file_name := 'ext_loader_call_n_log_' || TO_CHAR (SYSDATE, 'yyyy_mm_dd');

  ssql :=
           'CREATE TABLE ext_loader_call_n_log
      ORGANIZATION EXTERNAL
      (
      TYPE ORACLE_DATAPUMP
      DEFAULT DIRECTORY e_care_backup
      LOCATION ('''
        || ext_file_name
        || '.dmp'')
      )
      AS SELECT * FROM loader_call_n_log';

  EXECUTE IMMEDIATE ssql;

  TRANC_DROP_TABLE ('loader_call_n_log');
  /*     
  arch_res := NVL (
                   pack7z (path_loader_call_n_log || DIRECTORY_SEPARATOR || ext_file_name || '.dmp',
                           path_loader_call_n_log || DIRECTORY_SEPARATOR || ext_file_name || '.7z'),
                   '0'
                  );

  IF arch_res = '0' THEN
    TRANC_DROP_TABLE ('loader_call_n_log');
    
    del_res := PKG_TRF_FILEAPI.DELETE (
                                       path_loader_call_n_log || DIRECTORY_SEPARATOR || ext_file_name || '.dmp'
                                      );
    --удалим архивы старше 5 дней
    del_res := PKG_TRF_FILEAPI.DELETE (
                                       path_loader_call_n_log
                                      ||DIRECTORY_SEPARATOR
                                      || 'ext_loader_call_n_log_'
                                      || TO_CHAR (SYSDATE - 5, 'yyyy_mm_dd')
                                      || '.7z'
                                     );
  END IF;

  */

  /*ext_file_name := 'ext_beeline_soap_api_log_' || TO_CHAR (SYSDATE, 'yyyy_mm_dd');

  ssql := '  CREATE TABLE ext_beeline_soap_api_log
              ORGANIZATION EXTERNAL
              (
              TYPE ORACLE_DATAPUMP
              DEFAULT DIRECTORY soapapi_backup
              LOCATION ('''
                || ext_file_name
                || '.dmp'')
              )
              AS SELECT bsal_id, soap_request, t.soap_answer.getclobval() soap_answer, insert_date, phone, account_id, load_type FROM beeline_soap_api_log t';

  EXECUTE IMMEDIATE ssql;*/
  
  -- проверяем на наличие исключения в таблице на остановку джобов
  /*select count(*) into vCount from
    STOP_JOB_EXCEPTION
  where
    upper(NAME_STOP_JOB) = 'J_OS_LOGGER_BACK_UP';
      
  if nvl(vCount, 0) = 0 then
    INSERT INTO STOP_JOB_EXCEPTION (NAME_STOP_JOB)
    VALUES ('J_OS_LOGGER_BACK_UP');
    COMMIT;
  end if;
      
  --стопаем джобы
  STOP_JOB_PCKG.STOP_JOB(2);*/
      
  /*TRANC_DROP_TABLE ('beeline_soap_api_log');
      
  execute immediate 'ALTER TABLE BEELINE_SOAP_API_LOG ENABLE ROW MOVEMENT';
  execute immediate 'ALTER TABLE BEELINE_SOAP_API_LOG SHRINK SPACE CASCADE';*/
  

  /*
  arch_res := NVL (
                   pack7z (
                      path_ext_beeline_soap_api_log || DIRECTORY_SEPARATOR || ext_file_name || '.dmp',
                      path_ext_beeline_soap_api_log || DIRECTORY_SEPARATOR || ext_file_name || '.7z'),
                  '0'
                 );

  IF arch_res = '0' THEN
    TRANC_DROP_TABLE ('beeline_soap_api_log');
    del_res := PKG_TRF_FILEAPI.DELETE (
                                       path_ext_beeline_soap_api_log || DIRECTORY_SEPARATOR || ext_file_name || '.dmp'
                                      );
    --удалим архивы старше 5 дней
    del_res := PKG_TRF_FILEAPI.DELETE (
                                         path_ext_beeline_soap_api_log
                                      || DIRECTORY_SEPARATOR
                                      || 'ext_beeline_soap_api_log_'
                                      || TO_CHAR (SYSDATE - 5, 'yyyy_mm_dd')
                                      || '.7z'
                                      );
  END IF;

  */
  INSERT INTO loader_call_n_log (
                                  SELECT * FROM temp_loader_call_n_log t
                                );

  COMMIT;

  TRANC_DROP_TABLE ('temp_loader_call_n_log');
END;