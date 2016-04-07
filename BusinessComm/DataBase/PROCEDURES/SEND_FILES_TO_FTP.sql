CREATE OR REPLACE PROCEDURE SEND_FILES_TO_FTP
--Version =1
--
--v.1 Кочнев  01.12.2015 Создал процедуру по заданию #3752
-- Сделать отправку файла dbf из каталога DIR_BILL_FOR_1C (каталог на сервере оракла) на ftp сервер 136.243.5.113 в /1C/TO_1C

 (
  FILE_EXT  VARCHAR2, -- расширение файла, например - '.dbf'
  PATH_TO VARCHAR2,  -- Путь на FTP сервере - должен существовать
  PATH_FROM VARCHAR2, -- название переменной в таблице - constant- фактически это  директория в Оракл
  FILE_TYPE_ID Integer -- для PAYMENTS - 0, для VIRT_ACCOUNT - 1
  )
 AS
 List_Files_From_Path varchar2(4000); -- Cписок файлов,по физическому пути директории Оракл 
 From_Dir             varchar2(150);  -- Директория Оракл
 from_path            varchar2 (200); -- физический путь директории Оракл
 to_path              varchar2 (200); -- физический путь директории Оракл для backup
 pos                  integer;        -- позиция разделителя в cписке файлов
 pos_ext              integer;        -- позиция разделителя расширения файла 
 file_name            varchar2(50);   -- файл из списка
 file_name_predv      varchar2(50);   -- предварительное имя файла из списка
 ext_f                varchar2(50);   -- фактическое расширение у файла из списка

 FTP_ADDRESS          VARCHAR2(20);
 FTP_PORT             VARCHAR2(10);
 FTP_LOGIN            VARCHAR2(20);
 FTP_PASSWORD         VARCHAR2(20);
 cFTP_DIRECTORY_PATH CONSTANT VARCHAR2(10) := '/';
 cFTP_LOCAL_NAME     CONSTANT VARCHAR2(15) := 'LOCAL_FTP';
 ID_COPY             CONSTANT INTEGER      := 1;
 ID_DELETE           CONSTANT INTEGER      := 3;
 ID_RENAME           CONSTANT INTEGER      := 20;

 l_conn               UTL_TCP.connection;
 
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

 procedure COPY_BACKUP(pFILE_NAME in varchar2, pFromDir in varchar2, pTo_Dir in varchar2) 
 is
  h         integer;
  lID       integer;
  file_from VARCHAR2(124);
  file_to   VARCHAR2(124);
  cBACKUP_EXT CONSTANT VARCHAR2(4) := '.OLD';
 begin
   file_from := pFromDir||pFILE_NAME;
   file_to := pTo_Dir||pFILE_NAME||cBACKUP_EXT;
   
   lID := INSERT_FILE_OPERATION_LOGS(pFILE_NAME, pFILE_NAME||cBACKUP_EXT, ID_RENAME, pFromDir, pTo_Dir, FILE_TYPE_ID);
   h := PKG_TRF_FILEAPI.COPY(file_from, file_to);
   UPDATE_FILE_OPERATION_LOGS (lID);
 end;  
   
 procedure DELETE_FILE(pFILE_NAME in varchar2, pFromDir in varchar2) 
 is
  h   integer;
  lID integer;
  file_del VARCHAR2(124);
 begin
   lID := INSERT_FILE_OPERATION_LOGS(pFILE_NAME, '', ID_DELETE, pFromDir, '', FILE_TYPE_ID);
   file_del := pFromDir||pFILE_NAME;
   h := PKG_TRF_FILEAPI.delete(file_del);
   UPDATE_FILE_OPERATION_LOGS (lID);
 end;  

 procedure PUT_FILE(pl_conn in  UTL_TCP.connection,  pFILE_NAME in varchar2, pFromDir in varchar2, pPATH_TO in varchar2,  pFILE_NAME_NEW in varchar2 ) 
 is
  lID     Integer;
  v_conn  UTL_TCP.connection;
  begin
    v_conn := pl_conn;
    lID := INSERT_FILE_OPERATION_LOGS(pFILE_NAME, pFILE_NAME_NEW, ID_COPY, from_path, FTP_ADDRESS||cFTP_DIRECTORY_PATH||PATH_TO, FILE_TYPE_ID);
          
    FTP_PKG.binary(p_conn => v_conn);
         
    FTP_PKG.put(p_conn       => v_conn,
                p_from_dir   => pFromDir,
                p_from_file  => pFILE_NAME,
                p_to_file    => pPATH_TO||cFTP_DIRECTORY_PATH||pFILE_NAME);
              
    UPDATE_FILE_OPERATION_LOGS (lID);
  end;
  
begin
  
  if length(FILE_EXT) <> 4 then
   return;  
  end if; 
  
  From_Dir := MS_CONSTANTS.GET_CONSTANT_VALUE(PATH_FROM);
  
  select DIRECTORY_PATH into from_path 
    from dba_directories
   where DIRECTORY_NAME = From_Dir;

  select DIRECTORY_PATH into To_path 
    from dba_directories
   where DIRECTORY_NAME = From_Dir||'_BACKUP';

  FTP_ADDRESS := NULL;

  SELECT FTP.FTP_ADDRESS, FTP.PORT, FTP.LOGIN, FTP.PASSWORD INTO FTP_ADDRESS, FTP_PORT, FTP_LOGIN, FTP_PASSWORD
    FROM FTP_SETTINGS FTP
   WHERE UPPER(FTP.FTP_LOCAL_NAME) = UPPER(cFTP_LOCAL_NAME) 
     AND FTP.STATUS = 1; 
   
  IF FTP_ADDRESS IS NOT NULL THEN
    pos := PKG_TRF_FILEAPI.getFileCount(from_path); -- количество файлов всех типов в директории Оракл

    if pos > 0 then
      file_name_predv := FILE_EXT;
       
      List_Files_From_Path := PKG_TRF_FILEAPI.list(from_path); -- список файлов всех типов в директории Оракл
      
      l_conn := FTP_PKG.login(FTP_ADDRESS, FTP_PORT, FTP_LOGIN, FTP_PASSWORD);
      
      while (pos > 0) AND (file_name_predv IS NOT NULL) loop
        pos := instr(List_Files_From_Path,',',1);
        file_name_predv := substr(List_Files_From_Path,1,pos-1);
        List_Files_From_Path := substr(List_Files_From_Path, pos+1); 
        if pos > 0 then
          file_name := file_name_predv;
        else
          file_name := List_Files_From_Path;
        end if;  
        IF (file_name IS NOT NULL) then
          --- используем только файлы со своим расширением
          pos_ext := instr(file_name,'.',1);
          ext_f := substr(file_name, pos_ext);
          if UPPER(FILE_EXT) = upper(ext_f) then
          
            PUT_FILE(l_conn,  file_name, From_Dir, PATH_TO, file_name);
          
            COPY_BACKUP(file_name, from_path, To_path); 
          
            DELETE_FILE(file_name, from_path); 
            
          end if;  
        end if;
      end loop;
      
      FTP_PKG.logout(l_conn); 
      
    end if;
  End if;
end;
/
 
 