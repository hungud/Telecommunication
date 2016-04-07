CREATE OR REPLACE FUNCTION GET_BLOB_FROM_URL(pURL varchar2, pLoadTypeId integer) RETURN BLOB
IS

--
--#Version=1
--
--v.1 Афрсин 05.02.2016 - Добавил функцию,для получения данных по ссылке 
--  

  Result            BLOB;
  l_http_request    UTL_HTTP.req;
  l_http_response   UTL_HTTP.resp;
  l_blob            BLOB;
  l_raw             RAW (32767);
  l_resp_code varchar2(10 char);
  
  procedure write_log(ppLOAD_TYPE_ID Integer, ppURL varchar2, pRESPONSE_BODY blob, pRESPONSE_RESULT varchar2, pERROR_TEXT varchar2) is
    PRAGMA AUTONOMOUS_TRANSACTION;
  begin
    INSERT INTO GET_BLOB_FROM_URL_LOG
      (
        LOAD_TYPE_ID,
        URL,
        RESPONSE_BODY,
        RESPONSE_RESULT,
        ERROR_TEXT
      )
    VALUES (
             ppLOAD_TYPE_ID,
             ppURL,
             pRESPONSE_BODY,
             pRESPONSE_RESULT,
             pERROR_TEXT
           );
    Commit;  
  end;
  
BEGIN
  -- Initialize the BLOB.
  DBMS_LOB.createtemporary (l_blob, FALSE);

  -- Make a HTTP request and get the response.
  l_http_request := UTL_HTTP.begin_request (pURL);
  UTL_HTTP.set_body_charset (l_http_request, 'UTF-8');
  UTL_HTTP.set_transfer_timeout (60);
  l_http_response := UTL_HTTP.get_response (l_http_request);
  
  l_resp_code := l_http_response.status_code;

  -- Copy the response into the BLOB.
  BEGIN

    LOOP
      UTL_HTTP.read_raw (l_http_response, l_raw, 32766);
      DBMS_LOB.writeappend (l_blob, UTL_RAW.LENGTH (l_raw), l_raw);
    END LOOP;

  EXCEPTION
    WHEN UTL_HTTP.end_of_body THEN
      UTL_HTTP.end_response (l_http_response);

    -- логирование
    write_log (pLoadTypeId, pURL, l_blob, l_resp_code, 'OK!');
  END;

  Result := l_blob;
  -- Relase the resources associated with the temporary LOB.
  DBMS_LOB.freetemporary (l_blob);
  RETURN (Result);
EXCEPTION
  WHEN OTHERS THEN
  BEGIN
   UTL_HTTP.end_response (l_http_response);

   -- логирование
   write_log (pLoadTypeId, pURL, l_blob, l_resp_code, 'Ошибка соединения' || CHR (13) ||SQLERRM);

   DBMS_LOB.freetemporary (l_blob);
   RAISE;
  END;
END;
