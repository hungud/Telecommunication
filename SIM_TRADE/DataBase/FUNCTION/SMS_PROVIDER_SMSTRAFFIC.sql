create or replace FUNCTION SMS_PROVIDER_SMSTRAFFIC(
  pSITE_LOGIN IN VARCHAR2,
  pSITE_PASSWORD IN VARCHAR2,
  pPROVIDER_NAME IN VARCHAR2,
  pPHONE_LIST_ARRAY IN DBMS_SQL.VARCHAR2_TABLE,
  pMAILING_NAME IN VARCHAR2,
  pSENDER_NAME IN VARCHAR2,
  pSMS_TEXT IN VARCHAR2
  ) RETURN VARCHAR2 IS
--#Version=2
--
  ParamURL constant varchar2(50) := 'http://www.smstraffic.ru/multi.php'; -- Адрес для проверки введенного кода с картинки
  URL VARCHAR2(1000 CHAR);
  URL1 VARCHAR2(1000 CHAR);
  vPARAM_TYPE VARCHAR2(1 CHAR) := '';
  vRESULT VARCHAR2(1024 CHAR);
  vPHONES VARCHAR2(300 CHAR);
  FIRST_PHONE INTEGER;
  CHARSET VARCHAR2(50 CHAR);
  TYPE_ENCODE BOOLEAN;
  ENCODE_SMS_TEXT VARCHAR2(900 CHAR);
begin
  CHARSET:='windows-1251';
  TYPE_ENCODE:=true;
  FIRST_PHONE:=pPHONE_LIST_ARRAY.FIRST;
  vPHONES:=pPHONE_LIST_ARRAY(FIRST_PHONE);
  ENCODE_SMS_TEXT:=utl_url.escape(pSMS_TEXT, TYPE_ENCODE, CHARSET); 
  URL1 := 'http://server1.smstraffic.ru/multi.php';
  URL1 :=  URL1 || '?login='||pSITE_LOGIN || '&password='||pSITE_PASSWORD || '&phones='||vPHONES || '&originator='||pSENDER_NAME || '&message='||ENCODE_SMS_TEXT || '&rus=1&want_sms_ids=1';
  URL:=ParamURL || '?login='||pSITE_LOGIN || '&password='||pSITE_PASSWORD || '&phones='||vPHONES || '&originator='||pSENDER_NAME || '&message='||ENCODE_SMS_TEXT || '&rus=1&want_sms_ids=1';
  BEGIN
    vRESULT := SUBSTR(UTL_HTTP.REQUEST(URL), 1, 1024);
  EXCEPTION WHEN OTHERS THEN
    vRESULT := 'error';
  END;
	IF INSTR(vRESULT, '<result>OK</result>')>0 THEN
    vRESULT:=NULL;
  END IF;
	IF INSTR(vRESULT, '<result>ERROR</result><code>1000</code>')>0 THEN
    BEGIN
      vRESULT := SUBSTR(UTL_HTTP.REQUEST(URL1), 1, 1024);
    EXCEPTION WHEN OTHERS THEN
      vRESULT := 'error';
    END;
    IF INSTR(vRESULT, '<result>OK</result>')>0 THEN
      vRESULT:=NULL;
    END IF;
  END IF;
  RETURN vRESULT;
END;
/

GRANT EXECUTE ON SMS_PROVIDER_SMSTRAFFIC TO CORP_MOBILE_ROLE;
