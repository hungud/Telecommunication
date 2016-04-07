CREATE OR REPLACE PACKAGE LOADER_CALL_PCKG IS
--#Version=24
--
--v.24 ��������.  01.12.2015 ������� ������� SEND_SMS_MULTI. ���� �������� ������, �� ������ ���� ����� ������.
--v23. ��������. 28.10.2015 ��� ����������� ��������� ������� �������� �� ������� "Error! ���������� ���������!"
--v22. ��������. 20.10.2015 �������� SEND_SMS_MULTI. ���� �������� �� ������ �� ������, �� ���������� ����� ��������� ���-������.
--v21. �������. 24.03.2015 ������� �������� USE_ONLY_SMS_PROV � SEND_SMS_MULTI, ����������� �� ��,
--20. �������. ��������� ������� ��������� GET_PHONE_DETAIL. �������� ����� �������� ��� ������
--19. ��������. ��������� ������� ��� �������� ������� � ������ �����.
--18. �������. ������� ��������� �������.
-- 17. ��������. ��������� ������� ��� �������� ������������ ����� � ����� � ��.
-- 16. ��������. ��������� ������� ��� �������� ������� � ����� � ��.
-- 16  ���������� �.�. 26.10.2012 � ������� GET_SERVICE_URL - �������� � ���������� �������� ��������
-- 15. �������. ��������� ����������� �� ��������� ��� ����������.
-- 14. �������. Add LOAD_BILL_DETAILS
-- 11. �������. ������ �������� �� ������.
-- 9. �������. �������� GET_PHONE_STATUS, SET_PHONE_OPTION_ON, SET_PHONE_OPTION_OFF, SEND_PAID_SMS � "���-������"
-- 8. �������. ������� LOAD_REPORT_DATA
-- 5. ������. ������� ��������� ���������� � �� ��� LOCK_PHONE � UNLOCK_PHONE
-- 3. ������� ��������� LOCK_PHONE � UNLOCK_PHONE.
--
  FUNCTION LOAD_PHONES(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    bLOAD_TURNED_OPTION IN BOOLEAN
    ) RETURN VARCHAR2;
--
  FUNCTION LOAD_PAYMENTS(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2
    ) RETURN VARCHAR2;
--
  FUNCTION LOAD_PHONE_DETAIL(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pORGANIZATION_ID IN VARCHAR2,
    pPHONES IN DBMS_SQL.VARCHAR2_TABLE
    ) RETURN VARCHAR2;
--
  FUNCTION LOAD_PHONE_DETAIL_2(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pORGANIZATION_ID IN VARCHAR2,
    pPHONE_LIST_ARRAY IN DBMS_SQL.VARCHAR2_TABLE
    ) RETURN VARCHAR2;
--
  FUNCTION LOAD_PHONE_DETAIL_3(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pORGANIZATION_ID IN VARCHAR2,
    pTHREAD_COUNT IN INTEGER,
    pPHONE_LIST_ARRAY IN DBMS_SQL.VARCHAR2_TABLE
    ) RETURN VARCHAR2;
--
  FUNCTION LOAD_BILL(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pFORCE_SET_PERIOD IN BOOLEAN
    ) RETURN VARCHAR2;
--
  FUNCTION LOAD_BILL_DETAILS(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pFORCE_SET_PERIOD IN BOOLEAN
    ) RETURN VARCHAR2;
--
  FUNCTION GET_PHONE_DETAIL(
    pSITE_LOGIN IN VARCHAR2,
--    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
--    pLOADER_NAME IN VARCHAR2,
--    pDB_DATA_SOURCE IN VARCHAR2,
--    pDB_USER_NAME IN VARCHAR2,
--    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN CLOB;
--
  FUNCTION GET_PHONE_BILL_DETAIL(
    pSITE_LOGIN IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN CLOB;
--
  FUNCTION GET_SITE_PHONE_DETAIL(
    pSITE_LOGIN IN VARCHAR2,
--    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
--    pLOADER_NAME IN VARCHAR2,
--    pDB_DATA_SOURCE IN VARCHAR2,
--    pDB_USER_NAME IN VARCHAR2,
--    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN CLOB;
--
  FUNCTION LOCK_PHONE(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN VARCHAR2;
--
  FUNCTION UNLOCK_PHONE(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN VARCHAR2;
--
  FUNCTION SEND_SMS_MULTI(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pPROVIDER_NAME IN VARCHAR2,
    pPHONE_LIST_ARRAY IN DBMS_SQL.VARCHAR2_TABLE,
    pMAILING_NAME IN VARCHAR2,
    pSENDER_NAME IN VARCHAR2,
    pSMS_TEXT IN VARCHAR2,
    pUSE_ONLY_SMS_PROV IN INTEGER DEFAULT 0
    ) RETURN VARCHAR2;
--    
FUNCTION LOAD_REPORT_DATA(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2
    ) RETURN VARCHAR2;   
--    
FUNCTION READ_FIELD_DETAILS(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pFIELD_ID IN INTEGER
    ) RETURN VARCHAR2;
-- 
--�������� ������� - ������-��� - ������ ��������(FullCheck - ������ ������(false) ��� ��� ������������ �����(true))   
FUNCTION GET_PHONE_STATUS(
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2,
    pFULL_CHECK IN BOOLEAN
    ) RETURN VARCHAR2; 
-- 
--�������� ������� - ������-��� - ����������� �����   
FUNCTION SET_PHONE_OPTION_ON(
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2,
    pOPTION_NAME IN VARCHAR2
    ) RETURN VARCHAR2;  
--
--�������� ������� - ������-��� - ���������� �����    
FUNCTION SET_PHONE_OPTION_OFF(
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2,
    pOPTION_NAME IN VARCHAR2
    ) RETURN VARCHAR2;
--
-- �������� ������� ��� ����� ���-����������    
FUNCTION SEND_PAID_SMS(
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN VARCHAR2;              
--
FUNCTION GET_PHONE_BILLS(
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN VARCHAR2;
--
FUNCTION GET_PHONE_BILL_DETAILS(
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN VARCHAR2;
--
  FUNCTION CP_TRANSFERS(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pACCOUNTS_FROM IN VARCHAR2,
    pACCOUNTS_TO IN VARCHAR2,
    pTRANSFER_SUM IN VARCHAR2
    ) RETURN VARCHAR2;    
--    
  FUNCTION LOAD_PHONE_OPTIONS(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2    
    ) RETURN VARCHAR2;
--
  FUNCTION GET_ADD_DETAIL_COST(
    pSITE_LOGIN IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN VARCHAR2;
-- 
FUNCTION GET_PARTNER_BALANCE(
  pSITE_LOGIN IN VARCHAR2,
  pSITE_PASSWORD IN VARCHAR2,
  pLOADING_YEAR IN INTEGER,
  pLOADING_MONTH IN INTEGER,
  pLOADER_NAME IN VARCHAR2,
  pDB_DATA_SOURCE IN VARCHAR2,
  pDB_USER_NAME IN VARCHAR2,
  pDB_PASSWORD IN VARCHAR2,
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN VARCHAR2;
--     
FUNCTION GET_PARTNER_URL(
  pURL IN VARCHAR2
  ) RETURN CLOB;
--    
END LOADER_CALL_PCKG;

CREATE OR REPLACE PACKAGE BODY LOADER_CALL_PCKG IS
--
  --cSERVICE_URL CONSTANT VARCHAR2(50 CHAR) := 'http://localhost:7988/soap/ISiteRobot';
  --cSERVICE_URL CONSTANT VARCHAR2(50 CHAR) := 'http://localhost:8080/soap/ISiteRobot';
  cACTION_PREFIX CONSTANT VARCHAR2(50 CHAR) := 'urn:SiteRobotSOAP-ISiteRobot#';
--
  FUNCTION GET_SERVICE_URL(
    TYPE INTEGER
    ) RETURN VARCHAR2 IS
-- type ��� ��������� 1-99 - ������, 100-200 - �������.
-- ���������� �.�. 26.10.2012 �������� � ����������  
URL VARCHAR2(200 CHAR);
BEGIN
  BEGIN
    SELECT SERVICE_URL.URL INTO GET_SERVICE_URL.URL FROM SERVICE_URL WHERE TYPE_LOAD=TYPE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      URL:='http://localhost:7988/soap/ISiteRobot';
  END;  
  
  RETURN URL;        
END;    
--
  FUNCTION LOAD_PHONES(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    bLOAD_TURNED_OPTION IN BOOLEAN
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'LoadPhones2';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vBOOL_STR VARCHAR2(5 CHAR);
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(1);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'sitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingYear', 'xs:int', pLOADING_YEAR);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingMonth', 'xs:int', pLOADING_MONTH);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);
  IF bLOAD_TURNED_OPTION THEN
    vBOOL_STR := 'true';
  ELSE
    vBOOL_STR := 'false';
  END IF;
  SOAP_API.ADD_PARAMETER(OL_REQ, 'bLoadTurnedOption', 'xs:boolean', vBOOL_STR);
--                                
  -- we call the web service
  ol_resp := soap_api.invoke(ol_req, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN soap_api.get_return_value(ol_resp, 'return', 'xmlns:NS1');
--
  END LOAD_PHONES;
--
  FUNCTION LOAD_PAYMENTS(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'loadPayments';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(5);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'sitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingYear', 'xs:int', pLOADING_YEAR);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingMonth', 'xs:int', pLOADING_MONTH);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);
--                                
  -- we call the web service
  ol_resp := soap_api.invoke(ol_req, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN soap_api.get_return_value(ol_resp, 'return', 'xmlns:NS1');
--
  END LOAD_PAYMENTS;
--
FUNCTION LOAD_PHONE_DETAIL(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pORGANIZATION_ID IN VARCHAR2,
    pPHONES IN DBMS_SQL.VARCHAR2_TABLE
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'loadDetail';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(50);
  IF pPHONES.COUNT > 0 THEN
    -- we initilize a new request
    OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
    -- we started to add parameters
    SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'sitePassword', 'xs:string', pSITE_PASSWORD);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingYear', 'xs:int', pLOADING_YEAR);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingMonth', 'xs:int', pLOADING_MONTH);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'loaderName', 'xs:string', pLOADER_NAME);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'OrganizationID', 'xs:string', pORGANIZATION_ID);
    SOAP_API.ADD_PARAMETER_ARRAY(OL_REQ, 'phoneNumbers', 'xs:Array', pPHONES, 'string');
  --
    -- we call the web service
    OL_RESP := SOAP_API.INVOKE(OL_REQ, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
    -- we get back the results
    RETURN SOAP_API.GET_RETURN_VALUE(OL_RESP, 'return', 'xmlns:NS1');
  --
  ELSE
    RETURN NULL;
  END IF;
END LOAD_PHONE_DETAIL;
--
  FUNCTION LOAD_PHONE_DETAIL_2(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pORGANIZATION_ID IN VARCHAR2,
    pPHONE_LIST_ARRAY IN DBMS_SQL.VARCHAR2_TABLE
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'loadDetailArray';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(51);
  IF pPHONE_LIST_ARRAY.COUNT > 0 THEN
    -- we initilize a new request
    OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
    -- we started to add parameters
    SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'sitePassword', 'xs:string', pSITE_PASSWORD);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingYear', 'xs:int', pLOADING_YEAR);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingMonth', 'xs:int', pLOADING_MONTH);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'loaderName', 'xs:string', pLOADER_NAME);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'OrganizationID', 'xs:string', pORGANIZATION_ID);
    SOAP_API.ADD_PARAMETER_ARRAY(OL_REQ, 'phoneNumberListArray', 'xs:Array', pPHONE_LIST_ARRAY, 'string');
  --
    -- we call the web service
    OL_RESP := SOAP_API.INVOKE(OL_REQ, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
    -- we get back the results
    RETURN SOAP_API.GET_RETURN_VALUE(OL_RESP, 'return', 'xmlns:NS1');
  --
  ELSE
    RETURN NULL;
  END IF;
END LOAD_PHONE_DETAIL_2;
--
  FUNCTION LOAD_PHONE_DETAIL_3(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pORGANIZATION_ID IN VARCHAR2,
    pTHREAD_COUNT IN INTEGER,
    pPHONE_LIST_ARRAY IN DBMS_SQL.VARCHAR2_TABLE
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'loadDetailArray';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(52);
  IF pPHONE_LIST_ARRAY.COUNT > 0 THEN
    -- we initilize a new request
    OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
    -- we started to add parameters
    SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'sitePassword', 'xs:string', pSITE_PASSWORD);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingYear', 'xs:int', pLOADING_YEAR);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingMonth', 'xs:int', pLOADING_MONTH);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'loaderName', 'xs:string', pLOADER_NAME);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'OrganizationID', 'xs:string', pORGANIZATION_ID);
    SOAP_API.ADD_PARAMETER(OL_REQ, 'ThreadCount', 'xs:int', pTHREAD_COUNT);
    SOAP_API.ADD_PARAMETER_ARRAY(OL_REQ, 'phoneNumberListArray', 'xs:Array', pPHONE_LIST_ARRAY, 'string');
  --
    -- we call the web service
    OL_RESP := SOAP_API.INVOKE(OL_REQ, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
    -- we get back the results
    RETURN SOAP_API.GET_RETURN_VALUE(OL_RESP, 'return', 'xmlns:NS1');
  --
  ELSE
    RETURN NULL;
  END IF;
END LOAD_PHONE_DETAIL_3;
--
  FUNCTION LOAD_BILL(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pFORCE_SET_PERIOD IN BOOLEAN
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'loadBill';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vBOOL_STR VARCHAR2(5 CHAR);
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(10);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'sitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingYear', 'xs:int', pLOADING_YEAR);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingMonth', 'xs:int', pLOADING_MONTH);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);
  IF pFORCE_SET_PERIOD THEN
    vBOOL_STR := 'true';
  ELSE
    vBOOL_STR := 'false';
  END IF;
  SOAP_API.ADD_PARAMETER(OL_REQ, 'ForceSetPeriod', 'xs:boolean', vBOOL_STR);
--                                
  -- we call the web service
  ol_resp := soap_api.invoke(ol_req, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN soap_api.get_return_value(ol_resp, 'return', 'xmlns:NS1');
--
  END LOAD_BILL;
--
  FUNCTION LOAD_BILL_DETAILS(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pFORCE_SET_PERIOD IN BOOLEAN
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'LoadBillDetails';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vBOOL_STR VARCHAR2(5 CHAR);
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(11);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'sitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingYear', 'xs:int', pLOADING_YEAR);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingMonth', 'xs:int', pLOADING_MONTH);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);
  IF pFORCE_SET_PERIOD THEN
    vBOOL_STR := 'true';
  ELSE
    vBOOL_STR := 'false';
  END IF;
  SOAP_API.ADD_PARAMETER(OL_REQ, 'ForceSetPeriod', 'xs:boolean', vBOOL_STR);                              
  -- we call the web service
  ol_resp := soap_api.invoke(ol_req, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN soap_api.get_return_value(ol_resp, 'return', 'xmlns:NS1');
END LOAD_BILL_DETAILS;
--
  FUNCTION GET_PHONE_DETAIL(
    pSITE_LOGIN IN VARCHAR2,
--    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
--    pLOADER_NAME IN VARCHAR2,
--    pDB_DATA_SOURCE IN VARCHAR2,
--    pDB_USER_NAME IN VARCHAR2,
--    pDB_PASSWORD IN VARCHAR2
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN CLOB IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'getPhoneDetail';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
  FullFilePath varchar2(1000);
  exitFile Clob;
  AccountLogin varchar2(100);
BEGIN
  select directory_path into FullFilePath from dba_directories where DIRECTORY_NAME= 'CALLSMM';
    
    FullFilePath := FullFilePath ||pLOADING_YEAR ||'_';
    if length(to_char(pLOADING_MONTH)) = 1 then
        FullFilePath := FullFilePath || '0' ||to_char(pLOADING_MONTH);
    else
        FullFilePath := FullFilePath || to_char(pLOADING_MONTH);
    end if;
    
    select login into AccountLogin from accounts where account_id = GET_ACCOUNT_ID_BY_PHONE(pPHONE_NUMBER);
    
    FullFilePath := FullFilePath || '\' || AccountLogin || '\' ;--||pPHONE_NUMBER||'.txt';
        
--    dbms_output.put_line('FullFilePath = '||FullFilePath);
    
    exitFile := null;
    --exitFile := pkg_fileutil.fn_ReadCLOBfromFile(FullFilePath, pPHONE_NUMBER||'.txt');
     exitFile := pkg_fileutil.blob_to_clob(pkg_fileutil.fn_ReadBLOBfromFile(FullFilePath, pPHONE_NUMBER||'.txt'));
      
    Return exitFile;
/*  vSERVICE_URL:=GET_SERVICE_URL(15);

  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
--  SOAP_API.ADD_PARAMETER(OL_REQ, 'sitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingYear', 'xs:int', pLOADING_YEAR);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingMonth', 'xs:int', pLOADING_MONTH);
--  SOAP_API.ADD_PARAMETER(OL_REQ, 'loaderName', 'xs:string', pLOADER_NAME);
--  SOAP_API.ADD_PARAMETER(OL_REQ, 'dataSource', 'xs:string', pDB_DATA_SOURCE);
--  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
--  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'phoneNumber', 'xs:string', pPHONE_NUMBER);
--                                
  -- we call the web service
  ol_resp := soap_api.invoke(ol_req, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN soap_api.get_return_value(ol_resp, 'return', 'xmlns:NS1');
*/  

  END GET_PHONE_DETAIL;
--
FUNCTION GET_PHONE_BILL_DETAIL(
    pSITE_LOGIN IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN CLOB IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'getPhoneBillDetail';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(15);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingYear', 'xs:int', pLOADING_YEAR);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingMonth', 'xs:int', pLOADING_MONTH);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'phoneNumber', 'xs:string', pPHONE_NUMBER);
--                                
  -- we call the web service
  ol_resp := soap_api.invoke(ol_req, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN soap_api.get_return_value(ol_resp, 'return', 'xmlns:NS1');
--
  END GET_PHONE_BILL_DETAIL;  
--
  FUNCTION GET_SITE_PHONE_DETAIL(
    pSITE_LOGIN IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN CLOB IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'getSitePhoneDetail';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(15);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingYear', 'xs:int', pLOADING_YEAR);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingMonth', 'xs:int', pLOADING_MONTH);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'phoneNumber', 'xs:string', pPHONE_NUMBER);
--                                
  -- we call the web service
  ol_resp := soap_api.invoke(ol_req, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN soap_api.get_return_value(ol_resp, 'return', 'xmlns:NS1');
--
  END GET_SITE_PHONE_DETAIL;
--
  FUNCTION LOCK_PHONE(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'lockPhone';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(20);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'sitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'phoneNumber', 'xs:string', pPHONE_NUMBER);
--                                
  -- we call the web service
  ol_resp := soap_api.invoke(ol_req, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN soap_api.get_return_value(ol_resp, 'return', 'xmlns:NS1');
END LOCK_PHONE;
--
--
  FUNCTION UNLOCK_PHONE(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'unlockPhone';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(25);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'sitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'phoneNumber', 'xs:string', pPHONE_NUMBER);
--                                
  -- we call the web service
  ol_resp := soap_api.invoke(ol_req, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN soap_api.get_return_value(ol_resp, 'return', 'xmlns:NS1');
END UNLOCK_PHONE;
--
FUNCTION SEND_SMS_MULTI(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pPROVIDER_NAME IN VARCHAR2,
    pPHONE_LIST_ARRAY IN DBMS_SQL.VARCHAR2_TABLE,
    pMAILING_NAME IN VARCHAR2,
    pSENDER_NAME IN VARCHAR2,
    pSMS_TEXT IN VARCHAR2,
    pUSE_ONLY_SMS_PROV IN INTEGER DEFAULT 0
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'SendSmsMulti';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
  vPHONES varchar2(11);
  FIRST_PHONE integer;
  provv_id integer;
  vOperNoBe integer;
  vOperName varchar2(2000 CHAR);
BEGIN
  FIRST_PHONE:=pPHONE_LIST_ARRAY.FIRST;
  vPHONES:=pPHONE_LIST_ARRAY(FIRST_PHONE);
  --���� ���������� ������ ����� ��� ����������, �� �� ��������  ������ �� ������� SMS_SEND_PARAM_BY_ACCOUNT  
  --����� ���������� ���������� ���� �������� pUSE_ONLY_SMS_PROV = 1 ��� �� ������ �������� <> ������
  --��������� ���������. ���� ��� ����������� ��������� ���� ������, �� ���� ����� ����
  vOperNoBe := 0;
  begin
    vOperName := GET_OPERATOR_BY_PHONE(vPHONES);
    if (vOperName <> '������') and (vOperName not like '%Error! ���������� ���������!%') then
      vOperNoBe := 1;
    end if;
  exception
    when others then
      vOperNoBe := 0;   
  end;

  if ((nvl(pUSE_ONLY_SMS_PROV, -1) = 1) OR (vOperNoBe = 1)) then
    provv_id := 0;
  else 
    provv_id :=6; --������   
    /*begin
      select ssa.provider_id into provv_id 
        from SMS_SEND_PARAM_BY_ACCOUNT ssa
      where ssa.account_id=GET_ACCOUNT_ID_BY_PHONE(vPHONES);
    exception
      when others then
        provv_id :=0;
    end;*/
  end if;
    
  if provv_id=0 then
    IF pPROVIDER_NAME<>'SMSTraffic' THEN
      vSERVICE_URL:=GET_SERVICE_URL(30);
      -- we initilize a new request
      OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
      -- we started to add parameters
      SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
      SOAP_API.ADD_PARAMETER(OL_REQ, 'sitePassword', 'xs:string', pSITE_PASSWORD);
      SOAP_API.ADD_PARAMETER(OL_REQ, 'ProviderName', 'xs:string', pPROVIDER_NAME);
      SOAP_API.ADD_PARAMETER_ARRAY(OL_REQ, 'phoneNumberListArray', 'xs:Array', pPHONE_LIST_ARRAY, 'string');
      SOAP_API.ADD_PARAMETER(OL_REQ, 'MailingName', 'xs:string',pMAILING_NAME);
      SOAP_API.ADD_PARAMETER(OL_REQ, 'SenderName', 'xs:string', pSENDER_NAME);
      SOAP_API.ADD_PARAMETER(OL_REQ, 'SmsText', 'xs:string', pSMS_TEXT);   
    --                                
      -- we call the web service
      ol_resp := soap_api.invoke(ol_req, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
      -- we get back the results
      RETURN soap_api.get_return_value(ol_resp, 'return', 'xmlns:NS1');
    ELSE
      IF pPROVIDER_NAME='SMSTraffic' THEN
      RETURN SMS_PROVIDER_SMSTRAFFIC(pSITE_LOGIN, pSITE_PASSWORD, pPROVIDER_NAME, 
                                     pPHONE_LIST_ARRAY, pMAILING_NAME, pSENDER_NAME, pSMS_TEXT);
      END IF;                               
    END IF;  
  else
    sms_add_request(provv_id,vPHONES,pSMS_TEXT);
    Return null;
  end if;
END SEND_SMS_MULTI;
--
-- �������� ������ - ����� � �����������
  FUNCTION LOAD_REPORT_DATA(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'LoadLastPhonesStat';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(35);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'sitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingYear', 'xs:int', pLOADING_YEAR);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingMonth', 'xs:int', pLOADING_MONTH);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);    
  -- we call the web service
  OL_RESP := SOAP_API.INVOKE(OL_REQ, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN SOAP_API.GET_RETURN_VALUE(OL_RESP, 'return', 'xmlns:NS1');
END LOAD_REPORT_DATA;
--
-- �������� ������ - ����� � �����������
  FUNCTION READ_FIELD_DETAILS(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pFIELD_ID IN INTEGER
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'ReadFieldDetails';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(55);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'sitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingYear', 'xs:int', pLOADING_YEAR);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingMonth', 'xs:int', pLOADING_MONTH);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);  
  SOAP_API.ADD_PARAMETER(OL_REQ, 'FieldId', 'xs:int', pFIELD_ID);   
  -- we call the web service
  OL_RESP := SOAP_API.INVOKE(OL_REQ, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN SOAP_API.GET_RETURN_VALUE(OL_RESP, 'return', 'xmlns:NS1');
END READ_FIELD_DETAILS;
--
--�������� ������� - ������-��� - ������ ��������(FullCheck - ������ ������(false) ��� ��� ������������ �����(true))
  FUNCTION GET_PHONE_STATUS(
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2,
    pFULL_CHECK IN BOOLEAN
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'GetPhoneStatus';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vBOOL_STR VARCHAR2(5 CHAR);
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(100);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'SitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'LoaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);    
  SOAP_API.ADD_PARAMETER(OL_REQ, 'PhoneNumber', 'xs:string', pPHONE_NUMBER);    
  IF pFULL_CHECK THEN
    vBOOL_STR := 'true';
  ELSE
    vBOOL_STR := 'false';
  END IF;
  SOAP_API.ADD_PARAMETER(OL_REQ, 'FullCheck', 'xs:string', vBOOL_STR);    
  -- we call the web service
  OL_RESP := SOAP_API.INVOKE(OL_REQ, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN SOAP_API.GET_RETURN_VALUE(OL_RESP, 'return', 'xmlns:NS1');
END GET_PHONE_STATUS;
--
--�������� ������� - ������-��� - ����������� �����
  FUNCTION SET_PHONE_OPTION_ON(
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2,
    pOPTION_NAME IN VARCHAR2
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'SetPhoneOptionOn';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(105);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'SitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'LoaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);    
  SOAP_API.ADD_PARAMETER(OL_REQ, 'PhoneNumber', 'xs:string', pPHONE_NUMBER);    
  SOAP_API.ADD_PARAMETER(OL_REQ, 'OptionName', 'xs:string', pOPTION_NAME);    
  -- we call the web service
  OL_RESP := SOAP_API.INVOKE(OL_REQ, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN SOAP_API.GET_RETURN_VALUE(OL_RESP, 'return', 'xmlns:NS1');
END SET_PHONE_OPTION_ON;
--
--�������� ������� - ������-��� - ���������� �����
  FUNCTION SET_PHONE_OPTION_OFF(
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2,
    pOPTION_NAME IN VARCHAR2
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'SetPhoneOptionOff';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(110);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'SitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'LoaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);    
  SOAP_API.ADD_PARAMETER(OL_REQ, 'PhoneNumber', 'xs:string', pPHONE_NUMBER);    
  SOAP_API.ADD_PARAMETER(OL_REQ, 'OptionName', 'xs:string', pOPTION_NAME);    
  -- we call the web service
  OL_RESP := SOAP_API.INVOKE(OL_REQ, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN SOAP_API.GET_RETURN_VALUE(OL_RESP, 'return', 'xmlns:NS1');
END SET_PHONE_OPTION_OFF;

  FUNCTION SEND_PAID_SMS(
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN VARCHAR2 IS 
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'SendPaidSMS';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(115);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'SitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'LoaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);    
  SOAP_API.ADD_PARAMETER(OL_REQ, 'PhoneNumber', 'xs:string', pPHONE_NUMBER);       
  -- we call the web service
  OL_RESP := SOAP_API.INVOKE(OL_REQ, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN SOAP_API.GET_RETURN_VALUE(OL_RESP, 'return', 'xmlns:NS1');
END SEND_PAID_SMS;    
--
  FUNCTION GET_PHONE_BILLS(
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN VARCHAR2 IS 
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'GetPhoneBills';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(120);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'SitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'LoaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);    
  SOAP_API.ADD_PARAMETER(OL_REQ, 'PhoneNumber', 'xs:string', pPHONE_NUMBER);       
  -- we call the web service
  OL_RESP := SOAP_API.INVOKE(OL_REQ, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN SOAP_API.GET_RETURN_VALUE(OL_RESP, 'return', 'xmlns:NS1');
END GET_PHONE_BILLS;    
--
  FUNCTION GET_PHONE_BILL_DETAILS(
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN VARCHAR2 IS 
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'GetPhoneBillDetails';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(130);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'SitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'LoaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);    
  SOAP_API.ADD_PARAMETER(OL_REQ, 'PhoneNumber', 'xs:string', pPHONE_NUMBER);       
  -- we call the web service
  OL_RESP := SOAP_API.INVOKE(OL_REQ, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN SOAP_API.GET_RETURN_VALUE(OL_RESP, 'return', 'xmlns:NS1');
END GET_PHONE_BILL_DETAILS;    
--
  FUNCTION CP_TRANSFERS(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pACCOUNTS_FROM IN VARCHAR2,
    pACCOUNTS_TO IN VARCHAR2,
    pTRANSFER_SUM IN VARCHAR2
    ) RETURN VARCHAR2 IS 
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'CPTransfer';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(125);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'SiteLogin', 'xs:string', pSITE_LOGIN);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'SitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'LoaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);    
  SOAP_API.ADD_PARAMETER(OL_REQ, 'AccountsFrom', 'xs:string', pACCOUNTS_FROM);       
  SOAP_API.ADD_PARAMETER(OL_REQ, 'AccountsTo', 'xs:string', pACCOUNTS_TO);       
  SOAP_API.ADD_PARAMETER(OL_REQ, 'TransferSum', 'xs:string', pTRANSFER_SUM);       
  -- we call the web service
  OL_RESP := SOAP_API.INVOKE(OL_REQ, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN SOAP_API.GET_RETURN_VALUE(OL_RESP, 'return', 'xmlns:NS1');
END CP_TRANSFERS;    
--
--
  FUNCTION LOAD_PHONE_OPTIONS(
    pSITE_LOGIN IN VARCHAR2,
    pSITE_PASSWORD IN VARCHAR2,
    pLOADING_YEAR IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pLOADER_NAME IN VARCHAR2,
    pDB_DATA_SOURCE IN VARCHAR2,
    pDB_USER_NAME IN VARCHAR2,
    pDB_PASSWORD IN VARCHAR2,
    pPHONE_NUMBER IN VARCHAR2    
    ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'LoadPhoneOptions';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vBOOL_STR VARCHAR2(5 CHAR);
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(1);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'sitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingYear', 'xs:int', pLOADING_YEAR);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingMonth', 'xs:int', pLOADING_MONTH);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'Phone_number', 'xs:string', pPHONE_NUMBER);  
  -- we call the web service
  ol_resp := soap_api.invoke(ol_req, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN soap_api.get_return_value(ol_resp, 'return', 'xmlns:NS1');
END LOAD_PHONE_OPTIONS;
--
--
FUNCTION GET_ADD_DETAIL_COST(
  pSITE_LOGIN IN VARCHAR2,
  pLOADING_YEAR IN INTEGER,
  pLOADING_MONTH IN INTEGER,
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'GetAddDetailCost';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
 /*   GetAddDetailCost(
      const siteLogin : String;
      loadingYear : Integer;
      loadingMonth : Integer;
      const phoneNumber : String
      ) : String; stdcall;*/
  vSERVICE_URL:=GET_SERVICE_URL(90);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingYear', 'xs:int', pLOADING_YEAR);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingMonth', 'xs:int', pLOADING_MONTH);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'phoneNumber', 'xs:string', pPHONE_NUMBER);
--                                
  -- we call the web service
  ol_resp := soap_api.invoke(ol_req, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN soap_api.get_return_value(ol_resp, 'return', 'xmlns:NS1');
--
END GET_ADD_DETAIL_COST;
--
FUNCTION GET_PARTNER_BALANCE(
  pSITE_LOGIN IN VARCHAR2,
  pSITE_PASSWORD IN VARCHAR2,
  pLOADING_YEAR IN INTEGER,
  pLOADING_MONTH IN INTEGER,
  pLOADER_NAME IN VARCHAR2,
  pDB_DATA_SOURCE IN VARCHAR2,
  pDB_USER_NAME IN VARCHAR2,
  pDB_PASSWORD IN VARCHAR2,
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN VARCHAR2 IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'GetPartnerBalance';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
/* GetPartnerBalance(
      const siteLogin : String;
      const sitePassword : string;
      loadingYear : Integer;
      loadingMonth : Integer;
      const loaderName : String;
      const DBDataSource : String;
      const DBUserName : String;
      const DBPassword : String;
      const PhoneNumber : String
      ) : String; stdcall;*/
  vSERVICE_URL:=GET_SERVICE_URL(95);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'siteLogin', 'xs:string', pSITE_LOGIN);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'sitePassword', 'xs:string', pSITE_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingYear', 'xs:int', pLOADING_YEAR);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loadingMonth', 'xs:int', pLOADING_MONTH);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'loaderName', 'xs:string', pLOADER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBDataSource', 'xs:string', pDB_DATA_SOURCE);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBUserName', 'xs:string', pDB_USER_NAME);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'DBPassword', 'xs:string', pDB_PASSWORD);
  SOAP_API.ADD_PARAMETER(OL_REQ, 'phoneNumber', 'xs:string', pPHONE_NUMBER);
--                                
  -- we call the web service
  ol_resp := soap_api.invoke(ol_req, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN soap_api.get_return_value(ol_resp, 'return', 'xmlns:NS1');
--
END GET_PARTNER_BALANCE;
--  
FUNCTION GET_PARTNER_URL(
  pURL IN VARCHAR2
  ) RETURN CLOB IS
--
  cEXTERNAL_PROCEDURE_NAME CONSTANT VARCHAR2(50 CHAR) := 'GetPartnerURL';
--
  OL_REQ  SOAP_API.T_REQUEST;
  OL_RESP SOAP_API.T_RESPONSE;
  vSERVICE_URL VARCHAR2(200 CHAR);
BEGIN
  vSERVICE_URL:=GET_SERVICE_URL(85);
  -- we initilize a new request
  OL_REQ := SOAP_API.NEW_REQUEST(cEXTERNAL_PROCEDURE_NAME, 'xmlns="' || vSERVICE_URL || '"');
  -- we started to add parameters
  SOAP_API.ADD_PARAMETER(OL_REQ, 'URL', 'xs:string', pURL);
--                                
  -- we call the web service
  ol_resp := soap_api.invoke(ol_req, vSERVICE_URL, cACTION_PREFIX || cEXTERNAL_PROCEDURE_NAME);
  -- we get back the results
  RETURN soap_api.get_return_value(ol_resp, 'return', 'xmlns:NS1');
END;
--    
END LOADER_CALL_PCKG;