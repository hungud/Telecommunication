
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."SEND_DATA_DCCAWS" (url in varchar2, envlp in varchar2,saction in varchar2)
return varchar2
as
    http_req  utl_http.req;
    http_resp utl_http.resp;
    envlp_out varchar2(32767);
    doc       XMLType;
begin
  utl_http.set_wallet('Denis Valentinovich Khramushin');
    http_req := utl_http.begin_request(url, 'POST','HTTP/1.1');
    utl_http.set_body_charset(http_req, 'UTF-8');
    utl_http.set_header (http_req, 'User-Agent', 'Mozilla/4.0' );
    utl_http.set_header(http_req, 'Content-Type', 'text/xml; charset=UTF-8');
    utl_http.set_header(http_req, 'Content-Length', lengthb(convert(envlp, 'utf8')));
    utl_http.set_header(http_req, 'SOAPAction', 'https://dealer.beeline.ru/'||saction);
    utl_http.write_text(http_req, envlp);
    http_resp := utl_http.get_response(http_req);

    utl_http.read_text(http_resp, envlp_out);
    utl_http.end_response(http_resp);

    return envlp_out;
end;
