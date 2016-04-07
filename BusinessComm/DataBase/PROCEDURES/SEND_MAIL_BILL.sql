CREATE OR REPLACE PROCEDURE SEND_MAIL_BILL
  IS

  CURSOR C IS
   SELECT *
     FROM SEND_MAIL_PARAM;
  cursor D is
    select VIRTUAL_ACCOUNTS_ID, EMAIL, BODY_MAIL, PERIOD  
      from SEND_MAIL_LOG
     where DELIVERED = 0
     and VIRTUAL_ACCOUNTS_ID = 7;
 
/*  VIRTUAL_ACCOUNTS_ID  INTEGER                  NOT NULL,
  DATE_SEND            DATE                     DEFAULT sysdate               NOT NULL,
  PERIOD               INTEGER,
  BODY_MAIL            BLOB,
  DELIVERED            INTEGER                  DEFAULT 0                     NOT NULL,
  ERROR                VARCHAR2(500 CHAR),
  EMEIL          VARCHAR2(100 CHAR)
*/  
  MAIL C%ROWTYPE;

  mail_conn         UTL_SMTP.connection;
  nls_charset       varchar2(200);
  boundary          VARCHAR2(32);
  vRAW              RAW(32767);
  amt               BINARY_INTEGER:=10368;
  p                 BINARY_INTEGER := 1;
  MESSAGE_TITLE     varchar2(200);
  MAIL_TEXT         CLOB;
  v_YEAR_MONTH_NAME varchar2(200);
  FILENAME          varchar2(200);
begin
    OPEN C;
   FETCH C INTO MAIL;
   CLOSE C;
  
  DBMS_RANDOM.SEED(SYS_GUID());
  boundary:=DBMS_RANDOM.STRING('u',32);

  SELECT VALUE INTO   nls_charset
    FROM   nls_database_parameters
    WHERE  parameter = 'NLS_CHARACTERSET';

  MESSAGE_TITLE := 'Отчет по расходам за услуги ';
  MAIL_TEXT := ' При этом '||MAIL.SMPT_FROM|| ' направляет Вам отчет по расходам за услуги за ' ;
    
   for rec in D loop
     begin
       -- установка соединения
       mail_conn := UTL_SMTP.open_connection(MAIL.SMPT_SERVER, MAIL.SMPT_PORT);
       -- отзыв от сервера для соединения
       UTL_SMTP.ehlo(mail_conn, MAIL.SMPT_SERVER);
       
       -- идентификация установки связи
       utl_smtp.command(mail_conn, 'auth login');
       utl_smtp.command(mail_conn, utl_encode.text_encode(MAIL.USER_LOGIN, nls_charset, utl_encode.base64));
       utl_smtp.command(mail_conn, utl_encode.text_encode(MAIL.USER_PASSWORD, nls_charset, utl_encode.base64));
        
       -- установка адреса отправителя
       UTL_SMTP.mail(mail_conn, MAIL.USER_LOGIN);
        
       -- установка адреса получателя
       UTL_SMTP.rcpt(mail_conn, rec.EMAIL);
      
       -- отправка команды data, после которой можно начать передачу письма
       UTL_SMTP.open_data(mail_conn);  
       
       MESSAGE_TITLE := MESSAGE_TITLE||MAIL.SMPT_FROM;
       
       -- отправка заголовков письма: дата, "от", "кому", "тема"
       UTL_SMTP.write_data(mail_conn, 'Subject: '||encode(MESSAGE_TITLE)||UTL_TCP.crlf);
       UTL_SMTP.write_data(mail_conn, 'MIME-Version: 1.0' || UTL_TCP.crlf);
       UTL_SMTP.write_data(mail_conn, 'Date: ' || TO_CHAR(SYSDATE, 'dd.MM.yy hh24:mi:ss', 'NLS_DATE_LANGUAGE = RUSSIAN') || UTL_TCP.crlf);
       UTL_SMTP.write_data(mail_conn, 'From: ' || MAIL.USER_LOGIN || UTL_TCP.crlf);
       UTL_SMTP.write_data(mail_conn, 'To: '   || rec.EMAIL || UTL_TCP.crlf);
       UTL_SMTP.write_data(mail_conn, 'Content-Type: multipart/mixed;' || UTL_TCP.crlf);
       UTL_SMTP.write_data(mail_conn, ' boundary="'||boundary||'"'|| UTL_TCP.CRLF);
       UTL_SMTP.write_data(mail_conn, UTL_TCP.crlf);
       
       select lower(YEAR_MONTH_NAME) 
         into v_YEAR_MONTH_NAME
         from V_PERIODS 
        where YEAR_MONTH = rec.PERIOD;
       MAIL_TEXT := MAIL_TEXT||v_YEAR_MONTH_NAME;
       
       -- текст письма
        IF MAIL_TEXT IS NOT NULL THEN
          UTL_SMTP.write_data(mail_conn, '--'|| boundary || UTL_TCP.crlf );
          UTL_SMTP.write_data(mail_conn, 'Content-Type: text/html; charset=UTF-8' || UTL_TCP.crlf);
          UTL_SMTP.write_data(mail_conn, 'Content-Transfer-Encoding: quoted-printable '|| UTL_TCP.CRLF);
          UTL_SMTP.write_data(mail_conn, UTL_TCP.crlf);

          FOR i IN 0..TRUNC((DBMS_LOB.GETLENGTH(MAIL_TEXT)-1)/2000) LOOP
            UTL_SMTP.write_raw_data(mail_conn, UTL_ENCODE.QUOTED_PRINTABLE_ENCODE(UTL_RAW.cast_to_raw(DBMS_LOB.SUBSTR(MAIL_TEXT, 2000, i*2000+1))));
          END LOOP;
          UTL_SMTP.write_data(mail_conn, UTL_TCP.crlf);
        END IF;

       FILENAME := MESSAGE_TITLE||'.pdf';
       -- attachment
       IF rec.BODY_MAIL IS NOT NULL THEN
          UTL_SMTP.write_data(mail_conn, '--'|| boundary || UTL_TCP.crlf );
          UTL_SMTP.write_data(mail_conn, 'Content-Type: '||'text/html;'|| UTL_TCP.crlf );
          UTL_SMTP.write_data(mail_conn, ' name="');
          UTL_SMTP.write_raw_data(mail_conn,utl_raw.cast_to_raw(FILENAME));
          UTL_SMTP.write_data(mail_conn, '"' || UTL_TCP.crlf);
          UTL_SMTP.write_data(mail_conn, 'Content-Transfer-Encoding: base64'|| UTL_TCP.crlf );
          UTL_SMTP.write_data(mail_conn, 'Content-Disposition: attachment;'|| UTL_TCP.crlf );
          UTL_SMTP.write_data(mail_conn, ' filename="' || FILENAME || '"' || UTL_TCP.crlf);
          UTL_SMTP.write_data(mail_conn, UTL_TCP.crlf);

          LOOP
             BEGIN
               dbms_lob.read (rec.BODY_MAIL, amt, p, vRAW);
               p := p + amt;
               UTL_SMTP.write_raw_data(mail_conn, UTL_ENCODE.base64_encode(vRAW));
             EXCEPTION
               WHEN no_data_found THEN
                 EXIT;
             END;
          END LOOP;
       end if;

       UTL_SMTP.write_data(mail_conn, '--' || boundary || '--');
       UTL_SMTP.write_data(mail_conn, UTL_TCP.crlf);
       
       -- передача сигнала о завершении передачи сообщения
       UTL_SMTP.close_data(mail_conn);
       -- завершение сессии и закрытие соединения с сервером
       UTL_SMTP.quit(mail_conn);
    
      UPDATE SEND_MAIL_LOG
         SET DELIVERED  = 1
       where VIRTUAL_ACCOUNTS_ID = rec.VIRTUAL_ACCOUNTS_ID;  
      commit;
      
     EXCEPTION
       -- если произошла ошибка передачи данных, закрыть соединение и вернуть
       -- ошибку передачи письма
       WHEN UTL_SMTP.transient_error OR UTL_SMTP.permanent_error THEN
       BEGIN
         UTL_SMTP.quit(mail_conn);
       EXCEPTION
        -- Если SMTP сервер недоступен, соединение с сервером отсутствует.
        -- Вызов QUIT приводит к ошибке. Обработка исключения позволяет
        -- игнорировать эту ошибку.
        WHEN UTL_SMTP.transient_error OR UTL_SMTP.permanent_error THEN
          NULL;
       END;
       raise_application_error(-20000, 'Ошибка отправки почты: ' || SQLERRM);
     end;  
   end loop;
end;
/