
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."TEST_BI_AUTH" (login in varchar2,password in varchar2) return varchar2 as
    soap_text varchar2(32767);
    env       CLOB;
    http_req  utl_http.req;
    http_resp utl_http.resp;
    url        varchar2(32767);
    retxml  XMLTYPE;
begin

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
DBMS_OUTPUT.PUT_LINE('Запрос AUTH');
DBMS_OUTPUT.PUT_LINE(soap_text);

--в качестве транспортного протокола используем HTTP
url:='http://uatssouss.beeline.ru:80/api/AuthService';
http_req:= utl_http.begin_request(url, 'POST','HTTP/1.1');
--utl_http.set_persistent_conn_support(http_req, TRUE);
utl_http.set_body_charset(http_req, 'UTF-8');
--   utl_http.set_proxy('proxy:80', NULL);
--   utl_http.set_persistent_conn_support(TRUE);
--   UTL_HTTP.set_authentication(http_req, '', '3', 'Basic', TRUE );
utl_http.set_header(http_req, 'Content-Type', 'text/xml');
    utl_http.set_header(http_req, 'Content-Length', length(soap_text));
    utl_http.set_header(http_req, 'SOAPAction', 'http://uatssouss.beeline.ru:80/api/AuthService/urn:uss-wsapi:Auth:AuthInterface:authRequest');
    utl_http.write_text(http_req, soap_text);
    http_resp := utl_http.get_response(http_req);
    utl_http.read_text(http_resp, env);
    utl_http.end_response(http_resp);
   DBMS_OUTPUT.PUT_LINE('Ответ AUTH');
   DBMS_OUTPUT.PUT_LINE(env);

    retxml := sys.xmltype.createxml(env);
    select extractValue(retxml,'S:Envelope/S:Body/ns0:authResponse/return','xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Auth"') into url from dual;
return url;
end;