
  CREATE OR REPLACE PACKAGE "LONTANA"."UTILS_MAIL" 
  AS
  mailhost VARCHAR2(30) := 'smtp.mail.ru';   -- сервер почты    
  sender VARCHAR2(30) := 'vv_sabayev@mail.ru'; -- отправитель    
 
  FUNCTION SUBJ_ENCODE(SUBJ_STR VARCHAR2) RETURN VARCHAR2;
  PROCEDURE SENDMAIL(RECIPIENT VARCHAR2, SUBJECT VARCHAR2, MESSAGE VARCHAR2);
END;
CREATE OR REPLACE PACKAGE BODY "LONTANA"."UTILS_MAIL" AS
  
  FUNCTION SUBJ_ENCODE(SUBJ_STR VARCHAR2) RETURN VARCHAR2
  -- Функция для перекодировки заголовка письма в utf-8
  AS
    a varchar2(1000);
    b varchar2(24);
    result varchar2(4000);
  BEGIN
    a := subj_str;
 
    WHILE LENGTH(a) > 24
    LOOP
      b := SUBSTR(a, 1, 24);
      a := SUBSTR(a, 25);
      RESULT :=
        RESULT || '=?UTF-8?B?'
        || UTL_RAW.cast_to_varchar2(UTL_ENCODE.base64_encode(UTL_RAW.cast_to_raw(CONVERT(b, 'utf8'))))
        || '?=';
    END LOOP;
 
    IF LENGTH(a) > 0 THEN
      RESULT :=
        RESULT || '=?UTF-8?B?'
        || UTL_RAW.cast_to_varchar2(UTL_ENCODE.base64_encode(UTL_RAW.cast_to_raw(CONVERT(a, 'utf8'))))
        || '?=';
    END IF;
 
    RETURN RESULT;
  END;
 
  PROCEDURE SENDMAIL(RECIPIENT VARCHAR2, SUBJECT VARCHAR2, MESSAGE VARCHAR2)
  -- Процедура для отправки письма
  AS
    mail_conn utl_smtp.connection;
    nls_charset varchar2(255);
  BEGIN
    select value
    into   nls_charset
    from   nls_database_parameters
    where  parameter = 'NLS_CHARACTERSET';
   
    -- установка соединения
    mail_conn := UTL_SMTP.open_connection(mailhost, 25);
    UTL_SMTP.helo(mail_conn, mailhost);
    UTL_SMTP.command(mail_conn, 'auth login');
    UTL_SMTP.command(mail_conn, UTL_ENCODE.text_encode('vv_sabayev@mail.ru', nls_charset, 1));
    UTL_SMTP.command(mail_conn, UTL_ENCODE.text_encode('noonenowhere', nls_charset, 1));
    UTL_SMTP.mail(mail_conn, sender);
    UTL_SMTP.rcpt(mail_conn, recipient);
    UTL_SMTP.open_data(mail_conn);
   
    -- передача данных: заголовки
    UTL_SMTP.write_data(mail_conn, 'Date: ' || TO_CHAR(SYSDATE, 'dd Mon yy hh24:mi:ss', 'NLS_DATE_LANGUAGE = RUSSIAN') || UTL_TCP.crlf);
    UTL_SMTP.write_data(mail_conn, 'From: ' || sender || UTL_TCP.crlf);
    UTL_SMTP.write_data(mail_conn, 'To: ' || recipient || UTL_TCP.crlf);
    UTL_SMTP.write_raw_data
      (mail_conn,
      UTL_RAW.cast_to_raw('Subject: ' || subj_encode(NVL(subject, '(no subject)')) || UTL_TCP.crlf));
 
    -- передача данных: кодировки
    UTL_SMTP.write_data(mail_conn, 'MIME-Version: 1.0' || UTL_TCP.crlf);
    UTL_SMTP.write_data(mail_conn, 'Content-Type: text/plain; charset="windows-1251"' || UTL_TCP.crlf);
    UTL_SMTP.write_data(mail_conn, 'Content-Transfer-Encoding: 8bit' || UTL_TCP.crlf);
 
    -- передача данных: текст письма
    UTL_SMTP.write_raw_data(mail_conn, UTL_RAW.cast_to_raw(UTL_TCP.crlf || message));
   
    -- завершение соединения
    UTL_SMTP.close_data(mail_conn);
    UTL_SMTP.quit(mail_conn);
    --EXCEPTION
      --WHEN UTL_SMTP.transient_error OR UTL_SMTP.permanent_error THEN
      --BEGIN
      --  UTL_SMTP.quit(mail_conn);
      --  COMMIT;
      --  RAISE;
      --EXCEPTION
      --  WHEN UTL_SMTP.transient_error OR UTL_SMTP.permanent_error THEN
      --    NULL;
     --END;
  END;
END;