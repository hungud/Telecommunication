CREATE OR REPLACE PROCEDURE CHECK_NEW_BILLS_MEGAFON
     IS

    -- 02.11.12 г. А. Пискунов Функция автоматической отправки СМС с сообщением о балансе
    
    vPHONE_NUMBER VARCHAR(20);
    vMAILING_NAME VARCHAR2(200);
    vSMS_TEXT VARCHAR2(2000);
    
    vIS_SEND INT;
    vTYPE_NOTIFY int;
    vYEAR_MONTH VARCHAR2(6);
    vYEAR INT;
    vMONTH INT;
      
    vSMS_RESULT VARCHAR(200);
    vCntBillsActual int;

BEGIN

    vPHONE_NUMBER := MS_PARAMS.GET_PARAM_VALUE('PHONE_NUMBER');
    
    --vYEAR_MONTH := to_char(SYSDATE, 'YYYYMM');
    vYEAR := to_number(to_char(SYSDATE, 'YYYY'));
    vMONTH := to_number(to_char(SYSDATE, 'MM'));
    IF vMONTH=1 THEN
      vYEAR_MONTH := to_char(vYEAR-1)||'12';
    ELSE
      vYEAR_MONTH := to_char(vYEAR)||to_char(vMONTH-1);
    ENF IF;
    vMAILING_NAME := 'Счёт';
    vSMS_TEXT := 'Начали поступать счета за ' || substr(vYEAR_MONTH,5,2) || 'месяц ';
    
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
            
            SELECT COUNT(1) INTO vCntBillsActual FROM SIM_PHONE_BILLS WHERE YEAR_MONTH = vYEAR_MONTH;
            IF vCntBillsActual> 0 THEN      
              vSMS_RESULT := LOADER3_PCKG.SEND_SMS(vPHONE_NUMBER, vMAILING_NAME, vSMS_TEXT);        -- Так должно быть на самом деле
              INSERT INTO SEND_SMS_INFO(ID, TYPE_NOTIFY, YEAR_MONTH, IS_SEND)                        -- Это информационная таблица для учета отправленных СМС
              VALUES(S_NEW_SEND_SMS_INFO.NEXTVAL, vTYPE_NOTIFY, vYEAR_MONTH, 1);
              commit;
            END IF;
                        
       END;
    END IF;   
       
END CHECK_NEW_BILLS_MEGAFON;
/
--GRANT EXECUTE ON CHECK_NEW_BILLS_MEGAFON TO LONTANA_ROLE;
