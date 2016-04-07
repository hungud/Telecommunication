CREATE OR REPLACE PROCEDURE P_OS_SOAP_API_LOG_BACK_UP
AS

  --
  --#Version=1
  --
  -- V.1 21.12.2015 Алексеев Процедура выгрузки данных таблицы BEELINE_SOAP_API_LOG во 
  --                                      внешнюю таблицу и truncate таблицы BEELINE_SOAP_API_LOG.
   
   ssql        VARCHAR2 (1000);
   v_file_name VARCHAR2(100 char);

  PROCEDURE TRANC_DROP_TABLE (pTABLE_NAME VARCHAR2, UseDrop INTEGER DEFAULT 0)
  AS
    table_ext   INTEGER;
  BEGIN
    --проверяем ниличие таблицы
    SELECT COUNT (*)
       INTO table_ext
      FROM dba_tables
    WHERE UPPER (table_name) = UPPER (pTABLE_NAME);

    --если таблица существует
    IF nvl(table_ext, 0) = 1 THEN
      --проверяем удалять таблицу или транкейтним
      IF nvl(UseDrop, 0) = 1 THEN --drop
        EXECUTE IMMEDIATE 'drop table ' || pTABLE_NAME || ' cascade constraints';
      ELSE --truncate
        EXECUTE IMMEDIATE 'truncate table ' || pTABLE_NAME;
      END IF;
    END IF;
  END;
   
BEGIN
  --удаляем таблицу EXT_BEELINE_SOAP_API_LOG
  TRANC_DROP_TABLE ('EXT_BEELINE_SOAP_API_LOG', 1);

  --определяем имя файла.
  --Если файл выгружается в 00, то указываем его как прошлый день 24 часа
  if to_number(to_char(sysdate, 'HH24')) = 0 then
    v_file_name := TO_CHAR (SYSDATE-1, 'yyyy_mm_dd')||'_24';
  else
    v_file_name := TO_CHAR (SYSDATE, 'yyyy_mm_dd_hh24');
  end if;
  
  --выгружаем данные во внешнюю таблицу
  ssql :=
    '  CREATE TABLE ext_beeline_soap_api_log
    ORGANIZATION EXTERNAL
    (
    TYPE ORACLE_DATAPUMP
    DEFAULT DIRECTORY soapapi_backup
    LOCATION (''ext_beeline_soap_api_log_'
      || v_file_name
      || '.dmp'')
    )
    AS SELECT bsal_id, soap_request, t.soap_answer.getclobval() soap_answer, insert_date, phone, account_id, load_type FROM beeline_soap_api_log t';

  EXECUTE IMMEDIATE ssql;
  
  --делаем truncate таблицы beeline_soap_api_log
  TRANC_DROP_TABLE ('beeline_soap_api_log');
  commit;
  
  execute immediate 'ALTER TABLE BEELINE_SOAP_API_LOG ENABLE ROW MOVEMENT';
  execute immediate 'ALTER TABLE BEELINE_SOAP_API_LOG SHRINK SPACE CASCADE';
END;