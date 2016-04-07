CREATE OR REPLACE FUNCTION GET_REGION_BY_PHONE (pPHONE_NUMBER IN VARCHAR2) RETURN VARCHAR2 IS 

  --Version 2
  --
  --v.2 Алексеев 28.10.2015 Добавил запись результатов в лог.
  --v.1 Алексеев 19.10.2015 Функция определения оператора связи по номеру.
  
  url VARCHAR2(2000 char);
  req utl_http.req; --запрос
  resp utl_http.resp; --ответ  
  sRes VARCHAR2(1024 char);--текст ответа
  vRESULT VARCHAR2(2000 CHAR);
  v_num varchar2(5 char);
  
  
  v_obj json;

  
BEGIN
  --очистим параметры
  vRESULT := '';
  sRes := '';
  
  BEGIN
    --получаем ссылку и указываем номер
    url := MS_CONSTANTS.GET_CONSTANT_VALUE('URL_DET_OPERATOR_BY_PHONE');
    url := REPLACE(url, '%phone%', pPHONE_NUMBER);
    
    req:= utl_http.begin_request(url);--открыли
    utl_http.set_body_charset(req,'UTF-8');
    resp := utl_http.get_response(req);

    utl_http.read_line(resp, sRes, TRUE);

    --проверяем статус ответа. Если 200 - значит ок
    v_obj := json(sRes);
    
    v_num := v_obj.get('status').get_string;
    
    v_obj := JSON_EXT.GET_JSON (v_obj, 'message'); 
    
    
    if v_num = '200' then
      --считываем оператора. "operator": встречается в ответе 2 раза, учтем это      
      v_obj := JSON_EXT.GET_JSON (v_obj, 'operator');
      vRESULT := v_obj.get('region').get_string;
    else --считываем ошибку
      vRESULT := v_obj.get('error').get_string;
    end if;
       
    UTL_HTTP.END_RESPONSE(resp); --закрыли
  EXCEPTION 
    WHEN others THEN  --в любом случае закрываем соединение
      UTL_HTTP.END_RESPONSE(resp);
      vRESULT :=  resp.status_code||' Error! Соединение сорвалось! '||sRes;
  END;

  return vRESULT;
END;
