declare
  prov_id integer;
  CURSOR C IS
    SELECT ssp.LOGIN, ssp.PASSWORD, ssp.SENDER_NAME
      FROM SMS_SEND_PARAMETRS ssp
     WHERE ssp.provider_id = prov_id;
  --
  vREC C%ROWTYPE;
  CURSOR CUR IS
    SELECT rowid,
           sc.provider_id,
           sc.phone,
           sc.message,
           sc.sms_id,
           sc.status_code,
           sc.error_code,
           sc.req_count,
           sc.insert_date,
           sc.update_date,
           sc.result_str,
           sc.description_str,
           sc.date_start
      FROM SMS_CURRENT SC
     WHERE sc.date_start<=sysdate
     and ((sc.status_code = 99 and
           (sc.error_code = 0 or sc.error_code is null or
           (sc.error_code in (6, 7, 43, 40) and
           sc.update_date < sysdate - 1 / 1440)))
        or (sc.status_code in (0, 1) and
           sc.update_date < sysdate - 5 / 1440))
     order by 6 desc;
  pREC CUR%ROWTYPE;
  -- ---------------------------------------------------------------------
  l_envelope      CLOB;
  l_envelope1     CLOB;
  l_textt         VARCHAR2(10000 CHAR);
  l_text          VARCHAR2(30000 CHAR);
  l_http_request  UTL_HTTP.req;
  l_http_response UTL_HTTP.resp;
  --  l_response       t_response;
  l_request_blob    BLOB;
  vLANG_CONTEXT     INTEGER;
  vWARNING          INTEGER;
  vCLOB_DEST_OFFSET INTEGER;
  vBLOB_SRC_OFFSET  INTEGER;
BEGIN
  open cur;
  loop
    FETCH cur
      into pREC;
    EXIT WHEN cur%NOTFOUND;
    if pREC.req_count <
       to_number(MS_params.GET_PARAM_VALUE('SMS_REQ_COUNT')) then
      prov_id := pREC.provider_id;
      open c;
      FETCH c
        into vREC;
      close c;
      l_envelope := 'login=' || vREC.LOGIN || '&' || 'pwd=' ||
                    vREC.PASSWORD || '&';
      if prec.status_code = 99 /*or prec.error_code in (6, 7, 43, 40)*/
       then
        l_envelope1 := 'cmd=sm' || '&' || 'phones=' || pREC.phone || '&' ||
                       'message=' || replace(pREC.message, '+', '%2B') || '&' || 'originator=' ||
                       vREC.SENDER_NAME || '&' || 'hour_start=0' || '&' ||
                       'hour_stop=23' || '&' || 'format=text/plain' || '&' ||
                       'want_sms_ids=1';
      else
        l_envelope1 := 'cmd=status' || '&' || ' sms_id=' || pREC.
                       sms_id || '&' || 'format=text/plain';
      end if;
      DBMS_LOB.APPEND(l_envelope, l_envelope1);
      ----  generate_envelope(p_request, l_envelope);
      ---select UTL_URL.escape('5{!zFz[9@>TKsFw''') from dual
      --select UTL_URL.escape('cmd=sm_test'||'&'||'login=tarifer'||'&'||'pwd='||'5{!zFz[9@>TKsFw'''||'&'||'phones=79689681650'||'&'||'message=test1тест'||'&'||'originator=AgSvyazi'||'&'||'format=text/plain'||'&'||'want_sms_ids=1',True,'UTF8') from dual
      --select 'login=tarifer'||'&'||'pwd='||UTL_URL.escape('5{!zFz[9@>TKsFw''')||'&'||'cmd=sm_test'||'&'||'phones=79689681650'||'&'||'message=test1тест'||'&'||'originator=AgSvyazi'||'&'||'format=text/plain'||'&'||'want_sms_ids=1' from dual    
      --l_envelope:=UTL_URL.escape(l_envelope);
      --show_envelope(l_envelope);
      l_http_request := UTL_HTTP.begin_request('http://smpp-beeline-local.ditrade.ru', --'http://smpp-beeline.ditrade.ru/',
                                               'POST',
                                               'HTTP/1.1');
      -- Преобразуем текст запроса в бинарный вид в кодировке UTF-8
      vCLOB_DEST_OFFSET := 1;
      vBLOB_SRC_OFFSET  := 1;
      vLANG_CONTEXT     := DBMS_LOB.default_lang_ctx;
      DBMS_LOB.CREATETEMPORARY(l_request_blob, TRUE);
      DBMS_LOB.CONVERTTOBLOB(l_request_blob,
                             l_envelope,
                             DBMS_LOB.GETLENGTH(l_envelope),
                             vCLOB_DEST_OFFSET,
                             vBLOB_SRC_OFFSET,
                             NLS_CHARSET_ID('AL32UTF8'),
                             vLANG_CONTEXT,
                             vWARNING);
      -- Освободим ресурсы
      l_envelope := NULL;
      -- Кодировка запроса - UTF8
      utl_http.set_body_charset(l_http_request, 'AL32UTF8');
      UTL_HTTP.SET_TRANSFER_TIMEOUT(l_http_request, 60); -- 8 часов 60*60*8
      UTL_HTTP.set_header(l_http_request,
                          'Content-Type',
                          'application/x-www-form-urlencoded; charset=utf-8');
      UTL_HTTP.set_header(l_http_request,
                          'Content-Length',
                          DBMS_LOB.GETLENGTH(l_request_blob));
      --  UTL_HTTP.set_header(l_http_request, 'SOAPAction', p_action);
      FOR i IN 0 .. TRUNC((DBMS_LOB.GETLENGTH(l_request_blob) - 1) / 32000) LOOP
        UTL_HTTP.write_raw(l_http_request,
                           DBMS_LOB.SUBSTR(l_request_blob,
                                           32000,
                                           i * 32000 + 1));
      END LOOP;
      --UTL_HTTP.write_text(l_http_request,l_envelope);
      DBMS_LOB.FREETEMPORARY(l_request_blob);
      --
      l_http_response := UTL_HTTP.get_response(l_http_request);
      --     dbms_output.put_line(l_http_response.status_code);
      BEGIN
        -- Кодировка результата - UTF8
        utl_http.set_body_charset(l_http_response, 'AL32UTF8');
        LOOP
          UTL_HTTP.read_text(l_http_response, l_textt, 10000);
          EXIT WHEN l_textt IS NULL;
          l_text := l_text || l_textt;
        end loop;
      EXCEPTION
        WHEN utl_http.end_of_body THEN
          utl_http.end_response(l_http_response);
        WHEN OTHERS THEN
          utl_http.end_response(l_http_response);
          --    pERROR_TEXT := SQLERRM;
        --      RAISE;*/
      END;
      dbms_output.put_line(l_text);
      if l_text is not null and l_http_response.status_code = 200 then
        if prec.status_code = 99 /*or prec.error_code in (6, 7, 43, 40)*/
         then
          if regexp_substr(l_text, '[^;]+', 1, 2) in
             ('0', '6', '7', '43', '40') then
            if regexp_substr(l_text, '[^;]+', 1, 2) = '0' then
              update SMS_CURRENT sc
                 set sc.status_code     = 0,
                     sc.error_code      = to_number(regexp_substr(l_text,
                                                                  '[^;]+',
                                                                  1,
                                                                  2)),
                     sc.result_str      = regexp_substr(l_text,
                                                        '[^;]+',
                                                        1,
                                                        1),
                     sc.description_str = regexp_substr(l_text,
                                                        '[^;]+',
                                                        1,
                                                        3),
                     sc.sms_id          = to_number(regexp_substr(l_text,
                                                                  '[^;]+',
                                                                  1,
                                                                  5)),
                     sc.req_count       = sc.req_count + 1
               where sc.rowid = pREC.rowid;
              commit;
            else           
              update SMS_CURRENT sc
                 set --sc.status_code     = 99,
                         sc.error_code = to_number(regexp_substr(l_text,
                                                                 '[^;]+',
                                                                 1,
                                                                 2)),
                     sc.result_str      = regexp_substr(l_text,
                                                        '[^;]+',
                                                        1,
                                                        1),
                     sc.description_str = regexp_substr(l_text,
                                                        '[^;]+',
                                                        1,
                                                        3),
                     sc.req_count       = sc.req_count + 1
               where sc.rowid = pREC.rowid;
              if to_number(MS_params.GET_PARAM_VALUE('SMS_LOG_REQ_COUNT')) = 1 then
                insert into sms_log
                values
                  (pREC.phone,
                   pREC.message,
                   prec.sms_id,
                   pREC.insert_date,
                   pREC.insert_date,
                   pREC.update_date,
                   'Error! Resent:' || regexp_substr(l_text, '[^;]+', 1, 1),
                   prec.status_code,
                   to_number(regexp_substr(l_text, '[^;]+', 1, 2)),
                   regexp_substr(l_text, '[^;]+', 1, 3) || ' Full:' ||
                   l_text,
                   sysdate,
                   prec.req_count,
                   prec.date_start);
              end if;
              commit;
            end if;
          else
            delete SMS_CURRENT sc where sc.rowid = pREC.rowid;
            insert into sms_log
            values
              (pREC.phone,
               pREC.message,
               prec.sms_id,
               pREC.insert_date,
               pREC.insert_date,
               pREC.update_date,
               regexp_substr(l_text, '[^;]+', 1, 1),
               prec.status_code,
               to_number(regexp_substr(l_text, '[^;]+', 1, 2)),
               regexp_substr(l_text, '[^;]+', 1, 3),
               sysdate,
               prec.req_count + 1,
               prec.date_start);
            commit;
          end if;
        else
          if regexp_substr(l_text, '[^;]+', 1, 6) in ('0', '1') /* or
                       regexp_substr(l_text, '[^;]+', 1, 7) in ('6', '7', '43', '40')*/
           then
            /*          if regexp_substr(l_text, '[^;]+', 1, 7) in ('6', '7', '43','40') then
              update SMS_CURRENT sc
                 set sc.error_code = to_number(regexp_substr(l_text,
                                                             '[^;]+',
                                                             1,
                                                             7)),
                      sc.req_count= sc.req_count
               where sc.rowid = pREC.rowid;
              commit;
            else*/
            update SMS_CURRENT sc
               set sc.status_code = to_number(regexp_substr(l_text,
                                                            '[^;]+',
                                                            1,
                                                            6)),
                   sc.error_code  = to_number(regexp_substr(l_text,
                                                            '[^;]+',
                                                            1,
                                                            7))
             where sc.rowid = pREC.rowid;
            commit;
            --          end if;
          else
            delete SMS_CURRENT sc where sc.rowid = pREC.rowid;
            insert into sms_log
            values
              (pREC.phone,
               pREC.message,
               prec.sms_id,
               to_date(regexp_substr(l_text, '[^;]+', 1, 2),
                       'yyyy-mm-dd hh24:mi:ss'),
               to_date(regexp_substr(l_text, '[^;]+', 1, 3),
                       'yyyy-mm-dd hh24:mi:ss'),
               to_date(regexp_substr(l_text, '[^;]+', 1, 4),
                       'yyyy-mm-dd hh24:mi:ss'),
               regexp_substr(l_text, '[^;]+', 1, 5),
               to_number(regexp_substr(l_text, '[^;]+', 1, 6)),
               to_number(regexp_substr(l_text, '[^;]+', 1, 7)),
               regexp_substr(l_text, '[^;]+', 1, 8),
               sysdate,
               pREC.req_count,
               prec.date_start);
            commit;
          end if;
        end if;
      else
        delete SMS_CURRENT sc where sc.rowid = pREC.rowid;
        insert into sms_log
        values
          (pREC.phone,
           pREC.message,
           prec.sms_id,
           pREC.insert_date,
           pREC.insert_date,
           pREC.update_date,
           'HTTP Error',
           l_http_response.status_code,
           l_http_response.status_code,
           l_http_response.reason_phrase,
           sysdate,
           pREC.req_count + 1,
           prec.date_start);
        commit;
      end if;
      l_text := null;
    else
      delete SMS_CURRENT sc where sc.rowid = pREC.rowid;
      insert into sms_log
      values
        (pREC.phone,
         pREC.message,
         prec.sms_id,
         pREC.insert_date,
         pREC.insert_date,
         pREC.update_date,
         'Max request count:' || pREC.result_str,
         pREC.status_code,
         pREC.error_code,
         pREC.description_str,
         sysdate,
         pREC.req_count,
         prec.date_start);
      commit;
    end if;
  end loop;
  close cur;
END;
/