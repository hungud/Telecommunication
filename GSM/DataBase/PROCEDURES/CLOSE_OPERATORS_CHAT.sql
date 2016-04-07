CREATE OR REPLACE PROCEDURE CLOSE_OPERATORS_CHAT(pUSER_NAME_ID INTEGER) IS

  --Version 1
  --
  --v.1 Алексеев. 06.11.2015. Процедура закрытия чата при разрыве диалога
  
  url VARCHAR2(2000);
  req utl_http.req; --запрос
  resp utl_http.resp; --ответ  
  sRes VARCHAR2(1024);--текст ответа
BEGIN 
  --будем делать 3 попытки продергивания ссылки
  FOR I IN 1..3 LOOP    
    BEGIN
      --получаем ссылку и указываем номер
      url := MS_params.GET_PARAM_VALUE('URL_CLOSE_OPERATORS_CHAT');
      url := REPLACE(url, '%oper_id%', pUSER_NAME_ID);

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
    END;
  END LOOP;
END;