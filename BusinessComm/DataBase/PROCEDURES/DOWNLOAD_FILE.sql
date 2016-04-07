create or replace procedure DOWNLOAD_FILE
(
pFILE_BODY  out blob,
paccount_id in Integer,  
pyear_month in integer,
pFILE_NAME  in varchar2
) 
is
begin
  insert into  DB_LOADER_BILL_LOAD_LOG(log_bill_id,  account_id,  year_month,  file_body, FILE_NAME, LOAD_RESULT)  
        values  (S_DB_LOADER_BILL_LOAD_LOG.Nextval,   paccount_id, pyear_month, empty_blob(), pFILE_NAME, 1) returning file_body into  pfile_body;
end;

GRANT EXECUTE ON DOWNLOAD_FILE TO BUSINESS_COMM_ROLE;