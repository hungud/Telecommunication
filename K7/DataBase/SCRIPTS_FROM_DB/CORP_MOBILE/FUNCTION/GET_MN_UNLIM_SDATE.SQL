
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_MN_UNLIM_SDATE" (
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN date IS
--#Version=1
  vRESULT date;
BEGIN
SELECT
  nvl(max(DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE),to_date('31.12.1999','dd.mm.yyyy'))
into vRESULT
FROM
  DB_LOADER_ACCOUNT_PHONE_OPTS
WHERE
  DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER=pPHONE_NUMBER
  AND DB_LOADER_ACCOUNT_PHONE_OPTS.YEAR_MONTH = (
    SELECT MAX(YEAR_MONTH)
    FROM DB_LOADER_ACCOUNT_PHONE_OPTS
    WHERE DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER=pPHONE_NUMBER)
  and DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE='MN_UNLIMC'
  and nvl(DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE,sysdate+1)>sysdate;
return vRESULT;
exception
  when others then return to_date('31.12.1999','dd.mm.yyyy');
END;
