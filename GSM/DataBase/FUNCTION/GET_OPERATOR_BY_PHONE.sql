CREATE OR REPLACE FUNCTION GET_OPERATOR_BY_PHONE (pPHONE_NUMBER IN VARCHAR2) RETURN VARCHAR2 IS 

  --Version 2
  --
  --v.2 Алексеев 28.10.2015 Добавил запись результатов в лог.
  --v.1 Алексеев 19.10.2015 Функция определения оператора связи по номеру.
  
  url VARCHAR2(2000);
  req utl_http.req; --запрос
  resp utl_http.resp; --ответ  
  sRes VARCHAR2(1024);--текст ответа
  vRESULT VARCHAR2(2000 CHAR);
  v_num integer;
  v_cnt integer;
  
  procedure INSERT_LOG_CHECK_OPERATOR(pPHONE IN VARCHAR2, vRES IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  begin
    INSERT INTO LOG_CHECK_OPERATOR_BY_PHONE 
    (
      YEAR_MONTH, 
      PHONE_NUMBER, 
      DATE_INSERT, 
      TEXT_RESULT
    ) 
    VALUES 
    (
      to_number(to_char(sysdate, 'YYYYMM')),
      pPHONE,
      sysdate,
      vRES
    );
    COMMIT;
  end;
  
BEGIN
  --очистим параметры
  vRESULT := '';
  sRes := '';
  
  BEGIN
    --получаем ссылку и указываем номер
    url := MS_params.GET_PARAM_VALUE('URL_DET_OPERATOR_BY_PHONE');
    url := REPLACE(url, '%phone%', pPHONE_NUMBER);
    
    UTL_HTTP.set_wallet(ms_params.GET_PARAM_VALUE('SSL_WALLET_DIR'), '082g625p4Y412sD');
    req:= utl_http.begin_request(url);--открыли
    utl_http.set_body_charset(req,'UTF-8');
    resp := utl_http.get_response(req);

    utl_http.read_line(resp, sRes, TRUE);

    --проверяем статус ответа. Если 200 - значит ок 
    v_num := INSTR(sRes, '"status":');
    v_cnt := LENGTH('"status":');
    if to_number(SUBSTR(sRes, (v_num + v_cnt + 1), ((INSTR(sRes, '"', (v_num + v_cnt + 1))) - (v_num + v_cnt + 1)))) = 200 then
      --считываем оператора. "operator": встречается в ответе 2 раза, учтем это      
      v_num := INSTR(sRes, '"operator":');
      v_cnt := LENGTH('"operator":'); 
      v_num := INSTR(sRes, '"operator":', v_num + v_cnt);
    else --считываем ошибку
      v_num := INSTR(sRes, '"error":');
      v_cnt := LENGTH('"error":');  
    end if;
    vRESULT := SUBSTR(sRes, (v_num + v_cnt + 1), ((INSTR(sRes, '"', (v_num + v_cnt + 1))) - (v_num + v_cnt + 1)));  
       
    UTL_HTTP.END_RESPONSE(resp); --закрыли
  EXCEPTION 
    WHEN others THEN  --в любом случае закрываем соединение
      UTL_HTTP.END_RESPONSE(resp);
      vRESULT :=  resp.status_code||' Error! Соединение сорвалось! '||sRes;
  END;
  
  --логируем результат
  INSERT_LOG_CHECK_OPERATOR(pPHONE_NUMBER, vRESULT);
 
  return vRESULT;
END;

CREATE SYNONYM WWW_DEALER.GET_OPERATOR_BY_PHONE FOR GET_OPERATOR_BY_PHONE;
GRANT EXECUTE ON GET_OPERATOR_BY_PHONE TO WWW_DEALER;