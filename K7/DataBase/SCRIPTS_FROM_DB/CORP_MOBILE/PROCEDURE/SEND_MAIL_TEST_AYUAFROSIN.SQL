
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SEND_MAIL_TEST_AYUAFROSIN" (p_to          IN VARCHAR2,
                                       p_from        IN VARCHAR2,
                                       p_subject     IN VARCHAR2,
                                       p_text_msg    IN VARCHAR2 DEFAULT NULL,
                                       p_attach_name IN VARCHAR2 DEFAULT NULL,
                                       p_attach_mime IN VARCHAR2 DEFAULT NULL,
                                       p_attach_blob IN BLOB DEFAULT NULL,
                                       p_smtp_host   IN VARCHAR2,
                                       p_smtp_port   IN NUMBER DEFAULT 25)
AS
  l_mail_conn   UTL_SMTP.connection;
  l_boundary    VARCHAR2(50) := '----=*#abc1234321cba#*=';
  l_step        PLS_INTEGER  := 12000; -- make sure you set a multiple of 3 not higher than 24573
  nls_charset   VARCHAR2 (200);
BEGIN
  l_mail_conn := UTL_SMTP.open_connection(p_smtp_host, p_smtp_port);
  
  SELECT VALUE
     INTO nls_charset
     FROM nls_database_parameters
    WHERE parameter = 'NLS_CHARACTERSET';
  
  UTL_SMTP.command (
      l_mail_conn,
      UTL_ENCODE.text_encode ('tariff@2255757.ru',
                              nls_charset,
                              UTL_ENCODE.base64));
   UTL_SMTP.command (
      l_mail_conn,
      UTL_ENCODE.text_encode ('Hutgy68kjkg',
                              nls_charset,
                              UTL_ENCODE.base64));
  
  UTL_SMTP.command (l_mail_conn, 'auth login');
  UTL_SMTP.helo(l_mail_conn, p_smtp_host);
  UTL_SMTP.mail(l_mail_conn, p_from);
  UTL_SMTP.rcpt(l_mail_conn, p_to);

  UTL_SMTP.open_data(l_mail_conn);
  
  UTL_SMTP.write_data(l_mail_conn, 'Date: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS') || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'To: ' || p_to || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'From: ' || p_from || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'Subject: ' || p_subject || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'Reply-To: ' || p_from || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'MIME-Version: 1.0' || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'Content-Type: multipart/mixed; boundary="' || l_boundary || '"' || UTL_TCP.crlf || UTL_TCP.crlf);
  
  IF p_text_msg IS NOT NULL THEN
    UTL_SMTP.write_data(l_mail_conn, '--' || l_boundary || UTL_TCP.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'Content-Type: text/plain; charset="iso-8859-1"' || UTL_TCP.crlf || UTL_TCP.crlf);

    UTL_SMTP.write_data(l_mail_conn, p_text_msg);
    UTL_SMTP.write_data(l_mail_conn, UTL_TCP.crlf || UTL_TCP.crlf);
  END IF;

  IF p_attach_name IS NOT NULL THEN
    UTL_SMTP.write_data(l_mail_conn, '--' || l_boundary || UTL_TCP.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'Content-Type: ' || p_attach_mime || '; name="' || p_attach_name || '"' || UTL_TCP.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'Content-Transfer-Encoding: base64' || UTL_TCP.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'Content-Disposition: attachment; filename="' || p_attach_name || '"' || UTL_TCP.crlf || UTL_TCP.crlf);

    FOR i IN 0 .. TRUNC((DBMS_LOB.getlength(p_attach_blob) - 1 )/l_step) LOOP
      UTL_SMTP.write_data(l_mail_conn, UTL_RAW.cast_to_varchar2(UTL_ENCODE.base64_encode(DBMS_LOB.substr(p_attach_blob, l_step, i * l_step + 1))));
    END LOOP;

    UTL_SMTP.write_data(l_mail_conn, UTL_TCP.crlf || UTL_TCP.crlf);
  END IF;
  
  UTL_SMTP.write_data(l_mail_conn, '--' || l_boundary || '--' || UTL_TCP.crlf);
  UTL_SMTP.close_data(l_mail_conn);

  UTL_SMTP.quit(l_mail_conn);
END;