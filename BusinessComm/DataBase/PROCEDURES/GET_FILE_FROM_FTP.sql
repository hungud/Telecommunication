CREATE OR REPLACE PROCEDURE GET_FILE_FROM_FTP
--Version =3
--
--v.3 Кочнев  25.11.2015 Добавил вызов из нескольких процедур
--v.2 Афросин 16.12.2014 Добавил обработку ошибок при работе с файлами
--v.1 Афросин 11.12.2014 Добавил функцию получения файлов с FTP
(
  FILE_EXT  VARCHAR2, -- для PAYMENTS - '.txt', для VIRT_ACCOUNT - '.dbf'
  FILE_PATH VARCHAR2,  -- для PAYMENTS - 'PAYMENTS', для VIRT_ACCOUNT - '1C/FROM_1C/VIRT_ACCOUNT'
  FILE_TYPE_ID Integer, -- для PAYMENTS - 0, для VIRT_ACCOUNT - 1
  DIR_FILES_NEW VARCHAR2, --:= MS_CONSTANTS.GET_CONSTANT_VALUE('DIR_PAYMENT_FILES_NEW');
  DIR_FILES_BACKUP VARCHAR2 --:= 'DIR_PAYMENT_FILES_BACKUP';
  
)
 AS
  cFTP_DIRECTORY_PATH CONSTANT VARCHAR2(10) := '/';
  cFTP_LOCAL_NAME CONSTANT VARCHAR2(15) := 'LOCAL_FTP';
  
  FTP_ADDRESS VARCHAR2(20);
  FTP_PORT VARCHAR2(10);
  FTP_LOGIN  VARCHAR2(20);
  FTP_PASSWORD VARCHAR2(20);
    
  ID_COPY CONSTANT INTEGER := 1;
  ID_DELETE CONSTANT INTEGER := 3;
  ID_RENAME CONSTANT INTEGER := 20;

  l_conn  UTL_TCP.connection;
  copy_to_path varchar2 (200);
  copy_to_path_new varchar2 (200);
    
    
  FUNCTION INSERT_FILE_OPERATION_LOGS (pFILE_NAME in varchar2, pFILE_NAME_NEW in varchar2, pFILE_OPERATION_TYPE_ID in integer, pFROM_PATH in varchar2, pTO_PATH in varchar2, pFILE_TYPE_ID integer)
  RETURN INTEGER as
    RES INTEGER;
  begin
    INSERT INTO FILE_OPERATION_LOGS (FILE_NAME, FILE_NAME_NEW, FILE_OPERATION_TYPE_ID, FROM_PATH, TO_PATH, FILE_TYPE_ID)
    VALUES
    (pFILE_NAME, pFILE_NAME_NEW, pFILE_OPERATION_TYPE_ID, pFROM_PATH, pTO_PATH, pFILE_TYPE_ID) RETURNING FILE_OPERATION_LOG_ID INTO RES;
    COMMIT;
    RETURN RES;
  end;
    
  procedure UPDATE_FILE_OPERATION_LOGS (logId in integer, pERROR_TEXT varchar2 default null) as
  begin
    UPDATE FILE_OPERATION_LOGS FO
      set FO.OPERATION_END_DATE_TIME = SYSDATE,
          FO.ERROR_TEXT = pERROR_TEXT
    WHERE FO.FILE_OPERATION_LOG_ID = logId;
    COMMIT;
  end;
    
  procedure GET_FILE (pFILE_NAME in varchar2, pFILE_NAME_NEW in varchar2, pDirectoryNAME in varchar2, pCopy_to_path in varchar2, pl_conn in  UTL_TCP.connection, pfull_file_path in varchar2, pFolderName varchar2) is
   lID Integer;
   v_conn  UTL_TCP.connection;
  begin
    v_conn := pl_conn;
      
    lID := INSERT_FILE_OPERATION_LOGS(pFILE_NAME, pFILE_NAME_NEW, ID_COPY, FTP_ADDRESS ||'/'||pFolderName, pCopy_to_path, FILE_TYPE_ID);
          
    FTP_PKG.binary(p_conn => v_conn);
         
    FTP_PKG.get(p_conn  => v_conn,
            p_from_file => pfull_file_path,
            p_to_dir    => pDirectoryNAME,
            p_to_file   => pFILE_NAME);
              
    UPDATE_FILE_OPERATION_LOGS (lID);
  end;
    
  procedure GET_FILE_A (pFILE_NAME in varchar2, pFILE_NAME_NEW in varchar2, pDirectoryNAME in varchar2, pCopy_to_path in varchar2, pl_conn in  UTL_TCP.connection, pfull_file_path in varchar2, pFolderName varchar2) is
   lID Integer;
   v_conn  UTL_TCP.connection;
  begin
    v_conn := pl_conn;
      
    lID := INSERT_FILE_OPERATION_LOGS(pFILE_NAME, pFILE_NAME_NEW, ID_COPY, FTP_ADDRESS ||'/'||pFolderName, pCopy_to_path, FILE_TYPE_ID);
          
    FTP_PKG.ascii(p_conn => v_conn);
         
    FTP_PKG.get(p_conn  => v_conn,
            p_from_file => pfull_file_path,
            p_to_dir    => pDirectoryNAME,
            p_to_file   => pFILE_NAME);
              
    UPDATE_FILE_OPERATION_LOGS (lID);
  end;

  procedure GET_FILE_FROM_FOLDER (pFolderName varchar2, pl_conn UTL_TCP.connection) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_conn  UTL_TCP.connection;
    l_list  FTP_PKG.t_string_table;
    full_file_path varchar2(200);
    vlogID Integer;
    temp_file_name varchar2(200);
    file_name_old varchar2(200);
    h  integer;
  begin
     v_conn := pl_conn;
     FTP_PKG.nlst(p_conn   => v_conn,
           p_dir   => pFolderName,
           p_list  => l_list);
    
    
    IF l_list.COUNT > 0 THEN
      
      select DIRECTORY_PATH into copy_to_path from dba_directories
      where DIRECTORY_NAME = DIR_FILES_BACKUP;
        
      select DIRECTORY_PATH into copy_to_path_new from dba_directories
      where DIRECTORY_NAME = DIR_FILES_NEW;
        
      FOR i IN l_list.first .. l_list.last LOOP
        IF    ( REGEXP_LIKE (UPPER(l_list (i)), UPPER(FILE_EXT), 'i')) 
           AND NOT (REGEXP_LIKE (UPPER(l_list (i)), UPPER(FILE_EXT) ||'.', 'i'))   then
            
        begin
          --full_file_path := pFolderName||'/'|| l_list(i);
          full_file_path := l_list(i);
            
            
          file_name_old :=  Replace(l_list(i), pFolderName||'/', '');
            
          temp_file_name := file_name_old ||'.tmp';
            
          --        копируем с FTP в backup
          GET_FILE (file_name_old, file_name_old, DIR_FILES_BACKUP, Copy_to_path, l_conn, full_file_path, pFolderName);
          --        Копируем в папку новую папку
          vlogID := INSERT_FILE_OPERATION_LOGS(file_name_old, temp_file_name, ID_COPY, Copy_to_path, copy_to_path_new, FILE_TYPE_ID);
            
          h := PKG_TRF_FILEAPI.COPY(Copy_to_path||file_name_old, copy_to_path_new||temp_file_name );
         -- UTL_FILE.FCOPY (DIR_FILES_BACKUP, file_name_old, DIR_FILES_NEW, temp_file_name);

          --DBMS_FILE_TRANSFER.COPY_FILE(DIR_FILES_BACKUP, file_name_old, DIR_FILES_NEW, temp_file_name);

          UPDATE_FILE_OPERATION_LOGS (vlogID);
          --       Переименовываем файл в новой папке   
          vlogID := INSERT_FILE_OPERATION_LOGS(temp_file_name, file_name_old, ID_RENAME, copy_to_path_new, copy_to_path_new, FILE_TYPE_ID);
  
          h := PKG_TRF_FILEAPI.renameTo(copy_to_path_new||temp_file_name, copy_to_path_new||file_name_old );
   
          --UTL_FILE.FRENAME (DIR_FILES_NEW, temp_file_name, DIR_FILES_NEW, file_name_old, TRUE);
          
          if (FILE_TYPE_ID = 0) then  
            insert
              into PAYMENTS_FILES (file_name)
              values (file_name_old);
            commit;
          elsif (FILE_TYPE_ID = 1) then  
            insert
              into VIRT_ACCOUNT_FILES (file_name)
              values (file_name_old);
            commit;
          end if;
            
          UPDATE_FILE_OPERATION_LOGS (vlogID);
            
          --        Удаляем файл на FTP
          vlogID := INSERT_FILE_OPERATION_LOGS(file_name_old, '', ID_DELETE, FTP_ADDRESS ||'/'||pFolderName, '', FILE_TYPE_ID);

          FTP_PKG.delete(p_conn => l_conn,
               p_file => full_file_path);
               
          UPDATE_FILE_OPERATION_LOGS (vlogID);
          
        exception
          when Others then
           ROLLBACK;
           if vlogID is not null then
              UPDATE_FILE_OPERATION_LOGS (vlogID, SQLERRM);  
            end if;
              
        end;
            
        end if;
      END LOOP;
    END IF;
  end;
    
   
BEGIN

  FTP_ADDRESS := NULL;
  SELECT FTP.FTP_ADDRESS, FTP.PORT, FTP.LOGIN, FTP.PASSWORD INTO FTP_ADDRESS, FTP_PORT, FTP_LOGIN, FTP_PASSWORD
  FROM FTP_SETTINGS FTP
    WHERE UPPER(FTP.FTP_LOCAL_NAME) = UPPER(cFTP_LOCAL_NAME) AND FTP.STATUS = 1; 
    
  IF FTP_ADDRESS IS NOT NULL THEN
    l_conn := FTP_PKG.login(FTP_ADDRESS, FTP_PORT, FTP_LOGIN, FTP_PASSWORD);
      
    GET_FILE_FROM_FOLDER (cFTP_DIRECTORY_PATH||FILE_PATH, l_conn);
      
    FTP_PKG.logout(l_conn);
  END IF;
    
END;
/
