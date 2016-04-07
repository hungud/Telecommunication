
  CREATE OR REPLACE FUNCTION "SIM_TRADE"."PACK7Z" 
  (  inFile in varchar2,
     outFile in varchar2
  )
RETURN VARCHAR2
AS LANGUAGE JAVA
NAME 'Java7za.unpack7z ( java.lang.String, 
                       java.lang.String )
return java.lang.String';