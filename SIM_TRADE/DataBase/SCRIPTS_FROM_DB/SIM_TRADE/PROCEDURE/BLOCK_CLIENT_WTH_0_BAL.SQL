
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."BLOCK_CLIENT_WTH_0_BAL" AS
 PRAGMA AUTONOMOUS_TRANSACTION;
--

--#Version=20
--
--v20. Афросин. Добавил отправку смс с отрицательным балансомраз в 12 часов
--v19. Алексеев. Убрал проверку на величину баланса в определении количества попыток блокировки с неотправл. смс
--v18. Алексеев. Установил проверку на то, что если за последний час не было отправлено 3 смс, то все равно блокируем
--01.06.2013 Назан Новый кабинет
--09.09.2011 Крайнов. Вынесен отбор телефонов во вьюшку
--Крайнов. Добавлен потеряггый коммит.
  vDISCONNECT_COUNT BINARY_INTEGER := 10;
  cSMS_BLOCK_INTERVAL CONSTANT INTEGER := TO_NUMBER(NVL(MS_PARAMS.GET_PARAM_VALUE('BLOCK_SMS_INTERVAL'), '12'));
--
CURSOR C IS
SELECT V_PHONE_NUMBERS_FOR_BLOCK.ACCOUNT_ID,
       V_PHONE_NUMBERS_FOR_BLOCK.PHONE_NUMBER_FEDERAL,
       V_PHONE_NUMBERS_FOR_BLOCK.BALANCE,
       V_PHONE_NUMBERS_FOR_BLOCK.FIO,
       V_PHONE_NUMBERS_FOR_BLOCK.BLOCK_NOTICE_TEXT,
       c.contract_id,
       C.DATE_BLOCK_SMS
  FROM V_PHONE_NUMBERS_FOR_BLOCK,
       contracts c
  WHERE
  C.CONTRACT_ID = V_PHONE_NUMBERS_FOR_BLOCK.CONTRACT_ID
  and NOT EXISTS (SELECT 1
                      FROM QUEUE_PHONE_REBLOCK
                      WHERE QUEUE_PHONE_REBLOCK.PHONE_NUMBER = V_PHONE_NUMBERS_FOR_BLOCK.PHONE_NUMBER_FEDERAL)
  ORDER BY BALANCE-NVL(V_PHONE_NUMBERS_FOR_BLOCK.DISCONNECT_LIMIT, 0) ASC;
--
CURSOR BL (ID INTEGER) IS
  SELECT 
    ACCOUNTS.DO_AUTO_BLOCK
  FROM ACCOUNTS
  WHERE ID=ACCOUNTS.ACCOUNT_ID;
--
  vBL BL%ROWTYPE;
  SMS VARCHAR2(2000); 
  LOCK_PH VARCHAR2(2000);
  ERROR_COL NUMBER;
  SMS_TXT VARCHAR2(500 char);
  INDEXI INTEGER;
  pErrSms INTEGER;
  BL_PHONE DBMS_SQL.VARCHAR2_TABLE;
  BL_FIO DBMS_SQL.VARCHAR2_TABLE;
  BL_BALANCE DBMS_SQL.NUMBER_TABLE;
  BL_SMS DBMS_SQL.VARCHAR2_TABLE;
BEGIN
  INDEXI:=-1;
--  
  FOR vREC IN C LOOP
    OPEN BL(vREC.ACCOUNT_ID);
    FETCH BL INTO vBL;
    CLOSE BL;
    IF vBL.DO_AUTO_BLOCK=1 AND
      ((vREC.DATE_BLOCK_SMS is null) or ((sysdate-vREC.DATE_BLOCK_SMS)*24>= cSMS_BLOCK_INTERVAL))
    THEN
      ERROR_COL:=0; 
      SMS_TXT:=replace(vREC.BLOCK_NOTICE_TEXT,'%balance%',round(vRec.Balance));
      SMS_TXT:=replace(SMS_TXT,'%dolg%',round(-vRec.Balance));          
      SMS:=LOADER3_pckg.SEND_SMS(vREC.PHONE_NUMBER_FEDERAL,
                                 'Смс-оповещение',
                                 SMS_TXT);
      update contracts c
            set c.date_block_sms = sysdate
          where
            c.contract_id = vREC.contract_id
            and c.phone_number_federal = vREC.phone_number_federal;
                                             
      INDEXI:=INDEXI+1;
      BL_PHONE(INDEXI):=vREC.PHONE_NUMBER_FEDERAL;
      BL_FIO(INDEXI):=vREC.FIO;
      BL_BALANCE(INDEXI):=vREC.BALANCE;
      BL_SMS(INDEXI):=SMS;      
    END IF;
        -- Не более vDISCONNECT_COUNT за 1 раз.
    vDISCONNECT_COUNT := vDISCONNECT_COUNT - 1;
    IF vDISCONNECT_COUNT <= 0 THEN
      EXIT;
    END IF;    
  END LOOP; 
  
  IF BL_PHONE.COUNT>0 THEN  
    DBMS_LOCK.SLEEP(180);
    FOR I IN BL_PHONE.FIRST..BL_PHONE.LAST LOOP
      --проверяем количество не отправленных смс (сколько раз блокировался с ошибкой "СМС не отправлено")
      pErrSms := 0;
      IF BL_SMS(I) IS NOT NULL THEN
        SELECT count(*)
        INTO pErrSms
        FROM AUTO_BLOCKED_PHONE ph
        WHERE PH.PHONE_NUMBER = BL_PHONE(I)
        AND PH.BLOCK_DATE_TIME >= SYSDATE-1/24
        AND PH.NOTE = 'СМС не отправлено';
      END IF;
      
      IF (BL_SMS(I) IS NULL) OR (pErrSms > 2) THEN 
        LOCK_PH:=LOADER3_pckg.LOCK_PHONE(BL_PHONE(I),0,1);--для сим-трайд прописываем жестко, т.к. 1 л\с
        IF LOCK_PH IS NOT NULL THEN
          LOOP
            ERROR_COL:=ERROR_COL+1;
             LOCK_PH:=LOADER3_pckg.LOCK_PHONE(BL_PHONE(I),0,1);--для сим-трайд прописываем жестко, т.к. 1 л\с
            EXIT WHEN (LOCK_PH IS NULL) OR (ERROR_COL=2); 
          END LOOP;
        END IF;     
        IF LOCK_PH IS NOT NULL THEN
          INSERT INTO AUTO_BLOCKED_PHONE(PHONE_NUMBER, BALLANCE, NOTE, BLOCK_DATE_TIME, ABONENT_FIO) 
            VALUES (BL_PHONE(I), BL_BALANCE(I), SUBSTR('Ошибка. '||LOCK_PH, 300), SYSDATE, BL_FIO(I));
        ELSE 
          UPDATE DB_LOADER_ACCOUNT_PHONES
            SET DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE=0
            WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=BL_PHONE(I)
              AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH=(SELECT * 
                                                         FROM (SELECT DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH 
                                                                 FROM DB_LOADER_ACCOUNT_PHONES 
                                                                 WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=BL_PHONE(I)
                                                                 ORDER BY YEAR_MONTH DESC)
                                                         WHERE ROWNUM=1);
        END IF;
      ELSE 
        INSERT INTO AUTO_BLOCKED_PHONE(PHONE_NUMBER, BALLANCE, NOTE, BLOCK_DATE_TIME, ABONENT_FIO) 
          VALUES(BL_PHONE(I), BL_BALANCE(I), 'СМС не отправлено', SYSDATE, BL_FIO(I));  
      END IF;
      COMMIT;
    END LOOP;
  END IF;  
END;