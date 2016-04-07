
  CREATE OR REPLACE FUNCTION "SIM_TRADE"."SMS_PROVIDER_MY_MOBI_VISION" (
  pSITE_LOGIN IN VARCHAR2,
  pPROVIDER_NAME IN VARCHAR2,
  pPHONE_LIST_ARRAY IN DBMS_SQL.VARCHAR2_TABLE,
  pMAILING_NAME IN VARCHAR2,
  pSENDER_NAME IN VARCHAR2,
  pSMS_TEXT IN VARCHAR2
  ) RETURN VARCHAR2 IS
--#Version=2
--
/*
login: Simtrade
API ключ: 02581258e2683a47a84043524d39fef82342bdeb
Адрес сервера для запросов: https://my.mbvn.ru/get/send.php
В запросе необходимо передать шесть обязательных параметров login, signature, phone, text, sender, timestamp
login - Ваш логин
signature - подпись
phone - Один номер, или список номеров через запятую (не более 50 номеров в одном запросе)
text - Текст СМС сообщения
sender - Имя отправителя (одно из одобренных на вашем аккаунте)
timestamp - Timestamp по UTC
Пример запроса:
https://my.mbvn.ru/get/send.php?login=Simtrade&signature=37009b5b3bd6d21531f3b39086b8b1f8&phone=84957887327&text=Hello!&sender=smstest&timestamp=1422257991
*/
  ParamURL constant varchar2(50) := 'https://my.mbvn.ru/get/send.php'; -- c https требует сертификат
  URL VARCHAR2(2000 CHAR);
  vRESULT VARCHAR2(2000 CHAR);
  vPHONES VARCHAR2(300 CHAR);
  vDATE_UTC VARCHAR2(500CHAR);
  FIRST_PHONE INTEGER;
  CHARSET VARCHAR2(50 CHAR);
  ENCODE_SMS_TEXT VARCHAR2(2000 CHAR);
  vSITE_SIGNATURE VARCHAR2(2000 CHAR);
  vAPI_KEY VARCHAR2(60 CHAR); --API ключ: 02581258e2683a47a84043524d39fef82342bdeb
  req utl_http.req; --запрос
  resp utl_http.resp; --ответ  
  sRes VARCHAR2(1024);--текст ответа
  sCode VARCHAR2(4);--код ошибки
begin
  CHARSET:='windows-1251';
  FIRST_PHONE:=pPHONE_LIST_ARRAY.FIRST;
  vPHONES:=pPHONE_LIST_ARRAY(FIRST_PHONE);
  ENCODE_SMS_TEXT:=pSMS_TEXT; 
  
  /*
  Подпись
    Любой запрос должен содержать обязательный параметр timestamp - который в свою очередь должен быть включен в подпись и действителен в течение 60 секунд.
    Запросить timestamp нужно по адресу: https://my.mbvn.ru/get/timestamp.php
  */ 
  
  BEGIN
    --vDATE_UTC :=  UTL_HTTP.REQUEST('https://my.mbvn.ru/get/timestamp.php'); -- c https требует сертификат
    --vDATE_UTC :=  UTL_HTTP.REQUEST('http://my.mbvn.ru/get/timestamp.php'); -- c https требует сертификат
    UTL_HTTP.set_wallet(ms_params.GET_PARAM_VALUE('SSL_WALLET_DIR'), '082g625p4Y412sD');
    req:= utl_http.begin_request('https://my.mbvn.ru/get/timestamp.php');--открыли соединение
    utl_http.set_body_charset(req,'UTF-8');
    resp := utl_http.get_response(req);
    
    utl_http.read_line(resp, vDATE_UTC, TRUE);
    vRESULT := '';
    UTL_HTTP.END_RESPONSE(resp);--закрыли соединение
  EXCEPTION
    WHEN others THEN--в любом случае закрываем соединение
      UTL_HTTP.END_RESPONSE(resp);
    vRESULT :=  resp.status_code||' Error! Соединение сорвалось! '||vDATE_UTC;
  END;
  
  /* 
  Подпись (параметр signature) - md5 хэш, который формируется следующим образом:
  Все параметры из запроса нужно отсортировать в алфавитном порядке в строку, в конец строки добавить API ключ. При этом последовательность параметров непосредственно в запросе не имеет значения.

  Например для запроса https://my.mbvn.ru/get/balance.php?login=Simtrade&signature=c5303897fb1cf6fa4ac904be6c382812&timestamp=1422267219 
  таким образом в данном случае подпись будет состоять из параметров login, timestamp и API ключа: c5303897fb1cf6fa4ac904be6c382812
  В результате получится
  YourLogin84957887327Long text1422267219
  В конец строки добавить ваш API ключ - 02581258e2683a47a84043524d39fef82342bdeb
  YourLogin84957887327Long text142226721902581258e2683a47a84043524d39fef82342bdeb
 */
  if vRESULT is null then
    vAPI_KEY := '02581258e2683a47a84043524d39fef82342bdeb';
    vSITE_SIGNATURE := pSITE_LOGIN||'8'||vPHONES||pSENDER_NAME||ENCODE_SMS_TEXT||vDATE_UTC||vAPI_KEY; --номер должен быть с 8
    vSITE_SIGNATURE := LOWER(Rawtohex(UTL_RAW.CAST_TO_RAW(DBMS_OBFUSCATION_TOOLKIT.MD5(input_string=>vSITE_SIGNATURE))));

    ENCODE_SMS_TEXT:=replace(ENCODE_SMS_TEXT, ' ', '%20'); --заменяем пробелы %20

    URL:= ParamURL || '?login='||pSITE_LOGIN ||chr(38)||'timestamp='||vDATE_UTC || chr(38)||'phone=8'||vPHONES || chr(38)|| 'sender='||pSENDER_NAME|| chr(38)||'text='||ENCODE_SMS_TEXT ||chr(38)|| 'signature='||vSITE_SIGNATURE;

    BEGIN
      UTL_HTTP.set_wallet(ms_params.GET_PARAM_VALUE('SSL_WALLET_DIR'), '082g625p4Y412sD');
      req:= utl_http.begin_request(url);--открыли
      utl_http.set_body_charset(req,'UTF-8');
      resp := utl_http.get_response(req);

      utl_http.read_line(resp, sRes, TRUE);

      --если в sRes нет подстроки "error":, то это ошибка
      if INSTR(sRes, '"error":') > 0 then
        --изымаем код ошибки из результата
        --ищем строку "error":
        sCode := SUBSTR(sRes, INSTR(sRes, '"error":') + LENGTH('"error":') + 1, 1);--код ошибки в кавычках поэтому прибавляем 1 {"error":"1"}
          
        if to_number(sCode) <> 0 then
          vRESULT := 'Код статуса: '||resp.status_code||'.  '||sRes;--ошибка
        else
          vRESULT := '';        
        end if;
      else
        vRESULT := 'Код статуса: '||resp.status_code||'.  '||sRes;  
      end if;
       
      UTL_HTTP.END_RESPONSE(resp); --закрыли
      return vRESULT;
    EXCEPTION 
      WHEN others THEN--в любом случае закрываем соединение
        UTL_HTTP.END_RESPONSE(resp);
      vRESULT :=  resp.status_code||' Error! Соединение сорвалось! '||sRes;
      return vRESULT;
    END;
  else
    return vRESULT;  
  end if;
END;