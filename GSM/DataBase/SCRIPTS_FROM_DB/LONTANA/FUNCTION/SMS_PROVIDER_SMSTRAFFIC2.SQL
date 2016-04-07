
  CREATE OR REPLACE FUNCTION "LONTANA"."SMS_PROVIDER_SMSTRAFFIC2" (
  pPHONE IN VARCHAR2,
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
  CURSOR C IS
    SELECT 
      SMS_SEND_PARAMETRS.LOGIN, 
      SMS_SEND_PARAMETRS.PASSWORD,
      SMS_SEND_PARAMETRS.SENDER_NAME,
      SMS_SEND_PARAMETRS.PROVIDER_NAME 
    FROM
      SMS_SEND_PARAMETRS 
    WHERE SMS_SEND_PARAMETRS.Status=1
      AND SMS_SEND_PARAMETRS.PROVIDER_NAME = 'SMSTraffic';
  DUMMY C%ROWTYPE;
begin
  OPEN C;
  FETCH C INTO DUMMY;
  CLOSE C;
  CHARSET:='windows-1251';
  TYPE_ENCODE:=true;
  ENCODE_SMS_TEXT:=utl_url.escape(pSMS_TEXT, TYPE_ENCODE, CHARSET); 
  URL1 := 'http://server1.smstraffic.ru/multi.php';
  URL1 :=  URL1 || '?login='||DUMMY.LOGIN || '&password='||DUMMY.PASSWORD || '&phones='||pPHONE || '&originator='||DUMMY.SENDER_NAME || '&message='||ENCODE_SMS_TEXT || '&rus=1&want_sms_ids=1';
  URL:=ParamURL || '?login='||DUMMY.LOGIN || '&password='||DUMMY.PASSWORD || '&phones='||pPHONE || '&originator='||DUMMY.SENDER_NAME || '&message='||ENCODE_SMS_TEXT || '&rus=1&want_sms_ids=1';
  BEGIN
    vRESULT := SUBSTR(UTL_HTTP.REQUEST(URL), 1, 1024);
  EXCEPTION WHEN OTHERS THEN
    vRESULT := SQLERRM;
  END;
    IF INSTR(vRESULT, '<result>OK</result>')>0 THEN
    vRESULT:=NULL;
  END IF;
  IF INSTR(vRESULT, '<result>ERROR</result><code>1000</code>')>0 THEN
    BEGIN
      vRESULT := SUBSTR(UTL_HTTP.REQUEST(URL1), 1, 1024);
    EXCEPTION WHEN OTHERS THEN
      vRESULT := 'ErrorReserveURL';
    END;
    IF INSTR(vRESULT, '<result>OK</result>')>0 THEN
      vRESULT:=NULL;
    END IF;
  END IF;
  RETURN vRESULT;
END; 