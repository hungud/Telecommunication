
  CREATE OR REPLACE PROCEDURE "LONTANA"."EXPORT_CALLS_TO_TEXT" (
--
--#Version=1
--
-- перекладываем базу во внешние файлы
--
        PROG_FILE_DIR IN VARCHAR2, -- ПУТЬ К ПАПКЕ С ИПОЛНЯЕМЫМ ФАЙЛОМ
        MONTH_YEAR IN VARCHAR2,     --МЕСЯЦ_ГОД ЗА КОТОРЫЙ ПРОИСХОДИТ ВЫГРУЗКА
        EXT_FILE_PATH IN VARCHAR2, --ПУТЬ КУДА БУДУТ ВЫГРУЖАТЬСЯ ФАЙЛЫ
        CONNECT_STR IN VARCHAR2, --СТРОКА СОЕДИНЕНИЯ
        WORK_SCHEMA_NAME IN VARCHAR2      -- ИМЯ СХЕМЫ ДЛЯ КОТОРОЙ ПРОИЗВОДИТСЯ ВЫГРУЗКА ФАЙЛОВ
)
AS
      LANGUAGE JAVA
      NAME 'JAVA_EXPORT_CALLS_TO_TEXT.EXPORT_CALLS_TO_TEXT ( java.lang.String,
                          java.lang.String,
                          java.lang.String,
                          java.lang.String,
                          java.lang.String
                                 ) 
      ';