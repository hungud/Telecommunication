CREATE OR REPLACE PROCEDURE SEND_MAIL_NOTICE_BEELINE
IS
   --#Version=2   
   --v.2  13.08.2015 Афросин даобавил обработку ошибок в GET_MAIL_NOTICE_BELINE 
   TEXT             CLOB;
   pIS_SUCCESS      NUMBER := -1;
   pEMail           VARCHAR2 (32);
   pERROR_TEXT      VARCHAR2 (2000) := '';
   pLOAD_TYPE_ID    NUMBER;

   Log_dept_value   NUMBER
      := ms_params.GET_PARAM_VALUE ('ERROR_SUBSCRIBE_CHECK_TIME');

  FUNCTION GET_MAIL_NOTICE_BELINE  RETURN CLOB IS
    --Version=1
  RESULT_CLOB CLOB;
  LINE CLOB;

  BEGIN



    FOR rec IN (
                 select
                   decode(t.type_req,10,'Ошибка разблокировки',9,'Ошибка блокировки',12,'Ошибка смены SIM-карты','N/A') mess,
                   acc.login,
                   t.phone_number,
                   t.response comments,
                   to_char('Время: '||to_char(t.date_insert,'dd.mm hh24:mi')) other
                 from
                   soap_api_sys_log t,
                   accounts acc
                 where
                   t.type_req in (9,10,12)
                   and t.is_ok = 0 
                   and t.date_insert > sysdate - Log_dept_value/1440
                   and acc.account_id = t.account_id
                 union all
                 select
                   decode(b.ticket_type,10,'Ошибка разблокировки',9,'Ошибка блокировки',12,'Ошибка смены SIM-карты','N/A') mess,
                   acc.login,
                   b.phone_number,
                   b.comments,
                   to_char('Пользователь '||b.user_created||'; Время: '||to_char(b.date_create,'dd.mm hh24:mi')||'; №заявки Билайн:'||b.ticket_id) other

                 from
                   beeline_tickets b,
                   accounts acc
                 where
                   b.ticket_type in (9,10,12) 
                   and b.date_update > sysdate - Log_dept_value/1440
                   and b.answer = 0
                   and acc.account_id=b.account_id

    ) LOOP
      
      begin
        --добавление записей
        if not(
                (
                  rec.mess = 'Ошибка разблокировки'
                  and instr( beeline_api_pckg.phone_status(rec.phone_number), 'ACTIVE')> 0 
                )
                or 
                (
                  rec.mess='Ошибка блокировки'
                  and instr(beeline_api_pckg.phone_status(rec.phone_number),'BLOCKED')>0
                )
              )
        then
            --инициализация clob       
          if RESULT_CLOB is null then 
            RESULT_CLOB := 'Отчёт об ошибках блокировки, разблокировки и смене SIM-карт'||chr(13)||'<br/><br/>';
          end if;
          
          LINE := chr(10)||rec.mess||chr(13)||'<br/>'||
                  ' Л/С:'||rec.login||' CTN:'||rec.phone_number ||chr(13)||'<br/>'||
                  ' Комментарий:'||rec.comments||chr(13)||'<br/>'||
                  rec.other||chr(13)||'<br/>'
                  ||'____________________________________________________'||chr(13)||'<br/><br/>';
          
          DBMS_LOB.APPEND(RESULT_CLOB, LINE);
        end if;
      exception
        when OTHERS then
          null;
      end;
      
    END LOOP;
 

    RETURN RESULT_CLOB;
--  DBMS_LOB.FREETEMPORARY(RESULT_CLOB);

  END;

   PROCEDURE ins_log (p_EMail          IN VARCHAR2,
                      p_IS_SUCCESS     IN NUMBER,
                      p_ERROR_TEXT     IN VARCHAR2,
                      p_LOAD_TYPE_ID   IN NUMBER)
   IS
   BEGIN
      INSERT INTO ALL_LOAD_LOGS (LOAD_LOG_ID,
                                 EMAIL,
                                 LOAD_DATE_TIME,
                                 IS_SUCCESS,
                                 ERROR_TEXT,
                                 LOAD_TYPE_ID,
                                 BEELINE_RN)
           VALUES (NEW_ACCOUNT_LOAD_LOG_ID,
                   p_EMail,
                   SYSDATE,
                   p_IS_SUCCESS,
                   p_ERROR_TEXT,
                   p_LOAD_TYPE_ID,
                   NULL);

      COMMIT;
   END;
BEGIN
   ------------------ Отправка уведомлений для разбора в билайн
   pLOAD_TYPE_ID := 81;

   IF MS_PARAMS.GET_PARAM_VALUE ('SEND_MAIL_NOTICE_BELINE') = 1
   THEN
      -- отправляем отчет по настройке

      TEXT := GET_MAIL_NOTICE_BELINE;

      FOR rec
         IN (SELECT REPORT_MAIL_RECIPIENTS.MAIL_ADRESS,
                    REPORT_TYPES.REPORT_NAME
               FROM REPORT_MAIL_RECIPIENTS, REPORT_TYPES
              WHERE     REPORT_MAIL_RECIPIENTS.TYPE_REPORT =
                           'SEND_MAIL_NOTICE_BELINE'
                    AND REPORT_MAIL_RECIPIENTS.TYPE_REPORT =
                           REPORT_TYPES.TYPE_REPORT)
      LOOP
         BEGIN
            pEMail := rec.MAIL_ADRESS;

            IF TEXT IS NOT NULL
            THEN
               SEND_MAIL1 (
                  rec.MAIL_ADRESS,
                     rec.REPORT_NAME
                  || ' '
                  || TO_CHAR (SYSDATE, 'DD.MM.YYYY hh24:mi:ss'),
                  TEXT);
            /*        ELSE
                      SEND_MAIL1(rec.MAIL_ADRESS,
                                rec.REPORT_NAME || ' ' ||
                                TO_CHAR(SYSDATE, 'DD.MM.YYYY hh24:mi:ss'),
                                'blank report');*/
            END IF;

            pIS_SUCCESS := 1;
            pERROR_TEXT := 'Письмо отправлено';
         EXCEPTION
            WHEN OTHERS
            THEN
               pIS_SUCCESS := 0;
               pERROR_TEXT := 'Error ! ' || SQLERRM;
         END;

         ins_log (pEMail,
                  pIS_SUCCESS,
                  pERROR_TEXT,
                  pLOAD_TYPE_ID);
      END LOOP;
   ELSE
      -- не отправляем отчет по настройке
      pIS_SUCCESS := 0;
      pERROR_TEXT :=
         'Отчет не отправлен по значению параметра - не отправлять отчет';
      ins_log (pEMail,
               pIS_SUCCESS,
               pERROR_TEXT,
               pLOAD_TYPE_ID);
   END IF;
END;
/
