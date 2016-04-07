create or replace function F_USSD_TEST return integer is
  Result integer;
    req        utl_http.req;--запрос
    resp       utl_http.resp;--ответ
    
    str varchar2(1000);
begin
           
          begin
         -- utl_http.set_transfer_timeout(3);
         -- UTL_HTTP.SET_WALLET( 'file:' || 'c:\oracle_wallets', '7HGOZY2Wu' );
          
          req:= utl_http.begin_request('http://localhost:3128/ussd.php?action=deliver&response=*11%23&msisdn=9623630138&service=123&ussd=*132*11%23&location=&lang=ru');
        --utl_http.set_header(req, 'User-Agent', 'Mozilla/4.0');
         -- req:= utl_http.begin_request('http://teletie.ditrade.ru/teletiepay.php');
          
          utl_http.set_body_charset(req,'UTF-8');
          resp := utl_http.get_response(req);
          exception
          when others then 
          str:=utl_http.get_detailed_sqlerrm;return(0);
          end;
          
  if  resp.status_code=200 then result:=1; else result:=0;end if;        
  UTL_HTTP.END_RESPONSE(resp);
  return(Result);
end F_USSD_TEST;
/
