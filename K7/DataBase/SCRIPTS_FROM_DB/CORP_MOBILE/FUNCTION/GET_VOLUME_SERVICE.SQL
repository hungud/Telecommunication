
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_VOLUME_SERVICE" (
  pPHONE_NUMBER IN VARCHAR2,
  vYEAR_MONTH in integer,
  vSERVICE_VOLUME_ID in number
  ) RETURN VARCHAR2 IS
BEGIN
return db_loader_pckg.GET_VOLUME_SERVICE(pPHONE_NUMBER,vYEAR_MONTH,vSERVICE_VOLUME_ID);
END;
