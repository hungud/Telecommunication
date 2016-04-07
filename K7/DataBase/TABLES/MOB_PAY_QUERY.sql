/* Formatted on 24/04/2015 9:56:39 (QP5 v5.252.13127.32867) */
CREATE OR REPLACE PROCEDURE MOB_PAY_QUERY
IS
--
--Version=2
--
--v.2 Афросин 24.04.2015 Вынес код в процедуру. Добавил запись в MOB_PAY_LOG имя пользователя, создавшенго запись.
--
--
   CURSOR cMOB_PAY_REQUEST
   IS
      SELECT DISTINCT cbr.phone, cbr.sum_pay, cbr.req_count, CBR.USER_CREATED
        FROM MOB_PAY_REQUEST cbr
       WHERE EXISTS
                (SELECT 1
                   FROM mob_pay mp
                  WHERE mp.phone = cbr.phone AND mp.date_pay IS NULL);
   
   recMOB_PAY_REQUEST cMOB_PAY_REQUEST%ROWTYPE;
   /*
   vPhone       VARCHAR2 (11);
   vSum_pay     MOB_PAY_REQUEST.SUM_PAY%TYPE;
   vReq_count   MOB_PAY_REQUEST.REQ_COUNT%TYPE;
   vUSER_CREATED MOB_PAY_REQUEST.USER_CREATED%TYPE;
   */
   req          UTL_HTTP.req;
   resp         UTL_HTTP.resp;
   SMS          VARCHAR2 (2000);
   urls         VARCHAR2 (1000);
   datas        VARCHAR2 (1024);
   answer_mes   VARCHAR2 (2000);
   flp          NUMBER;

   
--
-- ПРОЦЕДУРА ДЛЯ ЗАПИСИ В MOB_PAY_LOG И УДАЛЕНИЯ ИЗ MOB_PAY_REQUEST    
   procedure WRITE_LOG_AND_DEL(pRecMOB_PAY_REQUEST in  cMOB_PAY_REQUEST%ROWTYPE, pStatus_code in INTEGER, pAnswer_mes in VARCHAR2 ) as
   begin
    
    INSERT INTO MOB_PAY_LOG 
                  (
                    PHONE,
                    SUM_PAY,
                    REQ_COUNT,
                    DATE_INSERT,
                    RES_CODE,
                    ERROR_TEXT,
                    USER_CREATED
                )
                    VALUES (pRecMOB_PAY_REQUEST.phone,
                            pRecMOB_PAY_REQUEST.sum_pay,
                            pRecMOB_PAY_REQUEST.req_count + 1,
                            NULL,
                            pStatus_code,
                            pAnswer_mes,
                            pRecMOB_PAY_REQUEST.USER_CREATED
                           );

               DELETE MOB_PAY_REQUEST cbr
                WHERE     cbr.phone = pRecMOB_PAY_REQUEST.phone
                      AND cbr.req_count = pRecMOB_PAY_REQUEST.req_count
                      AND cbr.sum_pay = pRecMOB_PAY_REQUEST.sum_pay;

               COMMIT;
   end;
   
BEGIN
   OPEN cMOB_PAY_REQUEST;

   LOOP
      recMOB_PAY_REQUEST := null;
      FETCH cMOB_PAY_REQUEST INTO recMOB_PAY_REQUEST;

      EXIT WHEN cMOB_PAY_REQUEST%NOTFOUND;
      
      SELECT COUNT (*)
        INTO flp
        FROM mob_pay mp
       WHERE mp.phone = recMOB_PAY_REQUEST.Phone AND mp.date_pay IS NULL;

      IF flp > 0
      THEN
         BEGIN
            urls :=
                  '/mobtopup/?phonenr=%2B7'
               || recMOB_PAY_REQUEST.Phone
               || '&'
               || 'amount='
               || REPLACE (TO_CHAR (recMOB_PAY_REQUEST.sum_pay), ',', '.');
            urls :=
                  MS_params.GET_PARAM_VALUE ('MOB_PAY_URL')
               || urls
               || '&'
               || 'sign='
               || gnuhash_sha512 (
                     urls || MS_params.GET_PARAM_VALUE ('MOB_PAY_PASSWORD'));
            req := UTL_HTTP.begin_request (urls);
            resp := UTL_HTTP.get_response (req);

            BEGIN
               answer_mes := '';

               LOOP
                  UTL_HTTP.READ_TEXT (resp, datas);
                  answer_mes := answer_mes || datas;
               --           dbms_output.put_line( datas);
               -- do something with the data
               END LOOP;
            EXCEPTION
               WHEN UTL_HTTP.END_OF_BODY
               THEN
                  NULL;
            END;

            IF resp.status_code = 200 THEN
            

              WRITE_LOG_AND_DEL(recMOB_PAY_REQUEST, resp.status_code , resp.reason_phrase || ' ' || answer_mes);
              
              IF INSTR (answer_mes, '''success'':false') > 0 THEN
                  SMS :=
                     LOADER3_pckg.SEND_SMS (
                        recMOB_PAY_REQUEST.phone,
                        'SMS-info',
                        MS_params.GET_PARAM_VALUE ('MOB_PAY_SMS_ERROR'));
              ELSE
                  UPDATE mob_pay mp
                     SET mp.date_pay = SYSDATE,
                         MP.USER_UPDATED = recMOB_PAY_REQUEST.USER_CREATED
                   WHERE mp.phone = recMOB_PAY_REQUEST.phone AND 
                         mp.date_pay IS NULL;

                  COMMIT;
              END IF;
              
            ELSIF recMOB_PAY_REQUEST.req_count + 1 <
                     TO_NUMBER (
                        MS_params.GET_PARAM_VALUE ('MOB_PAY_COUNT_QUERY'))
            THEN
               UPDATE MOB_PAY_REQUEST cbr
                  SET cbr.req_count = recMOB_PAY_REQUEST.req_count + 1;

               COMMIT;
            ELSE
               WRITE_LOG_AND_DEL(recMOB_PAY_REQUEST,  resp.status_code, 
                                 answer_mes
                                 || ' Превышено  количество попыток запроса к сайту партнера.');
               SMS :=
                  LOADER3_pckg.SEND_SMS (
                     recMOB_PAY_REQUEST.phone,
                     'SMS-info',
                     MS_params.GET_PARAM_VALUE ('MOB_PAY_SMS_ERROR'));
            END IF;

            UTL_HTTP.end_response (resp);
         EXCEPTION
            WHEN OTHERS THEN
               UTL_HTTP.end_response (resp);
               
               WRITE_LOG_AND_DEL(recMOB_PAY_REQUEST,  100, 
                                 'Ошибка запроса к сайту партнера.');
               SMS :=
                  LOADER3_pckg.SEND_SMS (
                     recMOB_PAY_REQUEST.phone,
                     'SMS-info',
                     MS_params.GET_PARAM_VALUE ('MOB_PAY_SMS_ERROR'));
         END;
      ELSE
         DELETE MOB_PAY_REQUEST cbr
          WHERE cbr.phone = recMOB_PAY_REQUEST.phone;

         COMMIT;
      END IF;
   END LOOP;

   CLOSE cMOB_PAY_REQUEST;
END;
/
