CREATE OR REPLACE PROCEDURE LOAD_XML_FILE(
  pFILE_NAME IN VARCHAR2
  ) IS
  L_cLOB cLOB;
  L_BFILE BFILE;
  dir_name varchar2(300 char);
  vDest Integer:=1;
  vSrcs Integer:=1;
  vLang Integer:=Dbms_Lob.Default_Lang_Ctx;
  vWars Number;
  vLang2 Integer:=NLS_CHARSET_ID('CL8MSWIN1251'); 
  vCSid integer:=NLS_CHARSET_ID('CL8MSWIN1251');
BEGIN
  dir_name:='XML_BILL_FILES';
--pFILE_NAME:='bl.4879472080000000010002010820130100590004YCD00120.20130831.output.xml';
    INSERT INTO temp9(str1,str2, clb)
      VALUES('1', pFILE_NAME, EMPTY_CLOB()) RETURNING clb INTO L_cLOB;
    L_BFILE := BFILENAME( DIR_NAME, pFILE_NAME );
    DBMS_LOB.FILEOPEN( L_BFILE );
  --  DBMS_LOB.LOADFROMFILE ( L_BLOB, L_BFILE,DBMS_LOB.GETLENGTH( L_BFILE ) , 1, );
    --Dbms_Lob.LoadClobFromFile(L_BLOB,L_BFILE,Dbms_Lob.GetLength(L_BFILE),vDest, vSrcs,Dbms_Lob.Default_Csid, Dbms_Lob.c 'windows-1251' ,vWars );
    Dbms_Lob.LoadClobFromFile(L_cLOB,L_BFILE,Dbms_Lob.GetLength(L_BFILE),vDest, vSrcs, vCSid, vLang2 ,vWars );
    --Dbms_Lob.LoadClobFromFile(L_BLOB,L_BFILE,Dbms_Lob.lobmaxsize ,vDest, vSrcs, vCSid, vLang2 ,vWars );
    DBMS_LOB.FILECLOSE( L_BFILE );
  commit;
END;