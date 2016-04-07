
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_PHONE_DETAIL_3" (
    pYEAR IN INTEGER,
    pMONTH IN INTEGER,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN CLOB IS
--
CURSOR C IS
  SELECT distinct ACCOUNTS.LOGIN
    FROM 
      DB_LOADER_PHONE_STAT, 
      ACCOUNTS
    WHERE --DB_LOADER_PHONE_STAT.YEAR_MONTH = pYEAR*100 + pMONTH
      DB_LOADER_PHONE_STAT.PHONE_NUMBER = pPHONE_NUMBER
      AND ACCOUNTS.ACCOUNT_ID=DB_LOADER_PHONE_STAT.ACCOUNT_ID;
  --
  vLOGIN ACCOUNTS.LOGIN%TYPE;
  res clob;
  new_res clob;
BEGIN
  --dbms_lob.createtemporary(res, TRUE);
  for rec in c 
  loop
   IF rec.login IS NOT NULL THEN
     new_res:=LOADER_CALL_PCKG.GET_PHONE_DETAIL(rec.login, pYEAR, pMONTH, pPHONE_NUMBER);
     if res is null then
       res := new_res;
     else
     if new_res is not null then
      dbms_lob.APPEND(res,new_res );
      end if;
      end if;
    END IF;
  end loop;
  return res;
END; 