/* Formatted on 25/11/2014 14:25:55 (QP5 v5.252.13127.32867) */
CREATE OR REPLACE PROCEDURE HOT_BILLING_CSV_LOADED (NAME_FILEP IN VARCHAR2)
--
--Version= 2
--
--v.2 Афросин - убрал не используемые параметры
--
IS
   flag   NUMBER (1);
BEGIN
   SELECT COUNT (*)
     INTO flag
     FROM HOT_BILLING_FILES hbf
    WHERE hbf.file_name = NAME_FILEP;

   IF flag = 0
   THEN
      INSERT INTO HOT_BILLING_FILES (FILE_NAME)
           VALUES (NAME_FILEP);

      COMMIT;
   END IF;

   SELECT COUNT (*)
     INTO flag
     FROM HOT_BILLING_FILES hbf
    WHERE hbf.file_name =
             SUBSTR (NAME_FILEP, 0, LENGTH (NAME_FILEP) - 3) || 'dbf';

   IF flag = 0
   THEN
      INSERT INTO HOT_BILLING_FILES (FILE_NAME)
           VALUES (SUBSTR (NAME_FILEP, 0, LENGTH (NAME_FILEP) - 3) || 'dbf');

      COMMIT;
   END IF;
END;
/
