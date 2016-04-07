CREATE OR REPLACE PROCEDURE GET_BEELINE_TOKEN (pACCOUNT_ID INTEGER DEFAULT NULL) IS
-- VERSION=1
-- v1. 28.07.2015 Матюнин И.- Вывел в отдельные процедуры режим обновление токена и режим проверки полученной ошибки на соответсвие критическим ошибкам, 
                           -- а также получение токена с сайта. 
--
-- Поцедура, обновляющая токены  
-- Продергиваем BEELINE_SOAP_API_PCKG.getCTNInfoList для проверки работоспособности токена, если ответ призодит с критической ошибкой, то обновляем токен с сайта
  vTOKEN        varchar2(500 CHAR); 
  dat_f number; 
  Resp_date_change  varchar2(200 char);
    
  vERR_CODE VARCHAR2(50 char);
  vERR_MESSAGE  VARCHAR2(200 char);
    
  pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);
  vPHONE_NUMBER varchar2(15 char);   
  vLAST_UPDATE_TOKEN DATE;
  
  PROCEDURE SET_TOKEN_VALID (pLOGIN VARCHAR2, pIS_VALID INTEGER, pTOKEN VARCHAR2 DEFAULT NULL) IS    
  -- проуедура обновляем токен по указанному логину. Если по логину не сущетсвует записи, то добавляет её.
  BEGIN
    IF TRIM(pTOKEN) IS NOT NULL THEN 
      UPDATE beeline_api_token_list t 
         SET t.token = pTOKEN 
           , t.last_update = sysdate
           , t.IS_VALID = pIS_VALID
       WHERE t.acc_log = pLOGIN
      ;
    ELSE
      UPDATE beeline_api_token_list t 
         SET t.last_update = sysdate
           , t.IS_VALID = pIS_VALID
       WHERE t.acc_log = pLOGIN
      ;
    END IF;
    
    IF ( sql%rowcount = 0 ) THEN
      INSERT INTO beeline_api_token_list(ACC_LOG, TOKEN, LAST_UPDATE, IS_VALID)
        VALUES (pLOGIN, pTOKEN, sysdate, pIS_VALID );
    END IF;
    COMMIT;
  EXCEPTION 
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20000, 'При вставке или обновлении данных токена в таблицу BEELINE_API_TOKEN_LIST возникла ошибка!');
  END;
           
  FUNCTION IS_BROKEN_ERROR(pANS SOAP_API_ANSWER_TYPE) RETURN INTEGER
  IS    
  -- Проверяем, критическая ли ошибка для токена или нет. 
  -- 0 - не критичная, 1 - критичная!
  -- Также добавляем ошибку в справочник, если ее там нет
    vRES BOOLEAN;
    vIS_BREAK INTEGER;
    vERR_CODE VARCHAR2(50 char);
    vERR_MESSAGE  VARCHAR2(200 char);
  BEGIN
    SELECT 
           extractValue(pANS.ANSWER,'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorDescription'
                              ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types"'
                       ),
           extractValue(pANS.ANSWER,'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorCode'
                                   ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types"'
                       ) 
      INTO vERR_MESSAGE, vERR_CODE
      FROM dual
    ;
      
    SELECT BS.IS_BREAK_TOKEN
      INTO vIS_BREAK  
      FROM BEELINE_SOAP_API_ERR BS
     WHERE UPPER( TRIM(BS.ERR_CODE) ) = UPPER( TRIM(vERR_CODE) )
    ; 
    RETURN vIS_BREAK;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
   -- Значит в справочнике нет такой записи. Вытаскиваем код ошибки и текст ошибки и добавляем в справочник. 
      IF vERR_CODE IS NOT NULL or vERR_MESSAGE IS NOT NULL THEN 
        INSERT INTO BEELINE_SOAP_API_ERR(ERR_CODE, ERR_ENG_TEXT ) VALUES (vERR_CODE, vERR_MESSAGE );
        COMMIT;
      END IF;     
      RETURN 0;
  END;

  FUNCTION  GET_NEW_TOKEN_FROM_SITE(pLOGIN varchar2, pPASSWORD varchar2) RETURN varchar2
  -- Функция получения токена с сайта билайн
  IS
    retxml  XMLTYPE;
    v_TOKEN  varchar2(500 CHAR); 
    soap_text varchar2(32767);
    env       CLOB; 
    http_req  utl_http.req; 
    http_resp utl_http.resp;     
  BEGIN
    soap_text:='<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Auth">
        <soapenv:Header/>
        <soapenv:Body>
          <urn:auth>
            <login>'||pLOGIN||'</login>
            <password>'||pPASSWORD||'</password>
          </urn:auth>
        </soapenv:Body>
      </soapenv:Envelope>';
             
    --в качестве транспортного протокола используем HTTP 'file:C:\OracleClient32'
    UTL_HTTP.set_wallet(ms_params.GET_PARAM_VALUE('SSL_WALLET_DIR'), '082g625p4Y412sD');
    v_TOKEN:=ms_constants.GET_CONSTANT_VALUE('BEELINE_SOAP_API_URL')||'/AuthService'; 
    http_req:= utl_http.begin_request(v_TOKEN, 'POST','HTTP/1.1'); 
    utl_http.set_body_charset(http_req, 'UTF-8'); 
    utl_http.set_header(http_req, 'Content-Type', 'text/xml'); 
    utl_http.set_header(http_req, 'Content-Length', length(soap_text)); 
    utl_http.set_header(http_req, 'SOAPAction', 'https://uatssouss.beeline.ru:443/api/AuthService/urn:uss-wsapi:Auth:AuthInterface:authRequest'); 
    utl_http.write_text(http_req, soap_text); 
    http_resp := utl_http.get_response(http_req); 
    utl_http.read_text(http_resp, env); 
    utl_http.end_response(http_resp);
                
    IF http_resp.status_code = 200 THEN
      retxml := sys.xmltype.createxml(env); 
      SELECT extractValue(retxml,'S:Envelope/S:Body/ns0:authResponse/return','xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Auth"') 
        INTO v_TOKEN 
        FROM dual;
    END IF;  
    RETURN v_TOKEN;
  END;

      
BEGIN 
  dat_f := TO_NUMBER(TO_CHAR(sysdate,'yyyymm'));   
  
  FOR rec IN (SELECT account_id, LOGIN, NEW_PSWD password, account_number  
                FROM accounts ac
                    ,beeline_api_token_list ba
               WHERE 
--                     AC.ACCOUNT_ID NOT IN (125)  -- кроме единого счета
--                 AND 
                     (AC.ACCOUNT_ID = pACCOUNT_ID OR pACCOUNT_ID IS NULL)
                 AND TRIM(AC.NEW_PSWD) IS NOT NULL 
                 AND AC.LOGIN = BA.ACC_LOG (+)
              ORDER BY nvl(BA.IS_VALID, 0)  -- чтобы в первую очередь брались валидные токены
             )
  LOOP
    BEGIN    
      SELECT DB.PHONE_NUMBER           
        INTO vPHONE_NUMBER    
        FROM DB_LOADER_ACCOUNT_PHONES DB               
       WHERE db.year_month = dat_f
         AND DB.ACCOUNT_ID = rec.account_id
         AND DB.PHONE_IS_ACTIVE = 1
         AND rownum<=1
         --AND db.phone_number = '9687711133'
      ;
      
      pANSWER := BEELINE_SOAP_API_PCKG.getCTNInfoList(BEELINE_SOAP_API_PCKG.auth(rec.LOGIN, rec.password), vPHONE_NUMBER, rec.account_number, '');

      SELECT 
        extractValue(
            pANSWER.ANSWER,
             'S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList/statusDate'
             ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"'
        )   
        INTO Resp_date_change    
        FROM dual
      ;
      -- если выборка прошла без ошибок, значит токен рабочий. Фикисируем этот факт. 
      SET_TOKEN_VALID(rec.login, 1);      
    EXCEPTION
      -- если возникли ошибки, смотрим что за ошибки 
      WHEN others THEN 
        IF REC.ACCOUNT_ID <> 125 THEN -- если не единый ЛС
          SELECT 
               extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorDescription'
                                  ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types"'
                           ),
               extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorCode'
                                       ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types"'
                           ) 
            INTO vERR_MESSAGE, vERR_CODE
            FROM dual
          ;
          
          -- если vERR_MESSAGE, vERR_CODE пустые, то на всякий пусть будет запрошен новыей токен  
          IF IS_BROKEN_ERROR(pANSWER)=0 and (vERR_MESSAGE is not null or vERR_CODE is not null) THEN
            -- Ошибка не критичная, значит токен рабочий
            SET_TOKEN_VALID(rec.login, 1);
          ELSE 
            -- Ошибка критичная - токен сломан, поэтому пытаемся получить новый токен через сайт
            -- Сначала фиксируем. что токен инвалидный
            SET_TOKEN_VALID(rec.login, 0);          
            vTOKEN := GET_NEW_TOKEN_FROM_SITE(rec.login, rec.password);
            IF TRIM(vTOKEN) IS NOT NULL THEN
              -- Получили новый токер,записываем значение нового токена
              SET_TOKEN_VALID(rec.login, 1, vTOKEN);
            END IF;           
          END IF;
        ELSE
          BEGIN
            SELECT BA.LAST_UPDATE
              INTO vLAST_UPDATE_TOKEN
              FROM beeline_api_token_list BA              
             WHERE BA.ACC_LOG = REC.LOGIN
               AND BA.LAST_UPDATE >= (SYSDATE - 1/24) -- ТОКЕН ОБНОВЛЯЛСЯ БОЛЬШЕ ЧАСА НАЗАД
            ;
          EXCEPTION 
            WHEN NO_DATA_FOUND THEN             
              -- Сначала фиксируем. что токен инвалидный
              -- SET_TOKEN_VALID(rec.login, 0);          
              vTOKEN := GET_NEW_TOKEN_FROM_SITE(rec.login, rec.password);
              IF TRIM(vTOKEN) IS NOT NULL THEN
                -- Получили новый токер,записываем значение нового токена
                SET_TOKEN_VALID(rec.login, 1, vTOKEN);
              ELSE
                SET_TOKEN_VALID(rec.login, 0);
              END IF; 
          END;
          vTOKEN := GET_NEW_TOKEN_FROM_SITE(rec.login, rec.password);
        END IF;        
    END;                   
  END LOOP;          
       
END;
/
