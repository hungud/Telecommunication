
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."LOAD_TEXT_FILE_AS_CLOB" (
  pFILE_NAME IN VARCHAR2
  ) IS
  L_CLOB CLOB;
  L_BFILE BFILE;
  dir_name varchar2(300 char);
  L_VARN NUMBER;
    l_soffset NUMBER := 1;
    l_doffset NUMBER := 1;
    l_lang    NUMBER := 0;
    l_code    NUMBER;
BEGIN
  dir_name:='XML_BILL_FILES';
 -- SELECT CLB INTO L_CLOB FROM TEMP9 WHERE STR2=pFILE_NAME;
 INSERT INTO TEMP9( STR2, CLB ) 
  VALUES( pFILE_NAME, EMPTY_CLOB() )
  RETURNING CLB INTO l_clob;
  L_BFILE := BFILENAME( DIR_NAME, pFILE_NAME );
 -- SELECT EMPTY_CLOB() INTO L_CLOB FROM DUAL;-- :=EMPTY_CLOB();
  DBMS_LOB.OPEN( L_BFILE ,DBMS_LOB.LOB_READONLY);
  --DBMS_LOB.LOADFROMFILE( L_CLOB, L_BFILE,DBMS_LOB.GETLENGTH( L_BFILE ), l_soffset, l_doffset );
  l_soffset:=1; 
  l_code:=nls_charset_id('CL8MSWIN1251');
--  l_code:=nls_charset_id('WE8MSWIN1252');
  DBMS_LOB.LOADCLOBFROMFILE( L_CLOB, L_BFILE,DBMS_LOB.LOBMAXSIZE, l_soffset, l_soffset,l_code,l_lang,L_VARN);
  DBMS_LOB.CLOSE( L_BFILE );
/*  dest_offset IN            INTEGER := 1,
                         src_offset  IN            INTEGER := 1*/ --'CL8MSWIN1251'
  /*UPDATE TEMP9
    SET CLB = L_CLOB
    WHERE STR2=pFILE_NAME;*/
--  insert into CAPTCHA_IMAGE(IMAGE_BLOB, FILE_NAME)
    --values(L_BLOB, pFILE_NAME);
  commit;
END; 