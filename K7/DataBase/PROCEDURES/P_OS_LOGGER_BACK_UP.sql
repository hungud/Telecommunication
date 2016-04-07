CREATE OR REPLACE PROCEDURE P_OS_LOGGER_BACK_UP
AS
   --
   --#Version=3
   -- V.3 29.12.2015 Алексеев А.П. Убрал выгрузку по BEELINE_SOAP_API_LOG. Для BEELINE_SOAP_API_LOG крутится отдельный job
   -- V.1 06.02.2015 Афросин А.Ю. Добавил проверку на существование таблицы
   -- V.1 05.02.2015 Афросин А.Ю. Выгрузка таблиц с логами во внешние файлы
   ssql        VARCHAR2 (1000);
   table_ext   INTEGER;

   PROCEDURE TRANC_DROP_TABLE (pTABLE_NAME    VARCHAR2,
                               UseDrop        INTEGER DEFAULT 0)
   AS
      table_ext   INTEGER;
   BEGIN
      SELECT COUNT (*)
        INTO table_ext
        FROM dba_tables
       WHERE UPPER (table_name) = UPPER (pTABLE_NAME);

      IF table_ext = 1
      THEN
         IF UseDrop = 1
         THEN
            EXECUTE IMMEDIATE
               'drop table ' || pTABLE_NAME || ' cascade constraints';
         ELSE
            EXECUTE IMMEDIATE 'truncate table ' || pTABLE_NAME;
         END IF;
      END IF;
   END;
BEGIN
   --  Execute immediate 'truncate table temp_loader_call_n_log';
   TRANC_DROP_TABLE ('temp_loader_call_n_log');

   INSERT INTO temp_loader_call_n_log
      (SELECT *
         FROM loader_call_n_log t
        WHERE t.load_date > SYSDATE - 1 / 24);

   COMMIT;


   --TRANC_DROP_TABLE ('EXT_BEELINE_SOAP_API_LOG', 1);
   TRANC_DROP_TABLE ('EXT_LOADER_CALL_N_LOG', 1);


   ssql :=
         'CREATE TABLE ext_loader_call_n_log
    ORGANIZATION EXTERNAL
    (
    TYPE ORACLE_DATAPUMP
    DEFAULT DIRECTORY e_care_backup
    LOCATION (''ext_loader_call_n_log_'
      || TO_CHAR (SYSDATE, 'yyyy_mm_dd')
      || '.dmp'')
    )
    AS SELECT * FROM loader_call_n_log';

   EXECUTE IMMEDIATE ssql;

   TRANC_DROP_TABLE ('loader_call_n_log');

   /*ssql :=
         '  CREATE TABLE ext_beeline_soap_api_log
    ORGANIZATION EXTERNAL
    (
    TYPE ORACLE_DATAPUMP
    DEFAULT DIRECTORY soapapi_backup
    LOCATION (''ext_beeline_soap_api_log_'
      || TO_CHAR (SYSDATE, 'yyyy_mm_dd')
      || '.dmp'')
    )
    AS SELECT bsal_id, soap_request, t.soap_answer.getclobval() soap_answer, insert_date, phone, account_id, load_type FROM beeline_soap_api_log t';

   EXECUTE IMMEDIATE ssql;

   TRANC_DROP_TABLE ('beeline_soap_api_log');*/


   INSERT INTO loader_call_n_log
      (SELECT *
         FROM temp_loader_call_n_log t);

   COMMIT;

   TRANC_DROP_TABLE ('temp_loader_call_n_log');
END;