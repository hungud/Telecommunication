
  CREATE OR REPLACE PACKAGE "CORP_MOBILE"."SEND_GROUP_DETAIL_XML" AS
--
-- Version = 2
-- Крайнов. Рассылка по детализаций из АПИ
  PROCEDURE SEND_XML(
    p_GROUP_ID INTEGER, 
    p_mail_param_account_id integer default null
    );
  --
  PROCEDURE SEND_API_XML(
    p_GROUP_ID INTEGER, 
    p_mail_param_account_id integer default null
    );
  --
  PROCEDURE SEND_BALANCE_XML(
    p_GROUP_ID INTEGER, 
    p_mail_param_account_id integer default null
    );
  --
END SEND_GROUP_DETAIL_XML; 
CREATE OR REPLACE PACKAGE BODY "CORP_MOBILE"."SEND_GROUP_DETAIL_XML" AS
/*
  procedure blob_compressJ(p_name in varchar2, p_blob_in in blob, p_blob_out out blob)
  as language java
  name 'LobCompress.ZipCompress(java.lang.String, oracle.sql.BLOB, oracle.sql.BLOB[])';

  function blob_compress(p_name varchar2, p_blob blob) return blob is
    l_blob blob;
  begin
    if p_name is null or p_blob is null then return null; end if;
    dbms_lob.createtemporary(l_blob,true);
    blob_compressJ(p_name,p_blob,l_blob);
    return l_blob;
  end;
*/  
  --
  procedure write_blob(cc in out nocopy clob, s in varchar2)is
  begin
    cc:=cc||convert(s,'UTF8');
--    dbms_lob.writeappend(cc, length(convert(s,'UTF8')), utl_raw.cast_to_raw(convert(s,'UTF8')));
  end;
  --
  PROCEDURE  excel_open(
    l_xml_body  IN OUT NOCOPY  CLOB,
    encoding  IN VARCHAR2  DEFAULT  'utf-8' )  IS
  BEGIN
      write_blob(l_xml_body, '<?xml version="1.0" encoding="' || encoding || '"?>' || chr(10) ||
                        '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet">' || chr(10) ||
                        '<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">' || chr(10) ||
                        '<ProtectStructure>False</ProtectStructure>' || chr(10) ||
                        '<ProtectWindows>False</ProtectWindows>' || chr(10) ||
                        '</ExcelWorkbook>' || chr(10) || '<Styles>' || chr(10) ||
                        '<Style ss:ID="Default" ss:Name="Normal">' || chr(10) ||
                        '<Alignment ss:Vertical="Bottom"/>' || chr(10) ||
                        '<Borders/>' || chr(10) || '<Font/>' || chr(10) ||
                        '<Interior/>' || chr(10) || '<NumberFormat/>' || chr(10) ||
                        '<Protection/>' || chr(10) || '</Style>' || chr(10) ||
                        '<Style ss:ID="s22">' || chr(10) ||
                        '<Alignment ss:Horizontal="Center" ss:Vertical="Bottom" />' || chr(10) ||
                        '<Font ss:FontName="Calibri" x:Family="Swiss" ss:Bold="1"/>' || chr(10) ||
                        '<Borders>' || chr(10) ||
                        '<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>' || chr(10) ||
                        '</Borders>' || chr(10) ||
                        '<Interior ss:Color="#C0C0C0" ss:Pattern="Solid"/>' || chr(10) ||
                        '</Style>' || chr(10) ||
                        '<Style ss:ID="s63">' || chr(10) ||
                        '<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>' || chr(10) ||
                        '</Style>' || chr(10) || 
                        '<Style ss:ID="s70">' || chr(10) ||
                        '<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>' || chr(10) ||
                        '<Font ss:FontName="Calibri" x:CharSet="204" x:Family="Swiss" ss:Size="11"' || chr(10) ||
                        'ss:Color="#000000" ss:Bold="1"/>' || chr(10) ||
                        '</Style>' || chr(10) ||
                        '</Styles>');
  END  excel_open;
  --
  PROCEDURE excel_close( l_xml_body IN OUT NOCOPY CLOB ) IS
  BEGIN
    write_blob(l_xml_body,'</Workbook>'||chr(10));
  END  excel_close;
  --
  PROCEDURE worksheet_open(
    l_xml_body      IN OUT NOCOPY CLOB,
    p_worksheetname IN VARCHAR2
  )  IS
  BEGIN
    write_blob(l_xml_body, '<Worksheet ss:Name="'||chr(10));
    write_blob(l_xml_body, p_worksheetname ||chr(10));
    write_blob(l_xml_body,  '"><Table>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="63"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="56"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="50"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="56"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="71"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="64"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="74"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="104"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="56"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="47"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="77"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="92"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="83"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="80"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="100"/>'||chr(10));
  END  worksheet_open;
  --
  PROCEDURE worksheet_close( l_xml_body IN OUT NOCOPY CLOB )  IS
  BEGIN
    write_blob(l_xml_body, '</Table></Worksheet>'||chr(10));
  END  worksheet_close;
  --
  PROCEDURE row_open(l_xml_body IN OUT NOCOPY CLOB) IS
  BEGIN
    write_blob(l_xml_body, '<Row>'||chr(10));
  END  row_open;
  --
  PROCEDURE row_close( l_xml_body IN OUT NOCOPY CLOB ) IS
  BEGIN
    write_blob(l_xml_body, '</Row>'||chr(10));
  END  row_close;
  --
  PROCEDURE cell_write  (
    l_xml_body  IN  OUT NOCOPY CLOB,
    p_content   IN  VARCHAR2,
    is_number   IN INTEGER DEFAULT 0
  )  IS
  BEGIN
    if is_number = 1 then 
      write_blob(l_xml_body, '<Cell ss:StyleID="s63"><Data ss:Type="String">');
    else
      write_blob(l_xml_body, '<Cell><Data ss:Type="String">');
    end if;    
    if p_content IS NOT NULL then
      write_blob(l_xml_body, p_content);
    end if;  
    write_blob(l_xml_body, '</Data></Cell>'||chr(10));
  END  cell_write;
  --
  PROCEDURE cell_head_write  (
    l_xml_body  IN  OUT NOCOPY CLOB,
    p_content   IN  VARCHAR2
  )  IS
  BEGIN
    write_blob(l_xml_body, '<Cell ss:StyleID="s22"><Data ss:Type="String">');
    write_blob(l_xml_body, p_content);
    write_blob(l_xml_body, '</Data></Cell>'||chr(10));
  END  cell_head_write;
  --  
PROCEDURE SEND_MAIL_WITH_ATTACHMENT_new(
  RECIPIENT IN VARCHAR2,
  MESSAGE_TITLE IN VARCHAR2,
  MAIL_TEXT IN CLOB DEFAULT NULL,
  FILENAME IN VARCHAR2 DEFAULT NULL,
  ATTACHMENT IN CLOB DEFAULT NULL,
  p_mail_param_account_id integer default null
  ) IS
CURSOR C IS
  SELECT *
    FROM send_mail_param_by_account 
   where account_id = nvl(p_mail_param_account_id,20); -- По-умолчанию от tariff@2255757.ru (account_id=20)
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
--  
  PROCEDURE SEND_XML(p_GROUP_ID INTEGER, p_mail_param_account_id integer default null) IS
    c clob;
    l_year_month varchar2(6);
    l_send_detail_auto number(1) := 0;
    l_group_name varchar2(220 char);
    l_paramdet_mail varchar2(100);
    v_errm varchar2(2000 char);    
    sql_stm varchar2(2000);
    TYPE c_call_Typ IS REF CURSOR;
    c_call c_call_Typ;
    SELF_NUMBER varchar2(11);
    SERVICE_DATE varchar2(10);
    SERVICE_TIME varchar2(8);
    SERVICE_TYPE varchar2(20);
    SERVICE_DIRECTION varchar2(13 char);
    OTHER_NUMBER varchar2(21);
    DURATION number;
    DURATION_MIN number;
    SERVICE_COST number;
    IS_ROAMING varchar2(2 char);
    ROAMING_ZONE varchar2(6);
    ADD_INFO varchar2(100 char);
    BASE_STATION_CODE varchar2(6);
    COST_NO_VAT number;
    BS_PLACE varchar2(50);
    cursor c_group_phones (l_group_id v_contracts.group_id%type, year_month varchar2) is
      select v.PHONE_NUMBER_FEDERAL, v.CONTRACT_NUM, v.GROUP_ID from v_contracts v
      where v.GROUP_ID = l_group_id
        AND v.CONTRACT_DATE < ADD_MONTHS(TO_DATE(YEAR_MONTH||'01', 'yyyymmdd'), 1)
        AND (v.CONTRACT_CANCEL_DATE IS NULL OR v.CONTRACT_CANCEL_DATE >= TO_DATE(YEAR_MONTH||'01', 'yyyymmdd'));
  BEGIN
    --Проверяем признак необходимости отправлять детализации группы и 
    -- отправлялась ли детализация в текущем месяце
    begin
      SELECT send_detail_auto into l_send_detail_auto
      FROM contract_groups g
      WHERE g.group_id = p_GROUP_ID AND TO_NUMBER(TO_CHAR(SYSDATE,'dd')) >= send_detail_day
        AND NOT EXISTS (SELECT 1 
                          FROM send_detail_groups_log l 
                          WHERE l.group_id = p_GROUP_ID
                            AND l.send_date_time > TRUNC(SYSDATE,'mm')
                            AND l.error_text IS NULL
                            and nvl(l.is_detail,0)=1);-- детализации
    exception
      when no_data_found then null;
    end;                          
    if l_send_detail_auto = 1 then  
      dbms_lob.createtemporary(c,true);
      --Получаем период, за который нужно отправиль детализацию (прошлый месяц)
      select to_char(max(s.year_month)-1) into l_year_month 
       from db_loader_phone_stat s, hot_billing_month m
       where s.year_month = m.year_month and m.db = 1;
      --Формируем текст запроса 
      sql_stm := 'select c10.subscr_no as SELF_NUMBER,'||
       ' c10.call_date as SERVICE_DATE,'||
       ' c10.call_time as SERVICE_TIME,'||
       ' (select dl.SERVICE_NAME from DB_LOADER_SERVICE_TYPES dl'||
       '  where dl.service_code=c10.servicetype) as SERVICE_TYPE,'||
       ' decode(c10.servicedirection,1,''Исходящий'',2,''Входящий'',3,''переадресация'',''Неопределено'') as SERVICE_DIRECTION,'||
       ' decode(c10.subscr_no,c10.calling_no,c10.dialed_dig,c10.calling_no) as OTHER_NUMBER,'||
       ' c10.dur as DURATION,'||
       ' case '||
       '  when c10.dur<=2 then 0'||
       '  else ceil(c10.dur/60)'||
       ' end DURATION_MIN,'||
       ' c10.call_cost as SERVICE_COST,'||
       ' decode(c10.isroaming,''1'',''Да'','''') as IS_ROAMING,'||
       ' c10.roamingzone as ROAMING_ZONE,'||
       ' substr(c10.at_ft_de,1,100) as ADD_INFO,'||
       ' TRIM( BOTH chr(13) FROM c10.cell_id) as BASE_STATION_CODE,'||
       ' c10.costnovat as COST_NO_VAT,'||
       ' (select bb.zone_name from BEELINE_BS_ZONES bb'||
       '  where bb.beeline_bs_zone_id=TRIM( BOTH chr(13) FROM c10.cell_id)) as BS_PLACE'||
       ' from call_'||substr(l_year_month,5,2)||'_'||substr(l_year_month,1,4)||' c10'||
       ' where c10.subscr_no = :PHONE_NUMBER'||
       ' order by c10.start_time';
       
      excel_open(c);
       --Цикл по телефонным номерам группы
       for v_group_phones in c_group_phones(p_group_id, l_year_month) loop
        exit when c_group_phones%notfound;
        dbms_output.put_line(v_group_phones.group_id||' | '||v_group_phones.phone_number_federal);      
        worksheet_open(c,v_group_phones.phone_number_federal);
         row_open(c);
          --Заголовки
          cell_head_write(c,'Свой номер');
          cell_head_write(c,'Дата');
          cell_head_write(c,'Время');
          cell_head_write(c,'Тип услуги');
          cell_head_write(c,'Направление');
          cell_head_write(c,'Собеседник');
          cell_head_write(c,'Длительность');
          cell_head_write(c,'Длительность (мин)');
          cell_head_write(c,'Стоимость');
          cell_head_write(c,'Роуминг');
          cell_head_write(c,'Зона роуминга');        
          cell_head_write(c,'Доп.информация');
          cell_head_write(c,'Базовая станция');
          cell_head_write(c,'Сумма без НДС');
          cell_head_write(c,'Зона БС');
         row_close(c);
         OPEN c_call FOR sql_stm USING v_group_phones.phone_number_federal;
         LOOP 
           FETCH c_call INTO SELF_NUMBER, SERVICE_DATE, SERVICE_TIME, SERVICE_TYPE,
                             SERVICE_DIRECTION, OTHER_NUMBER, DURATION, DURATION_MIN,
                             SERVICE_COST, IS_ROAMING, ROAMING_ZONE, ADD_INFO,
                             BASE_STATION_CODE, COST_NO_VAT, BS_PLACE;
           EXIT WHEN c_call%NOTFOUND;
           row_open(c);
            cell_write(c, SELF_NUMBER);
            cell_write(c, SERVICE_DATE);
            cell_write(c, SERVICE_TIME);
            cell_write(c, SERVICE_TYPE);
            cell_write(c, SERVICE_DIRECTION);
            cell_write(c, OTHER_NUMBER);
            cell_write(c, TO_CHAR(DURATION),1);
            cell_write(c, TO_CHAR(DURATION_MIN),1);
            cell_write(c, TO_CHAR(SERVICE_COST),1);
            cell_write(c, IS_ROAMING);
            cell_write(c, ROAMING_ZONE);
            cell_write(c, ADD_INFO);
            cell_write(c, BASE_STATION_CODE);
            cell_write(c, TO_CHAR(COST_NO_VAT),1);
            cell_write(c, BS_PLACE);
           row_close(c);
         END LOOP;--c_call
         CLOSE c_call;
        worksheet_close(c);
       end loop;--v_grop_phones
      excel_close(c);
      --получаем параметры для отправки файла
      SELECT group_name, paramdet_mail INTO l_group_name, l_paramdet_mail FROM contract_groups WHERE group_id = p_group_id;
     
      send_mail_with_attachment_new(recipient => l_paramdet_mail,
                                    message_title => 'Детализация группы договоров "'|| l_group_name ||'" за '|| substr(l_year_month,1,4) || '- '|| substr(l_year_month,5,2),
                                    mail_text => null,
                                    filename => 'Detail_'||to_char(SYSDATE,'yyyymmddhh24miss')||'.xls',
                                    attachment => c,
                                    p_mail_param_account_id => p_mail_param_account_id);
    
      --запись в лог                              
      INSERT INTO send_detail_groups_log (group_id, year_month, send_date_time, is_detail)
      VALUES (p_group_id, l_year_month, SYSDATE, 1);
--      insert into test_blob (id,c) values ((select nvl(max(id),0)+1 from test_blob),c);
      COMMIT;
      dbms_lob.freetemporary(c);
    end if;--l_send_detail_auto
  EXCEPTION
    WHEN OTHERS THEN 
      v_errm:=substr(SQLERRM,1,2000);
      INSERT INTO send_detail_groups_log (group_id, year_month, send_date_time, error_text, is_detail)
      VALUES (p_group_id, l_year_month, SYSDATE, v_errm, 1);
    COMMIT;
       
  END;
--  
  PROCEDURE SEND_API_XML(p_GROUP_ID INTEGER, p_mail_param_account_id integer default null) IS
    c clob;
    l_year_month varchar2(6);
    l_send_detail_auto number(1) := 0;
    l_group_name varchar2(220 char);
    l_paramdet_mail varchar2(100);
    v_errm varchar2(2000 char);    
    sql_stm varchar2(2000);
 /*   TYPE c_call_Typ IS REF CURSOR;
    c_call c_call_Typ;*/
  /*  SELF_NUMBER varchar2(11);
    CALLDATE VARCHAR2(30 Char);
    CALLNUMBER VARCHAR2(15 Char);
    CALLTONUMBER VARCHAR2(30 Char);
    SERVICENAME VARCHAR2(120 Char);
    CALLTYPE VARCHAR2(120 Char);
    DATAVOLUME VARCHAR2(15 Char);
    CALLAMT VARCHAR2(15 Char);
    CALLDURATION VARCHAR2(15 Char);*/
  --  ap API_GET_UNBILLED_CALLS_LIST%rowtype;
    cursor c_group_phones (l_group_id v_contracts.group_id%type/*, year_month varchar2*/) is
      select v.PHONE_NUMBER_FEDERAL, v.CONTRACT_NUM, v.GROUP_ID 
        from v_contracts v
        where v.GROUP_ID = l_group_id
          AND v.CONTRACT_CANCEL_DATE IS NULL;
    cursor c_call(phone in varchar2) is
      SELECT phone ctn,
             TO_CHAR(CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(UC.callDate), 'DD.MM.YYYY HH24:MI:SS') callDate,
             UC.serviceName serviceName,
             UC.callType callType,
             DECODE(REPLACE(UC.callAmt, '.', ','), '0,0', '0', REPLACE(UC.callAmt, '.', ',')) callAmt,
             UC.callNumber,
             UC.callToNumber,
             UC.callDuration,
             DECODE(REPLACE(UC.dataVolume, '.', ','), '0,0', '0', REPLACE(UC.dataVolume, '.', ',')) dataVolume
        FROM API_GET_UNBILLED_CALLS_LIST UC
        ORDER BY callDate;
    call_row c_call%rowtype;    
  BEGIN
    v_errm:='';
    --Проверяем признак необходимости отправлять детализации группы и 
    -- отправлялась ли детализация в текущем месяце
    l_send_detail_auto:=1;  
    l_year_month:=0;                        
    if l_send_detail_auto = 1 then  
      dbms_lob.createtemporary(c,true);
      excel_open(c);
      --Цикл по телефонным номерам группы
      for v_group_phones in c_group_phones(p_group_id/*, l_year_month*/) loop
        v_errm:='';
        exit when c_group_phones%notfound;
        dbms_output.put_line(v_group_phones.group_id||' | '||v_group_phones.phone_number_federal);      
        worksheet_open(c,v_group_phones.phone_number_federal);
        row_open(c);
          --Заголовки
          cell_head_write(c,'Свой номер');
          cell_head_write(c,'Дата и время');
          cell_head_write(c,'Тип вызова');
          cell_head_write(c,'Описание вызова');
          cell_head_write(c,'Стоимость');
          cell_head_write(c,'Исходящий номер');
          cell_head_write(c,'Входящий номер');
          cell_head_write(c,'Длительность');
          cell_head_write(c,'Объём');
        row_close(c);
      --  v_errm:=v_errm||' '||v_group_phones.phone_number_federal;
        BEELINE_API_PCKG.LOAD_DETAIL_FROM_API(v_group_phones.phone_number_federal);
      --  v_errm:=v_errm||' API+ ';
        dbms_output.put_line('API+');  
        OPEN c_call(v_group_phones.phone_number_federal);
        LOOP 
          FETCH c_call INTO call_row;
        --  v_errm:=v_errm||v_group_phones.phone_number_federal;
          EXIT WHEN c_call%NOTFOUND;
          --dbms_output.put_line('API+');  
          row_open(c);
            cell_write(c, call_row.ctn);
            cell_write(c, call_row.callDate);
            cell_write(c, call_row.serviceName);
            cell_write(c, call_row.callType);
            cell_write(c, call_row.callAmt);
            cell_write(c, call_row.callNumber);
            cell_write(c, call_row.callToNumber);
            cell_write(c, call_row.callDuration);
            cell_write(c, call_row.dataVolume);
          row_close(c);
        END LOOP;--c_call
        CLOSE c_call;
        v_errm:=v_errm||' SQL+';
       worksheet_close(c);
      end loop;--v_grop_phones
      excel_close(c);
      --получаем параметры для отправки файла
      SELECT group_name, paramdet_mail 
        INTO l_group_name, l_paramdet_mail 
        FROM contract_groups 
        WHERE group_id = p_group_id;     
      send_mail_with_attachment_new(recipient => l_paramdet_mail,
                                    message_title => 'Детализация группы договоров "'|| l_group_name ||'" за '|| substr(l_year_month,1,4) || '- '|| substr(l_year_month,5,2),
                                    mail_text => null,
                                    filename => 'Detail_'||to_char(SYSDATE,'yyyymmddhh24miss')||'.xls',
                                    attachment => c,
                                    p_mail_param_account_id => p_mail_param_account_id);    
      --запись в лог                              
      INSERT INTO send_detail_groups_log(group_id, year_month, send_date_time, is_detail)
        VALUES(p_group_id, l_year_month, SYSDATE, 1);
--      insert into test_blob (id,c) values ((select nvl(max(id),0)+1 from test_blob),c);
      COMMIT;
      dbms_lob.freetemporary(c);
    end if;--l_send_detail_auto
  EXCEPTION
    WHEN OTHERS THEN 
      v_errm:=v_errm||substr(SQLERRM,1,2000);
      INSERT INTO send_detail_groups_log (group_id, year_month, send_date_time, error_text, is_detail)
      VALUES (p_group_id, l_year_month, SYSDATE, v_errm, 1);
    COMMIT;       
  END;
--   
  PROCEDURE worksheet_balance_open(
    l_xml_body      IN OUT NOCOPY CLOB,
    p_worksheetname IN VARCHAR2
  )  IS
  BEGIN
    write_blob(l_xml_body, '<Worksheet ss:Name="'||chr(10));
    write_blob(l_xml_body, p_worksheetname ||chr(10));
    write_blob(l_xml_body,  '"><Table>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="108"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="96"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="80"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="86"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="60"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="290"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="80"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="180"/>'||chr(10));
    write_blob(l_xml_body, '<Column ss:Width="117"/>'||chr(10));
  END;
--
  PROCEDURE cell_balance_title_write  (
    l_xml_body  IN  OUT NOCOPY CLOB,
    p_content   IN  VARCHAR2
  )  IS
  BEGIN
    write_blob(l_xml_body, '<Cell ss:MergeAcross="8" ss:StyleID="s70"><Data ss:Type="String">');
    write_blob(l_xml_body, p_content);
    write_blob(l_xml_body, '</Data></Cell>'||chr(10));
  END;
  --  
  PROCEDURE SEND_BALANCE_XML(p_GROUP_ID INTEGER, p_mail_param_account_id integer default null) IS
    c clob;
    
    v_email_balance         contract_groups.email_balance%type := null;
    v_email_balance_period  contract_groups.email_balance_period%type := null;
    v_email_balance_last    contract_groups.email_balance_last%type := null;
    
    v_group_name            contract_groups.group_name%type; 

    v_stmt                  varchar2(4000);
    v_errm                  varchar2(2000 char);

    type vt_balance is record
      (
       contract_num       contracts.contract_num%type, 
       phone              contracts.phone_number_federal%type, 
       account_number     accounts.account_number%type,
       balance            number(12,2),
       IS_ACTIVE          varchar2(16),
       dop_status         contract_dop_statuses.dop_status_name%type,
       disconnect_limit   contracts.disconnect_limit%type,
       credit             varchar2(16),
       tariff_name        tariffs.tariff_name%type
      );
    
    type vt_ind_balance is table of vt_balance index by pls_integer;
    
    v_rec vt_ind_balance;

  BEGIN
  
    select
           nvl(group_name,'N/A'),
           email_balance,
           email_balance_period,
           email_balance_last
      into 
           v_group_name,
           v_email_balance,
           v_email_balance_period,
           v_email_balance_last
      from contract_groups 
     where group_id=p_GROUP_ID;
    
    if v_email_balance is not null -- если необходимые поля не пусты и дата последней посылки округлённой до начала суток и период рассылки меньше либо равн текущей даты то отсылаем
        and nvl(v_email_balance_period,0) <> 0
        and trunc(nvl(v_email_balance_last,sysdate-v_email_balance_period),'DD')+v_email_balance_period<=sysdate
    then
      dbms_lob.createtemporary(c,true);
      --Формируем текст запроса 
      v_stmt := 'SELECT '||
                '  c.contract_num, '||
                '  c.phone_number_federal, '|| 
                '  a.account_number, '||
                '  get_abonent_balance(c.PHONE_NUMBER_FEDERAL), '||
                '  (select CASE '|| 
                '            WHEN FB.PHONE_IS_ACTIVE = 1 THEN ''Акт.'' '||
                '            ELSE ''Бл.'' '||
                '          END  '||
                '     FROM DB_LOADER_ACCOUNT_PHONES FB '||
                '     WHERE FB.PHONE_NUMBER = c.PHONE_NUMBER_FEDERAL '||
                '       AND FB.YEAR_MONTH = TO_CHAR(SYSDATE, ''YYYYMM'') '||
                '       AND ROWNUM <=1), '||
                '  d.dop_status_name, '||
                '  c.disconnect_limit, '||
                '  CASE '||
                '     WHEN c.is_credit_contract = 1 THEN ''Кредит'' '||
                '     ELSE ''Аванс'' '||
                '  END credit, '||
                '  t.tariff_name '||
                ' FROM contracts c, '||
                '      accounts a, '||
                '      contract_dop_statuses d, '||
                '      tariffs t '||
                ' WHERE get_account_id_by_phone(c.phone_number_federal) = a.account_id(+) '||
                '   AND c.dop_status = d.dop_status_id(+) '||
                '   AND c.curr_tariff_id = t.tariff_id(+) '||
                '   AND c.group_id = '||p_GROUP_ID||
                '   AND NOT EXISTS (SELECT 1 '||
                '                    FROM CONTRACT_CANCELS CC '||
                '                    WHERE CC.CONTRACT_ID = C.CONTRACT_ID)';

      execute immediate v_stmt bulk collect INTO v_rec ;
      
      excel_open(c);
      worksheet_balance_open(c, htf.escape_sc(v_group_name));
      
      row_open(c); -- Шапка
        cell_balance_title_write(c,'Номера группы договоров '||htf.escape_sc(v_group_name));
      row_close(c);
      
      row_open(c); row_close(c);

      row_open(c);
        --Заголовки
        cell_head_write(c,'Номер договора');
        cell_head_write(c,'Телефон');
        cell_head_write(c,'Номер счёта');
        cell_head_write(c,'Баланс');
        cell_head_write(c,'Статус');
        cell_head_write(c,'Доп.статус');
        cell_head_write(c,'Тип оплаты');
        cell_head_write(c,'Название тарифа');
        cell_head_write(c,'Кредитный лимит');
      row_close(c);
           
      for i in 1..v_rec.count loop
      
        row_open(c);
          cell_write(c, v_rec(i).contract_num);
          cell_write(c, v_rec(i).phone);
          cell_write(c, v_rec(i).account_number);
          cell_write(c, to_char(v_rec(i).balance),1);
          cell_write(c, v_rec(i).IS_ACTIVE);
          cell_write(c, htf.escape_sc(v_rec(i).dop_status));
          cell_write(c, v_rec(i).credit);
          cell_write(c, htf.escape_sc(v_rec(i).tariff_name));
          cell_write(c, to_char(v_rec(i).disconnect_limit),1);
        row_close(c);

      end loop;
      
      worksheet_close(c);
      excel_close(c);
      
      send_mail_with_attachment_new(recipient => v_email_balance,
                                    message_title => '"'|| v_group_name ||'" на '||to_char(sysdate,'dd-mm-yyyy hh24:mi')||' .',
                                    mail_text => null,
                                    filename => 'balance_'||to_char(SYSDATE,'yyyymmddhh24miss')||'.xls',
                                    attachment => c,
                                    p_mail_param_account_id => p_mail_param_account_id);
        
      dbms_lob.freetemporary(c);
      update contract_groups set email_balance_last=sysdate where group_id=p_GROUP_ID;
      --запись в лог                              
      INSERT INTO send_detail_groups_log (group_id, year_month, send_date_time, is_detail)
      VALUES (p_group_id, to_char(SYSDATE,'yyyymm'), SYSDATE, 0);
    end if;
  EXCEPTION
    WHEN OTHERS THEN 
      v_errm:=substr(SQLERRM,1,2000);
      INSERT INTO send_detail_groups_log (group_id, year_month, send_date_time, error_text, is_detail)
      VALUES (p_group_id,to_char(SYSDATE,'yyyymm'), SYSDATE, v_errm, 0);
    COMMIT;
  END;
--  
END SEND_GROUP_DETAIL_XML; 