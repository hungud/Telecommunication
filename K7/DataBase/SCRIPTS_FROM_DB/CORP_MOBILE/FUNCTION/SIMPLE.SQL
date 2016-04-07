
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."SIMPLE" (login varchar2,pass varchar2)
return varchar2 as
external library simple_dll
parameters(login string
          ,pass string)
name "get_token"
language c;
