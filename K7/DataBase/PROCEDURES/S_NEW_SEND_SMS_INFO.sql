CREATE OR REPLACE PROCEDURE LONTANA.CHECK_NEW_BILLS_MEGAFON
     IS

    -- 02.11.12 г. А. Пискунов Функция автоматической отправки СМС с сообщением о балансе
    
    vPHONE_NUMBER VARCHAR(20);
    vMAILING_NAME VARCHAR2(200);
    vSMS_TEXT VARCHAR2(2000);
    
    vIS_SEND INT;
    vTYPE_NOTIFY int;
    vYEAR_MONTH VARCHAR2(6);
      
    vSMS_RESULT VARCHAR(200);

BEGIN

    vPHONE_NUMBER := MS_PARAMS.GET_PARAM_VALUE('PHONE_NUMBER');
    
    vYEAR_MONTH := to_char(SYSDATE, 'YYYYMM');
    
    vMAILING_NAME := 'Баланс';
    vSMS_TEXT := 'Пришли счета за ' || to_char(SYSDATE, 'MM') || 'месяц ';
    
     vTYPE_NOTIFY := 1;  -- Пока только для 'Баланса'   
    
    
    BEGIN 
     SELECT SSI.IS_SEND INTO vIS_SEND FROM SEND_SMS_INFO SSI 
             WHERE (SSI.YEAR_MONTH = vYEAR_MONTH) AND (SSI.TYPE_NOTIFY = 1) AND (SSI.IS_SEND = 1);

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        vIS_SEND := 0;
    END;

    IF (vIS_SEND = 0) THEN
        BEGIN
        
            /*INSERT INTO TEST_SMS_OUTPUT(PHONE_NUMBER,MAILING_NAME,SMS_TEXT)     -- Это таблица-заглушка для функции отправки СМС
                VALUES (vPHONE_NUMBER,pMAILING_NAME,pSMS_TEXT);*/
                
            vSMS_RESULT := LOADER3_PCKG.SEND_SMS(vPHONE_NUMBER, vMAILING_NAME, vSMS_TEXT);        -- Так должно быть на самом деле
            
                        
            INSERT INTO SEND_SMS_INFO(ID, TYPE_NOTIFY, YEAR_MONTH, IS_SEND)                        -- Это информационная таблица для учета отправленных СМС
                VALUES(S_SEND_SMS_INFO.NEXTVAL, vTYPE_NOTIFY, vYEAR_MONTH, 1);
       END;
    END IF;   
       
END CHECK_NEW_BILLS_MEGAFON;
/
