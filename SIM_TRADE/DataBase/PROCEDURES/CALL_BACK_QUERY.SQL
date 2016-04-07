--#if isclient("CORP_MOBILE")
--#if GetVersion("CALL_BACK_QUERY") < 1 then
CREATE OR REPLACE PROCEDURE CALL_BACK_QUERY IS
--#Version=1
--1 Первая версия забытая засвниться Михаилом.
  pphonea    VARCHAR2(11);
  pphoneb    VARCHAR2(11);
  preq_count integer;
  prowid     rowid;
  req        utl_http.req;
  resp       utl_http.resp;
  SMS        VARCHAR2(2000);
  cursor curp is
    select rowid, cbr.phonea, cbr.phoneb, cbr.req_count
      from CALL_BACK_REQUEST cbr;
begin
  open curp;
  loop
    FETCH curp
      into prowid, pphonea, pphoneb, preq_count;
    EXIT WHEN curp%NOTFOUND;
    BEGIN
      req     := utl_http.begin_request(MS_params.GET_PARAM_VALUE('CALL_BACK_URL') ||
                                        '?ani=' || '7' || pphonea || '&' ||
                                        'dest=' || pphoneb || '&' ||
                                        'type=1');
      resp    := utl_http.get_response(req);
      if resp.status_code = 200 then
        insert into CALL_BACK_LOG
        values
          (pphonea,
           pphoneb,
           preq_count + 1,
           null,
           resp.status_code,
           resp.reason_phrase);
        delete CALL_BACK_REQUEST cbr where cbr.rowid = prowid;
        commit;
      elsif preq_count + 1 <
            to_number(MS_params.GET_PARAM_VALUE('CALL_BACK_COUNT_QUERY')) then
        update CALL_BACK_REQUEST cbr set cbr.req_count = preq_count + 1;
        commit;
      else
        insert into CALL_BACK_LOG
        values
          (pphonea,
           pphoneb,
           preq_count + 1,
           null,
           resp.status_code,
           resp.reason_phrase ||
           ' Превышено  количество попыток запроса к сайту партнера.');
        delete CALL_BACK_REQUEST cbr where cbr.rowid = prowid;
        commit;
        SMS := LOADER3_pckg.SEND_SMS(pphonea,
                                     'SMS-info',
                                     MS_params.GET_PARAM_VALUE('CALL_BACK_SMS_ERROR'));
      end if;
      utl_http.end_response(resp);
    EXCEPTION
      WHEN others THEN
        if nvl(resp.status_code, 0) > 0 then
          UTL_HTTP.END_RESPONSE(resp);
        end if;
        insert into CALL_BACK_LOG
        values
          (pphonea,
           pphoneb,
           preq_count + 1,
           null,
           100,
           'Ошибка запроса к сайту партнера.');
        delete CALL_BACK_REQUEST cbr where cbr.rowid = prowid;
        commit;
        SMS := LOADER3_pckg.SEND_SMS(pphonea,
                                     'SMS-info',
                                     MS_params.GET_PARAM_VALUE('CALL_BACK_SMS_ERROR'));
    END;
  end loop;
  close curp;
end;
/

--#end if
--#end if
