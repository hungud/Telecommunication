
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."BLOB_UNZIP" 
  (  zipFile in varchar2,
     outputFolder in varchar2
  )
RETURN VARCHAR2
AS LANGUAGE JAVA
NAME 'JavaAppZipUse.unFileZipIt( java.lang.String ,
                         java.lang.String
                       )
return java.lang.String';