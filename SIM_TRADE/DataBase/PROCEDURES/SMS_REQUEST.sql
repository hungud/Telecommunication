/* Formatted on 25/11/2014 13:03:45 (QP5 v5.252.13127.32867) */
CREATE OR REPLACE PROCEDURE SMS_REQUEST
IS
   --
   --#Version=3
   --
   -- V.3 - Афросин 25.11.2014 - Добавил доп.проверку на TeleTie
   -- V.2 - Афросин 24.11.2014 - Добавил возможность задавать имя отрпавителя в поле письма
   --
   prov_id             INTEGER;

   CURSOR C
   IS
      SELECT ssp.LOGIN, ssp.PASSWORD, ssp.SENDER_NAME
        FROM SMS_SEND_PARAMETRS ssp
       WHERE ssp.provider_id = prov_id;

   --
   vREC                C%ROWTYPE;

   CURSOR CUR
   IS
        SELECT ROWID,
               sc.provider_id,
               sc.phone,
               sc.MESSAGE,
               sc.sms_id,
               sc.status_code,
               sc.ERROR_CODE,
               sc.req_count,
               sc.insert_date,
               sc.update_date,
               sc.result_str,
               sc.description_str,
               sc.date_start,
               case Upper(SC.SMS_SENDER_NAME)
                when 'TELETIE' THEN 'Teletie'
                else 
                  SC.SMS_SENDER_NAME
               end SMS_SENDER_NAME
          FROM SMS_CURRENT SC
         WHERE     sc.date_start <= SYSDATE
               AND (   (    sc.status_code = 99
                        AND (   sc.ERROR_CODE = 0
                             OR sc.ERROR_CODE IS NULL
                             OR (    sc.ERROR_CODE IN (6,
                                                       7,
                                                       43,
                                                       40)
                                 AND sc.update_date < SYSDATE - 1 / 1440)))
                    OR (    sc.status_code IN (0, 1)
                        AND sc.update_date < SYSDATE - 5 / 1440))
               AND TRIM (
                      REPLACE (REPLACE (MESSAGE, CHR (13), ''), CHR (10), ''))
                      IS NOT NULL
      ORDER BY 6 DESC;

   pREC                CUR%ROWTYPE;
   -- ---------------------------------------------------------------------
   l_envelope          CLOB;
   l_envelope1         CLOB;
   l_textt             VARCHAR2 (10000 CHAR);
   l_text              VARCHAR2 (30000 CHAR);
   l_http_request      UTL_HTTP.req;
   l_http_response     UTL_HTTP.resp;
   --  l_response       t_response;
   l_request_blob      BLOB;
   vLANG_CONTEXT       INTEGER;
   vWARNING            INTEGER;
   vCLOB_DEST_OFFSET   INTEGER;
   vBLOB_SRC_OFFSET    INTEGER;
BEGIN
   OPEN cur;

   LOOP
      FETCH cur INTO pREC;

      EXIT WHEN cur%NOTFOUND;

      IF pREC.req_count <
            TO_NUMBER (MS_params.GET_PARAM_VALUE ('SMS_REQ_COUNT'))
      THEN
         prov_id := pREC.provider_id;

         OPEN c;

         FETCH c INTO vREC;

         CLOSE c;

         l_envelope :=
            'login=' || vREC.LOGIN || '&' || 'pwd=' || vREC.PASSWORD || '&';

         IF prec.status_code = 99     /*or prec.error_code in (6, 7, 43, 40)*/
         THEN
            l_envelope1 :=
                  'cmd=sm'
               || '&'
               || 'phones='
               || pREC.phone
               || '&'
               || 'message='
               || REPLACE (pREC.MESSAGE, '+', '%2B')
               || '&'
               || 'originator='
               || NVL (pREC.SMS_SENDER_NAME, vREC.SENDER_NAME)
               || '&'
               || 'hour_start=0'
               || '&'
               || 'hour_stop=23'
               || '&'
               || 'format=text/plain'
               || '&'
               || 'want_sms_ids=1';
         ELSE
            l_envelope1 :=
                  'cmd=status'
               || '&'
               || ' sms_id='
               || pREC.sms_id
               || '&'
               || 'format=text/plain';
         END IF;

         DBMS_LOB.APPEND (l_envelope, l_envelope1);
         ----  generate_envelope(p_request, l_envelope);
         ---select UTL_URL.escape('5{!zFz[9@>TKsFw''') from dual
         --select UTL_URL.escape('cmd=sm_test'||'&'||'login=tarifer'||'&'||'pwd='||'5{!zFz[9@>TKsFw'''||'&'||'phones=79689681650'||'&'||'message=test1тест'||'&'||'originator=AgSvyazi'||'&'||'format=text/plain'||'&'||'want_sms_ids=1',True,'UTF8') from dual
         --select 'login=tarifer'||'&'||'pwd='||UTL_URL.escape('5{!zFz[9@>TKsFw''')||'&'||'cmd=sm_test'||'&'||'phones=79689681650'||'&'||'message=test1тест'||'&'||'originator=AgSvyazi'||'&'||'format=text/plain'||'&'||'want_sms_ids=1' from dual

         --l_envelope:=UTL_URL.escape(l_envelope);
         --show_envelope(l_envelope);
         l_http_request :=
            UTL_HTTP.begin_request ('http://smpp-beeline-local.ditrade.ru', --'http://smpp-beeline.ditrade.ru/',
                                    'POST',
                                    'HTTP/1.1');
         -- Преобразуем текст запроса в бинарный вид в кодировке UTF-8
         vCLOB_DEST_OFFSET := 1;
         vBLOB_SRC_OFFSET := 1;
         vLANG_CONTEXT := DBMS_LOB.default_lang_ctx;
         DBMS_LOB.CREATETEMPORARY (l_request_blob, TRUE);
         DBMS_LOB.CONVERTTOBLOB (l_request_blob,
                                 l_envelope,
                                 DBMS_LOB.GETLENGTH (l_envelope),
                                 vCLOB_DEST_OFFSET,
                                 vBLOB_SRC_OFFSET,
                                 NLS_CHARSET_ID ('AL32UTF8'),
                                 vLANG_CONTEXT,
                                 vWARNING);
         -- Освободим ресурсы
         l_envelope := NULL;
         -- Кодировка запроса - UTF8
         UTL_HTTP.set_body_charset (l_http_request, 'AL32UTF8');
         UTL_HTTP.SET_TRANSFER_TIMEOUT (l_http_request, 60); -- 8 часов 60*60*8
         UTL_HTTP.set_header (
            l_http_request,
            'Content-Type',
            'application/x-www-form-urlencoded; charset=utf-8');
         UTL_HTTP.set_header (l_http_request,
                              'Content-Length',
                              DBMS_LOB.GETLENGTH (l_request_blob));

         --  UTL_HTTP.set_header(l_http_request, 'SOAPAction', p_action);
         FOR i IN 0 ..
                  TRUNC ( (DBMS_LOB.GETLENGTH (l_request_blob) - 1) / 32000)
         LOOP
            UTL_HTTP.write_raw (
               l_http_request,
               DBMS_LOB.SUBSTR (l_request_blob, 32000, i * 32000 + 1));
         END LOOP;

         --UTL_HTTP.write_text(l_http_request,l_envelope);
         DBMS_LOB.FREETEMPORARY (l_request_blob);
         --
         l_http_response := UTL_HTTP.get_response (l_http_request);

         --     dbms_output.put_line(l_http_response.status_code);
         BEGIN
            -- Кодировка результата - UTF8
            UTL_HTTP.set_body_charset (l_http_response, 'AL32UTF8');

            LOOP
               UTL_HTTP.read_text (l_http_response, l_textt, 10000);
               EXIT WHEN l_textt IS NULL;
               l_text := l_text || l_textt;
            END LOOP;
         EXCEPTION
            WHEN UTL_HTTP.end_of_body
            THEN
               UTL_HTTP.end_response (l_http_response);
            WHEN OTHERS
            THEN
               UTL_HTTP.end_response (l_http_response);
         --    pERROR_TEXT := SQLERRM;
         --      RAISE;*/
         END;

         --      debug_out(l_text);
         IF l_text IS NOT NULL AND l_http_response.status_code = 200
         THEN
            IF prec.status_code = 99  /*or prec.error_code in (6, 7, 43, 40)*/
            THEN
               IF REGEXP_SUBSTR (l_text,
                                 '[^;]+',
                                 1,
                                 2) IN ('0',
                                        '6',
                                        '7',
                                        '43',
                                        '40')
               THEN
                  IF REGEXP_SUBSTR (l_text,
                                    '[^;]+',
                                    1,
                                    2) = '0'
                  THEN
                     UPDATE SMS_CURRENT sc
                        SET sc.status_code = 0,
                            sc.ERROR_CODE =
                               TO_NUMBER (REGEXP_SUBSTR (l_text,
                                                         '[^;]+',
                                                         1,
                                                         2)),
                            sc.result_str =
                               REGEXP_SUBSTR (l_text,
                                              '[^;]+',
                                              1,
                                              1),
                            sc.description_str =
                               REGEXP_SUBSTR (l_text,
                                              '[^;]+',
                                              1,
                                              3),
                            sc.sms_id =
                               TO_NUMBER (REGEXP_SUBSTR (l_text,
                                                         '[^;]+',
                                                         1,
                                                         5)),
                            sc.req_count = sc.req_count + 1
                      WHERE sc.ROWID = pREC.ROWID;

                     COMMIT;
                  ELSE
                     UPDATE SMS_CURRENT sc
                        SET                         --sc.status_code     = 99,
                           sc.ERROR_CODE =
                               TO_NUMBER (REGEXP_SUBSTR (l_text,
                                                         '[^;]+',
                                                         1,
                                                         2)),
                            sc.result_str =
                               REGEXP_SUBSTR (l_text,
                                              '[^;]+',
                                              1,
                                              1),
                            sc.description_str =
                               REGEXP_SUBSTR (l_text,
                                              '[^;]+',
                                              1,
                                              3),
                            sc.req_count = sc.req_count + 1
                      WHERE sc.ROWID = pREC.ROWID;

                     IF TO_NUMBER (
                           MS_params.GET_PARAM_VALUE ('SMS_LOG_REQ_COUNT')) =
                           1
                     THEN
                        INSERT INTO sms_log
                             VALUES (pREC.phone,
                                     pREC.MESSAGE,
                                     prec.sms_id,
                                     pREC.insert_date,
                                     pREC.insert_date,
                                     pREC.update_date,
                                        'Error! Resent:'
                                     || REGEXP_SUBSTR (l_text,
                                                       '[^;]+',
                                                       1,
                                                       1),
                                     prec.status_code,
                                     TO_NUMBER (REGEXP_SUBSTR (l_text,
                                                               '[^;]+',
                                                               1,
                                                               2)),
                                        REGEXP_SUBSTR (l_text,
                                                       '[^;]+',
                                                       1,
                                                       3)
                                     || ' Full:'
                                     || l_text,
                                     SYSDATE,
                                     prec.req_count,
                                     prec.date_start,
                                     pREC.SMS_SENDER_NAME);
                     END IF;

                     COMMIT;
                  END IF;
               ELSE
                  DELETE SMS_CURRENT sc
                   WHERE sc.ROWID = pREC.ROWID;

                  INSERT INTO sms_log
                       VALUES (pREC.phone,
                               pREC.MESSAGE,
                               prec.sms_id,
                               pREC.insert_date,
                               pREC.insert_date,
                               pREC.update_date,
                               REGEXP_SUBSTR (l_text,
                                              '[^;]+',
                                              1,
                                              1),
                               prec.status_code,
                               TO_NUMBER (REGEXP_SUBSTR (l_text,
                                                         '[^;]+',
                                                         1,
                                                         2)),
                               REGEXP_SUBSTR (l_text,
                                              '[^;]+',
                                              1,
                                              3),
                               SYSDATE,
                               prec.req_count + 1,
                               prec.date_start,
                               pREC.SMS_SENDER_NAME);

                  COMMIT;
               END IF;
            ELSE
               IF REGEXP_SUBSTR (l_text,
                                 '[^;]+',
                                 1,
                                 6) IN ('0', '1') /* or
         regexp_substr(l_text, '[^;]+', 1, 7) in ('6', '7', '43', '40')*/
               THEN
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
                  UPDATE SMS_CURRENT sc
                     SET sc.status_code =
                            TO_NUMBER (REGEXP_SUBSTR (l_text,
                                                      '[^;]+',
                                                      1,
                                                      6)),
                         sc.ERROR_CODE =
                            TO_NUMBER (REGEXP_SUBSTR (l_text,
                                                      '[^;]+',
                                                      1,
                                                      7))
                   WHERE sc.ROWID = pREC.ROWID;

                  COMMIT;
               --          end if;
               ELSE
                  DELETE SMS_CURRENT sc
                   WHERE sc.ROWID = pREC.ROWID;

                  INSERT INTO sms_log
                       VALUES (pREC.phone,
                               pREC.MESSAGE,
                               prec.sms_id,
                               TO_DATE (REGEXP_SUBSTR (l_text,
                                                       '[^;]+',
                                                       1,
                                                       2),
                                        'yyyy-mm-dd hh24:mi:ss'),
                               TO_DATE (REGEXP_SUBSTR (l_text,
                                                       '[^;]+',
                                                       1,
                                                       3),
                                        'yyyy-mm-dd hh24:mi:ss'),
                               TO_DATE (REGEXP_SUBSTR (l_text,
                                                       '[^;]+',
                                                       1,
                                                       4),
                                        'yyyy-mm-dd hh24:mi:ss'),
                               REGEXP_SUBSTR (l_text,
                                              '[^;]+',
                                              1,
                                              5),
                               TO_NUMBER (REGEXP_SUBSTR (l_text,
                                                         '[^;]+',
                                                         1,
                                                         6)),
                               TO_NUMBER (REGEXP_SUBSTR (l_text,
                                                         '[^;]+',
                                                         1,
                                                         7)),
                               REGEXP_SUBSTR (l_text,
                                              '[^;]+',
                                              1,
                                              8),
                               SYSDATE,
                               pREC.req_count,
                               prec.date_start,
                               pREC.SMS_SENDER_NAME);

                  COMMIT;
               END IF;
            END IF;
         ELSE
            DELETE SMS_CURRENT sc
             WHERE sc.ROWID = pREC.ROWID;

            INSERT INTO sms_log
                 VALUES (pREC.phone,
                         pREC.MESSAGE,
                         prec.sms_id,
                         pREC.insert_date,
                         pREC.insert_date,
                         pREC.update_date,
                         'HTTP Error',
                         l_http_response.status_code,
                         l_http_response.status_code,
                         l_http_response.reason_phrase,
                         SYSDATE,
                         pREC.req_count + 1,
                         prec.date_start,
                         pREC.SMS_SENDER_NAME);

            COMMIT;
         END IF;

         l_text := NULL;
      ELSE
         DELETE SMS_CURRENT sc
          WHERE sc.ROWID = pREC.ROWID;

         INSERT INTO sms_log
              VALUES (pREC.phone,
                      pREC.MESSAGE,
                      prec.sms_id,
                      pREC.insert_date,
                      pREC.insert_date,
                      pREC.update_date,
                      'Max request count:' || pREC.result_str,
                      pREC.status_code,
                      pREC.ERROR_CODE,
                      pREC.description_str,
                      SYSDATE,
                      pREC.req_count,
                      prec.date_start,
                      pREC.SMS_SENDER_NAME);

         COMMIT;
      END IF;
   END LOOP;

   CLOSE cur;
END;
/
