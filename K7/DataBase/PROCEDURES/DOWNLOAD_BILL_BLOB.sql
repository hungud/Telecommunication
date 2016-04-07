--#if GetVersion("DOWNLOAD_BILL_BLOB") < 1 then 
create or replace procedure DOWNLOAD_BILL_BLOB
(
  sFILENAME       in varchar2,
  ssMONTH        in varchar2,
  ssLOGIN       in varchar2,
  bDATA           out blob
)
as
--#Version=1
--Процедура загрузки файла с клиентской части в BLOB в БД
begin
  insert into BILL_BLOB(FILENAME,DATA,sMONTH,sLOGIN,state) values(sFILENAME,empty_blob(),ssMONTH,ssLOGIN,null) returning DATA into  bDATA;
end;
--GRANT EXECUTE ON DOWNLOAD_BILL_BLOB TO CORP_MOBILE_ROLE;
--GRANT EXECUTE ON DOWNLOAD_BILL_BLOB TO CORP_MOBILE_ROLE_RO;
--#end if
/
