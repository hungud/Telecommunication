
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."BLOB_UNTAR" 
  (  tarFile in varchar2,
     resFile in varchar2,
     destFolder in varchar2
  )
RETURN VARCHAR2
AS LANGUAGE JAVA
NAME 'myuntar.funtar ( java.lang.String, 
                       java.lang.String, 
                       java.lang.String )
return java.lang.String';