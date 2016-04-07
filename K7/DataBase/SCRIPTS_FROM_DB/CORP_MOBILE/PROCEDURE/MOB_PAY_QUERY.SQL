
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."MOB_PAY_QUERY" 
IS
  --
  --Version=5
  --
  --v6. Соколов 22.01.2015 Добавил счетчик в таблицу MOB_PAY_IN_PROCESSED.
  --v5. Соколов 03.09.2015 Добавил очередь не обработанных платежей.
  --v.4 Афросин 29.06.2015 Добавил проверку статусов и запись в лог.
  --v.3 Афросин 25.06.2015 Добавил переход на другю платежную систему
  --v.2 Афросин 24.04.2015 Вынес код в процедуру. Добавил запись в MOB_PAY_LOG имя пользователя, создавшенго запись.
  --
  --
  cSleepSecondsCount  CONSTANT INTEGER := 10;
  cCommission CONSTANT NUMBER(3, 2) := 0.0;  
  cCurrency  CONSTANT INTEGER := 643;
  cDealer  CONSTANT INTEGER := 11832;
  cLogin  CONSTANT varchar2(10) := 'mobpayussd';
  cPassword CONSTANT varchar2(13) := 'DFE34ddsswedg';
  cResponseXMLNode CONSTANT VARCHAR2(33) := '/response/@';
  cPaymentXMLNode CONSTANT VARCHAR2(33) := '/response/add-payment/payment/@';
  cTerminal CONSTANT INTEGER := 7865;
  cProviderId CONSTANT INTEGER := 135;
  cSiteUrl CONSTANT VARCHAR2(55) := 'https://pays-api-2012.armax.ru/pays-api2012/api/v1/pays';
--/*
  CURSOR cMOB_PAY_REQUEST
  IS
    SELECT * FROM 
    (SELECT DISTINCT cbr.phone,
                    cbr.sum_pay,
                    cbr.req_count,
                    null as REQUEST_TEXT,
                    CBR.USER_CREATED
      FROM MOB_PAY_REQUEST cbr
      UNION ALL
     SELECT DISTINCT np.phone,
                     0 as sum_pay,
                     NVL(np.req_count,0) as req_count,
                     np.REQUEST_TEXT,
                     np.USER_CREATED
      FROM MOB_PAY_IN_PROCESSED np) t
     WHERE EXISTS
              (SELECT 1
                 FROM mob_pay mp
                WHERE
                  mp.phone = t.phone
                  AND mp.date_pay IS NULL
              );
--*/                  
/*
   CURSOR cMOB_PAY_REQUEST
   IS
      SELECT  '9654041993'phone,
                      1 sum_pay,
                      0 req_count,
                      User USER_CREATED
        FROM dual;
   
--*/
   
  vRequestText varchar2(32767); 
  vRespStatusCode  Integer; 
  vResponseAddPay        CLOB;
  vResponseCheckStatusPay CLOB;   
     
  recMOB_PAY_REQUEST   cMOB_PAY_REQUEST%ROWTYPE;

  SMS                  VARCHAR2 (2000);
  answer_mes           VARCHAR2 (2000);
  flp                  NUMBER;
 
     
  vPhoneNumber varchar2(10);
  vId integer;
  vSum varchar2(10);
  vdateStr varchar2(19);
  
  
  vOrderResult varchar2(1);
  vOrderStatus varchar2(1);
  vResultDescriptin varchar2(500);    
  --vResponseResult varchar2(3);
  vResponseResultDescriptin varchar2(4000);
  
  retxml  XMLTYPE;
  
   
-- ПРОЦЕДУРА ДЛЯ ОТПРАВКИ ЗАПРОСА НА СЕРВИС ПЛАТЕЖЕЙ  
   procedure SendRequest(pRequestText in varchar2, pRequestResult out clob, pRespStatusCode out Integer) as
      http_req  utl_http.req; 
      http_resp utl_http.resp;
    begin
      begin
        pRequestResult := null;
        pRespStatusCode := null;
        --в качестве транспортного протокола используем HTTP 'file:C:\OracleClient32'
        UTL_HTTP.set_wallet(ms_params.GET_PARAM_VALUE('SSL_WALLET_DIR'), '082g625p4Y412sD');
        
        http_req:= utl_http.begin_request(cSiteUrl, 'POST','HTTP/1.1'); 
        utl_http.set_body_charset(http_req, 'UTF-8');
        utl_http.set_header(http_req, 'Content-Type', 'text/xml');
        utl_http.set_header(http_req, 'Content-Length', length(pRequestText)); 
        utl_http.write_text(http_req, pRequestText); 
        http_resp := utl_http.get_response(http_req); 
        utl_http.read_text(http_resp, pRequestResult);
        pRespStatusCode := http_resp.status_code;
        utl_http.end_response(http_resp);
      EXCEPTION
        when OTHERS then
          utl_http.end_response(http_resp);  
      end;
    end;
 


   --
   -- ПРОЦЕДУРА ДЛЯ ЗАПИСИ В MOB_PAY_LOG И УДАЛЕНИЯ ИЗ MOB_PAY_REQUEST
   PROCEDURE WRITE_LOG_AND_DEL (
      pRecMOB_PAY_REQUEST   IN cMOB_PAY_REQUEST%ROWTYPE,
      pStatus_code          IN INTEGER,
      pAnswer_mes           IN VARCHAR2,
      pREQUEST_TEXT         IN VARCHAR2,
      pRESPONSE_ADD_PAY     IN VARCHAR2,
      pRESPONSE_CHECK_STATUS_PAY  IN VARCHAR2  
      )
   AS
   BEGIN
     INSERT INTO MOB_PAY_LOG (PHONE,
                               SUM_PAY,
                               REQ_COUNT,
                               DATE_INSERT,
                               RES_CODE,
                               ERROR_TEXT,
                               USER_CREATED,
                               REQUEST_TEXT,
                               RESPONSE_ADD_PAY,
                               RESPONSE_CHECK_STATUS_PAY  
                             )
          VALUES (pRecMOB_PAY_REQUEST.phone,
                   pRecMOB_PAY_REQUEST.sum_pay,
                   pRecMOB_PAY_REQUEST.req_count + 1,
                   NULL,
                   pStatus_code,
                   pAnswer_mes,
                   pRecMOB_PAY_REQUEST.USER_CREATED,
                   pREQUEST_TEXT,
                   pRESPONSE_ADD_PAY,
                   pRESPONSE_CHECK_STATUS_PAY
                 );

     DELETE MOB_PAY_REQUEST cbr
     WHERE     cbr.phone = pRecMOB_PAY_REQUEST.phone
             AND cbr.req_count = pRecMOB_PAY_REQUEST.req_count
             AND cbr.sum_pay = pRecMOB_PAY_REQUEST.sum_pay;

     COMMIT;
   END;
   
BEGIN
  OPEN cMOB_PAY_REQUEST;

  LOOP
    recMOB_PAY_REQUEST := NULL;
    
    answer_mes:= NULL;

    FETCH cMOB_PAY_REQUEST INTO recMOB_PAY_REQUEST;

    EXIT WHEN cMOB_PAY_REQUEST%NOTFOUND;

    SELECT COUNT (*)
      INTO flp
      FROM mob_pay mp
     WHERE mp.phone = recMOB_PAY_REQUEST.Phone AND mp.date_pay IS NULL;

    IF flp > 0 OR TRUE THEN
    BEGIN
      IF recMOB_PAY_REQUEST.REQUEST_TEXT IS NULL THEN
                
        vPhoneNumber := recMOB_PAY_REQUEST.Phone;  
        vId := to_char(sysdate, 'yyyymmddhh24miSSSSS');
        vSum := REPLACE (TO_CHAR (recMOB_PAY_REQUEST.sum_pay), ',', '.');
        vdateStr :=  to_char(TO_TIMESTAMP_TZ (to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SSTZH:TZM'),'YYYY-MM-DD"T"HH24:MI:SS');
        --текст запроса
        vRequestText := '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
                  <request>
                    <auth dealer="'||cDealer||'" login="'||cLogin||'" password="'||cPassword||'" terminal="'||cTerminal||'"/>
                    <add-payment>
                      <payment date="'||vdateStr||'" id="'||vId||'">
                        <from commission="'||cCommission||'" currency="'||cCurrency||'" summ="'||vSum||'"/>
                        <to account="'||vPhoneNumber||'" props="" provider="'||cProviderId||'"/>
                      </payment>
                    </add-payment>
                  </request>';
                      
  --    отправляем запрос на проведение платежа
        SendRequest(vRequestText, vResponseAddPay, vRespStatusCode);
  --   ждем cSleepSecondsCount и отправляем тотже запрос повторно,для получения стутуса платежа      
        dbms_lock.sleep(cSleepSecondsCount);
      else
        vRequestText := recMOB_PAY_REQUEST.REQUEST_TEXT;
      end if;--IF recMOB_PAY_REQUEST.REQUEST_TEXT IS NULL THEN
      
--      проверяем статус платежа
      SendRequest(vRequestText, vResponseCheckStatusPay, vRespStatusCode);
       

       retxml := sys.xmltype.createxml(vResponseCheckStatusPay);
       /*
       --вре результаты запросаs
       select extractValue(retxml, cResponseXMLNode||'result'),
                extractValue(retxml, cResponseXMLNode||'result-description'),
                
                extractValue(retxml, cPaymentXMLNode||'status'),
                extractValue(retxml, cPaymentXMLNode||'result'),
                extractValue(retxml, cPaymentXMLNode||'description')
                
          into 
          vOrderResult,
               vResultDescriptin,
               vOrderStatus,
               vResponseResult,
               vResponseResultDescriptin
          from dual;
       */
       
      select extractValue(retxml, cPaymentXMLNode||'status'),
              extractValue(retxml, cPaymentXMLNode||'description')
          into 
               vOrderStatus,
               vResponseResultDescriptin
               
          from dual; 
   
      IF vRespStatusCode = 200 THEN
       
        CASE vOrderStatus 
          WHEN  '2' THEN
            answer_mes := 'Error: Status='||vOrderStatus;
            SMS :=
               LOADER3_pckg.SEND_SMS (
                  recMOB_PAY_REQUEST.phone,
                  'SMS-info',
                  MS_params.GET_PARAM_VALUE ('MOB_PAY_SMS_ERROR'));
                    
          WHEN '1' THEN
            answer_mes := 'OK {"success":true}';--не стал переделывать ответ, т.к. в программен на этом запрос завязан
              
            UPDATE mob_pay mp
               SET mp.date_pay = SYSDATE,
                   MP.USER_UPDATED = recMOB_PAY_REQUEST.USER_CREATED
             WHERE     mp.phone = recMOB_PAY_REQUEST.phone
                   AND mp.date_pay IS NULL;
            commit; 
          WHEN '0' THEN
              
            IF recMOB_PAY_REQUEST.REQUEST_TEXT IS NULL THEN
              
             INSERT INTO MOB_PAY_IN_PROCESSED (PHONE,REQUEST_TEXT,USER_CREATED)
                   VALUES (recMOB_PAY_REQUEST.phone,vRequestText,recMOB_PAY_REQUEST.USER_CREATED);
             COMMIT;      
            END IF;       
                     
        END CASE;
        
        if vOrderStatus in ('1', '2') then
          DELETE FROM MOB_PAY_IN_PROCESSED NP
          WHERE
            NP.PHONE =  recMOB_PAY_REQUEST.phone;       

          COMMIT;
        end if;
        
        WRITE_LOG_AND_DEL (recMOB_PAY_REQUEST,
                   vRespStatusCode,
                   answer_mes,
                   vRequestText,
                   vResponseAddPay,
                   vResponseCheckStatusPay
                   );
      ELSIF recMOB_PAY_REQUEST.req_count + 1 < TO_NUMBER (MS_params.GET_PARAM_VALUE ('MOB_PAY_COUNT_QUERY')) THEN
        UPDATE MOB_PAY_REQUEST cbr
            SET cbr.req_count = recMOB_PAY_REQUEST.req_count + 1
        WHERE cbr.phone = recMOB_PAY_REQUEST.phone;    

        COMMIT;
      ELSIF (recMOB_PAY_REQUEST.req_count + 1 < TO_NUMBER (MS_params.GET_PARAM_VALUE ('MOB_PAY_COUNT_QUERY'))) AND recMOB_PAY_REQUEST.REQUEST_TEXT IS NOT NULL THEN
        UPDATE MOB_PAY_IN_PROCESSED cbr
            SET cbr.req_count = recMOB_PAY_REQUEST.req_count + 1
        WHERE cbr.phone = recMOB_PAY_REQUEST.phone;    

        COMMIT;
      ELSE
        WRITE_LOG_AND_DEL (
            recMOB_PAY_REQUEST,
            vRespStatusCode,
            answer_mes
            || ' Превышено  количество попыток запроса к сайту партнера.',
            vRequestText,
            vResponseAddPay,
            vResponseCheckStatusPay
            
            );
        SMS :=
            LOADER3_pckg.SEND_SMS (
               recMOB_PAY_REQUEST.phone,
               'SMS-info',
               MS_params.GET_PARAM_VALUE ('MOB_PAY_SMS_ERROR'));
               
        DELETE MOB_PAY_IN_PROCESSED cbr
        WHERE cbr.phone = recMOB_PAY_REQUEST.phone;
        COMMIT; 
              
      END IF;

    EXCEPTION
      WHEN OTHERS THEN

        WRITE_LOG_AND_DEL (
            recMOB_PAY_REQUEST,
            100,
            'Ошибка запроса к сайту партнера.',
            vRequestText,
            vResponseAddPay,
            vResponseCheckStatusPay
            
            );
        SMS :=
            LOADER3_pckg.SEND_SMS (
               recMOB_PAY_REQUEST.phone,
               'SMS-info',
               MS_params.GET_PARAM_VALUE ('MOB_PAY_SMS_ERROR'));
    END;
    ELSE
      DELETE MOB_PAY_REQUEST cbr
      WHERE cbr.phone = recMOB_PAY_REQUEST.phone;

      COMMIT;
    END IF;
  END LOOP;

  CLOSE cMOB_PAY_REQUEST;
END;