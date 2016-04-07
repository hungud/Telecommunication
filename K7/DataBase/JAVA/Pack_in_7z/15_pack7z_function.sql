CREATE OR REPLACE FUNCTION pack7z
  (  inFile in varchar2,
     outFile in varchar2
  )
RETURN VARCHAR2
AS LANGUAGE JAVA
NAME 'Java7za.unpack7z ( java.lang.String, 
                       java.lang.String )
return java.lang.String';
