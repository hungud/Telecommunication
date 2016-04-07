
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SEND_MAIL_WITH_ATTACHMENT" (
  RECIPIENT IN VARCHAR2,
  MESSAGE_TITLE IN VARCHAR2,
  MAIL_TEXT IN CLOB DEFAULT NULL,
  FILENAME IN VARCHAR2 DEFAULT NULL,
  ATTACHMENT IN BLOB DEFAULT NULL
  ) IS
--Vesion#1
CURSOR C IS
  SELECT *
    FROM SEND_MAIL_PARAMETRES;
  -- переменная, представляющая smtp-соединение
  mail_conn UTL_SMTP.connection;
  nls_charset varchar2(200);
  MAIL C%ROWTYPE;
  boundary VARCHAR2(32);
  vRAW RAW(32767);
  amt BINARY_INTEGER:=10368;
  p BINARY_INTEGER := 1;
--
BEGIN
  OPEN C;
  FETCH C INTO MAIL;
  CLOSE C;
  --формирование boundary
  DBMS_RANDOM.SEED(SYS_GUID());
  boundary:=DBMS_RANDOM.STRING('u',32);

  -- установка соединения
  mail_conn := UTL_SMTP.open_connection(MAIL.SMTP_SERVER, MAIL.SMTP_PORT);
  -- подтверждение установки связи
  UTL_SMTP.ehlo(mail_conn, MAIL.SMTP_SERVER);
  --utl_smtp.command(mail_conn, 'STARTTLS');
  utl_smtp.command(mail_conn, 'auth login');
  SELECT VALUE INTO   nls_charset
    FROM   nls_database_parameters
    WHERE  parameter = 'NLS_CHARACTERSET';
 -- cENCODING_PAGE := 'AL32UTF8';
 -- CodedStr := utl_encode.text_encode('darkelf522', cENCODING_PAGE, utl_encode.base64);
  utl_smtp.command(mail_conn, utl_encode.text_encode(MAIL.USER_LOGIN, nls_charset, utl_encode.base64));
  utl_smtp.command(mail_conn, utl_encode.text_encode(MAIL.USER_PASSWORD, nls_charset, utl_encode.base64));
  -- установка адреса отправителя
  UTL_SMTP.mail(mail_conn, MAIL.USER_LOGIN);
  -- установка адреса получателя
  UTL_SMTP.rcpt(mail_conn, RECIPIENT);
  -- отправка команды data, после которой можно начать передачу письма
  UTL_SMTP.open_data(mail_conn);
  -- отправка заголовков письма: дата, "от", "кому", "тема"
  UTL_SMTP.write_data(mail_conn, 'Subject: '||encode(MESSAGE_TITLE)||UTL_TCP.crlf);
  UTL_SMTP.write_data(mail_conn, 'MIME-Version: 1.0' || UTL_TCP.crlf);
  UTL_SMTP.write_data(mail_conn, 'Date: ' || TO_CHAR(SYSDATE, 'dd.MM.yy hh24:mi:ss', 'NLS_DATE_LANGUAGE = RUSSIAN') || UTL_TCP.crlf);
  UTL_SMTP.write_data(mail_conn, 'From: ' || MAIL.USER_LOGIN || UTL_TCP.crlf);
  UTL_SMTP.write_data(mail_conn, 'To: ' || RECIPIENT || UTL_TCP.crlf);
  UTL_SMTP.write_data(mail_conn, 'Content-Type: multipart/mixed;' || UTL_TCP.crlf);
  UTL_SMTP.write_data(mail_conn, ' boundary="'||boundary||'"'|| UTL_TCP.CRLF);
  UTL_SMTP.write_data(mail_conn, UTL_TCP.crlf);
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
  -- attachment
  IF ATTACHMENT IS NOT NULL THEN
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
      dbms_lob.read (ATTACHMENT, amt, p, vRAW);
      p := p + amt;
      UTL_SMTP.write_raw_data(mail_conn, UTL_ENCODE.base64_encode(vRAW));
      EXCEPTION
        WHEN no_data_found THEN
        EXIT;
      END;
      END LOOP;
  END IF;

  UTL_SMTP.write_data(mail_conn, '--' || boundary || '--');
  UTL_SMTP.write_data(mail_conn, UTL_TCP.crlf);
  -- передача сигнала о завершении передачи сообщения
  UTL_SMTP.close_data(mail_conn);
  -- завершение сессии и закрытие соединения с сервером
  UTL_SMTP.quit(mail_conn);
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
END;
