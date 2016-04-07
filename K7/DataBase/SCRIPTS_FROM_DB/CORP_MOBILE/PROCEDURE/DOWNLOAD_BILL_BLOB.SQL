
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."DOWNLOAD_BILL_BLOB" 
(
  sFILENAME       in varchar2,
  ssMONTH        in varchar2,
  ssLOGIN       in varchar2,
  bDATA           out blob
)
as
--  lBlob           blob;
begin
  insert into BILL_BLOB(FILENAME,DATA,sMONTH,sLOGIN,state) values(sFILENAME,empty_blob(),ssMONTH,ssLOGIN,null) returning DATA into  bDATA;
--  commit;
 --  SELECT   DATA into lBlob FROM BILL_BLOB where FILENAME=sFILENAME;
 -- update BILL_BLOB set DATA=bDATA where FILENAME=sFILENAME;
  --dbms_lob.writeappend(lBlob,dbms_lob.getlength(bDATA),bDATA);
--  update BILL_BLOB set DATA=lBlob where FILENAME=sFILENAME;
--  commit;
end;
