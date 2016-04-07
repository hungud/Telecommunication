
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."ADD_DB_LOADER_PHONE_STAT_UPD" ( 
  pYEAR                     IN NUMBER,                     
  pMONTH                    IN NUMBER, 
  pLOGIN                    IN VARCHAR2, 
  pPHONE_NUMBER             IN VARCHAR2 
  ) IS 
-- 
--#Version=1 
-- 
  vYEAR_MONTH BINARY_INTEGER; 
  vACCOUNT_ID NUMBER; 
  CURSOR C_FIND IS 
    SELECT ddd.ROWID, 
      ddd.* 
    FROM DB_LOADER_PHONE_STAT_update ddd 
    WHERE ddd.year=pYEAR 
          AND DDD.MONTH=pMONTH 
          AND ddd.PHONE_NUMBER=pPHONE_NUMBER 
          and ddd.login=pLOGIN; 
  C_REC C_FIND%ROWTYPE; 
BEGIN 
  OPEN C_FIND; 
  FETCH C_FIND INTO C_REC; 
  IF C_FIND%FOUND THEN 
    null; 
  ELSE 
    insert into DB_LOADER_PHONE_STAT_update values(pYEAR,pPHONE_NUMBER,null,pMONTH,pLOGIN); 
    commit; 
  END IF; 
  CLOSE C_FIND; 
END;