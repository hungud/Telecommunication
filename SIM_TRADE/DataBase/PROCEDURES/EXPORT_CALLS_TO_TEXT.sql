CREATE OR REPLACE PROCEDURE EXPORT_CALLS_TO_TEXT (
--
--#Version=1
--
-- ОЕПЕЙКЮДШБЮЕЛ АЮГС БН БМЕЬМХЕ ТЮИКШ
--
        PROG_FILE_DIR IN VARCHAR2, -- осрэ й оюойе я хонкмъелшл тюикнл
        MONTH_YEAR IN VARCHAR2,     --леяъж_цнд гю йнрнпши опнхяундхр бшцпсгйю
        EXT_FILE_PATH IN VARCHAR2, --осрэ йсдю асдср бшцпсфюрэяъ тюикш
        CONNECT_STR IN VARCHAR2, --ярпнйю янедхмемхъ
        WORK_SCHEMA_NAME IN VARCHAR2      -- хлъ яуелш дкъ йнрнпни опнхгбндхряъ бшцпсгйю тюикнб
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