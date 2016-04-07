
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."F_TELETIE_TEST" return integer is
  Result integer;
    req        utl_http.req;--запрос
    resp       utl_http.resp;--ответ

    str varchar2(1000);
begin

          begin
          utl_http.set_transfer_timeout(3);
          req:= utl_http.begin_request('http://teletie.ditrade.ru/teletiepay.php');

          utl_http.set_body_charset(req,'UTF-8');
          resp := utl_http.get_response(req);
          exception
          when others then
          str:=sqlerrm;return(0);
          end;

  if  resp.status_code in (200,400) then result:=1; else result:=0;end if;
  UTL_HTTP.END_RESPONSE(resp);
  return(Result);
end F_TELETIE_TEST;
