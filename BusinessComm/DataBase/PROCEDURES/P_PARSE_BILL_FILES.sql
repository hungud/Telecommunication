CREATE OR REPLACE PROCEDURE P_PARSE_BILL_FILES AS
--
--#Version=1
--
--v.1 Афросин 12.10.2015 Процедура, отправки файлов на сервис парсинга.
--
--
  С_NEW_FILE_STATUS CONSTANT INTEGER := 0;
  С_ERROR_FILE_STATUS CONSTANT INTEGER := 3;
  C_NO_ERROR_STATUS  CONSTANT INTEGER := 1;
  
  C_URLS CONSTANT VARCHAR2(150 CHAR) := MS_CONSTANTS.GET_CONSTANT_VALUE('PARSER_URL');
  
  C_NO_ERROR CONSTANT VARCHAR2(8 CHAR) := 'NO_ERROR';  --ФАЙЛ РАСПАРСЕН БЕЗ ОШИБОК
  
  C_L_LENGTH         PLS_INTEGER := 66*240; -- число обязательно кратное 66
  
  cursor FILE_ID is
    select
      log_bill_id
    from
      DB_LOADER_BILL_LOAD_LOG
    where
      BILL_FILE_STATUS_ID = С_NEW_FILE_STATUS
--      and log_bill_id = 25
      order by log_bill_id asc
      ;-- статус необработанного файла 
   
   req        utl_http.req;--запрос
   resp       utl_http.resp;--ответ  
   l_clob           CLOB;
   l_text           VARCHAR2(32767);
   
   i Integer;

   clobLine clob;
   temp blob;
   file_size INTEGER;
   
   
   v_ErrorText varchar2(500 char);
   
   
   L_SUBSTRING      VARCHAR2(32000) := '_'; -- не пустое значение любое
   L_N              PLS_INTEGER := 0;
   

  procedure base64encode
      ( i_blob                        in blob
      , io_clob                       in out nocopy clob 
          
      )
  is
    l_step                          pls_integer := 22500; -- make sure you set a multiple of 3 not higher than 24573
    l_converted                     varchar2(32767);

    l_buffer_size_approx            pls_integer := 1048576;
    l_buffer                        clob;
  begin
    dbms_lob.createtemporary(l_buffer, true, dbms_lob.call);

    for i in 0 .. trunc((dbms_lob.getlength(i_blob) - 1 )/l_step) loop
      l_converted := utl_raw.cast_to_varchar2(utl_encode.base64_encode(dbms_lob.substr(i_blob, l_step, i * l_step + 1)));
      l_converted := REPLACE(l_converted, CHR(13), '');
      l_converted := REPLACE(l_converted, CHR(10), '');
      dbms_lob.writeappend(l_buffer, length(l_converted), l_converted);
                    

      if dbms_lob.getlength(l_buffer) >= l_buffer_size_approx then
        dbms_lob.append(io_clob, l_buffer);
                            
        dbms_lob.trim(l_buffer, 0);
      end if;
    end loop;

    dbms_lob.append(io_clob, l_buffer);

    dbms_lob.freetemporary(l_buffer);
  end;
   
   
begin

  for c in FILE_ID loop
    v_ErrorText := C_NO_ERROR;
    
    
    select FILE_BODY, DBMS_LOB.GETLENGTH(FILE_BODY) into temp, file_size
    from
      DB_LOADER_BILL_LOAD_LOG
    where
      LOG_BILL_ID = c.log_bill_id ;
                
      --проверяем файл на размер
      if file_size > 0 then
        begin  
          DBMS_LOB.CREATETEMPORARY (clobLine, TRUE);

          base64encode (temp, clobLine);
                      
          clobLine := '{"base64_file":"' ||clobLine||'"}';
                     
          utl_http.set_transfer_timeout(1200);--установка таймаута 5 минут. ( под ? )

          req:= utl_http.begin_request(url=>C_URLS, method=>'POST');
          
          utl_http.set_body_charset(req,'UTF-8');
          utl_http.SET_HEADER (req,'Content-Type', 'application/json');
                    
          UTL_HTTP.set_header (req, 'Content-Length', DBMS_LOB.getlength(clobLine));
                    
          L_SUBSTRING  := '_'; -- не пустое значение любое
          L_N := 0;
                    
          WHILE L_SUBSTRING IS NOT NULL LOOP
            L_SUBSTRING :=
              DBMS_LOB.SUBSTR(clobLine
                , C_L_LENGTH
                , C_L_LENGTH * L_N + 1
               );

          --IF NO SUBSTRING IS FOUND  - THEN WE'VE REACHED THE END OF BLOB
            IF L_SUBSTRING IS NOT NULL THEN
              UTL_HTTP.WRITE_TEXT (req, L_SUBSTRING);
              L_N := L_N + 1;
            END IF;
          END LOOP;
          resp := utl_http.get_response(req);

                      
          if resp.status_code = 400 then--если ошибка сервиса - вылетаем, с первой строкой.
            utl_http.read_line(resp, v_ErrorText);
            UTL_HTTP.END_RESPONSE(resp);
            v_ErrorText := v_ErrorText ||' Code:400';
          end if;
        exception  --резервное закрытие соединения, на всякий случай.
          when others then
            v_ErrorText := v_ErrorText||' Код:'||nvl(resp.status_code,0);
            if nvl(resp.status_code, 0)>0 then 
              UTL_HTTP.END_RESPONSE(resp);
            end if;
                     
            v_ErrorText := v_ErrorText||' ConnectErrorText! Соединение не создалось, файл не создан! '||chr(13)||sqlerrm;
        end;--подключение создалось
                  
                  
        begin
          DBMS_LOB.createtemporary(l_clob, FALSE);
          loop
            utl_http.READ_TEXT(resp, l_text, 32767);
            DBMS_LOB.writeappend (l_clob, LENGTH(l_text), l_text);
          end loop;

        exception
          WHEN UTL_HTTP.end_of_body THEN
            UTL_HTTP.end_response(resp);
          when others then--в любом случае закрываем соединение
            UTL_HTTP.END_RESPONSE(resp);
            if Instr(DBMS_UTILITY.FORMAT_ERROR_STACK, 'ORA-29266: end-of-body reached') = 0 then
              v_ErrorText := v_ErrorText || 'SQLERROR= '||DBMS_UTILITY.FORMAT_ERROR_STACK;
            end if;
              
        end;
        
        DBMS_LOB.freetemporary(clobLine);
    else
      l_clob := null;
      v_ErrorText := 'Файл не содержит данных';  
    end if;          
    
    
    if DBMS_LOB.INSTR(DBMS_LOB.SUBSTR(l_clob, 50, 1), 'data') = 0 then
      v_ErrorText := DBMS_LOB.SUBSTR(l_clob, 50, 1);
    end if;
    
    UPDATE DB_LOADER_BILL_LOAD_LOG
       SET
         PARSED_FILE_TEXT = l_clob,
         BILL_FILE_STATUS_ID = case v_ErrorText
                                 WHEN C_NO_ERROR then
                                   C_NO_ERROR_STATUS 
                               else
                                 С_ERROR_FILE_STATUS
                               end,
         ERROR_LOAD = REPLACE(v_ErrorText, C_NO_ERROR, '')
     where
        LOG_BILL_ID = c.log_bill_id;
     commit;
     
    /*
    if DBMS_LOB.INSTR(DBMS_LOB.SUBSTR(l_clob, 50, 1), 'message') = 0 then
      dbms_output.put_line('Error='||REPLACE(v_ErrorText, C_NO_ERROR, '')||DBMS_LOB.SUBSTR(l_clob, 50, 1));
    else
      dbms_output.put_line('-');
    
    end if;     
    */
    if file_size > 0 then 
      DBMS_LOB.freetemporary(l_clob);
    end if;
   
  end loop;     
end;    
