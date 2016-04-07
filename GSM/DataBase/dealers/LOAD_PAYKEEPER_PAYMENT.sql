grant execute ON IVIDEON.ADD_PAYKEEPER_PAYMENT to WWW_DEALER;
CREATE OR REPLACE PROCEDURE WWW_DEALER.LOAD_PAYKEEPER_PAYMENT (
    NAME_ARRAY IN OWA.VC_ARR,
    VALUE_ARRAY IN OWA.VC_ARR   
)
IS
-- VERSION=3
-- V3. 17.02.2016  - Матюнин И. Исправил ошибку при фомрирвоании ответа о добавлении платежа! раньше всегда ответ был успешным - косяк!
--                              В случае когда платеж доабвлен успешно отправляем подтверждение добавления платежа.
--                              Если платёж пришел повторно (а ранее он был добавлен),значит пейкипер не получил ответа - и мы повторяем подтверждение добавления платежа 
--                              В остальных случаях - отправляем ошибку!   
-- V2. 09.02.2016  - Афросин А. Добавил получение платежей для пользовтелей IVIDEONA
-- V1. 03.05.2015  - Матюнин И.
--  
-- Процедура, для приема POST запроса от платежной системы PayKeeper о совершенных в ней платежах по нашим телефонным номерам. 
-- Релаизована в рамках задачи http://redmine.tarifer.ru/issues/3023.
-- Проверяет соответствие присланных параметров, секретного слова, указанного в настройепх ЛК PayKeeper, и присланного ключа.
-- Если ключ совпадает, добавляем платеж - функция ADD_PAYKEEPER_PAYMENT
-- Список передаваемых параметров: 
--   ID VARCHAR2 DEFAULT NULL,  -- Уникальный, никогда не повторяющийся номер платежа в PayKeeper   
--   SUM VARCHAR2 DEFAULT NULL,  -- Сумма платежа в рублях с точностью до сотых. Разделитель – точка   
--   clientid VARCHAR2 DEFAULT NULL, -- Идентификатор клиента. Тот же, что при генерации формы оплаты   
--   orderid VARCHAR2 DEFAULT NULL, -- Номер заказа. Не обязателен   
--   KEY VARCHAR2 DEFAULT NULL -- Цифровая подпись запроса, строка из символов a-f и 0-9

  vRESULT_INSERT_PAY VARCHAR2(1000 CHAR);
  vERROR VARCHAR2(2000 CHAR);  
  vPAYKEEPER PAYKEEPER_PAYMENT_LOG%ROWTYPE;
  
  pID VARCHAR2(30 CHAR);
  pSUM VARCHAR2(15 CHAR);
  pCLIENT_ID VARCHAR2(50 CHAR);
  pORDER_ID VARCHAR2(50 CHAR);
  pKEY VARCHAR2(100 CHAR); 
  
  pCODE_WORD CONSTANT VARCHAR2(50 CHAR) := 'RjKjnBn3bVj59bne'; -- кодовое слово, должно быть таким же как в настройках лчиного кбаинета PayKeeper 
  vHASH_ANSWER VARCHAR2(100 CHAR);  -- MD5-hash для ответа о удачно проведенном платеже 
  
  -- Проверка валидность ключа
  FUNCTION IsValidKey RETURN BOOLEAN
  IS
    vHASH varchar2 (1000 CHAR);
    vKEY  varchar2 (100 CHAR);
  BEGIN
    vHASH := pID || pSUM || pCLIENT_ID || pORDER_ID || pCODE_WORD;
    vKEY := lower( Rawtohex(UTL_RAW.CAST_TO_RAW(DBMS_OBFUSCATION_TOOLKIT.MD5(input_string=>vHASH))));      
    IF vKEY = lower(pKEY) THEN
      RETURN TRUE; 
    ELSE
      RETURN FALSE;
    END IF;
  END IsValidKey;
  
  -- проверка на пользователя IVIDEONA
  FUNCTION IS_IVIDEON_USER( pUSER_ID varchar2) RETURN INTEGER
  IS
    vRes Integer;
    vCount Integer;
  BEGIN
    vRes := 0;
    vCount := 0;
    
    select
      count(*) into vCount
    from
      IVIDEON.V_IVIDEION_USERS
    where
      TO_CHAR(IVIDEON.V_IVIDEION_USERS.ABONENT_ID) = trim(pUSER_ID);
    
    if nvl(vCount, 0) > 0 then
      vRes := 1;
    else
      vRes := 0;
    end if;
    
    RETURN vRes;  
    
  END IS_IVIDEON_USER;
  
    
BEGIN
  BEGIN
    
    -- ОПРЕДЕЛЯЕМ ПАРАМЕТРЫ
    FOR I IN NAME_ARRAY.FIRST..NAME_ARRAY.LAST LOOP        
      IF UPPER(NAME_ARRAY(I)) = 'ID' THEN
        pID := SUBSTR(VALUE_ARRAY(I), 1, 100);
      ELSIF UPPER(NAME_ARRAY(I)) = 'SUM' THEN
        pSUM := SUBSTR(VALUE_ARRAY(I), 1, 100);
      ELSIF UPPER(NAME_ARRAY(I)) = 'CLIENTID' THEN
        pCLIENT_ID := SUBSTR(VALUE_ARRAY(I), 1, 100);
      ELSIF UPPER(NAME_ARRAY(I))  = 'ORDERID' THEN
        pORDER_ID := SUBSTR(VALUE_ARRAY(I), 1, 100);
      ELSIF UPPER(NAME_ARRAY(I))  = 'KEY' THEN
        pKEY := SUBSTR(VALUE_ARRAY(I), 1, 100);
      END IF;        
    END LOOP;
    
--    IF pID = '48' THEN
--      vHASH_ANSWER := lower(Rawtohex(UTL_RAW.CAST_TO_RAW(DBMS_OBFUSCATION_TOOLKIT.MD5(input_string=>pID||pCODE_WORD)))); 
--      vERROR := 'OK '||vHASH_ANSWER; 
--      HTP.PRN(vERROR);
--      INSERT INTO PAYKEEPER_PAYMENT_LOG (PAYKEEPER_ID, PAY_SUM, CLIENT_ID, ORDER_ID, KEY_HASH, ANSWER)
--            VALUES (pID, pSUM, pCLIENT_ID, pORDER_ID, pKEY, vERROR);
--      COMMIT;
--      return;   
--    END IF;
    
    vPAYKEEPER.PAYKEEPER_ID := pID; 
    vPAYKEEPER.PAY_SUM := pSUM; 
    vPAYKEEPER.CLIENT_ID := pCLIENT_ID; 
    vPAYKEEPER.ORDER_ID := pORDER_ID; 
    vPAYKEEPER.KEY_HASH := pKEY;
     
    IF pID IS NULL THEN
      vERROR := 'ERROR! Параметр ID не может быть пустым.';
      HTP.PRN(vERROR);
      return;
    ELSIF pSUM IS NULL THEN    
      vERROR := 'ERROR! Параметр SUM не может быть пустым.';
      HTP.PRN(vERROR);
      return;
    ELSIF pCLIENT_ID IS NULL THEN
      vERROR := 'ERROR! Параметр CLIENTID не может быть пустым.';
      HTP.PRN(vERROR);
      return;
    ELSIF pKEY IS NULL THEN
      vERROR := 'ERROR! Параметр KEY не может быть пустым.';
      HTP.PRN(vERROR);
      return;
    END IF;
      
    vRESULT_INSERT_PAY := 'null';
    BEGIN
      IF IsValidKey THEN
        
        --проверяем в какую схему пришел платеж (IVIDEON ИЛИ WWW_DEALER)
        IF IS_IVIDEON_USER(vPAYKEEPER.CLIENT_ID) = 1 THEN
          --ДОБАВЛЯЕМ ПЛАТЕЖ В IVIDEON
          vRESULT_INSERT_PAY := IVIDEON.ADD_PAYKEEPER_PAYMENT(vPAYKEEPER.PAYKEEPER_ID,  
                                                        vPAYKEEPER.PAY_SUM ,
                                                        vPAYKEEPER.CLIENT_ID
                                                       );
        ELSE
          -- ДОБАВЛЯЕМ ПЛАТЕЖ В DB_LOADER_PAYMENTS, 1 - ДОБАВЛЕН, 0 - НЕ ДОБАВЛЕН
          vRESULT_INSERT_PAY := LONTANA.ADD_PAYKEEPER_PAYMENT(vPAYKEEPER.PAYKEEPER_ID,  
                                                        vPAYKEEPER.PAY_SUM ,
                                                        vPAYKEEPER.CLIENT_ID, 
                                                        vPAYKEEPER.ORDER_ID
                                                       );
        END IF;
        
        IF vRESULT_INSERT_PAY = 'OK! Платеж добавлен!' THEN
          
          vHASH_ANSWER := lower( Rawtohex(UTL_RAW.CAST_TO_RAW(DBMS_OBFUSCATION_TOOLKIT.MD5(input_string=>pID||pCODE_WORD)))); 
          vERROR := 'OK '||vHASH_ANSWER;          
        
        -- Если при добавлении платежа возвращается ошибка, что платеж уже зарегистрирован в системе, 
        -- это означает, что в предыдущий раз, когда платеж поступал к нам, сервис пейкипера не получил наш ответ, и присылает тот же платеж вновь!
        -- В таком случае отвечаем им повторно об успешном добавлении платежа.  
        ELSIF vRESULT_INSERT_PAY like '%УЖЕ ЗАРЕГИСТРИРОВАН В СИСТЕМЕ%' THEN 
          vHASH_ANSWER := lower( Rawtohex(UTL_RAW.CAST_TO_RAW(DBMS_OBFUSCATION_TOOLKIT.MD5(input_string=>pID||pCODE_WORD))));
          vERROR := 'OK '||vHASH_ANSWER;

        -- При любом другом результате добавления платежа сообщаем об ошибке
        ELSE
          vERROR := 'Error! Ошибка при добавлении платежа'; --'OK '||vHASH_ANSWER;          
        END IF;
      ELSE
        vERROR := 'Error! Hash mismatch!';      
      END IF;               
      
    EXCEPTION 
      WHEN OTHERS THEN
        vERROR := 'Error! Other exception.';
        -- все равно вставляем в лог загрузки платежей
    END;
    
    HTP.PRN(vERROR);
  EXCEPTION 
    WHEN OTHERS THEN
      HTP.PRN('ERROR! В процедуре LOAD_PAYKEEPER_PAYMENT возникла ошибка.');
      vERROR := 'ERROR! В процедуре LOAD_PAYKEEPER_PAYMENT возникла ошибка.'|| vERROR;
  END;    
  
  vERROR := 'ОТВЕТ: "'||vERROR||'".  РЕЗУЛЬТАТ ДОБАВЛЕНИЯ ПЛАТЕЖА: "'||vRESULT_INSERT_PAY||'".';
  INSERT INTO PAYKEEPER_PAYMENT_LOG (PAYKEEPER_ID, PAY_SUM, CLIENT_ID, ORDER_ID, KEY_HASH, ANSWER)
            VALUES (pID, pSUM, pCLIENT_ID, pORDER_ID, pKEY, vERROR);
  COMMIT;
END;
/
