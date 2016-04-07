 --#if GetVersion("BEELINE_SOAP_API_PCKG") < 6 then
CREATE OR REPLACE PACKAGE BEELINE_SOAP_API_PCKG AS
-- 
--#Version=7
-- 7. Бакунов (Изменения вносил Алексеев). Добавлены новые функции
-- 6. Уколов. Добавил процедуру addDelSOC (подключение / отключение услуги)
--
--изменение замена 217.118.87.62 на uatssouss.beeline.ru 
--Для всех функций и процедур общие параметры: 
--tok - токен, phone - номер телефона в формате 9023755752, 
--ban - account_number из таблицы account, 
--hashs - при текущем методе авторизации не используется 
--Авторизация, выдает токен. login - логин в кабинет личного счета, к которому принадлежит номер 
--password - пароль в новый кабинет 
--system conventer'
FUNCTION blob_to_xmltype (blob_in IN BLOB)RETURN XMLTYPE;

function auth(login in varchar2,password in varchar2) return varchar2; 
--Выдает информацию по номеру: статус, ТП и т.п. 
function getCTNInfoList(tok in varchar2,phone in varchar2,pban in varchar2,hashs in varchar2) return SOAP_API_ANSWER_TYPE; 
--Выдает информацию по платежам за период с sDate по eDate 
function getPaymentList(tok in varchar2,phone in varchar2,ban in varchar2,hashs in varchar2,sDate in date, eDate in date) return SOAP_API_ANSWER_TYPE; 
--Выдает информацию по услугам абонента 
function getServiceList(tok in varchar2,phone in varchar2,pban in varchar2,hashs in varchar2) return SOAP_API_ANSWER_TYPE; 
--Замена текущей SIM карты абонента на SIM карту с номером ICC 
function replaseSIM(tok in varchar2,phone in varchar2,ICC in varchar2,hashs in varchar2,acc_id in number)return SOAP_API_ANSWER_TYPE; 
--Блокировка абонента. dateb - дата блокировки, всегда больше текущей, 
--rCode - причина блокировки: WIB – блокировка по желанию, STO – блокировка по краже 
function suspendCTN(tok in varchar2,phone in varchar2,dateb in date,hashs in varchar2,rCode in varchar2,acc_id in number) return SOAP_API_ANSWER_TYPE; 
--Разблокировка абонента. dateb - дата разблокировки, всегда больше текущей 
function restoreCTN(tok in varchar2,phone in varchar2,dateb in date,hashs in varchar2,acc_id in number) return SOAP_API_ANSWER_TYPE; 
-- Подключение / отключение услуги
function addDelSOC(tok in varchar2, phone in varchar2, soc in varchar2, inclusionType in varchar2, effDate in date, expDate in date, acc_id in number) return SOAP_API_ANSWER_TYPE;
--Необилинные звонки постпэйд
function getUnbilledCallsList(tok in varchar2,phone in varchar2,ban in varchar2,hashs in varchar2) return SOAP_API_ANSWER_TYPE ;
--Проверка тикетов
function getRequestList(tok in varchar2,request in number, Plog in varchar2, pAcc_id in number) return SOAP_API_ANSWER_TYPE ;
--Список Банов по коллекторским лицевым счетам...
function getBANInfoList(tok in varchar2,pLogin in varchar2, pAcc_id in number,hashs in varchar2) return SOAP_API_ANSWER_TYPE;
--заказ отчета по начислениям счёта.
function createBillChargesRequest(tok in varchar2,ban in number, pAcc_id in number,Pbill_Date in date) return SOAP_API_ANSWER_TYPE;
--получение отчета по начислениям счёта.
function getBillCharges(tok in varchar2,Req_id in varchar2,acc_id in  number) return SOAP_API_ANSWER_TYPE;
--Текущие начисления для всех 
function getUnbilledBalances(tok in varchar2,phone in varchar2,pban in varchar2,hashs in varchar2) return SOAP_API_ANSWER_TYPE;
--Текущие начисления быстрый метод без логирования в SOAP_LOG
function getUnbilledBalances(tok in varchar2,phone in varchar2,pacc in number) return SOAP_API_ANSWER_TYPE;
--смена тарифного плана
function changePP(tok in varchar2, hashs in varchar2, phone in varchar2, acc_id in number, PpricePlan IN VARCHAR2, futureDate in varchar2 default 'N') return SOAP_API_ANSWER_TYPE;
--получение номера SIM карты для BAN
function getSIMList(tok in varchar2, hashs in varchar2, ban in varchar2, phone in varchar2 default null) return SOAP_API_ANSWER_TYPE;
--получение информации о корректировках BAN
function getAdjustmentList(tok in varchar2, hashs in varchar2, ban in varchar2, startDate in date, endDate in date) return SOAP_API_ANSWER_TYPE;
--заказ отчета по детализации счета для списка CTN.
function createBillCallsRequest(tok in varchar2, hashs in varchar2, ban in varchar2, pAcc_id in number, billDate in date, CTNList IN VARCHAR2 DEFAULT NULL) return SOAP_API_ANSWER_TYPE;
--получение отчета по детализации счета для списка CTN
function getBillCalls(tok in varchar2, hashs in varchar2, requestId integer, acc_id in number) return SOAP_API_ANSWER_TYPE;
--формирование и отправка на e-mail заказанной детализации PDF для prepaid B2C и prepaid B2B
function createDetailsRequest(tok in varchar2, hashs in varchar2, phone in varchar2, periodStart in date, periodEnd in date,format in varchar2, acc_id in number) return SOAP_API_ANSWER_TYPE;
--получение файла детализации (в формате PDF)
function getDetails(tok in varchar2, hashs in varchar2, requestId integer, acc_id in number) return SOAP_API_ANSWER_TYPE;
--изменение номера
function changeNumber(tok in varchar2, hashs in varchar2, oldPhone in varchar2, newPhone in varchar2, acc_id in number) return SOAP_API_ANSWER_TYPE;
--изменение BAN
function changeBan(tok in varchar2, hashs in varchar2, oldBan in varchar2, newBan in varchar2) return SOAP_API_ANSWER_TYPE;
--отмена CTN(номера)
function cancelCtn(tok in varchar2, hashs in varchar2, phone in varchar2, acc_id in number) return SOAP_API_ANSWER_TYPE;

END BEELINE_SOAP_API_PCKG;
/
CREATE OR REPLACE PACKAGE BODY BEELINE_SOAP_API_PCKG AS
-- 
--#Version=7
-- 7. Бакунов (Изменения вносил Алексеев). Добавлены новые функции
--v5. 01.10.2013 Назин. Изменил авторизацию 
--v4. 30.09.2013 Назин. Добавлено определение ошибок API. Соединение вынесено в отдельную процедуру.
--V3. 22.07.2013 Николаев. Добавлено логирование. Ссылка на API вынесена в константу. 

cycle integer:=2;--Попыток соединения
ret SOAP_API_ANSWER_TYPE;--ответ сервера

procedure save_sys_log (pphone in varchar2,
                        pAccount_id in number,
                        pBAN in number,
                        pLoadtype in number,
                        ret in SOAP_API_ANSWER_TYPE) IS
pragma autonomous_transaction; 
begin
      insert into soap_api_sys_log
        (type_req, phone_number, account_id, ban, response, is_ok,date_insert)
      values
        (pLoadtype, pphone, pAccount_id, pBAN, ret.Err_text, decode(ret.Err_text,'OK',1,0),sysdate);
      commit;  
end;  
                        

function save_log(pphone in varchar2,
                  pAccount_id in number,
                  pLoadtype in number,
                  request in varchar2,
                  answer  in xmltype) return integer as
  LL  varchar2(256);
  pBSAL_ID integer;
  pragma autonomous_transaction; 
begin
  LL := ms_params.GET_PARAM_VALUE('BEELINE_SOAP_LOG_LEVEL');
  if LL = '1' then
    insert into BEELINE_SOAP_API_LOG(BSAL_ID,SOAP_REQUEST,SOAP_ANSWER,INSERT_DATE,PHONE,Account_Id,LOAD_TYPE)
                             values (null, request,answer, null,pphone,pAccount_id,pLoadtype) 
                             returning BSAL_ID into pBSAL_ID;
    commit;
  elsif LL = '2' and instr(answer.getStringVal(), 'error') > 0 then
    insert into BEELINE_SOAP_API_LOG(BSAL_ID,SOAP_REQUEST,SOAP_ANSWER,INSERT_DATE,PHONE,Account_Id,LOAD_TYPE) 
                             values (null, request, answer, null,pphone,pAccount_id,pLoadtype) 
                             returning BSAL_ID into pBSAL_ID;
    commit;
  end if;
  return  pBSAL_ID;
exception
  when others then
    LL:=sqlerrm;
    return LL;
end;

FUNCTION blob_to_xmltype (blob_in IN BLOB)
RETURN XMLTYPE
AS
  v_clob CLOB;
  v_varchar VARCHAR2(32767);
  v_start PLS_INTEGER := 1;
  v_buffer PLS_INTEGER := 32767;
BEGIN
  DBMS_LOB.CREATETEMPORARY(v_clob, TRUE);

  FOR i IN 1..CEIL(DBMS_LOB.GETLENGTH(blob_in) / v_buffer)
  LOOP
    v_varchar := UTL_RAW.CAST_TO_VARCHAR2(DBMS_LOB.SUBSTR(blob_in, v_buffer, v_start));
    DBMS_LOB.WRITEAPPEND(v_clob, LENGTH(v_varchar), v_varchar);
    v_start := v_start + v_buffer;
  END LOOP;

  RETURN XMLTYPE(v_clob);
END;


function auth(login in varchar2,password in varchar2) return varchar2 as 
    soap_text varchar2(32767); 
    env       CLOB; 
    http_req  utl_http.req; 
    http_resp utl_http.resp; 
    url        varchar2(32767); 
    retxml  XMLTYPE;
    token_old date; 
pragma autonomous_transaction;    
begin 
  begin
       select t.token,t.last_update into url,token_old from beeline_api_token_list t where t.acc_log=login for update;
      if (token_old<sysdate-9/1440 or token_old is null) then url:=null;else commit;return(url);end if;
  exception
      when no_data_found then url:=null;
  end;
if url is null then 
    --Это текст непосредственно SOAP 
    soap_text:='<?xml version="1.0" encoding="utf-8"?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Auth">
       <soapenv:Header/>
       <soapenv:Body>
          <urn:auth>
             <login>'||login||'</login>
             <password>'||password||'</password>
          </urn:auth>
       </soapenv:Body>
    </soapenv:Envelope>'; 
     
    --в качестве транспортного протокола используем HTTP 'file:C:\OracleClient32'
    
    UTL_HTTP.set_wallet(ms_params.GET_PARAM_VALUE('SSL_WALLET_DIR'), '082g625p4Y412sD');
    url:=ms_constants.GET_CONSTANT_VALUE('BEELINE_SOAP_API_URL')||'/AuthService'; 
    http_req:= utl_http.begin_request(url, 'POST','HTTP/1.1'); 
    utl_http.set_body_charset(http_req, 'UTF-8'); 
    utl_http.set_header(http_req, 'Content-Type', 'text/xml'); 
        utl_http.set_header(http_req, 'Content-Length', length(soap_text)); 
        utl_http.set_header(http_req, 'SOAPAction', 'https://uatssouss.beeline.ru:443/api/AuthService/urn:uss-wsapi:Auth:AuthInterface:authRequest'); 
        utl_http.write_text(http_req, soap_text); 
        http_resp := utl_http.get_response(http_req); 
        utl_http.read_text(http_resp, env); 
        utl_http.end_response(http_resp);
        if http_resp.status_code = 200 then
           retxml := sys.xmltype.createxml(env); 
           select extractValue(retxml,'S:Envelope/S:Body/ns0:authResponse/return','xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Auth"') into url from dual; 
           update beeline_api_token_list t set t.token=url,t.last_update=sysdate where t.acc_log=login;
                  IF ( sql%rowcount = 0 ) then
                    insert into beeline_api_token_list(acc_log,token,last_update)values (login,url,sysdate);
                  end if;
           commit;
        elsif http_resp.status_code = 500 then
        retxml := sys.xmltype.createxml(env); 
--insert into beeline_soap_api_log(soap_answer) values (retxml); commit;--логирование
        select 'Error.'||extractValue(retxml,'S:Envelope/S:Body/ns0:Fault/faultstring'
                                  ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.w3.org/2003/05/soap-envelope" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/"')
        into url from dual;
          rollback;           
        else
          url:='Error.API не доступно: '||to_char(http_resp.status_code)||' '||http_resp.reason_phrase;
          rollback;
        end if;
end if;        
return url; 
end; 


function create_conn(soap_req in varchar2
                    ,Surl in varchar2
                    ,Interface in varchar2
                    ,phone_n in varchar2 default null
                    ,Acc_id in number default null
                    ,load_type in number default 0
                    ) return varchar2 as

    http_req  utl_http.req; 
    http_resp utl_http.resp; 
    url        varchar2(32767); 
    retxml  XMLTYPE; 
    --line varchar2(1000);
    answer blob;
    raw_buf raw(32767);
    Err varchar2(1000);
    env clob;
begin
 --в качестве транспортного протокола используем HTTP 
  UTL_HTTP.set_wallet(ms_params.GET_PARAM_VALUE('SSL_WALLET_DIR'), '082g625p4Y412sD');
  url:=ms_constants.GET_CONSTANT_VALUE('BEELINE_SOAP_API_URL')||Surl; 
  http_req:= utl_http.begin_request(url, 'POST','HTTP/1.1'); 
  utl_http.set_body_charset(http_req, 'UTF-8'); 
  utl_http.set_header(http_req, 'Content-Type', 'text/xml'); 
  utl_http.set_header(http_req, 'Content-Length', length(soap_req)); 
  utl_http.set_header(http_req, 'SOAPAction', 'https://uatssouss.beeline.ru:443/api/SubscriberService/urn:uss-wsapi:Subscriber:SubscriberInterface:'||Interface); 
  utl_http.write_text(http_req, soap_req); 
  --
  -- Цикл соединения
  --
  for c in 1..cycle loop 
    Begin
      http_resp := utl_http.get_response(http_req);
      if http_resp.status_code>0--если есть результат соединения переходим к разбору
         then exit;
      end if;
    exception
    when others then --если соединение не прошло, пробуем ещё раз, с паузой 5 сек.
                if c<cycle 
                  then dbms_lock.sleep(5);
                  else
                    err:=http_resp.status_code||' Error! Соединение сорвалось! '||chr(13)||utl_http.get_detailed_sqlerrm;
                    ret.Err_text:=err;
                    return(err);
                end if;
    end;
  End loop;--цикл соединения конец
  --
  --разбор ответа от АПИ 
  -- 
  if http_resp.status_code!=200 then --если ошибка то
      begin
         utl_http.read_text(http_resp, env);--ответ в clob
         UTL_HTTP.END_RESPONSE(http_resp);--закрываем соединение
         retxml := sys.xmltype.createxml(env); --если xml, то достаём код API
             select --Текст
              extractValue(retxml,'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorDescription'
                    ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types"')
              ||chr(13)||'__________'||chr(13)
              ||api_err.err_rus_text
             into ret.Err_text 
             from beeline_soap_api_err api_err
                 ,(select extractValue(retxml,'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorCode'
                                       ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types"') x 
                   from dual
                  ) c
             Where api_err.err_code(+)=c.x--ищем перевод ошибки в таблице
         ;
         ret.ANSWER:=retxml;
         if load_type!=62 then 
         ret.BSAL_ID:=save_log(phone_n,Acc_id,load_type,soap_req,retxml);
         end if;
         Return('Error!');
     exception                            --если не xml то говоирим, что просто ошибка
         when others then
         ret.Err_text:=http_resp.status_code||' Error! Ошибка сервера Билайн, ответ не разобран '||sqlerrm;
             
         Return('Error!');
     end;
  end if; --конец разбора ошибки
  
--Если нет ошибки - чтение нормального ответа. 
  begin
      dbms_lob.createtemporary(answer, true );
  loop
       utl_http.read_raw(http_resp,raw_buf);--чтение varchar2
       --raw_buf:=utl_raw.cast_to_raw(line);
       dbms_lob.append(answer,raw_buf);--в blob
  end loop;
  exception
    when others then--в любом случае закрываем соединение
        UTL_HTTP.END_RESPONSE(http_resp);
        err:=utl_http.get_detailed_sqlerrm;
  end;--ответ разобрали
  --
  --Разбираем XML, логируем 
  --      
--  insert into aaa(clb) values(answer);commit; --оформить в автономную транзакцию.
  begin 
    retxml :=blob_to_xmltype(answer);--разбираем xml sys.xmltype.createXMLFromBinary
  exception 
    when others 
      then ret.Err_text:=' Error! АПИ вернула ответ не соответствующий спецификации xmlsoap.org';
      Return('Error!');
  end;
  
         if load_type!=62 then 
         ret.BSAL_ID:=save_log(phone_n,Acc_id,load_type,soap_req,retxml);
         end if;
  ret.ANSWER:=retxml;
  ret.Err_text:='OK';
  return('OK');
 exception
   when others then--дополнительная проверка на открытое соединение
      err:=err||'Код:'||nvl(http_resp.status_code,0);
      --if nvl(http_resp.status_code,0)>0 then UTL_HTTP.END_RESPONSE(http_resp);end if;
      err:=err||' Error! Соединение не случилось, файл не создан! '||chr(13)||sqlerrm;
      ret.Err_text:=err;
      return(err); 
end;


 
function getCTNInfoList(tok in varchar2,phone in varchar2,pban in varchar2,hashs in varchar2) return SOAP_API_ANSWER_TYPE as 
    soap_text varchar2(32767); 
    sURL varchar2(100);
    sINTERFACE varchar2(100);
    Err_text varchar2(1000);
    Acc_id number(3);
begin 
--Инициализация  
ret:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);
sINTERFACE:='getCTNInfoListRequest';
sURL:='/SubscriberService';
soap_text:='<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:getCTNInfoList>
        <token>'||tok||'</token>
        <hash>'||hashs||'</hash>
        <ban>'||pban||'</ban>
        <ctn>'||phone||'</ctn>
      </urn:getCTNInfoList>
   </soapenv:Body>
</soapenv:Envelope>';
   begin
      Select distinct t.account_id into Acc_id from accounts t where t.account_number=pban;
   exception -- определяет головной BAN коллекторского счёта.
     when no_data_found then select distinct w.account_id into Acc_id from BEELINE_LOADER_INF w where w.ban=pban;
   end;
--Запрос 
 Err_text:=create_conn(soap_text,sURL,sINTERFACE,phone,Acc_id,3);    
 --sys_log, only if SMTH wrong;
if ret.Err_text!='OK' or Err_text!='OK' then save_sys_log (phone ,
                                        acc_id ,
                                        pban,
                                        3,
                                        ret);
end if;
 return ret;
end; 
 
function getPaymentList(tok in varchar2,phone in varchar2,ban in varchar2,hashs in varchar2,sDate in date, eDate in date) return SOAP_API_ANSWER_TYPE as 
    soap_text varchar2(32767); 
    sURL varchar2(100);
    sINTERFACE varchar2(100);
    Err_text varchar2(1000);
    Acc_id number(3);
begin 
--Инициализация  
ret:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);
sINTERFACE:='getCTNInfoListRequest';
sURL:='/SubscriberService';
--Это текст непосредственно SOAP 
soap_text:='<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:getPaymentList>
        <token>'||tok||'</token>
        <hash>'||hashs||'</hash>
        <ban>'||ban||'</ban>
        <ctn>'||phone||'</ctn>
        <startDate>'||to_char(sDate,'yyyy-mm-dd')||'T'||to_char(sDate,'hh24:mi:ss')||'.0'||'</startDate>
        <endDate>'||to_char(eDate,'yyyy-mm-dd')||'T'||to_char(eDate,'hh24:mi:ss')||'.0'||'</endDate>
      </urn:getPaymentList>
   </soapenv:Body>
</soapenv:Envelope>'; 
 
Select t.account_id into Acc_id from accounts t where t.account_number=ban;
--Запрос 
 Err_text:=create_conn(soap_text,sURL,sINTERFACE,phone,Acc_id,1);    
 --sys_log, only if SMTH wrong;
if ret.Err_text!='OK' or Err_text!='OK' then save_sys_log (phone ,
                                        acc_id ,
                                        ban,
                                        1,
                                        ret);
end if;
 return ret; 
end; 
 
function getServiceList(tok in varchar2,phone in varchar2,pban in varchar2,hashs in varchar2) return SOAP_API_ANSWER_TYPE as 
    soap_text varchar2(32767); 
    sURL varchar2(100);
    sINTERFACE varchar2(100);
    Err_text varchar2(1000);
    Acc_id number(3);
begin 
--Инициализация  
ret:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);
sINTERFACE:='getServicesListRequest';
sURL:='/SubscriberService';
--Это текст непосредственно SOAP  
soap_text:='<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:getServicesList>
        <token>'||tok||'</token>
        <hash>'||hashs||'</hash>
        <ban>'||pban||'</ban>
        <ctn>'||phone||'</ctn>
      </urn:getServicesList>
   </soapenv:Body>
</soapenv:Envelope>'; 

   begin
      Select distinct t.account_id into Acc_id from accounts t where t.account_number=pban;
   exception -- определяет головной BAN коллекторского счёта.
     when no_data_found then select distinct w.account_id into Acc_id from BEELINE_LOADER_INF w where w.ban=pban;
   end;
--Запрос
 Err_text:=create_conn(soap_text,sURL,sINTERFACE,phone,Acc_id,4);    
 
--sys_log, only if SMTH wrong;
if ret.Err_text!='OK' or Err_text!='OK' then save_sys_log (phone ,
                                                        acc_id ,
                                                        pban,
                                                        4,
                                                        ret);
end if;              
 return ret;  
end; 

function getUnbilledCallsList(tok in varchar2,phone in varchar2,ban in varchar2,hashs in varchar2) return SOAP_API_ANSWER_TYPE as 
    soap_text varchar2(32767); 
    sURL varchar2(100);
    sINTERFACE varchar2(100);
    Err_text varchar2(1000);
    Acc_id number(3);
begin 
--Инициализация  
ret:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);
sINTERFACE:='getUnbilledCallsList';
sURL:='/SubscriberService';
--Это текст непосредственно SOAP  
soap_text:='<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:getUnbilledCallsList>
        <token>'||tok||'</token>
        <hash>'||hashs||'</hash>
        <ctn>'||phone||'</ctn>
      </urn:getUnbilledCallsList>
   </soapenv:Body>
</soapenv:Envelope>'; 

Select t.account_id into Acc_id from accounts t where t.account_number=ban;
--Запрос 
 Err_text:=create_conn(soap_text,sURL,sINTERFACE,phone,Acc_id,2);    
--sys_log только если что-то не так.
  if ret.Err_text!='OK' or Err_text!='OK' then  save_sys_log (phone ,
                                            acc_id ,
                                            BAN,
                                            2,
                                            ret);
  end if;

 return ret;  

end;
  
function replaseSIM(tok in varchar2,phone in varchar2,ICC in varchar2,hashs in varchar2,acc_id in number) return SOAP_API_ANSWER_TYPE as 
    soap_text varchar2(32767); 
    sURL varchar2(100);
    sINTERFACE varchar2(100);
    Err_text varchar2(1000);
begin 
--Инициализация  
ret:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);
sINTERFACE:='replaceSIMRequest';
sURL:='/SubscriberService';
--1753-01-01T00:00:00.000 
--Это текст непосредственно SOAP 
soap_text:='<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:replaceSIM>
        <token>'||tok||'</token>
        <hash>'||hashs||'</hash>
        <ctn>'||phone||'</ctn>
        <serialNumber>'||ICC||'</serialNumber>
      </urn:replaceSIM>
   </soapenv:Body>
</soapenv:Envelope>'; 
--Запрос 
 Err_text:=create_conn(soap_text,sURL,sINTERFACE,phone,acc_id,12);    
if Err_text!='OK' then null;end if;
  --sys_log
 save_sys_log (phone ,
              acc_id ,
              null,
              12,
              ret);--надо куда-нить воткнуть доп. логирование полегче....
 return ret; 
end;
 
function suspendCTN(tok in varchar2,phone in varchar2,dateb in date,hashs in varchar2,rCode in varchar2,acc_id in number)return SOAP_API_ANSWER_TYPE as 
    soap_text varchar2(32767); 
    sURL varchar2(100);
    sINTERFACE varchar2(100);
    Err_text varchar2(1000);
    pBan number;
begin 
--Инициализация  
ret:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);
sINTERFACE:='suspendCTNRequest';
sURL:='/SubscriberService';
--1753-01-01T00:00:00.000 
--Это текст непосредственно SOAP 
soap_text:='<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:suspendCTN>
        <token>'||tok||'</token>
        <hash>'||hashs||'</hash>
        <ctn>'||phone||'</ctn>
        <actvDate>'||to_char(dateb,'yyyy-mm-dd')||'T'||to_char(dateb,'hh24:mi:ss')||'.0'||'</actvDate>
        <reasonCode>'||rCode||'</reasonCode>
      </urn:suspendCTN>
   </soapenv:Body>
</soapenv:Envelope>'; 
--Запрос 
 Err_text:=create_conn(soap_text,sURL,sINTERFACE,phone,acc_id,9);    
  --sys_log
  begin 
    select i.ban into pban from beeline_loader_inf i where i.phone_number=phone;
  exception
    when others then null;
  end;

if Err_text!='OK' then null;end if;
 save_sys_log (phone ,
              acc_id ,
              pBAN,
              9,
              ret);
 return ret; 
end; 
 
function restoreCTN(tok in varchar2,phone in varchar2,dateb in date,hashs in varchar2,acc_id in number)return SOAP_API_ANSWER_TYPE as 
    soap_text varchar2(32767); 
    sURL varchar2(100);
    sINTERFACE varchar2(100);
    Err_text varchar2(1000);
    pban number;
begin 
--Инициализация  
ret:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);
sINTERFACE:='restoreCTNRequest';
sURL:='/SubscriberService';
--1753-01-01T00:00:00.000 
--Это текст непосредственно SOAP 
soap_text:='<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:restoreCTN>
        <token>'||tok||'</token>
        <hash>'||hashs||'</hash>
        <ctn>'||phone||'</ctn>
        <actvDate>'||to_char(dateb,'yyyy-mm-dd')||'T'||to_char(dateb,'hh24:mi:ss')||'.0'||'</actvDate>
        <reasonCode>RSBO</reasonCode>
      </urn:restoreCTN>
   </soapenv:Body>
</soapenv:Envelope>'; 
--Запрос 
 Err_text:=create_conn(soap_text,sURL,sINTERFACE,phone,acc_id,10); 
--sys_log
  begin 
    select i.ban into pban from beeline_loader_inf i where i.phone_number=phone;
  exception
    when others then null;
  end;
if Err_text!='OK' then null;end if;
 save_sys_log (phone ,
              acc_id ,
              pBAN,
              10,
              ret);
 return ret; 
end;

-- Подключение / отключение услуги
function addDelSOC(tok in varchar2, phone in varchar2, soc in varchar2, 
  inclusionType in varchar2, effDate in date, expDate in date, acc_id in number
  ) return SOAP_API_ANSWER_TYPE is
    soap_text varchar2(32767); 
    sURL varchar2(100);
    sINTERFACE varchar2(100);
    Err_text varchar2(1000);
    pBan number;
begin 
--Инициализация  
ret:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);
sINTERFACE:='addDelSOCRequest';
sURL:='/SubscriberService';
--1753-01-01T00:00:00.000 
--Это текст непосредственно SOAP 
soap_text:='<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:addDelSOC>
        <token>'||tok||'</token>
        <hash></hash>
        <ctn>'||phone||'</ctn>
        <soc>'||soc||'</soc>
        <inclusionType>'||inclusionType||'</inclusionType>
';
  IF effDate IS NOT NULL THEN
    soap_text:=soap_text || '      <effDate>'||to_char(effDate,'yyyy-mm-dd"T"hh24:mi:ss".0"')||'</effDate>
';
  END IF;
  IF expDate IS NOT NULL THEN
    soap_text:=soap_text || '      <expDate>'||to_char(expDate,'yyyy-mm-dd"T"hh24:mi:ss".0"')||'</expDate>
';
  END IF;
soap_text:=soap_text || '      </urn:addDelSOC>
   </soapenv:Body>
</soapenv:Envelope>'; 
--Запрос 
 Err_text:=create_conn(soap_text,sURL,sINTERFACE,phone,acc_id,15);    
  --sys_log
  begin 
    select i.ban into pban from beeline_loader_inf i where i.phone_number=phone;
  exception
    when others then null;
  end;
 save_sys_log (phone ,
              acc_id ,
              pBAN,
              15,
              ret);
 return ret; 
end; 
--
function getRequestList(tok in varchar2,request in number, Plog in varchar2, pAcc_id in number) return SOAP_API_ANSWER_TYPE as 
    soap_text varchar2(32767); 
    sURL varchar2(100);
    sINTERFACE varchar2(100);
    Err_text varchar2(1000);
   
begin 
--Инициализация  
ret:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);
sINTERFACE:='getRequestList';
sURL:='/SubscriberService';
soap_text:='<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:getRequestList>
        <token>'||tok||'</token>
        <hash></hash>
        <login>'||Plog||'</login>
        <page>1</page>
        <requestId>'||request||'</requestId>
      </urn:getRequestList>
   </soapenv:Body>
</soapenv:Envelope>';

--Запрос 
 Err_text:=create_conn(soap_text,sURL,sINTERFACE,'',pAcc_id,13);    
 if Err_text!='OK' then null;end if;--надо куда-нить воткнуть доп. логирование полегче....
 return ret;
end; 
 
--заказ отчета по начислениям счёта.
function createBillChargesRequest(tok in varchar2,Ban in number, pAcc_id in number,Pbill_Date in date) return SOAP_API_ANSWER_TYPE as 
    soap_text varchar2(32767); 
    sURL varchar2(100);
    sINTERFACE varchar2(100);
    Err_text varchar2(1000);
   
begin 
--Инициализация  
ret:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);
sINTERFACE:='createBillChargesRequest';
sURL:='/SubscriberService';
soap_text:='<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:createBillChargesRequest>
        <token>'||tok||'</token>
        <hash></hash>
        <ban>'||ban||'</ban>
        <billDate>'||to_char(Pbill_Date,'yyyy-mm-dd')||'T'||'00:00:00'||'.000'||'</billDate>
      </urn:createBillChargesRequest>
   </soapenv:Body>
</soapenv:Envelope>';

--Запрос 
 Err_text:=create_conn(soap_text,sURL,sINTERFACE,'',pAcc_id,5);    
 if Err_text!='OK' then null;end if;--надо куда-нить воткнуть доп. логирование полегче....
 return ret;
end; 

--получение отчета по начислениям счёта.
function getBillCharges(tok in varchar2,Req_id in varchar2,acc_id in  number) return SOAP_API_ANSWER_TYPE as 
    soap_text varchar2(32767); 
    sURL varchar2(100);
    sINTERFACE varchar2(100);
    Err_text varchar2(1000);
begin 
--Инициализация  
ret:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);
sINTERFACE:='getBillCharges';
sURL:='/SubscriberService';
/*
<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <SOAP-ENV:Body>
        <getBillCharges xmlns="urn:uss-wsapi:Subscriber">
            <token xmlns="">CB93815C96BF208734F06CF597B12C73</token>
            <hash xmlns=""></hash>
            <requestId xmlns="">2185195147</requestId>
        </getBillCharges>
    </SOAP-ENV:Body>
</SOAP-ENV:Envelope>*/
--Это текст непосредственно SOAP  
soap_text:='<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:getBillCharges>
        <token>'||tok||'</token>
        <hash></hash>
        <requestId>'||Req_id||'</requestId>
      </urn:getBillCharges>
   </soapenv:Body>
</soapenv:Envelope>'; 


--Запрос 
 Err_text:=create_conn(soap_text,sURL,sINTERFACE,null,Acc_id,5);    
--sys_log только если что-то не так.
  if ret.Err_text!='OK' or Err_text!='OK' then  save_sys_log (null ,
                                            acc_id ,
                                            null,
                                            2,
                                            ret);
  end if;

 return ret;  

end;

--Список Банов по коллекторским лицевым счетам...
function getBANInfoList(tok in varchar2,pLogin in varchar2, pAcc_id in number,hashs in varchar2) return SOAP_API_ANSWER_TYPE as 
    soap_text varchar2(32767); 
    sURL varchar2(100);
    sINTERFACE varchar2(100);
    Err_text varchar2(1000);

begin 
--Инициализация  
ret:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);
sINTERFACE:='getBANInfoList';
sURL:='/SubscriberService';
soap_text:='<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:getBANInfoList>
        <token>'||tok||'</token>
        <hash>'||hashs||'</hash>
        <login>'||pLogin||'</login>
      </urn:getBANInfoList>
   </soapenv:Body>
</soapenv:Envelope>';

--Запрос 
 Err_text:=create_conn(soap_text,sURL,sINTERFACE,null,pAcc_id,14);    
if Err_text!='OK' then null;end if;
 save_sys_log (null,
               pAcc_id,
                null,
                14,
                ret);
 return ret;
end;

--Текущие начисления для всех 
function getUnbilledBalances(tok in varchar2,phone in varchar2,pban in varchar2,hashs in varchar2) return SOAP_API_ANSWER_TYPE as 
    soap_text varchar2(32767); 
    sURL varchar2(100);
    sINTERFACE varchar2(100);
    Err_text varchar2(1000);
    Acc_id number(3);
begin 
--Инициализация  
ret:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);
sINTERFACE:='getUnbilledBalances';
sURL:='/SubscriberService';
soap_text:='<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:getUnbilledBalances>
        <token>'||tok||'</token>
        <hash>'||hashs||'</hash>
        <ctn>'||phone||'</ctn>
      </urn:getUnbilledBalances>
   </soapenv:Body>
</soapenv:Envelope>';
   begin
      Select distinct t.account_id into Acc_id from accounts t where t.account_number=pban;
   exception -- определяет головной BAN коллекторского счёта.
     when no_data_found then select distinct w.account_id into Acc_id from BEELINE_LOADER_INF w where w.ban=pban;
   end;
--Запрос 
 Err_text:=create_conn(soap_text,sURL,sINTERFACE,phone,Acc_id,6);    
 --sys_log, only if SMTH wrong;
if ret.Err_text!='OK' or Err_text!='OK' then save_sys_log (phone ,
                                        acc_id ,
                                        pban,
                                        6,
                                        ret);
end if;
 return ret;
end;

--Текущие начисления быстрый метод без логирования в SOAP_LOG
function getUnbilledBalances(tok in varchar2,phone in varchar2,pacc in number) return SOAP_API_ANSWER_TYPE as 
    soap_text varchar2(32767); 
    sURL varchar2(100);
    sINTERFACE varchar2(100);
    Err_text varchar2(1000);

begin 
--Инициализация  
ret:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);
sINTERFACE:='getUnbilledBalances';
sURL:='/SubscriberService';
soap_text:='<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:getUnbilledBalances>
        <token>'||tok||'</token>
        <ctn>'||phone||'</ctn>
      </urn:getUnbilledBalances>
   </soapenv:Body>
</soapenv:Envelope>';
--Запрос 
 Err_text:=create_conn(soap_text,sURL,sINTERFACE,phone,pacc,62);    
 return ret;
end;  

--Смена тарифного плана
function changePP(tok IN VARCHAR2, hashs IN VARCHAR2, phone IN VARCHAR2, acc_id IN NUMBER, PpricePlan IN VARCHAR2, futureDate IN VARCHAR2  DEFAULT  'N') RETURN  SOAP_API_ANSWER_TYPE AS
    soap_text VARCHAR2(32767);
    sURL VARCHAR2(100);
    sINTERFACE VARCHAR2(100);
    Err_text VARCHAR2(1000);
	pBan number;
BEGIN
    ret := SOAP_API_ANSWER_TYPE(NULL, NULL, NULL);
    sURL := '/SubscriberService';
    sINTERFACE := 'changePPRequest';

    soap_text :='<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
        <soapenv:Header/>
          <soapenv:Body>
            <urn:changePP>
              <token>' || tok || '</token>
              <hash>' || hashs || '</hash>
              <ctn>' || phone || '</ctn>
			  <pricePlan>' || PpricePlan || '</pricePlan>
              <futureDate>' || futureDate || '</futureDate>
            </urn:changePP>
          </soapenv:Body>
      </soapenv:Envelope>';

    --Запрос
	Err_text := create_conn(soap_text, sURL, sINTERFACE, phone, acc_id, 22);
	--sys_log
	begin 
      select i.ban into pban from beeline_loader_inf i where i.phone_number = phone;
    exception
      when others then null;
    end;
	save_sys_log (phone, acc_id, pban, 22, ret);

    RETURN  ret; 
END;

--получение номера SIM карты для BAN
FUNCTION getSIMList(tok IN VARCHAR2, hashs IN VARCHAR2, ban IN VARCHAR2, phone IN VARCHAR2 DEFAULT NULL) RETURN  SOAP_API_ANSWER_TYPE AS
    soap_text VARCHAR2(32767);
    sURL VARCHAR2(100);
    sINTERFACE VARCHAR2(100);
    Err_text VARCHAR2(1000);
    acc_id NUMBER;
BEGIN
    ret := SOAP_API_ANSWER_TYPE( NULL, NULL, NULL );
    sURL := '/SubscriberService';
    sINTERFACE := 'getSIMListRequest';

    soap_text :='<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
        <soapenv:Header/>
          <soapenv:Body>
            <urn:getSIMList>
              <token>' || tok || '</token>
              <hash>' || hashs || '</hash>
              <ban>' || ban || '</ban>
              <ctn>' || phone || '</ctn>
            </urn:getSIMList>
          </soapenv:Body>
      </soapenv:Envelope>';

    SELECT t.account_id INTO acc_id FROM accounts t WHERE t.account_number = ban;
    --Запрос
    Err_text := create_conn(soap_text, sURL, sINTERFACE, phone, acc_id, 23);
    --sys_log
    save_sys_log (phone, acc_id, ban, 23, ret);

    RETURN  ret;
END;

--получение информации о корректировках BAN
FUNCTION getAdjustmentList(tok IN VARCHAR2, hashs IN VARCHAR2, ban IN VARCHAR2, startDate IN DATE, endDate IN DATE) RETURN SOAP_API_ANSWER_TYPE AS
    soap_text VARCHAR2(32767);
    sURL VARCHAR2(100);
    sINTERFACE VARCHAR2(100);
    Err_text VARCHAR2(1000);
    acc_id NUMBER;
BEGIN
    ret := SOAP_API_ANSWER_TYPE(NULL, NULL, NULL);
    sURL := '/SubscriberService';
    sINTERFACE := 'getAdjustmentListRequest';

    soap_text :='<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
        <soapenv:Header/>
          <soapenv:Body>
            <urn:getAdjustmentList>
              <token>' || tok || '</token>
              <hash>' || hashs || '</hash>
              <ban>' || ban || '</ban>
              <startDate>' || to_char(startDate, 'yyyy-mm-dd') || 'T' || '00:00:00' || '.000' || '</startDate>
              <endDate>' || to_char(endDate, 'yyyy-mm-dd') || 'T' || '00:00:00' || '.000' || '</endDate>
            </urn:getAdjustmentList>
          </soapenv:Body>
      </soapenv:Envelope>';

    SELECT t.account_id INTO acc_id FROM accounts t WHERE t.account_number = ban;
    --Запрос
    Err_text := create_conn(soap_text, sURL, sINTERFACE, null, acc_id, 24);
    --sys_log
	save_sys_log (null, acc_id, ban, 24, ret);

    RETURN  ret;
END;

--заказ отчета по детализации счета для списка CTN. (список номеров указывается через запятую)
FUNCTION createBillCallsRequest(tok IN VARCHAR2, hashs IN VARCHAR2, ban IN VARCHAR2, pAcc_id in number, billDate IN DATE, CTNList IN VARCHAR2 DEFAULT NULL) RETURN SOAP_API_ANSWER_TYPE  AS
    soap_text VARCHAR2(32767);
    sURL VARCHAR2(100);
    sINTERFACE VARCHAR2(100);
    Err_text VARCHAR2(1000);
	pCTNListTag VARCHAR2(10000);
BEGIN
    ret := SOAP_API_ANSWER_TYPE(NULL, NULL, NULL);
    sURL := '/SubscriberService';
    sINTERFACE := 'createBillCallsRequestRequest';
	
	--определяем список абонентов
	pCTNListTag := '';
	WHILE INSTR(CTNList,',') > 0 LOOP
      --берем номер и создаем с ним строку CTN
	  pCTNListTag := '<CTNList>'||SUBSTR(CTNList, INSTR(CTNList,',') - 10, 10)||'</CTNList>';
	  --обрезаем строку
	  CTNList := SUBSTR(CTNList, INSTR(CTNList,',') + 1);
    END LOOP;

    soap_text :='<?xml version="1.0" encoding="utf-8"?>
	  <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
        <soapenv:Header/>
          <soapenv:Body>
            <urn:createBillCallsRequest>
              <token>' || tok || '</token>
              <hash>' || hashs || '</hash>
              <ban>' || ban || '</ban>
              <billDate>' || to_char(billDate, 'yyyy-mm-dd') || 'T' || '00:00:00' || '.000' || '</billDate> 
			  '|| pCTNListTag ||'
            </urn:createBillCallsRequest>
          </soapenv:Body>
      </soapenv:Envelope>';

    --Запрос
    Err_text := create_conn(soap_text, sURL, sINTERFACE, null, pAcc_id, 25);
	--sys_log
    if Err_text!='OK' then 
	  null;
	end if;

    RETURN  ret;
END;

--получение отчета по детализации счета для списка CTN
FUNCTION getBillCalls(tok IN VARCHAR2, hashs IN VARCHAR2, requestId INTEGER, acc_id IN NUMBER) RETURN SOAP_API_ANSWER_TYPE  AS
    soap_text VARCHAR2(32767);
    sURL VARCHAR2(100);
    sINTERFACE VARCHAR2(100);
    Err_text VARCHAR2(1000);
BEGIN
    ret := SOAP_API_ANSWER_TYPE(NULL, NULL, NULL);
    sURL := '/SubscriberService';
    sINTERFACE := 'getBillCallsRequest';

    soap_text :='<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
        <soapenv:Header/>
          <soapenv:Body>
            <urn:getBillCalls>
              <token>' || tok || '</token>
              <hash>' || hashs || '</hash>
              <requestId>' || requestId || '</requestId>
            </urn:getBillCalls>
          </soapenv:Body>
      </soapenv:Envelope>';
   
    --Запрос
    Err_text := create_conn(soap_text, sURL, sINTERFACE, null, acc_id, 26);
	--sys_log
    save_sys_log (null, acc_id, null, 26, ret);

    RETURN  ret;
END;

--формирование и отправка на e-mail заказанной детализации PDF для prepaid B2C и prepaid B2B
FUNCTION createDetailsRequest(tok IN VARCHAR2, hashs IN VARCHAR2, phone IN VARCHAR2, periodStart IN DATE, periodEnd IN DATE, format IN VARCHAR2, acc_id IN NUMBER) RETURN SOAP_API_ANSWER_TYPE AS
    soap_text VARCHAR2(32767);
    sURL VARCHAR2(100);
    sINTERFACE VARCHAR2(100);
    Err_text VARCHAR2(1000);
	pBan number;
BEGIN
    ret := SOAP_API_ANSWER_TYPE(NULL, NULL, NULL);
    sURL := '/SubscriberService';
    sINTERFACE := 'createDetailsRequest';

    soap_text :='<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
      <soapenv:Header/>
        <soapenv:Body>
          <urn:createDetailsRequest>
            <token>' || tok || '</token>
            <hash>' || hashs || '</hash>
            <periodStart>' || to_char(periodStart, 'yyyy-mm-dd') || 'T' || to_char(periodStart, 'hh24:mi:ss') || '</periodStart>
            <periodEnd>' || to_char(periodEnd, 'yyyy-mm-dd') || 'T' || to_char(periodEnd, 'hh24:mi:ss') || '</periodEnd>
            <ctn>' || phone || '</ctn>
            <format>' || format || '</format>
          </urn:createDetailsRequest>
        </soapenv:Body>
      </soapenv:Envelope>';

    --Запрос
    Err_text := create_conn(soap_text, sURL, sINTERFACE, phone, acc_id, 27);
	--sys_log
	begin 
      select i.ban into pban from beeline_loader_inf i where i.phone_number=phone;
    exception
      when others then null;
    end;
    save_sys_log(phone, acc_id, pban, 27, ret);

    RETURN  ret;
END;

--получение файла детализации (в формате PDF)
FUNCTION getDetails(tok IN VARCHAR2, hashs IN VARCHAR2, requestId INTEGER, acc_id IN NUMBER) RETURN SOAP_API_ANSWER_TYPE AS
    soap_text VARCHAR2(32767);
    sURL VARCHAR2(100);
    sINTERFACE VARCHAR2(100);
    Err_text VARCHAR2(1000);
BEGIN
    ret := SOAP_API_ANSWER_TYPE(NULL, NULL, NULL);
    sURL := '/SubscriberService';
    sINTERFACE := 'getDetailsRequest';

    soap_text :='<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
        <soapenv:Header/>
          <soapenv:Body>
            <urn:getDetails>
            <token>' || tok || '</token>
            <hash>' || hashs || '</hash>
            <requestId>' || requestId || '</requestId>
          </urn:getDetails>
        </soapenv:Body>
      </soapenv:Envelope>';

    --Запрос
    Err_text := create_conn(soap_text, sURL, sINTERFACE, null, acc_id, 28);
	--sys_log
	save_sys_log(null, acc_id, null, 28, ret);

    RETURN  ret;
END;

--изменение номера
FUNCTION changeNumber(tok IN VARCHAR2, hashs IN VARCHAR2, oldPhone IN VARCHAR2, newPhone IN VARCHAR2, acc_id IN NUMBER) RETURN SOAP_API_ANSWER_TYPE AS
    soap_text VARCHAR2(32767);
    sURL VARCHAR2(100);
    sINTERFACE VARCHAR2(100);
    Err_text VARCHAR2(1000);
	pBan number;
BEGIN
    ret := SOAP_API_ANSWER_TYPE(NULL, NULL, NULL);
    sURL := '/SubscriberService';
    sINTERFACE := 'changeNumber';

    soap_text :='<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
        <soapenv:Header/>
          <soapenv:Body>
            <urn:changeNumber>
              <token>' || tok || '</token>
              <hash>' || hashs || '</hash>
              <oldCtn>' || oldPhone || '</oldCtn>
              <newCtn>' || newPhone || '</newCtn>
            </urn:changeNumber>
          </soapenv:Body>
      </soapenv:Envelope>';

    --Запрос
	Err_text := create_conn(soap_text, sURL, sINTERFACE, oldPhone, acc_id, 29);
	--sys_log
	begin 
      select i.ban into pban from beeline_loader_inf i where i.phone_number = oldPhone;
    exception
      when others then null;
    end;
    save_sys_log(newPhone, acc_id, pban, 29, ret);

    RETURN  ret;
END;

--изменение BAN
FUNCTION changeBan(tok IN VARCHAR2, hashs IN VARCHAR2, oldBan IN VARCHAR2, newBan IN VARCHAR2) RETURN SOAP_API_ANSWER_TYPE AS
    soap_text VARCHAR2(32767);
    sURL VARCHAR2(100);
    sINTERFACE VARCHAR2(100);
    Err_text VARCHAR2(1000);
    acc_id NUMBER(3);
BEGIN
    ret := SOAP_API_ANSWER_TYPE(NULL, NULL, NULL);
    sURL := '/SubscriberService';
    sINTERFACE := 'changeBan';

    soap_text :='<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
        <soapenv:Header/>
          <soapenv:Body>
            <urn:changeBan>
              <token>' || tok || '</token>
              <hash>' || hashs || '</hash>
              <oldBan>' || oldBan || '</oldBan>
              <newBan>' || newBan || '</newBan>
            </urn:changeBan>
          </soapenv:Body>
      </soapenv:Envelope>';

    SELECT t.account_id INTO acc_id FROM accounts t WHERE t.account_number = oldBan;
    
	--Запрос
    Err_text := create_conn(soap_text, sURL, sINTERFACE, null, acc_id, 30);
	--sys_log
    save_sys_log(null, acc_id, newBan, 30, ret);

    RETURN  ret;
END;

--отмена CTN(номера)
FUNCTION cancelCtn(tok IN VARCHAR2, hashs IN VARCHAR2, phone IN VARCHAR2, acc_id IN NUMBER) RETURN SOAP_API_ANSWER_TYPE AS
    soap_text VARCHAR2(32767);
    sURL VARCHAR2(100);
    sINTERFACE VARCHAR2(100);
    Err_text VARCHAR2(1000);
	pBan number;
BEGIN
    ret := SOAP_API_ANSWER_TYPE(NULL, NULL, NULL);
    sURL := '/SubscriberService';
    sINTERFACE := 'cancelCtn';

    soap_text :='<?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:uss-wsapi:Subscriber">
        <soapenv:Header/>
          <soapenv:Body>
            <urn:cancelCtn>
              <token>' || tok || '</token>
              <hash>' || hashs || '</hash>
              <ctn>' || phone || '</ctn>
            </urn:cancelCtn>
          </soapenv:Body>
      </soapenv:Envelope>';

    --Запрос
	Err_text := create_conn(soap_text, sURL, sINTERFACE, phone, acc_id, 32);
	--sys_log
	begin 
      select i.ban into pban from beeline_loader_inf i where i.phone_number = phone;
    exception
      when others then null;
    end;
    save_sys_log(phone, acc_id, pban, 32, ret);
    
    RETURN  ret;
END;

END;
/
--#end if
