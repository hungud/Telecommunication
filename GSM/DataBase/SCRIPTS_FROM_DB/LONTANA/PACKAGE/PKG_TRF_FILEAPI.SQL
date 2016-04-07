
  CREATE OR REPLACE PACKAGE "LONTANA"."PKG_TRF_FILEAPI" 
as

  /* Функция проверки прав на чтение */
  function canRead
  (
    p_path  in varchar2
  )
    return number
  as
    language java name 'TRF_FileHandler.canRead (java.lang.String) return java.lang.int';


  /* Функция проверки прав на запись */
  function canWrite
  (
    p_path  in varchar2
  )
    return number
  as
    language java name 'TRF_FileHandler.canWrite (java.lang.String) return java.lang.int';

  /* Функция создания файла */
  function createNewFile
  (
    p_path  in varchar2
  )
  return number
  as
    language java name 'TRF_FileHandler.createNewFile (java.lang.String) return java.lang.int';


  /* Функция удаления файла или директории */
  function delete
  (
    p_path  in varchar2
  )
  return number
  as
    language java name 'TRF_FileHandler.delete (java.lang.String) return java.lang.int';


  /* Функция проверки наличия файла или директории*/
  function exists
  (
    p_path  in varchar2
  )
  return number
  as
    language java name 'TRF_FileHandler.exists (java.lang.String) return java.lang.int';


  /* Функция проверки наличия директории */
  function isDirectory
  (
    p_path  in varchar2
  )
  return number
  as
    language java name 'TRF_FileHandler.isDirectory (java.lang.String) return java.lang.int';

  /* Функция возврата проверки наличия файла */
  function isFile
  (
    p_path  in varchar2
  )
  return number
  as
    language java name 'TRF_FileHandler.isFile (java.lang.String) return java.lang.int';


  /* Функция возврата признака "Скрытый" */
  function isHidden
  (
    p_path  in varchar2
  )
  return number
  as
    language java name 'TRF_FileHandler.isHidden (java.lang.String) return java.lang.int';


  /* Функция возврата даты последнего изменения */
  function lastModified
  (
    p_path  in varchar2
  )
  return date
  as
    language java name 'TRF_FileHandler.lastModified (java.lang.String) return java.sql.Timestamp';


  /* Функция возврата размера файла (в байтах) */
  function length
  (
    p_path  in varchar2
  )
  return number
  as
    language java name 'TRF_FileHandler.length (java.lang.String) return java.lang.long';


  /* Функция возврата каталогов и файлов */
  function list
  (
    p_path  in varchar2
  )
  return varchar2
  as
    language java name 'TRF_FileHandler.list (java.lang.String) return java.lang.String';


  /* Функция создания директории */
  function mkdir
  (
    p_path  in varchar2
  )
  return number
  as
    language java name 'TRF_FileHandler.mkdir (java.lang.String) return java.lang.int';


  /* Функция создания директорий */
  function mkdirs
  (
    p_path  in varchar2
  )
  return number
  as
    language java name 'TRF_FileHandler.mkdirs (java.lang.String) return java.lang.int';


  /* Функция переименования файла или директории */
  function renameTo
  (
    p_from_path  in varchar2,
    p_to_path    in varchar2
  )
  return number
  as
    language java name 'TRF_FileHandler.renameTo (java.lang.String, java.lang.String) return java.lang.int';


  /* Функция установки признака "Только для чтения" */
  function setReadOnly
  (
    p_path  in varchar2
  )
  return number
  as
    language java name 'TRF_FileHandler.setReadOnly (java.lang.String) return java.lang.int';


  /* Функция копирования файла или директории */
  function copy
  (
    p_from_path  in varchar2,
    p_to_path    in varchar2
  )
  return number
  as
    language java name 'TRF_FileHandler.copy (java.lang.String, java.lang.String) return java.lang.int';

  function getFileCount
  (
    dirpath  in varchar2
  )
  return number
  as
    language java name 'TRF_FileHandler.getFileCount (java.lang.String) return java.lang.int';



END PKG_TRF_FILEAPI;
