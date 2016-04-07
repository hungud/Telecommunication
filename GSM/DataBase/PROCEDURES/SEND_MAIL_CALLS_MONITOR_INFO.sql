CREATE OR REPLACE PROCEDURE LONTANA.SEND_MAIL_CALLS_MONITOR_INFO IS
--v5
--5. Матюнин 06.04.2015 - при выборке больше чем 23 номера, процедура слияния WRITE_CLOB выдавала ошибку, так как принимала VARCHAR2 на входе 
                        -- слияние переделано на DBMS_LOB.APPEND.
--4 Афросин 06.05.2015 - переделал столбец INTERNET_TRAFFIC, убрал перевод в гигобайт, т.к. во вьюхе переводится
--3 Афросин 05.05.2015 - переделал выборку на V_MONITOR_OUTCALL_DATA
--2. Матюнин 30.04.2015  - Поправлено вместо NULL присваивается пустая строка
--1. Матюнин 30.04.2015  - Процедура предназначена для рассылки почтового письма при наличии записей в мониторе исходящей связи.
                        --  Если записей нет письмо не отсылаем.
                        --  Логика работы процедуры: запускаем на обсчет монитор исходящей связи RUN_MONITOR_OUTGOING_CALLS(1), 
                        --  После этого запускаем отправку сообщения со свежими данными монитора, если есть подходящие записи.
                        
                        -- атачмент фомируется след. образом: в екселе берем образец, сохраняем в формате XML, 
                        -- открываем в текстовом редакторе. Берем оттуда теги и формируем динамически файл по ходу. 
                        -- В файле указыватся метаданные файлы, в том числе количество строк, дата слздание и проч. Их тоже определеяем динамически.     
  vTEXT clob; 
  vTEXT_STYLE clob;         --    стили для XLS файла
  vTEXT_TABLE_HEADER clob;  --   шапка таблицы
  vTEXT_TABLE_CLOSE CLOB;
  vCALC_DATE DATE;
  vROW_BEFORE_TABLE number default 7;  -- количество строк в файле включая шапку таблицы (без данных) 
  i integer;  
  pDATE_UNLOADED VARCHAR2(50 char);
--  cursor C_RULE_LIST IS
--    select R.LIMIT_INET_TRAFFIC, R.LIMIT_OUT_CALL_NO_PAY, R.LIMIT_OUT_CALL_PAY, R.LIMIT_OUT_SMS, R.TARIFF_ID
--          ,TAR.TARIFF_NAME
--      from RULE_FOR_CALLS_MONITOR r
--          ,tariffs tar
--     where R.TURN_ON = 1  -- берем только действующие правила
--       and R.TARIFF_ID = TAR.TARIFF_ID
--  ;
  
  cursor C_PHONE_LIST --(pMONITOR_ID INTEGER) 
    IS     
    select V.CONTRACT_DATE, 
           V.CONTRACT_CANCEL_DATE, 
           V.CONTRACT_ID, 
           V.TARIFF_ID, 
           V.DURATION_OUT_NO_PAID, 
           V.DURATION_OUT_NO_PAID_ONLY_BEE, 
           V.DURATION_IN_NO_PAID, 
           V.DURATION_IN_NO_PAID_ONLY_BEE, 
           V.DURATION_IN_YES_PAID, 
           V.DURATION_IN_YES_PAID_ONLY_BEE, 
           V.DURATION_OUT_YES_PAID, 
           V.DURATION_OUT_YES_PAID_ONLY_BEE, 
           V.INTERNET_TRAFFIC INTERNET_TRAFFIC, -- указываем в Гигабайтах
           V.SMS_OUT, 
           V.MMS_OUT, 
           V.PHONE_NUMBER_FEDERAL, 
           V.TARIFF_NAME, 
           V.PHONE_IS_ACTIVE,
           V.RULE_FOR_CALLS_MONITOR_ID
    from V_MONITOR_OUTCALL_DATA v
    ORDER BY V.TARIFF_NAME
  ;

    procedure write_blob(cc in out nocopy clob, s in varchar2)is
    begin
    cc:=cc||convert(s,'UTF8');
    --    dbms_lob.writeappend(cc, length(convert(s,'UTF8')), utl_raw.cast_to_raw(convert(s,'UTF8')));
    end;
    
    FUNCTION DATE_TO_XML(pDATE DATE) return varchar2 IS
      vRes varchar2(50 char);
    begin
      vRes := TO_CHAR(pDATE, 'YYYY-MM-DD')||'T'||TO_CHAR(pDATE, 'HH24:MI:SS')||'.000';
      return vRes;
    end;
    
    PROCEDURE SEND_MAIL_WITH_ATTACHMENT(
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
      --utl_smtp.command(mail_conn, 'STARTTLS');
      utl_smtp.command(mail_conn, 'auth login');
      SELECT VALUE INTO   nls_charset
        FROM   nls_database_parameters
        WHERE  parameter = 'NLS_CHARACTERSET';
     -- cENCODING_PAGE := 'AL32UTF8';
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
    --    UTL_SMTP.write_data(mail_conn, 'Content-Transfer-Encoding:base64 '|| UTL_TCP.crlf );
        UTL_SMTP.write_data(mail_conn, 'Content-Transfer-Encoding:quoted-printable '|| UTL_TCP.crlf );
        UTL_SMTP.write_data(mail_conn, 'Content-Disposition: attachment;'|| UTL_TCP.crlf );
        UTL_SMTP.write_data(mail_conn, ' filename="' || FILENAME || '"' || UTL_TCP.crlf);
        UTL_SMTP.write_data(mail_conn, UTL_TCP.crlf);

        LOOP
          BEGIN
          dbms_lob.read (ATTACHMENT, amt, p, l_buffer);
          p := p + amt;
          UTL_SMTP.write_data(mail_conn, utl_encode.text_encode(l_buffer,'UTF8',utl_encode.quoted_printable));
    --      UTL_SMTP.write_data(mail_conn, utl_encode.text_encode(l_buffer,'UTF8',utl_encode.base64));
          EXCEPTION
            WHEN no_data_found THEN
            EXIT;
          END;
          END LOOP;

      END IF;

    --  UTL_SMTP.write_data(mail_conn, '--' || boundary || '--');
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

    PROCEDURE ADD_LOG_MONITOR(vCUR C_PHONE_LIST%ROWTYPE) IS      
    BEGIN
      INSERT INTO LOG_CALLS_MONITOR(PHONE_NUMBER, CALC_DATE, RULE_FOR_CALLS_MONITOR_ID)
          VALUES(vCUR.PHONE_NUMBER_FEDERAL, vCALC_DATE, vCUR.RULE_FOR_CALLS_MONITOR_ID);
    EXCEPTION WHEN OTHERS THEN 
        NULL;
    END;

  
begin
  -- Запускаем рассчет данных для монитора в текущей сессии (параметр =1)
  RUN_MONITOR_OUTGOING_CALLS(1);

  vCALC_DATE := TRUNC(SYSDATE);  
  --vTEXT := null; -- v2. Поправлено вместо, NULL пустая строка
  i := 0;
  pDATE_UNLOADED := to_char( sysdate, 'YYYY-MM-DD HH24:MI:SS');
  vTEXT_STYLE := 
    '<?xml version="1.0"?>
<?mso-application progid="Excel.Sheet"?>
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:html="http://www.w3.org/TR/REC-html40">
 <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
  <Author>TARIFER</Author>
  <LastAuthor>TARIFER</LastAuthor>
  <LastPrinted>2015-04-29T11:17:40Z</LastPrinted>
  <Created>2015-04-29T06:58:42Z</Created>
  <LastSaved>2015-04-29T11:19:30Z</LastSaved>
  <Version>14.00</Version>
 </DocumentProperties>
 <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">
  <AllowPNG/>
 </OfficeDocumentSettings>
 <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
  <WindowHeight>12585</WindowHeight>
  <WindowWidth>22035</WindowWidth>
  <WindowTopX>240</WindowTopX>
  <WindowTopY>105</WindowTopY>
  
  <ProtectStructure>False</ProtectStructure>
  <ProtectWindows>False</ProtectWindows>
 </ExcelWorkbook>
 <Styles>
  <Style ss:ID="Default" ss:Name="Normal">
   <Alignment ss:Vertical="Bottom"/>
   <Borders/>
   <Font ss:FontName="Calibri" x:CharSet="204" x:Family="Swiss" ss:Size="11"
    ss:Color="#000000"/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="m116112672">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:CharSet="204" x:Family="Swiss" ss:Color="#333333"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="m116112692">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:CharSet="204" x:Family="Swiss" ss:Color="#333333"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="m116112712">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:CharSet="204" x:Family="Swiss" ss:Color="#333333"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="m116112732">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:CharSet="204" x:Family="Swiss" ss:Color="#333333"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="m116112752">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:CharSet="204" x:Family="Swiss" ss:Color="#333333"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="m116112772">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:CharSet="204" x:Family="Swiss" ss:Color="#333333"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="m116112792">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:CharSet="204" x:Family="Swiss" ss:Color="#333333"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="m116112812">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:CharSet="204" x:Family="Swiss" ss:Color="#333333"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="m116112264">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Calibri" x:CharSet="204" x:Family="Swiss" ss:Color="#000000"
    ss:Bold="1"/>
   <Interior ss:Color="#C0C0C0" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="m116112284">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:CharSet="204" x:Family="Swiss" ss:Color="#333333"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="m116112304">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:CharSet="204" x:Family="Swiss" ss:Color="#333333"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="m116112344">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:CharSet="204" x:Family="Swiss" ss:Color="#333333"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="m116112364">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:CharSet="204" x:Family="Swiss" ss:Color="#333333"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="s62">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
   <Font ss:FontName="Calibri" x:CharSet="204" x:Family="Swiss" ss:Size="11"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s64">
   <Font ss:FontName="Calibri" x:CharSet="204" x:Family="Swiss" ss:Size="11"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s66">
   <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
   <Font ss:FontName="Calibri" x:CharSet="204" x:Family="Swiss" ss:Size="11"
    ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="General Date"/>
  </Style>
  <Style ss:ID="s67">
   <Font ss:FontName="Calibri" x:CharSet="204" x:Family="Swiss" ss:Size="11"
    ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="General Date"/>
  </Style>
  <Style ss:ID="s75">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:CharSet="204" x:Family="Swiss" ss:Color="#333333"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="s97">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:CharSet="204" x:Family="Swiss" ss:Color="#333333"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="s98">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Calibri" x:CharSet="204" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s100">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Calibri" x:CharSet="204" x:Family="Swiss" ss:Color="#000000"/>
   <NumberFormat ss:Format="Short Date"/>
  </Style>
 </Styles>';
  

   
  vTEXT_TABLE_CLOSE :=    
  '
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Layout x:Orientation="Landscape"/>
    <Header x:Margin="0.44999999999999996"/>
    <Footer x:Margin="0.41" x:Data="&amp;LНапечатано: &amp;D &amp;T &amp;RСтраница &amp;P из &amp;N"/>
    <PageMargins x:Bottom="0.66" x:Left="0.17" x:Right="0.17"
     x:Top="0.56000000000000005"/>
   </PageSetup>
   <Unsynced/>
   <Print>
    <ValidPrinterInfo/>
    <PaperSizeIndex>9</PaperSizeIndex>
    <HorizontalResolution>600</HorizontalResolution>
    <VerticalResolution>600</VerticalResolution>
   </Print>
   <Selected/>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>14</ActiveRow>
     <ActiveCol>16</ActiveCol>     
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
</Workbook>
' 
  ;
  
  --FOR REC IN C_RULE_LIST LOOP --  
    FOR vPHONE_LIST IN C_PHONE_LIST LOOP
      ADD_LOG_MONITOR();
      i := i + 1;
      IF i = 1 THEN  -- Для первой строки закрывающие теги другие
        write_blob(vTEXT, 
      '
      <Row ss:AutoFitHeight="0" ss:Height="26.25">
        <Cell ss:Index="2" ss:StyleID="s98"><Data ss:Type="Number">'|| to_char(I) ||'</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="String" x:Ticked="1">'|| vPHONE_LIST.PHONE_NUMBER_FEDERAL||'</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
        <Cell ss:StyleID="s100"><Data ss:Type="DateTime">'|| DATE_TO_XML(vPHONE_LIST.CONTRACT_DATE) ||'</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>        
        <Cell ss:StyleID="s98"><Data ss:Type="String" x:Ticked="1">'|| htf.escape_sc(vPHONE_LIST.TARIFF_NAME)||'</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_IN_NO_PAID) || '</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_IN_NO_PAID_ONLY_BEE) || '</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_OUT_NO_PAID) || '</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_OUT_NO_PAID_ONLY_BEE) || '</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_IN_YES_PAID) || '</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_IN_YES_PAID_ONLY_BEE) || '</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_OUT_YES_PAID) || '</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_OUT_YES_PAID_ONLY_BEE) || '</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">'|| TO_CHAR(vPHONE_LIST.SMS_OUT ) ||'</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">'|| TO_CHAR(vPHONE_LIST.MMS_OUT ) ||'</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">'|| TO_CHAR(vPHONE_LIST.INTERNET_TRAFFIC) || '</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="String" x:Ticked="1">'|| vPHONE_LIST.PHONE_IS_ACTIVE || '</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
      </Row>'
      );
      ELSE
        write_blob(vTEXT,'
      <Row ss:AutoFitHeight="0" ss:Height="26.25">
        <Cell ss:Index="2" ss:StyleID="s98"><Data ss:Type="Number">'|| to_char(I) ||'</Data></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="String" x:Ticked="1">'|| vPHONE_LIST.PHONE_NUMBER_FEDERAL||'</Data></Cell>
        <Cell ss:StyleID="s100"><Data ss:Type="DateTime">'|| DATE_TO_XML(vPHONE_LIST.CONTRACT_DATE) ||'</Data></Cell>        
        <Cell ss:StyleID="s98"><Data ss:Type="String" x:Ticked="1">'|| htf.escape_sc( vPHONE_LIST.TARIFF_NAME) ||'</Data></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_IN_NO_PAID) || '</Data></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_IN_NO_PAID_ONLY_BEE) || '</Data></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_OUT_NO_PAID) || '</Data></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_OUT_NO_PAID_ONLY_BEE) || '</Data></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_IN_YES_PAID) || '</Data></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_IN_YES_PAID_ONLY_BEE) || '</Data></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_OUT_YES_PAID) || '</Data></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">' || TO_CHAR(vPHONE_LIST.DURATION_OUT_YES_PAID_ONLY_BEE) || '</Data></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">'|| TO_CHAR(vPHONE_LIST.SMS_OUT ) ||'</Data></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">'|| TO_CHAR(vPHONE_LIST.MMS_OUT ) ||'</Data></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="Number">'|| TO_CHAR(vPHONE_LIST.INTERNET_TRAFFIC) || '</Data></Cell>
        <Cell ss:StyleID="s98"><Data ss:Type="String" x:Ticked="1">'|| vPHONE_LIST.PHONE_IS_ACTIVE || '</Data></Cell>
      </Row>'
      );        
      END IF;
    END LOOP;
  --END LOOP;   
    
    --склеиваем файл в единый
    write_blob(vTEXT, vTEXT_TABLE_CLOSE);
    
    IF I > 0 THEN  -- Если в мониторе нет записей, письмо не отсылаем
      vTEXT_TABLE_HEADER := 
    '
 <Worksheet ss:Name="Лист1">
  <Names>
   <NamedRange ss:Name="Print_Titles" ss:RefersTo="=Лист1!R3:R8"/>
  </Names>
  <Table ss:ExpandedColumnCount="17" ss:ExpandedRowCount="'||
      to_char(I+vROW_BEFORE_TABLE)  -- необходимо указывать количество строк в таблице
  ||'" x:FullColumns="1"
   x:FullRows="1" ss:DefaultRowHeight="15">
   <Column ss:AutoFitWidth="0" ss:Width="1.5"/>
   <Column ss:AutoFitWidth="0" ss:Width="24"/>
   <Column ss:AutoFitWidth="0" ss:Width="59.25"/>
   <Column ss:AutoFitWidth="0" ss:Width="63"/>
   <Column ss:AutoFitWidth="0" ss:Width="85.5"/>
   <Column ss:AutoFitWidth="0" ss:Width="45"/>
   <Column ss:AutoFitWidth="0" ss:Width="40.5"/>
   <Column ss:AutoFitWidth="0" ss:Width="45" ss:Span="5"/>
   <Column ss:Index="14" ss:AutoFitWidth="0" ss:Width="35.25"/>
   <Column ss:AutoFitWidth="0" ss:Width="39"/>
   <Column ss:AutoFitWidth="0" ss:Width="51"/>
   <Column ss:AutoFitWidth="0" ss:Width="44.25"/>
   <Row ss:AutoFitHeight="0">
    <Cell ss:Index="5" ss:MergeAcross="3" ss:StyleID="s62"><Data ss:Type="String">МОНИТОР ИСХОДЯЩЕЙ СВЯЗИ</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:Index="9" ss:StyleID="s62"/>
    <Cell ss:StyleID="s62"/>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:Index="3" ss:StyleID="s64"><Data ss:Type="String">Данные монитора представлены на момент:</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:Index="6" ss:MergeAcross="2" ss:StyleID="s66"><Data ss:Type="DateTime">';
    write_blob( vTEXT_STYLE, vTEXT_TABLE_HEADER);
    write_blob( vTEXT_STYLE, DATE_TO_XML(sysdate) );
    write_blob( vTEXT_STYLE, '</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:Index="6" ss:StyleID="s67"><NamedCell ss:Name="Print_Titles"/></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="19.5">
    <Cell ss:Index="2" ss:MergeDown="2" ss:StyleID="m116112264"><Data
      ss:Type="String">№ п/п</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:MergeDown="2" ss:StyleID="m116112284"><Data ss:Type="String">ТЕЛЕФОН</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:MergeDown="2" ss:StyleID="m116112304"><Data ss:Type="String">ДАТА ДОГОВОРА</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:MergeDown="2" ss:StyleID="m116112344"><Data ss:Type="String">ТАРИФ</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:MergeAcross="3" ss:StyleID="m116112364"><Data ss:Type="String">Бесплатно</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:MergeAcross="3" ss:StyleID="m116112672"><Data ss:Type="String">ПЛАТНО</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:MergeAcross="1" ss:MergeDown="1" ss:StyleID="m116112692"><Data
      ss:Type="String">Количетсво исходящих</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:MergeDown="2" ss:StyleID="m116112712"><Data ss:Type="String">Интернет трафик, ГБ</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:MergeDown="2" ss:StyleID="m116112732"><Data ss:Type="String">Статус</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="19.5">
    <Cell ss:Index="6" ss:MergeAcross="1" ss:StyleID="m116112752"><Data
      ss:Type="String">Входящие</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:MergeAcross="1" ss:StyleID="m116112772"><Data ss:Type="String">Исходящие</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:MergeAcross="1" ss:StyleID="m116112792"><Data ss:Type="String">Входящие</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:MergeAcross="1" ss:StyleID="m116112812"><Data ss:Type="String">Исходящие</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="30">
    <Cell ss:Index="6" ss:StyleID="s75"><Data ss:Type="String">Все</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s75"><Data ss:Type="String">Только Билайн</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s75"><Data ss:Type="String">Все</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s75"><Data ss:Type="String">Только Билайн</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s75"><Data ss:Type="String">Все</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s75"><Data ss:Type="String">Только Билайн</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s75"><Data ss:Type="String">Все</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s75"><Data ss:Type="String">Только Билайн</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s97"><Data ss:Type="String">СМС</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s97"><Data ss:Type="String">ММС</Data><NamedCell
      ss:Name="Print_Titles"/></Cell>
   </Row>'
        );
        DBMS_LOB.APPEND(vTEXT_STYLE, vTEXT);
        --write_blob(vTEXT_STYLE, vTEXT);
        SEND_MAIL_WITH_ATTACHMENT(
          MS_params.GET_PARAM_VALUE ('MAIL_FOR_CALLS_MONITOR'),
          'Монитор исходящей связи',
          'Данные по монитору исхолдящей связи в аттаче. Дата формирования '||pDATE_UNLOADED,
          'CallsMonitor'||pDATE_UNLOADED||'.xls',
          VTEXT_STYLE
        );
    END IF;

end;
/
