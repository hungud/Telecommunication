GRANT EXECUTE ON LONTANA.TO_NUMBER2 TO IVIDEON;
CREATE SYNONYM IVIDEON.TO_NUMBER2 FOR LONTANA.TO_NUMBER2;

 
CREATE OR REPLACE FUNCTION ADD_PAYKEEPER_PAYMENT (
  pPAYKEEPER_PAYMENT_ID VARCHAR2,  
  pPAYMENT_SUM VARCHAR2,
  pABONENT_ID VARCHAR2
) 
RETURN VARCHAR2
IS 
--#version=6
--v6. 09.02.2016 - Афросин А. - переработал функцию под схему Ivideon
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
  
  cPAYKEEPER_COEFFICIENT CONSTANT INTEGER := 1;
  
  vBALANCE NUMBER;
  
  vPAYMENT_PURPOSE_ID PAYMENT_PURPOSE_TYPE.PAYMENT_PURPOSE_ID%TYPE;
  vPAYKEEPER_PAYMENT_ID PAYMENT_HISTORY.PAYKEEPER_PAYMENT_ID%TYPE;  
  vPAYMENT_SUM PAYMENT_HISTORY.PAYMENT_SUM%TYPE;
  vABONENT_ID PAYMENT_HISTORY.ABONENT_ID%TYPE;
  
  vRes varchar2(2000 char);
  
  
  
  --возвращает идентификатор назначения платежа для payKeeper
  function GET_PAYMENT_PURPOSE_ID RETURN PAYMENT_PURPOSE_TYPE.PAYMENT_PURPOSE_ID%TYPE
  IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    vRes PAYMENT_PURPOSE_TYPE.PAYMENT_PURPOSE_ID%TYPE;
  begin
    
    begin
      select
        PAYMENT_PURPOSE_ID into vRes
      from
        PAYMENT_PURPOSE_TYPE
      where
        upper(PAYMENT_PURPOSE_CODE) = 'PAYKEEPER_PAYMENT';
    exception
      when others then
        vRes := -1;  
    end;
    
    if nvl(vRes, -1) = -1 then
      Insert into PAYMENT_PURPOSE_TYPE
        (PAYMENT_PURPOSE_CODE, PAYMENT_PURPOSE_DESC)
      Values
        ('paykeeper_payment', 'пополнение из системы PayKeeper')
      returning PAYMENT_PURPOSE_ID into vRes;
    end if; 
    
    COMMIT;
    RETURN vRes;
  end;  
    
  --ПРОВЕРЯЕМ СУЩЕСТВОВАНИЕ ПЛАТЕЖА В PAYMENT_HISTORY
  --если платеж есть, то возвращаем 1, если нет, то 0
  FUNCTION PAYMENT_EXIST (
                    plPAYKEEPER_PAYMENT_ID PAYMENT_HISTORY.PAYKEEPER_PAYMENT_ID%TYPE,
                    plAbonent_id PAYMENT_HISTORY.Abonent_id%TYPE,
                    plPAYMENT_PURPOSE_ID PAYMENT_PURPOSE_TYPE.PAYMENT_PURPOSE_ID%TYPE)
  RETURN integer
  IS
    vCount INTEGER;
    vRes Integer;
  BEGIN
    
    SELECT count(*) into vCount
        FROM PAYMENT_HISTORY PH
       WHERE PH.PAYKEEPER_PAYMENT_ID = plPAYKEEPER_PAYMENT_ID
         AND ph.abonent_id = plAbonent_id
         and PH.PAYMENT_PURPOSE_ID = plPAYMENT_PURPOSE_ID;
    
    if nvl(vCount, 0) = 0 then
      vRes := 0;
    else
      vRes := 1;
    end if;  
    
    Return vRes;     
  END;
  
  
    --ПРОВЕРЯЕМ СУЩЕСТВОВАНИЕ ПЛАТЕЖА В PAYMENT_HISTORY
  --если платеж есть, то возвращаем 1, если нет, то 0
  FUNCTION ABONENT_EXIST (
                            plAbonent_id PAYMENT_HISTORY.Abonent_id%TYPE
                          )
  RETURN integer
  IS
    vCount INTEGER;
    vRes Integer;
  BEGIN
    
    SELECT count(*) into vCount
        FROM IVIDEON_ABONENTS
       WHERE abonent_id = plAbonent_id;
    
    if nvl(vCount, 0) = 0 then
      vRes := 0;
    else
      vRes := 1;
    end if;  
    
    Return vRes;     
  END;
  
BEGIN
  
  vPAYKEEPER_PAYMENT_ID := to_number(pPAYKEEPER_PAYMENT_ID) ;  
  vPAYMENT_SUM := TO_NUMBER2(pPAYMENT_SUM);
  vABONENT_ID :=  to_number(pABONENT_ID) ; 
  
  vPAYMENT_PURPOSE_ID := GET_PAYMENT_PURPOSE_ID;
  
  --ДАЛАЕМ ПРОВЕРКУ НА СУЩЕСТВОВАНИЕ АБОНЕНТА
  IF ABONENT_EXIST(vABONENT_ID) = 1 THEN 
         
    -- ЕСЛИ РАНЕЕ ПЛАТЕЖ НЕ НАЙДЕН, ТО ДОБАВЛЕМ ЕГО
    IF PAYMENT_EXIST(vPAYKEEPER_PAYMENT_ID, vABONENT_ID, vPAYMENT_PURPOSE_ID) = 0 THEN    
      -- делаем проверку на свякий случай
      BEGIN
        -- v2 - добавлен коэффициент для пересчета платежа
        --vPAYKEEPER_COEFFICIENT := NVL(GET_PAYKEEPER_COEFFICIENT, 1);
        vPAYMENT_SUM := vPAYMENT_SUM * cPAYKEEPER_COEFFICIENT;
        
        BEGIN
          
          Insert into PAYMENT_HISTORY
            (ABONENT_ID, PAYMENT_SUM, PAYMENT_DATE,  PAYKEEPER_PAYMENT_ID, PAYMENT_PURPOSE_ID)
          Values
            (vABONENT_ID, vPAYMENT_SUM, sysdate, vPAYKEEPER_PAYMENT_ID, vPAYMENT_PURPOSE_ID);
          COMMIT;
            
          vRes :=  'OK! Платеж добавлен!';
        EXCEPTION
          WHEN OTHERS THEN 
            vRes := 'Ошибка при вставке платежа в таблицу!';
        END;
                
      EXCEPTION 
        WHEN OTHERS THEN 
          vRes := 'Ошибка при приведении типа платежа!';
      END;

    ELSE 
      vRes := 'ERROR! ПЛАТЕЖ SUM=' ||pPAYMENT_SUM|| ' ДЛЯ CLIENTID='|| pABONENT_ID ||' УЖЕ ЗАРЕГИСТРИРОВАН В СИСТЕМЕ';

    END IF;-- IF PAYMENT_EXIST(vPAYKEEPER_PAYMENT_ID, vABONENT_ID, vPAYMENT_PURPOSE_ID) = 0 THEN 
  else
    vRes := 'ERROR! НЕ НАЙДЕН ЛИЦЕВОЙ СЧЕТ ДЛЯ CLIENT_ID '||pABONENT_ID;  
  END IF;--IF ABONENT_EXIST(vABONENT_ID) = 1 THEN    
  
  Return vRes;
END;

--GRANT EXECUTE ON ADD_PAYKEEPER_PAYMENT to WWW_DEALER;
/
