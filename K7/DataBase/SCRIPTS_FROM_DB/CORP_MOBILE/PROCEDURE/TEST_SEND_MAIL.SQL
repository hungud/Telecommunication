
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."TEST_SEND_MAIL" (
  RECIPIENT IN VARCHAR2,
  MESSAGE_TITLE IN VARCHAR2,
  MAIL_TEXT IN CLOB,
  perr out VARCHAR2
  ) IS
--Vesion#1
CURSOR C IS
  SELECT *
    FROM SEND_MAIL_PARAMETRES;
  -- переменная, представляющая smtp-соединение
mail_conn UTL_SMTP.connection;
nls_charset varchar2(200);
MAIL C%ROWTYPE;
--
BEGIN
  OPEN C;
  FETCH C INTO MAIL;
  CLOSE C;

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
  UTL_SMTP.write_data(mail_conn, 'Subject: =?UTF-8?Q?' ||
                                   UTL_RAW.CAST_TO_VARCHAR2(UTL_ENCODE.QUOTED_PRINTABLE_ENCODE(UTL_RAW.CAST_TO_RAW(MESSAGE_TITLE))) ||
                                   '?=' || UTL_TCP.CRLF);
  UTL_SMTP.write_data(mail_conn, 'MIME-Version: 1.0' || UTL_TCP.crlf);
  UTL_SMTP.write_data(mail_conn, 'Content-Type: text/plain; charset=UTF-8' || UTL_TCP.crlf);
  UTL_SMTP.write_data(mail_conn, 'Content-Transfer-Encoding: quoted-printable '|| UTL_TCP.CRLF);
  UTL_SMTP.write_data(mail_conn, 'Date: ' || TO_CHAR(SYSDATE, 'dd.MM.yy hh24:mi:ss', 'NLS_DATE_LANGUAGE = RUSSIAN') || UTL_TCP.crlf);
  UTL_SMTP.write_data(mail_conn, 'From: ' || MAIL.USER_LOGIN || UTL_TCP.crlf);
  UTL_SMTP.write_data(mail_conn, 'To: ' || RECIPIENT || UTL_TCP.crlf);
  UTL_SMTP.write_data(mail_conn, UTL_TCP.crlf);
  -- текст письма
  FOR i IN 0..TRUNC((DBMS_LOB.GETLENGTH(MAIL_TEXT)-1)/2000) LOOP
    UTL_SMTP.write_raw_data(mail_conn, UTL_ENCODE.QUOTED_PRINTABLE_ENCODE(UTL_RAW.cast_to_raw(DBMS_LOB.SUBSTR(MAIL_TEXT, 2000, i*2000+1))));
  END LOOP;
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
      -- perr:='-91';
      UTL_SMTP.quit(mail_conn);
    EXCEPTION
      -- Если SMTP сервер недоступен, соединение с сервером отсутствует.
      -- Вызов QUIT приводит к ошибке. Обработка исключения позволяет
      -- игнорировать эту ошибку.
      WHEN UTL_SMTP.transient_error OR UTL_SMTP.permanent_error THEN
        NULL;
       -- perr:='-101';
    END;

 perr:=SQLERRM;
  --  raise_application_error(-20000, 'Ошибка отправки почты: ' || SQLERRM);
END;
