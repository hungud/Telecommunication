
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."HOT_BILLING_DBF_LOADED" (
   NAME_FILEP   IN VARCHAR2,
   pFILE_SIZE   IN INTEGER DEFAULT NULL,
   pROW_COUNT   IN INTEGER DEFAULT NULL)
IS
   --
   --#Version=3
   --
   --v3 Афросин Не возвращалось ни одного значения (Даже null) если директории не было в базе
   --v2. Добавил названия полей в оператор. Добавил обновление столбцов FILE_SIZE и ROW_COUNT
   --
   --v1.Добавили функцию, добавляющую имя файла в HOT_BILLING_FILES
   flag         NUMBER (1);
   vFILE_SIZE   INTEGER;
   vROW_COUNT   INTEGER;
   dir_path     VARCHAR2 (500);
BEGIN
   SELECT COUNT (*)
     INTO flag
     FROM HOT_BILLING_FILES hbf
    WHERE hbf.file_name = NAME_FILEP;

   IF flag = 0
   THEN
      SELECT min(directory_path)
        INTO dir_path
        FROM all_directories
       WHERE directory_name = 'DBF_FILES';

      vFILE_SIZE := NULL;
      vROW_COUNT := NULL;

      IF dir_path IS NOT NULL
      THEN
         vFILE_SIZE := PKG_TRF_FILEAPI.LENGTH (dir_path || '\' || NAME_FILEP);
         vROW_COUNT := DBASE_PKG.GET_DBF_ROW_COUNT ('DBF_FILES', NAME_FILEP);
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