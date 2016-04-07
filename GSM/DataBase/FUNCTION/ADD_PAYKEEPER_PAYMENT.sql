CREATE OR REPLACE FUNCTION LONTANA.ADD_PAYKEEPER_PAYMENT (
  pPAYKEEPER_ID VARCHAR2,  
  pPAY_SUM VARCHAR2,
  pCLIENT_ID VARCHAR2,
  pORDER_ID VARCHAR2  
) 
RETURN VARCHAR2
IS 
--#version=5
--v5. 14.07.2015 - Матюнин И., Уколов Д. - учтены замечания Уколова Д. по поводу оформления кода.
--v4. 14.07.2015 - Матюнин И., Алекссев А. - переделан механизм отправки смс, проведен совместный контроль кода
--v3. 13.07.2015 - Матюнин И. - Вынес определение в отдельные функции коэффициента пересчета платежа - GET_PAYKEEPER_COEFFICIENT, и привидение строки к дробному числу - TO_NUMBER2.  
--v2. 13.07.2015 - Матюнин И. - Добавлен коэффициент пересчета платежа, пришедшего из PayKeeper(как правило используется в акции). 
                             -- Хранится в PARAMS имя 'PAYKEEPER_COEFFICIENT'. Если не задан, то берем по умолчанию 1                             
--v1. - Матюнин И.
-- Функция предназначена для добавления платежа пришедшего из системы PayKeeper.
-- Релаизована в рамках задачи http://redmine.tarifer.ru/issues/3023.
-- Перед добавлением мы проверяем имеется ли в таблице платежей DB_LOADER_PAYMENTS платеж с указанными атрибутами, а именно:
   --  номер платежа PAYMENT_NUMBER - уникальный ID платежа в системе PayKeeper;
   --  номер телефона PHONE_NUMBER - номер телефона;
   --  комментарий к платежу PAYMENT_STATUS_TEXT - должен быть 'GSM PayKeeper'.
-- Если платеж не находим, значит он был добавлен ранее и не добавляем его, возвращаем ошибку!
--
-- ВНИМАНИЕ! Формат возвращаемого ответа должен быть согласован с процедурой WWW_DEALER.LOAD_PAYKEEPER_PAYMENT!

  vPAY_ALREADY_EXIST INTEGER;
  vPAYKEEPER PAYKEEPER_PAYMENT_LOG%ROWTYPE;
  vACCOUNT_ID INTEGER;
  vPAY_SUM number(15,2);
  cPAYKEEPER_STATUS_TEXT CONSTANT VARCHAR2 (20 CHAR) := 'GSM PayKeeper';
  
  vBALANCE NUMBER;
  vSMS_TEXT varchar2 (200 char);
  vPAYKEEPER_COEFFICIENT number;
  SMS VARCHAR2(2000); 
    
  FUNCTION PAYMENT_NUMBER_EXIST (pPAYMENT_NUMBER VARCHAR2, pPHONE_NUMBER VARCHAR2) RETURN BOOLEAN
  IS
  --ПРОВЕРЯЕМ СУЩЕСТВОВАНИЕ ПЛАТЕЖА В DB_LOADER_PAYMENTS 
    CURSOR CUR_PAYMENT (pPAYMENT_NUMBER VARCHAR2, pPHONE_NUMBER VARCHAR2) IS
      SELECT DP.ACCOUNT_ID, DP.CONTRACT_ID
        FROM DB_LOADER_PAYMENTS DP
       WHERE DP.PAYMENT_NUMBER = pPAYMENT_NUMBER
         AND DP.PHONE_NUMBER = pPHONE_NUMBER
         AND DP.PAYMENT_STATUS_TEXT = cPAYKEEPER_STATUS_TEXT 
    ;                
    vcur CUR_PAYMENT%rowtype;
  BEGIN
    OPEN CUR_PAYMENT(pPAYMENT_NUMBER, pPHONE_NUMBER);
    FETCH CUR_PAYMENT into vcur;
    IF CUR_PAYMENT%NOTFOUND THEN
      CLOSE CUR_PAYMENT;
      RETURN FALSE;
    ELSE
      CLOSE CUR_PAYMENT;
      RETURN TRUE;
    END IF;    
  END;
  
BEGIN
  
  vPAYKEEPER.PAYKEEPER_ID := pPAYKEEPER_ID; 
  vPAYKEEPER.PAY_SUM := pPAY_SUM ; --TO_NUMBER(pPAY_SUM); 
  vPAYKEEPER.CLIENT_ID := pCLIENT_ID; 
  vPAYKEEPER.ORDER_ID := pORDER_ID;     
  
--  vPAY_ALREADY_EXIST := 0;
--  BEGIN
--    vPAY_ALREADY_EXIST := PAYMENT_NUMBER_EXIST(vPAYKEEPER.PAYKEEPER_ID, vPAYKEEPER.CLIENT_ID);
--  EXCEPTION 
--    WHEN OTHERS THEN
--      RETURN ('Ошибка при вызове PAYMENT_NUMBER_EXIST');
--  END;

  -- ЕСЛИ РАНЕЕ ПЛАТЕЖ НЕ НАЙДЕН, ТО ДОБАВЛЕМ ЕГО
  IF ( NOT PAYMENT_NUMBER_EXIST(vPAYKEEPER.PAYKEEPER_ID, vPAYKEEPER.CLIENT_ID) ) THEN    
    vACCOUNT_ID := GET_ACCOUNT_ID_BY_PHONE(vPAYKEEPER.CLIENT_ID);
    
    IF NVL(vACCOUNT_ID, 0) <> 0 THEN
      -- делаем проверку на свякий случай
      BEGIN
        -- v2 - добавлен коэффициент для пересчета платежа
        vPAYKEEPER_COEFFICIENT := NVL(GET_PAYKEEPER_COEFFICIENT, 1);
        vPAY_SUM := TO_NUMBER2(vPAYKEEPER.PAY_SUM)*vPAYKEEPER_COEFFICIENT;        
      EXCEPTION 
        WHEN OTHERS THEN 
          RETURN ('Ошибка при приведении типа платежа!');
      END;

      BEGIN
        INSERT INTO DB_LOADER_PAYMENTS (ACCOUNT_ID, YEAR_MONTH, PHONE_NUMBER, PAYMENT_DATE, PAYMENT_SUM, PAYMENT_STATUS_IS_VALID, PAYMENT_NUMBER, PAYMENT_STATUS_TEXT)
        VALUES (vACCOUNT_ID, TO_CHAR(SYSDATE, 'YYYYMM'), vPAYKEEPER.CLIENT_ID, TRUNC(SYSDATE), vPAY_SUM, 1, vPAYKEEPER.PAYKEEPER_ID, cPAYKEEPER_STATUS_TEXT );
        COMMIT;
        
        --отправляем смс о зачислении платежа
        BEGIN
          vBALANCE := GET_ABONENT_BALANCE(vPAYKEEPER.CLIENT_ID);
          vSMS_TEXT := 'На Ваш счёт зачислен платёж в размере '|| to_char(vPAY_SUM) ||'р. Баланс после зачисления '|| to_char(vBALANCE) ||'р.';
          SMS:=LOADER3_pckg.SEND_SMS(vPAYKEEPER.CLIENT_ID,
                                     'Смс-оповещение',
                                     vSMS_TEXT
                                    );                                             
        EXCEPTION 
          WHEN OTHERS THEN
            NULL; -- если возникла ошибка при добавлении в очередь, просто съедаем её 
        END;
        RETURN('OK! Платеж добавлен!');
      EXCEPTION
        WHEN OTHERS THEN 
          RETURN ('Ошибка при вставке платежа в таблицу!');
      END;
    ELSE
      RETURN ('ERROR! НЕ НАЙДЕН ЛИЦЕВОЙ СЧЕТ ДЛЯ CLIENT_ID '||vPAYKEEPER.CLIENT_ID);      
    END IF;
  ELSE 
    RETURN ('ERROR! ПЛАТЕЖ SUM=' ||pPAY_SUM|| ' ДЛЯ CLIENTID='|| vPAYKEEPER.CLIENT_ID ||' УЖЕ ЗАРЕГИСТРИРОВАН В СИСТЕМЕ');
    --RETURN ('ERROR! Платеж с таким ID уже найден!');
  END IF;
  
END;

--GRANT EXECUTE ON ADD_PAYKEEPER_PAYMENT to WWW_DEALER;
/
