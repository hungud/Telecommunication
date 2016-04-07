
  CREATE OR REPLACE FUNCTION "SIM_TRADE"."SIMPLE" (login string,pass string)
return string as
external library simple_dll
parameters(login string,pass string)
name "get_token"
language c;
