
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_SITE_PHONE_DETAIL" (pLOADING_YEAR  IN INTEGER,
                                                 pLOADING_MONTH IN INTEGER,
                                                 pPHONE_NUMBER  IN VARCHAR2)
  RETURN CLOB IS
  --
  cACTION_PREFIX CONSTANT VARCHAR2(50 CHAR) := 'urn:SiteRobotSOAP-ISiteRobot#';
  CURSOR C IS
    SELECT distinct ACCOUNTS.LOGIN
      FROM DB_LOADER_PHONE_STAT, ACCOUNTS
     WHERE --DB_LOADER_PHONE_STAT.YEAR_MONTH = pYEAR*100 + pMONTH
     DB_LOADER_PHONE_STAT.PHONE_NUMBER = pPHONE_NUMBER
     AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_PHONE_STAT.ACCOUNT_ID;
  --
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'getSitePhoneDetail';
  --
  OL_REQ       SOAP_API.T_REQUEST;
  OL_RESP      SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
  res          clob;
  new_res      clob;
BEGIN
  for rec in c loop
    IF rec.login IS NOT NULL THEN
      vSERVICE_URL := 'http://localhost:7988/soap/ISiteRobot';
      -- we initilize a new request
      OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME,
                                     'xmlns="' || vSERVICE_URL || '"');
      -- we started to add parameters
      SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', rec.login);
      SOAP_API.ADD_PARAMETER(OL_REQ,
                             'loadingYear',
                             'xs:int',
                             pLOADING_YEAR);
      SOAP_API.ADD_PARAMETER(OL_REQ,
                             'loadingMonth',
                             'xs:int',
                             pLOADING_MONTH);
      SOAP_API.ADD_PARAMETER(OL_REQ,
                             'phoneNumber',
                             'xs:string',
                             pPHONE_NUMBER);
      --
      -- we call the web service
      ol_resp := soap_api.invoke(ol_req,
                                 vSERVICE_URL,
                                 cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
      -- we get back the results
      new_res := soap_api.get_return_value(ol_resp, 'return', 'xmlns:NS1');
    
      if res is null then
        res := new_res;
      else
        if new_res is not null then
          dbms_lob.APPEND(res, new_res);
        end if;
      end if;
    END IF;
  end loop;
  close c;
  return res;
END GET_SITE_PHONE_DETAIL;
