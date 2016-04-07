
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."TEST_BI_GETFOT" (tok in varchar2,phone in varchar2,ban in varchar2,hashs in varchar2,sDate in date, eDate in date,tt out integer) return XMLTYPE as
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
      <urn:getPaymentList>
        <token>'||tok||'</token>
        <hash>'||hashs||'</hash>
        <ban>'||ban||'</ban>
        <ctn>'||phone||'</ctn>
        <startDate>'||to_char(sDate,'yyyy-mm-dd')||'T'||to_char(sDate,'hh24:mi:ss')||'.000'||'</startDate>
        <endDate>'||to_char(eDate,'yyyy-mm-dd')||'T'||to_char(eDate,'hh24:mi:ss')||'.000'||'</endDate>
      </urn:getPaymentList>
   </soapenv:Body>
</soapenv:Envelope>';
tt:=10;
    retxml := sys.xmltype.createxml(soap_text);
return retxml;
end;
