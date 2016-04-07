CREATE OR REPLACE PROCEDURE OPERATORS_MESS_NOTIFICATION(pMESSAGE_ID INTEGER) IS

  --Version 1
  --
  --v.1 Алексеев. 06.11.2015. Процедура уведомления оператора о сообщении.
  --                                       Продергиваем ссылку http://cc.gsmcorp.tarifer.ru/instant_messages/notify_operator?message_id=%mess_id%
  
  url VARCHAR2(2000);
  req utl_http.req; --запрос
  resp utl_http.resp; --ответ  
  vRESULT VARCHAR2(2000 CHAR);
  sRes VARCHAR2(1024);--текст ответа
BEGIN 
  --будем делать 3 попытки продергивания ссылки
  FOR I IN 1..3 LOOP
    --очистим параметры
    vRESULT := '';
    
    BEGIN
      --получаем ссылку и указываем номер
      url := MS_params.GET_PARAM_VALUE('URL_OPERATORS_MESS_NOTIFICATION');
      url := REPLACE(url, '%mess_id%', pMESSAGE_ID);

      --UTL_HTTP.set_wallet(ms_params.GET_PARAM_VALUE('SSL_WALLET_DIR'), '082g625p4Y412sD');
      req:= utl_http.begin_request(url);--открыли
      utl_http.set_body_charset(req,'UTF-8');
      resp := utl_http.get_response(req);

      utl_http.read_line(resp, sRes, TRUE);       
      UTL_HTTP.END_RESPONSE(resp); --закрыли
      --если все отработало без ошибок, то выходим
      exit;
    EXCEPTION 
      WHEN others THEN  --в любом случае закрываем соединение
        UTL_HTTP.END_RESPONSE(resp);
        vRESULT :=  resp.status_code||' Error! Соединение сорвалось! '||sRes;
    END;
  END LOOP;
END;