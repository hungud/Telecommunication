
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GNUHASH_SHA512" (string IN VARCHAR2) RETURN VARCHAR2 AS LANGUAGE JAVA NAME 'SHA512.calcHash(java.lang.String) return java.lang.String';
