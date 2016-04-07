
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SEND_ABONENT_BALANCE_MESSAGE" (pPHONE_NUMBER   IN VARCHAR2,
                                                         pREQUEST_ID     IN VARCHAR2,
                                                         pERROR_MESSAGE  OUT VARCHAR2,
                                                         pIS_SENT_BEFORE OUT NUMBER) IS
  --#Version=8
  --12.11.2014 Алексеев. Отправка смс о баллансе с информацией об обещ. платеже (при его наличии). Для Teletie
  --25.11.2014 Алексеев. Таблица PROMISED_PAYMENTS заменена на вьюху V_ACTIVE_PROMISED_PAYMENTS
  CURSOR C IS
    SELECT 1
      FROM ABONENT_BALANCE_MESSAGES
     WHERE ABONENT_BALANCE_MESSAGES.UNIQUE_REQUEST_ID = pREQUEST_ID;
  CURSOR C2 IS
    SELECT 1
      FROM ABONENT_BALANCE_MESSAGES
     WHERE ABONENT_BALANCE_MESSAGES.PHONE_NUMBER = pPHONE_NUMBER
       AND ABONENT_BALANCE_MESSAGES.REQUEST_DATE_TIME > SYSDATE - 1 / 48 --Убрано для К7 временно
       and ABONENT_BALANCE_MESSAGES.ERROR_MESSAGE is null; -- 1 ЧАС
  CURSOR D IS
    SELECT V_ACTIVE_CONTRACTS.PHONE_NUMBER_FEDERAL
      FROM V_ACTIVE_CONTRACTS
     WHERE V_ACTIVE_CONTRACTS.PHONE_NUMBER_FEDERAL = PPHONE_NUMBER;
  CURSOR CUR IS 
    SELECT PROMISED_SUM, PROMISED_DATE
    FROM V_ACTIVE_PROMISED_PAYMENTS
    WHERE PHONE_NUMBER = pPHONE_NUMBER;
    
  vCUR CUR%ROWTYPE; 
  vDUMMY           BINARY_INTEGER;
  vBALANCE_MESSAGE VARCHAR2(300 CHAR);
  SQL_T            VARCHAR2(2000 CHAR);
  vBALANCE_VALUE   NUMBER(10, 2);
  vFOUND           BOOLEAN;
  pERROR_MESSAGEd  VARCHAR2(201 CHAR);
  dDUMMY           D%ROWTYPE;
  MN_UNLIM_SDATE   date;
  vYEAR_MONTH      integer;
  vPHONE_NUMBER    VARCHAR2(10);
  vIS_COLLECTOR integer;
  vBalMsg boolean;
  --
BEGIN
  IF pREQUEST_ID IS NULL THEN
    vFOUND := FALSE;
  ELSE
    OPEN C;
    FETCH C
      INTO vDUMMY;
    vFOUND := C%FOUND;
    CLOSE C;
  END IF;
  /*  IF (NOT vFOUND)AND(MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE') THEN
    OPEN C2;
    FETCH C2 INTO vDUMMY;
    IF C2%FOUND THEN
      vFOUND :=TRUE;
    END IF;
    CLOSE C2;
  END IF;*/
  IF NOT vFOUND THEN
  
    IF (MS_CONSTANTS.GET_CONSTANT_VALUE('USES_MNP') = 1) THEN
    vPHONE_NUMBER := MNP_TEMP_TO_MAIN(pPHONE_NUMBER);
    ELSE vPHONE_NUMBER := pPHONE_NUMBER;
    END IF;
    
    vBALANCE_VALUE   := GET_ABONENT_BALANCE(vPHONE_NUMBER);
    
    --определяем коллекторский счет или нет
    SELECT count(IS_COLLECTOR)
    INTO vIS_COLLECTOR
    FROM ACCOUNTS
    WHERE ACCOUNT_ID = GET_ACCOUNT_ID_BY_PHONE(pPHONE_NUMBER)
        AND  IS_COLLECTOR is not null;
        
    vBalMsg := TRUE;
    --если телетай
    if vIS_COLLECTOR <> 0 then
      --проверяем наличие обещанного платежа
      OPEN CUR;
      FETCH CUR INTO vCUR;
    
      if CUR%FOUND then
        if vCUR.PROMISED_SUM <> 0 then
          vBALANCE_MESSAGE := 'Баланс телефона ' || pPHONE_NUMBER || ' равен: ' ||
                        (vBALANCE_VALUE-vCUR.PROMISED_SUM) || ' руб. Обещанный платеж '||to_char(vCUR.PROMISED_SUM)||' руб., действует до '||to_char(vCUR.PROMISED_DATE, 'DD.MM.YYYY')||'.';
          vBalMsg := FALSE;
        end if;
      end if;
    end if;
    
    --если счет неколлекторский или коллекторский, но на нем нет обещанного платежа
    if vBalMsg then
      vBALANCE_MESSAGE := 'Баланс телефона ' || pPHONE_NUMBER || ' равен: ' ||
                        vBALANCE_VALUE || ' руб.';
    end if;
    
    OPEN D;
    FETCH D
      INTO dDUMMY;
    IF (MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME') <> 'CORP_MOBILE') OR
       (MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME') = 'CORP_MOBILE' AND
       D%FOUND) THEN
      pERROR_MESSAGE := SUBSTR(LOADER3_PCKG.SEND_SMS(pPHONE_NUMBER,
                                                     'Balance',
                                                     vBALANCE_MESSAGE,
                                                     1),
                               1,
                               200);
      IF (MS_CONSTANTS.GET_CONSTANT_VALUE('SEND_SMS_MN_UNLIM') = '1') then
        MN_UNLIM_SDATE := DB_LOADER_PCKG.GET_MN_UNLIM_SDATE(pPHONE_NUMBER);
        if MN_UNLIM_SDATE <> to_date('31.12.1999', 'dd.mm.yyyy') then
          begin
            select max(sv.sql_text)
              into SQL_T
              from service_volume sv
             where sv.option_code = 'MN_UNLIMC';
          exception
            when others then
              vBALANCE_MESSAGE := '0';
          end;
          vYEAR_MONTH := to_number(to_char(sysdate, 'yyyy')) * 100 +
                         to_number(to_char(sysdate, 'mm'));
          SQL_T       := REPLACE(SQL_T,
                                 '%ph_num%',
                                 '''' || pPHONE_NUMBER || '''');
          SQL_T       := REPLACE(SQL_T, '%y_mo%', to_char(vYEAR_MONTH));
          begin
            execute immediate SQL_T
              into vBALANCE_MESSAGE;
          exception
            when others then
              vBALANCE_MESSAGE := '0';
          end;
          if vBALANCE_MESSAGE <> '0' then
            vBALANCE_MESSAGE := 'Остаток минут по услуге "Международный безлимит": ' ||
                                vBALANCE_MESSAGE;
          
            pERROR_MESSAGEd := SUBSTR(LOADER3_PCKG.SEND_SMS(pPHONE_NUMBER,
                                                            'Mn_unlim',
                                                            vBALANCE_MESSAGE,
                                                            1),
                                      1,
                                      200);
          end if;
        end if;
      end if;
    ELSE
      pERROR_MESSAGE:='Contract cancel!';
    END IF;
    CLOSE D;
    INSERT INTO ABONENT_BALANCE_MESSAGES
      (UNIQUE_REQUEST_ID,
       REQUEST_DATE_TIME,
       PHONE_NUMBER,
       BALANCE_VALUE,
       BALANCE_MESSAGE,
       ERROR_MESSAGE)
    VALUES
      (pREQUEST_ID,
       SYSDATE,
       SUBSTR(pPHONE_NUMBER, -10, 10), /* Последние 10 символов */
       vBALANCE_VALUE,
       vBALANCE_MESSAGE,
       pERROR_MESSAGE);
    pIS_SENT_BEFORE := 0;
  ELSE
    pIS_SENT_BEFORE := 1;
  END IF;
END;