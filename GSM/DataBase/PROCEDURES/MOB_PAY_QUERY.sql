CREATE OR REPLACE PROCEDURE MOB_PAY_QUERY IS
  pphone     VARCHAR2(11);
  psum_pay   number;
  preq_count integer;
  req        utl_http.req;
  resp       utl_http.resp;
  SMS        VARCHAR2(2000);
  urls       varchar2(1000);
  datas      varchar2(1024);
  answer_mes varchar2(2000);
  flp        number;
  cursor curp is
    select distinct cbr.phone, cbr.sum_pay, cbr.req_count
      from MOB_PAY_REQUEST cbr
     where exists (select 1
              from mob_pay mp
             where mp.phone = cbr.phone
               and mp.date_pay is null);
begin
  open curp;
  loop
    FETCH curp
      into pphone, psum_pay, preq_count;
    EXIT WHEN curp%NOTFOUND;
    select count(*)
      into flp
      from mob_pay mp
     where mp.phone = pphone
       and mp.date_pay is null;
    if flp > 0 then
      BEGIN
        urls := '/mobtopup/?phonenr=%2B7' || pphone || '&' || 'amount=' ||
                replace(to_char(psum_pay), ',', '.');
        req  := utl_http.begin_request(MS_params.GET_PARAM_VALUE('MOB_PAY_URL') || urls || '&' ||
                                       'sign=' ||
                                       gnuhash_sha512(urls ||
                                                      MS_params.GET_PARAM_VALUE('MOB_PAY_PASSWORD')));
        resp := utl_http.get_response(req);
        BEGIN
          answer_mes := '';
          LOOP
            UTL_HTTP.READ_TEXT(resp, datas);
            answer_mes := answer_mes || datas;
            --           dbms_output.put_line( datas);
            -- do something with the data
          END LOOP;
        EXCEPTION
          WHEN UTL_HTTP.END_OF_BODY THEN
            NULL;
        END;
        if resp.status_code = 200 then
          insert into MOB_PAY_LOG
          values
            (pphone,
             psum_pay,
             preq_count + 1,
             null,
             resp.status_code,
             resp.reason_phrase || ' ' || answer_mes);
          delete MOB_PAY_REQUEST cbr
           where cbr.phone = pphone
             and cbr.req_count = preq_count
             and cbr.sum_pay = psum_pay;
          commit;
          if instr(answer_mes, '''success'':false') > 0 then
            SMS := LOADER3_pckg.SEND_SMS(pphone,
                                         'SMS-info',
                                         MS_params.GET_PARAM_VALUE('MOB_PAY_SMS_ERROR'));
          else
            update mob_pay mp
               set mp.date_pay = sysdate
             where mp.phone = pphone
               and mp.date_pay is null;
            commit;
          end if;
        elsif preq_count + 1 <
              to_number(MS_params.GET_PARAM_VALUE('MOB_PAY_COUNT_QUERY')) then
          update MOB_PAY_REQUEST cbr set cbr.req_count = preq_count + 1;
          commit;
        else
          insert into MOB_PAY_LOG
          values
            (pphone,
             psum_pay,
             preq_count + 1,
             null,
             resp.status_code,
             resp.reason_phrase || ' ' || answer_mes ||
             ' Превышено  количество попыток запроса к сайту партнера.');
          delete MOB_PAY_REQUEST cbr
           where cbr.phone = pphone
             and cbr.req_count = preq_count
             and cbr.sum_pay = psum_pay;
          commit;
          SMS := LOADER3_pckg.SEND_SMS(pphone,
                                       'SMS-info',
                                       MS_params.GET_PARAM_VALUE('MOB_PAY_SMS_ERROR'));
        end if;
        utl_http.end_response(resp);
      EXCEPTION
        WHEN others THEN
          utl_http.end_response(resp);
          insert into MOB_PAY_LOG
          values
            (pphone,
             psum_pay,
             preq_count + 1,
             null,
             100,
             'Ошибка запроса к сайту партнера.');
          delete MOB_PAY_REQUEST cbr
           where cbr.phone = pphone
             and cbr.req_count = preq_count
             and cbr.sum_pay = psum_pay;
          commit;
          SMS := LOADER3_pckg.SEND_SMS(pphone,
                                       'SMS-info',
                                       MS_params.GET_PARAM_VALUE('MOB_PAY_SMS_ERROR'));
      END;
    else
      delete MOB_PAY_REQUEST cbr where cbr.phone = pphone;
      commit;
    end if;
  end loop;
  close curp;
end;
