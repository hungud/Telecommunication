
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."TEST_USSDCALBACKOUT" (pPHONEA IN VARCHAR2)
  RETURN varchar2 IS
  --#Version=1
  PRAGMA AUTONOMOUS_TRANSACTION;
  USSD_BACK_TXT  VARCHAR2(300 CHAR);
  accountid  integer;
  balance    number;
  req        utl_http.req;--запрос
  resp       utl_http.resp;--ответ
  s_url      varchar2(256);
  response_env varchar2(256);
  vPHONE_number varchar2(11);
  vstatus varchar2(1);

BEGIN

-- вызов процедуры tasks на сервере обмена для вставки туда записи.
/*http://5.9.175.165:83/test_mysql?phone_number=9623630138*/
begin
s_url:='http://5.9.175.165:83/test_mysql?phone_number=2:'||pPHONEA;

       req:= utl_http.begin_request(s_url);
        utl_http.set_body_charset(req,'UTF-8');
        resp := utl_http.get_response(req);
        utl_http.read_text(resp, response_env);
 response_env:=replace(response_env,'"result":','');

   /*     if resp.status_code in (200) then
         USSD_BACK_TXT:='Заявка на подключение услуги callback принята';
         end if;

         if resp.status_code not in (200) then
         USSD_BACK_TXT:='Ошибка принятия заявки! Попробуйте еще раз!';
         end if;*/

         select substr(pPHONEA,1,instr(pPHONEA,':')-1) into vstatus from dual;
         select substr(pPHONEA,instr(pPHONEA,':')+1,length(pPHONEA) )  into vPHONE_number from dual;

          if response_env='{1}' then


         USSD_BACK_TXT:='Заявка на отключение услуги Са11Васк принята';
          INSERT INTO tasks (login, type, status) VALUES (vPHONE_number, 'del', 'new');


          commit;
         end if;

         if response_env<>'{1}' then
         USSD_BACK_TXT:='Ошибка принятия заявки! Попробуйте еще раз!';
         end if;

         if resp.status_code > 0 then UTL_HTTP.END_RESPONSE(resp); end if;

        exception when others then
        USSD_BACK_TXT:='Ошибка выполнения функции!';
        if resp.status_code > 0 then UTL_HTTP.END_RESPONSE(resp); end if;
        end;

  return USSD_BACK_TXT;

end;
