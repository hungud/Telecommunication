
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."FREE_CONTRACT_NUMBER" (pCONTRACT_NUM INTEGER)  IS 
--#Version=1 
begin 
  AUTO_NUMERATION2.FREE_SEQUENCE_VALUE('CONTRACT_NUM', pCONTRACT_NUM); 
end;