CREATE OR REPLACE PROCEDURE UNLOCK_ABONENT(
    pABONENT_ID IN INTEGER,
    RESULT OUT VARCHAR2, success OUT BOOLEAN
    ) IS
--
--#Version=1
--Соколов. Процедура дергает ссылку разблока абонента
--

CURSOR C IS
  SELECT 
    IA.PASSWORD,
    IA.IVIDEON_PASSWORD,
    IA.E_MAIL
  FROM 
    IVIDEON_ABONENTS IA  
  WHERE IA.ABONENT_ID = pABONENT_ID;
  --
    
  vREC C%ROWTYPE;
  env       varchar2(500 CHAR); 
  http_req  utl_http.req; 
  http_resp utl_http.resp;  
  URL VARCHAR2 (500);
BEGIN
  OPEN C;
  FETCH C INTO vREC;
  CLOSE C;
  IF vREC.PASSWORD IS NOT NULL THEN
    BEGIN
    URL:= 'http://ivideon.gsmcorp.tarifer.ru/api/internal/unlock?email='||vREC.E_MAIL||'&password='||vREC.PASSWORD;         
    http_req:= utl_http.begin_request(URL); 
    http_resp := utl_http.get_response(http_req); 
    utl_http.read_text(http_resp, env); 
    utl_http.end_response(http_resp);
    RESULT := NULL;       
    IF http_resp.status_code = 200 THEN    
     RESULT:= ENV;
     success := TRUE; 
    END IF;  
    END;    
  ELSE
    RESULT:= pABONENT_ID || ' не найден в базе данных.';
  END IF;
END;