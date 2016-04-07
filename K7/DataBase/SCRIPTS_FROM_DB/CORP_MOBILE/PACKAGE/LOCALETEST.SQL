
  CREATE OR REPLACE PACKAGE "CORP_MOBILE"."LOCALETEST" AS

PROCEDURE setDefaultLocale
AS LANGUAGE JAVA
NAME 'localetest.setDefaultLocale()';
END localetest;

