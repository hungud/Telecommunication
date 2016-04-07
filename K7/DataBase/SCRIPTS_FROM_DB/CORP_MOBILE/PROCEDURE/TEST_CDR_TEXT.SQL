
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."TEST_CDR_TEXT" IS


  req                  utl_http.req; --запрос
  resp                 utl_http.resp; --ответ
  s_url                varchar2(256);
  response_env         varchar2(256);
  SMS                  VARCHAR2(2000);
  ins_date_obmen_tasks varchar2(1);
  USSD_BACK_TXT varchar2(4000);

begin

    begin
      -- вот тут вызов новой процедуры test_get_mysql по аналогии с test_mysql
      
       s_url := 'http://5.9.175.165:83/ftasksres?phone_number=5:cdr_text';
      
    
      req := utl_http.begin_request(s_url);
      utl_http.set_body_charset(req, 'UTF-8');
      resp := utl_http.get_response(req);
      utl_http.read_text(resp, response_env);
       
     dbms_output.put_line(  'resp.status_code='|| resp.status_code );
 dbms_output.put_line(  '***************' );
  /*    response_env := substr(response_env,
                             instr(response_env, '":"') + 3,
                             instr(response_env, '"}') -
                             instr(response_env, '":"') - 3);*/
                             
                              dbms_output.put_line(response_env);

     /* if response_env = 'done' then

      \*  if x.type = 'add' then
          USSD_BACK_TXT        := 'Услуга добавлена';
          ins_date_obmen_tasks := '3';
        end if;
        if x.type = 'del' then
          USSD_BACK_TXT        := 'Услуга отключена';
          ins_date_obmen_tasks := '4';
        end if;*\
        dbms_output.put_line(123212321212);
      end if;*/

      
      if resp.status_code > 0 then
        UTL_HTTP.END_RESPONSE(resp);
      end if;

    exception
      when others then
        if resp.status_code > 0 then
          UTL_HTTP.END_RESPONSE(resp);
        end if;
       -- update tasks set sms = 9 where login = x.login;
        --commit;
        null;
    end;



end;
