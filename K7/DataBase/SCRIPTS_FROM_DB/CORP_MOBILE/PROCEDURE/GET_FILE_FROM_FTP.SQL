
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."GET_FILE_FROM_FTP" AS
--
--Version =2
--
--v.2 Афросин 16.12.2014 Добавил обработку ошибок при работе с файлами
--v.1 Афросин 11.12.2014 Добавил функцию получения файлов с FTP
--
  GZ_FILE_EXT CONSTANT VARCHAR2(4) := '.gz';
  DBF_FILE_EXT CONSTANT VARCHAR2(4) := '.dbf';

--  GZ_FILE_EXT CONSTANT VARCHAR2(4) := '.txt';
--  DBF_FILE_EXT CONSTANT VARCHAR2(4) := '.txt';

  FTP_DIRECTORY_PATH CONSTANT VARCHAR2(25) := '/BEELINE/BILLING/';
  
  FTP_POSTPAID_PATH CONSTANT VARCHAR2(8) := 'POSTPAID';
  
  FTP_COLLECTOR_PATH CONSTANT VARCHAR2(9) := 'COLLECTOR';
  
  FTP_LOCAL_NAME CONSTANT VARCHAR2(15) := 'HOT_BILLING_FTP';
 
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
  
  
  FUNCTION INSERT_FILE_OPERATION_LOGS (pFILE_NAME in varchar2, pFILE_NAME_NEW in varchar2, pFILE_OPERATION_TYPE_ID in integer, pFROM_PATH in varchar2, pTO_PATH in varchar2)
  RETURN INTEGER as
    RES INTEGER;
  begin
    INSERT INTO FILE_OPERATION_LOGS (FILE_NAME, FILE_NAME_NEW, FILE_OPERATION_TYPE_ID, FROM_PATH, TO_PATH)
    VALUES
    (pFILE_NAME, pFILE_NAME_NEW, pFILE_OPERATION_TYPE_ID, pFROM_PATH, pTO_PATH) RETURNING FILE_OPERATION_LOG_ID INTO RES;
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
    
    lID := INSERT_FILE_OPERATION_LOGS(pFILE_NAME, pFILE_NAME_NEW, ID_COPY, FTP_ADDRESS ||'/'||pFolderName, pCopy_to_path);
        
    FTP_PKG.binary(p_conn => v_conn);
       
    FTP_PKG.get(p_conn  => v_conn,
            p_from_file => pfull_file_path,
            p_to_dir    => pDirectoryNAME,
            p_to_file   => pFILE_NAME);
            
    UPDATE_FILE_OPERATION_LOGS (lID);
  end;
  
  procedure GET_FILE_FROM_FOLDER (pFolderName varchar2, pl_conn UTL_TCP.connection) IS
  v_conn  UTL_TCP.connection;
  l_list  FTP_PKG.t_string_table;
  full_file_path varchar2(200);
  vlogID Integer;
  h Number;
  temp_file_name varchar2(200);
  file_name_old varchar2(200);
  begin
     v_conn := pl_conn;
     FTP_PKG.nlst(p_conn   => v_conn,
           p_dir   => pFolderName,
           p_list  => l_list);
  
  
    IF l_list.COUNT > 0 THEN
    
      select DIRECTORY_PATH into copy_to_path from dba_directories
      where DIRECTORY_NAME = 'DBF_FILES_COPY_DBF';
      
      select DIRECTORY_PATH into copy_to_path_new from dba_directories
      where DIRECTORY_NAME = 'DBF_FILES_NEW_DBF';
      
      FOR i IN l_list.first .. l_list.last LOOP
        IF    ( REGEXP_LIKE (UPPER(l_list (i)), UPPER(GZ_FILE_EXT), 'i') OR REGEXP_LIKE (UPPER(l_list (i)), UPPER(DBF_FILE_EXT), 'i')) 
           AND NOT (REGEXP_LIKE (UPPER(l_list (i)), UPPER(GZ_FILE_EXT) ||'.', 'i')) AND NOT (REGEXP_LIKE (UPPER(l_list (i)), UPPER(DBF_FILE_EXT) ||'.', 'i'))  then
          
          begin
          full_file_path := pFolderName||'/'|| l_list(i);
          
          temp_file_name := l_list(i) ||'.tmp';
          
          file_name_old :=  l_list(i);
          
--        копируем с FTP  
          GET_FILE (file_name_old, file_name_old, 'DBF_FILES_COPY_DBF', Copy_to_path, l_conn, full_file_path, pFolderName);
          --GET_FILE (l_list(i), 'DBF_FILES_NEW_DBF', copy_to_path_new, l_conn, full_file_path, pFolderName);
          
--        Копируем в папку 'DBF_FILES_NEW_DBF' 
          vlogID := INSERT_FILE_OPERATION_LOGS(file_name_old, temp_file_name, ID_COPY, Copy_to_path, copy_to_path_new);
          h := PKG_TRF_FILEAPI.COPY(Copy_to_path||file_name_old, copy_to_path_new||temp_file_name );
          UPDATE_FILE_OPERATION_LOGS (vlogID);
          
--       Переименовываем файл в 'DBF_FILES_NEW_DBF'   
          vlogID := INSERT_FILE_OPERATION_LOGS(temp_file_name, file_name_old, ID_RENAME, copy_to_path_new, copy_to_path_new);
          h := PKG_TRF_FILEAPI.renameTo(copy_to_path_new||temp_file_name, copy_to_path_new||file_name_old );
          UPDATE_FILE_OPERATION_LOGS (vlogID);
          
--        Удаляем файл на FTP
          vlogID := INSERT_FILE_OPERATION_LOGS(file_name_old, '', ID_DELETE, FTP_ADDRESS ||'/'||pFolderName, '');

          FTP_PKG.delete(p_conn => l_conn,
               p_file => full_file_path);
          UPDATE_FILE_OPERATION_LOGS (vlogID);
          exception
            when Others then
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
    WHERE UPPER(FTP.FTP_LOCAL_NAME) = UPPER(FTP_LOCAL_NAME) AND FTP.STATUS = 1; 
  
  IF FTP_ADDRESS IS NOT NULL THEN
    l_conn := FTP_PKG.login(FTP_ADDRESS, FTP_PORT, FTP_LOGIN, FTP_PASSWORD);
    
    GET_FILE_FROM_FOLDER (FTP_DIRECTORY_PATH || FTP_POSTPAID_PATH, l_conn);
    GET_FILE_FROM_FOLDER (FTP_DIRECTORY_PATH || FTP_COLLECTOR_PATH, l_conn);
   
    
    FTP_PKG.logout(l_conn);
  END IF;
  
END;