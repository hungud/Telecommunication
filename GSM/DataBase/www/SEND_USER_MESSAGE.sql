CREATE OR REPLACE PROCEDURE LONTANA_WWW.SEND_USER_MESSAGE(
  pFROM_USER_ID VARCHAR2 DEFAULT NULL,
  pTO_USER_ID VARCHAR2 DEFAULT NULL,
  pMESSAGE_TEXT VARCHAR2 DEFAULT NULL
  ) IS 
  
  --Version 2
  --
  --v.2 Алексеев. 03.12.2015 Добавил проверку и преобразование кодировки текста
  --v.1 Алексеев. 05.11.2015 Функция записи сообщения в таблицу сообщений
  
  pSMS_TEXT VARCHAR2(4000 CHAR);
  pENCODE VARCHAR2(100 char);
BEGIN 
  --если сообщение не пустое
  IF TRIM(pMESSAGE_TEXT) IS NOT NULL THEN
    pSMS_TEXT := pMESSAGE_TEXT;
    
    --если есть иероглифы, то их необходимо преобразовать в нормальный текст
    --включить преобразование кодировки только для тестового номера
    --if pFROM_USER_ID = 139587 then
      --определяем кодировку
      if not regexp_like(asciistr(convert(pMESSAGE_TEXT, 'cl8mswin1251')), '\FFFD') then
        if regexp_like(convert(pMESSAGE_TEXT, 'cl8mswin1251', 'utf8'),'[а-яА-Я]') then
          pENCODE := 'UTF8';
        else
          pENCODE := 'WIN1251';
        end if;
      else
        pENCODE := 'WIN1251';
      end if;
      
      if pENCODE = 'WIN1251' then
        pSMS_TEXT := pMESSAGE_TEXT;
      else
        pSMS_TEXT := convert(pMESSAGE_TEXT, 'cl8mswin1251', 'utf8');
      end if;
    --end if;
                
    --добавляем его
    INSERT INTO D_INSTANT_MESSAGES
    (SENDER_USER_ID, TEXT, RECEIVER_USER_ID)
    VALUES
    (pFROM_USER_ID, pSMS_TEXT, pTO_USER_ID);
    COMMIT;
  ELSE
    OUT_ERROR('Текст сообщения должен быть определен.');
  END IF;  
EXCEPTION 
  WHEN OTHERS THEN
    OUT_ERROR(dbms_utility.format_error_stack ||CHR(13)||CHR(10)|| dbms_utility.format_error_backtrace);
END;