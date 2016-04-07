
  CREATE OR REPLACE PROCEDURE "LONTANA"."HOT_BILLING_DBF_LOADED" (
   NAME_FILEP   IN VARCHAR2,
   pFILE_SIZE   IN INTEGER DEFAULT NULL,
   pROW_COUNT   IN INTEGER DEFAULT NULL)
IS
   --
   --#Version=4
   --
   --v4 Афросин 29.12.2014 Добавил проверку на существование файла в проверяемой директории, если его там нет, то копируем его туда
   --v3 Афросин Не возвращалось ни одного значения (Даже null) если директории не было в базе
   --v2. Добавил названия полей в оператор. Добавил обновление столбцов FILE_SIZE и ROW_COUNT
   --
   --v1.Добавили функцию, добавляющую имя файла в HOT_BILLING_FILES
   flag         NUMBER (1);
   vFILE_SIZE   INTEGER;
   vROW_COUNT   INTEGER;
   dir_path     VARCHAR2 (500);
   temp_file_name varchar2(300);
   copy_res  integer;
BEGIN
   SELECT COUNT (*)
     INTO flag
     FROM HOT_BILLING_FILES hbf
    WHERE hbf.file_name = NAME_FILEP;

   IF flag = 0
   THEN
      SELECT MIN (directory_path)
        INTO dir_path
        FROM all_directories
       WHERE directory_name = 'DBF_FILES_NEW_DBF';

      vFILE_SIZE := NULL;
      vROW_COUNT := NULL;

      IF dir_path IS NOT NULL THEN
        temp_file_name := dir_path || '\' || NAME_FILEP;
         
         --Проверяем на файл на существование в директории 'DBF_FILES', если его там не,
         -- то копируем его из MS_PARAMS.GET_PARAM_VALUE(''HOT_BILL_NEW_DBF_FILE_PATH'') 

        if  PKG_TRF_FILEAPI."EXISTS"(temp_file_name) = 0 then
          copy_res :=  PKG_TRF_FILEAPI.COPY(MS_PARAMS.GET_PARAM_VALUE('DBF_FILES_COPY_DBF') || '\' || NAME_FILEP, temp_file_name);
        else
          copy_res := 1;
        end if;

        vFILE_SIZE := PKG_TRF_FILEAPI.LENGTH (temp_file_name);
        if  copy_res = 1 then
          vROW_COUNT := DBASE_PKG.GET_DBF_ROW_COUNT ('DBF_FILES_NEW_DBF', NAME_FILEP);
        end if;
        
      END IF;

      vFILE_SIZE := NVL (pFILE_SIZE, vFILE_SIZE);
      vROW_COUNT := NVL (pROW_COUNT, vROW_COUNT);

      INSERT INTO HOT_BILLING_FILES (FILE_NAME, FILE_SIZE, ROW_COUNT)
           VALUES (NAME_FILEP, vFILE_SIZE, vROW_COUNT);
   ELSE
      UPDATE HOT_BILLING_FILES
         SET FILE_SIZE = NVL (pFILE_SIZE, FILE_SIZE),
             ROW_COUNT = NVL (pROW_COUNT, ROW_COUNT)
       WHERE file_name = NAME_FILEP;
   END IF;

   COMMIT;
END;