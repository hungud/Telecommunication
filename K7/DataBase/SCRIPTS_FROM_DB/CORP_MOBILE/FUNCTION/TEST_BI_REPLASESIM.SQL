
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."TEST_BI_REPLASESIM" (tok in varchar2,phone in varchar2,ICC in varchar2,hashs in varchar2) return XMLTYPE as
    soap_text varchar2(32767);
    env       CLOB;
    http_req  utl_http.req;
    http_resp utl_http.resp;
    url        varchar2(32767);
    retxml  XMLTYPE;
begin
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

dbms_output.put_line(soap_text);

--в качестве транспортного протокола используем HTTP
url:='http://217.118.87.62:80/api/SubscriberService';
http_req:= utl_http.begin_request(url, 'POST','HTTP/1.1');
utl_http.set_body_charset(http_req, 'UTF-8');
--   utl_http.set_proxy('proxy:80', NULL);
--   utl_http.set_persistent_conn_support(TRUE);
--   UTL_HTTP.set_authentication(http_req, '', '3', 'Basic', TRUE );
utl_http.set_header(http_req, 'Content-Type', 'text/xml');
    utl_http.set_header(http_req, 'Content-Length', length(soap_text));
    utl_http.set_header(http_req, 'SOAPAction', 'http://217.118.87.62:80/api/SubscriberService/urn:uss-wsapi:Subscriber:SubscriberInterface:replaceSIMRequest');
    utl_http.write_text(http_req, soap_text);
    http_resp := utl_http.get_response(http_req);
    utl_http.read_text(http_resp, env);
    utl_http.end_response(http_resp);
    retxml := sys.xmltype.createxml(env);
return retxml;
end;
