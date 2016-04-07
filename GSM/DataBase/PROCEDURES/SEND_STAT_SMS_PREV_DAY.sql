CREATE OR REPLACE PROCEDURE SEND_STAT_SMS_PREV_DAY is
  
  --Version 2
  --
  --v.2 Алексеев 21.10.2015 В письмо добавил прикрепление файлоа с ошибками смс по номерам.
  --v.1 Алексеев 19.10.2015 Процедура отправки письма на почту о статистике по смс за предыдущий день.
  --                                     Письмо отправляется в 10:00 часов по MSK

  vText CLOB;
  vTextFile CLOB;
  vMess_Title varchar2(200 char);
  vError varchar2(2000 char);
  vErStr varchar2(2000 char);
  
  PROCEDURE SEND_MAIL_WITH_ATTACHMENT_MY(
    RECIPIENT IN VARCHAR2,
    MESSAGE_TITLE IN VARCHAR2,
    MAIL_TEXT IN CLOB DEFAULT NULL,
    FILENAME IN VARCHAR2 DEFAULT NULL,
    ATTACHMENT IN CLOB DEFAULT NULL
  ) IS
      CURSOR C IS
        SELECT *
          FROM SEND_MAIL_PARAMETRES;
    -- переменная, представляющая smtp-соединение
    mail_conn UTL_SMTP.connection;
    nls_charset varchar2(200);
    MAIL C%ROWTYPE;
    boundary VARCHAR2(32);
    amt BINARY_INTEGER:=480;
    p BINARY_INTEGER := 1;
    l_buffer varchar2(32767);

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
    utl_smtp.command(mail_conn, 'auth login');
    SELECT VALUE INTO   nls_charset
      FROM   nls_database_parameters
    WHERE  parameter = 'NLS_CHARACTERSET';

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
      UTL_SMTP.write_data(mail_conn, 'Content-Type: text/plain; charset=UTF-8'|| UTL_TCP.crlf );
      UTL_SMTP.write_data(mail_conn, ' name="');
      UTL_SMTP.write_raw_data(mail_conn,utl_raw.cast_to_raw(FILENAME));
      UTL_SMTP.write_data(mail_conn, '"' || UTL_TCP.crlf);
      UTL_SMTP.write_data(mail_conn, 'Content-Transfer-Encoding:quoted-printable '|| UTL_TCP.crlf );
      UTL_SMTP.write_data(mail_conn, 'Content-Disposition: attachment;'|| UTL_TCP.crlf );
      UTL_SMTP.write_data(mail_conn, ' filename="' || FILENAME || '"' || UTL_TCP.crlf);
      UTL_SMTP.write_data(mail_conn, UTL_TCP.crlf);

      LOOP
        BEGIN
          dbms_lob.read (ATTACHMENT, amt, p, l_buffer);
          p := p + amt;
          UTL_SMTP.write_data(mail_conn, utl_encode.text_encode(l_buffer,'UTF8',utl_encode.quoted_printable));
        EXCEPTION
          WHEN no_data_found THEN
            EXIT;
        END;
      END LOOP;
    END IF;

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
    
begin 
  vText := '';
  vTextFile := '';
  
  --получаем статистику по смс
  for rec in (
                   select name_param, value_param
                     from V_STAT_SMS_PREV_DAY
                )
  loop
    vText := vText||rec.name_param||' - '||rec.value_param||'<br>';
  end loop; 
  
  --получаем номера, по которым были ошибки
  for v_rec in (
                      select sm.phone, sm.status, sm.slerror
                        from sms_log sm
                      where trunc(SM.INSERT_DATE) = trunc(sysdate-1)
                          and ((nvl(SM.REQ_COUNT, 0) = 60)
                                  OR
                                  (NVL(SM.SLERROR_CODE, -1) <> -1))
                   )
  loop
    --выделяем ошибку если она есть, иначе статус
    if v_rec.slerror is not null then
      vTextFile := vTextFile||v_rec.phone||'   '||v_rec.slerror||chr(13)||chr(10); 
    else
      vTextFile := vTextFile||v_rec.phone||'   '||v_rec.status||chr(13)||chr(10); 
    end if;
  end loop;                              
  
  --отправляем по почте
  vMess_Title := 'Статистика по смс за предыдущий день!';
  begin
    SEND_MAIL_WITH_ATTACHMENT_MY
    (
       MS_params.GET_PARAM_VALUE ('EMAIL_SEND_STAT_SMS_PREV_DAY'),
       vMess_Title,
       vText,
       'Phone_Error_Sms.txt',
        vTextFile
    );
    vError := '';
  exception 
    when others then   
     vError := 'Ошибка отпраки письма!';             
  end;
  
  --логируем отправку
  INSERT INTO LOG_SEND_MAIL_INFO_SMS 
  (
     YEAR_MONTH, 
     DATE_CREATED, 
     MESSAGE_TITLE, 
     MAIL_TEXT, 
     MAIL_RECIPIENT, 
     ERROR_TEXT
  ) 
  VALUES 
  (
     to_number(to_char(sysdate, 'YYYYMM')),
     sysdate,
     vMess_Title,
     vText||chr(13)||chr(10)||vTextFile,
     MS_params.GET_PARAM_VALUE ('EMAIL_SEND_STAT_SMS_PREV_DAY'),
     vError
  );
  commit;
end;