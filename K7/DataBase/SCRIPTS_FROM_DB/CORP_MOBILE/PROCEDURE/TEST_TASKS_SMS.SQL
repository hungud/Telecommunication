
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."TEST_TASKS_SMS" IS

  USSD_BACK_TXT        VARCHAR2(300 CHAR) := '-1';
  req                  utl_http.req; --запрос
  resp                 utl_http.resp; --ответ
  s_url                varchar2(256);
  response_env         varchar2(256);
  response_env1        varchar2(256);
  SMS                  VARCHAR2(2000);
  ins_date_obmen_tasks varchar2(1);

begin

  for x in (select * from tasks where nvl(sms, 0) = 0) loop
  
    begin
      -- вот тут вызов новой процедуры test_get_mysql по аналогии с test_mysql
      if x.type = 'add' then
        s_url := 'http://5.9.175.165:83/ftasksres?phone_number=1:' ||
                 x.login;
      end if;
    
      if x.type = 'del' then
        s_url := 'http://5.9.175.165:83/ftasksres?phone_number=2:' ||
                 x.login;
      end if;
    
      req := utl_http.begin_request(s_url);
      utl_http.set_body_charset(req, 'UTF-8');
      resp := utl_http.get_response(req);
      utl_http.read_text(resp, response_env);
    
      response_env := substr(response_env,
                             instr(response_env, '":"') + 3,
                             instr(response_env, '"}') -
                             instr(response_env, '":"') - 3);
    
      if response_env = 'done' then
      
        if x.type = 'add' then
          USSD_BACK_TXT        := 'Услуга добавлена';
          ins_date_obmen_tasks := '3';
        end if;
        if x.type = 'del' then
          USSD_BACK_TXT        := 'Услуга отключена';
          ins_date_obmen_tasks := '4';
        end if;
      end if;
    
      if response_env = 'failed' then
        USSD_BACK_TXT := 'Неудача';
      end if;
    
      if response_env = 'exist' then
        USSD_BACK_TXT := 'Услуга у Вас уже подключена';
      end if;
    
      if response_env = 'no entry' then
        USSD_BACK_TXT := 'Услуга у Вас не подключена';
      end if;
    
      if response_env = 'none' then
        USSD_BACK_TXT := response_env;
      end if;
    
      --USSD_BACK_TXT:=response_env;
    
      --отправка смс
      if USSD_BACK_TXT not in ('none', '-1') then
        response_env1 := response_env;
        SMS           := LOADER3_pckg.SEND_SMS(x.login,
                                               'SMS-info',
                                               USSD_BACK_TXT);
      
        -- Вызов вставки даты отправки sms в tasks на сервере OBMEN
        if x.type = 'add' then
          s_url := 'http://5.9.175.165:83/test_mysql?phone_number=3:' ||
                   x.login;
        end if;
      
        if x.type = 'del' then
          s_url := 'http://5.9.175.165:83/test_mysql?phone_number=4:' ||
                   x.login;
        end if;
      
        req := utl_http.begin_request(s_url);
        utl_http.set_body_charset(req, 'UTF-8');
        resp := utl_http.get_response(req);
        utl_http.read_text(resp, response_env);
        response_env := replace(response_env, '"result":', '');
      
        if response_env <> '{1}' then
          update tasks
             set sms      = 1,
                 comments = 'Не проставлена дата отправки sms в obmen.tasks',
                 status   = response_env1
           where login = x.login
             and nvl(sms, 0) = 0
             and status = x.status
             and type = x.type
             and insert_date = x.insert_date;
        end if;
        if response_env = '{1}' then
          update tasks
             set sms = 1, status = response_env1
           where login = x.login
             and nvl(sms, 0) = 0
             and status = x.status
             and type = x.type
             and insert_date = x.insert_date;
        end if;
      
        if resp.status_code > 0 then
          UTL_HTTP.END_RESPONSE(resp);
        end if;
      
        commit;
      else
        update tasks
           set status = response_env
         where login = x.login
           and nvl(sms, 0) = 0
           and status = x.status
           and type = x.type
           and insert_date = x.insert_date;
      end if;
    
      if resp.status_code > 0 then
        UTL_HTTP.END_RESPONSE(resp);
      end if;
    
    exception
      when others then
        if resp.status_code > 0 then
          UTL_HTTP.END_RESPONSE(resp);
        end if;
        update tasks set sms = 9 where login = x.login;
        commit;
        null;
    end;
  
  end loop;

end;
