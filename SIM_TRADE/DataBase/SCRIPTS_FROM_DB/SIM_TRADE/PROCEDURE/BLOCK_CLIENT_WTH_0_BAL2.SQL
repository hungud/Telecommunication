
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."BLOCK_CLIENT_WTH_0_BAL2" (
  pACCOUNT_ID IN INTEGER
  ) AS
--
--#Version=23
--v. 23 Афросин добавил отправку смс с отрицательным балансомраз в 12 часов
--05.08.13 Крайнов. Добавил более плотную проверку баланса.
--15.05.2013 Назин. Убрал дублированную c Loader3 проверку выполнения по НК
-- 12.04.201. Крайнов. По константе('') проверка на полный запрет блокировки из таблицы "PHONE_NUMBER_BLOCK_DENIED"
--21.11.2012 Овсянников. Добавления номеров по расследованию + проверка баланса непосредственно перед блокировкой.
--09.09.2011 Крайнов. Вынесен отбор телефонов во вьюшку
--Крайнов. Добавлен потеряггый коммит.
-- 24.04.2013 Назин П. Логирование
  vDISCONNECT_COUNT BINARY_INTEGER := 15;
  
  nMethod number:=0;
  err varchar2(500);
  PSender_name varchar2(20);
  
  cSMS_BLOCK_INTERVAL CONSTANT INTEGER := TO_NUMBER(NVL(MS_PARAMS.GET_PARAM_VALUE('BLOCK_SMS_INTERVAL'), '12'));
--
CURSOR C IS
SELECT V_PHONE_NUMBERS_FOR_BLOCK.ACCOUNT_ID,
       V_PHONE_NUMBERS_FOR_BLOCK.PHONE_NUMBER_FEDERAL,
       V_PHONE_NUMBERS_FOR_BLOCK.BALANCE,
       V_PHONE_NUMBERS_FOR_BLOCK.FIO,
       V_PHONE_NUMBERS_FOR_BLOCK.BLOCK_NOTICE_TEXT,
       V_PHONE_NUMBERS_FOR_BLOCK.BLOCK_BALANCE,
       V_PHONE_NUMBERS_FOR_BLOCK.DEALER_KOD,
       c.contract_id,
       C.DATE_BLOCK_SMS
  FROM V_PHONE_NUMBERS_FOR_BLOCK,
       contracts c
  WHERE
    V_PHONE_NUMBERS_FOR_BLOCK.ACCOUNT_ID=pACCOUNT_ID
    and C.CONTRACT_ID = V_PHONE_NUMBERS_FOR_BLOCK.CONTRACT_ID
    AND NOT EXISTS (SELECT 1
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
  BL_PHONE DBMS_SQL.VARCHAR2_TABLE;
  BL_FIO DBMS_SQL.VARCHAR2_TABLE;
  BL_BALANCE DBMS_SQL.NUMBER_TABLE;
  BL_SMS DBMS_SQL.VARCHAR2_TABLE;
  BL_BLOCK_BALANCE DBMS_SQL.NUMBER_TABLE;

  DATE_ROWS DBMS_SQL.DATE_TABLE; 
  COST_ROWS DBMS_SQL.NUMBER_TABLE; 
  DESCRIPTION_ROWS DBMS_SQL.VARCHAR2_TABLE;
  L BINARY_INTEGER;
  NEEDINVESTIGATION INT;
  NEXTVALDET INT;
  TEMPSUM_REPORTDATA NUMBER(10,2);
  vPHONE_READY_FOR_BLOCK BOOLEAN;
  
  --
  CURSOR DL (KOD INTEGER) IS
  SELECT
    PATTERN, REPLACEMENT,SENDER_NAME
  FROM DEALERS
  WHERE DEALER_KOD=KOD AND PATTERN IS NOT NULL AND REPLACEMENT IS NOT NULL;

  vDL DL%ROWTYPE;
   
BEGIN
  BL_PHONE.DELETE; 
  BL_FIO.DELETE; 
  BL_BALANCE.DELETE; 
  BL_SMS.DELETE; 
  BL_BLOCK_BALANCE.DELETE; 
  DATE_ROWS.DELETE; 
  COST_ROWS.DELETE; 
  DESCRIPTION_ROWS.DELETE;
  INDEXI:=-1;
--  
  FOR vREC IN C LOOP
    OPEN BL(vREC.ACCOUNT_ID);
    FETCH BL INTO vBL;
    CLOSE BL;
    IF vBL.DO_AUTO_BLOCK=1 THEN
      IF NOT ROBOT_IN_BLOCK(vREC.PHONE_NUMBER_FEDERAL) THEN
        NEEDINVESTIGATION:=0;
        BEGIN
            SELECT 1 INTO NEEDINVESTIGATION FROM INVESTIGATION_PHONES WHERE PHONE_NUMBER=vREC.PHONE_NUMBER_FEDERAL AND ROWNUM=1;
        EXCEPTION 
            WHEN OTHERS THEN NEEDINVESTIGATION:=0;
        END;            
        IF NEEDINVESTIGATION=1 THEN 
          CALC_BALANCE_ROWS2(vREC.PHONE_NUMBER_FEDERAL, DATE_ROWS, COST_ROWS, DESCRIPTION_ROWS, TRUE, sysdate);
          L := COST_ROWS.LAST;
        IF L IS NOT NULL THEN
           NEXTVALDET:=S_NEW_ID_DETAILS_INVPHDET.NEXTVAL;
           TEMPSUM_REPORTDATA:=0;
           BEGIN
            SELECT DETAIL_SUM INTO TEMPSUM_REPORTDATA FROM DB_LOADER_REPORT_DATA WHERE YEAR_MONTH=(SELECT * 
                                                         FROM (SELECT DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH 
                                                                 FROM DB_LOADER_ACCOUNT_PHONES 
                                                                 WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=vREC.PHONE_NUMBER_FEDERAL
                                                                 ORDER BY YEAR_MONTH DESC)
                                                         WHERE ROWNUM=1) AND PHONE_NUMBER=vREC.PHONE_NUMBER_FEDERAL AND ROWNUM=1;
           EXCEPTION 
            WHEN OTHERS THEN TEMPSUM_REPORTDATA:=0;
           END;            
         FORALL I IN COST_ROWS.FIRST..L 
           INSERT INTO INVESTIGATION_PHONES_DETAILS (ID_DETAILS, PHONE_NUMBER, ROW_DATE, ROW_COST, ROW_COMMENT, DATEEVENT, SUM_REPORTDATA)
            VALUES (NEXTVALDET, vREC.PHONE_NUMBER_FEDERAL, DATE_ROWS(I), COST_ROWS(I), DESCRIPTION_ROWS(I), SYSDATE, TEMPSUM_REPORTDATA);
          END IF;
          COMMIT;
        END IF;
        ERROR_COL:=0; 
        vPHONE_READY_FOR_BLOCK:=TRUE;
        SMS_TXT:=replace(vREC.BLOCK_NOTICE_TEXT,'%balance%',round(vRec.Balance));
        SMS_TXT:=replace(SMS_TXT,'%dolg%',round(-vRec.Balance));
        PSender_name:=null;
               --Замена подставных параметров для дилеров по справочнику
               FOR vDL IN DL(vREC.DEALER_KOD) LOOP
                 SMS_TXT:=replace(SMS_TXT, vDL.pattern, vDL.replacement);
                 PSender_name:=vDL.Sender_Name;
               END LOOP;

               --Оставшиеся после замены подставные параметры делаем дефолтными
               FOR vDL IN DL(0) LOOP
                 SMS_TXT:=replace(SMS_TXT, vDL.pattern, vDL.replacement);
               END LOOP;
        -- Проверка есть ли прямой запрет на блок данного номера
        IF MS_CONSTANTS.GET_CONSTANT_VALUE('USE_FULL_ACCESS_DENIED_BLOCK')='1' THEN
          FOR rec_null IN(SELECT *
                            FROM PHONE_NUMBER_BLOCK_DENIED PHAD
                            WHERE PHAD.PHONE_NUMBER = vREC.PHONE_NUMBER_FEDERAL
                              AND ROWNUM = 1)
          LOOP
          -- Запрет найден, номер не готов.
            vPHONE_READY_FOR_BLOCK:=FALSE;
          END LOOP;
        END IF;
        -- Если номер готов, шлем СМС и добавляем в список.
        IF vPHONE_READY_FOR_BLOCK
            -- последнее уведомление или не было или было больше 12 часов
           and ((vREC.DATE_BLOCK_SMS is null) or ((sysdate-vREC.DATE_BLOCK_SMS)*24>= cSMS_BLOCK_INTERVAL))
         THEN
          SMS:=LOADER3_pckg.SEND_SMS(vREC.PHONE_NUMBER_FEDERAL,
                                     'Смс-оповещение',
                                     SMS_TXT,
                                     0/*,
                                     PSender_name*/);     
          update contracts c
            set c.date_block_sms = sysdate
          where
            c.contract_id = vREC.contract_id
            and c.phone_number_federal = vREC.phone_number_federal;
          
          DBMS_LOCK.SLEEP(2);
          INDEXI:=INDEXI+1;
          BL_PHONE(INDEXI):=vREC.PHONE_NUMBER_FEDERAL;
          BL_BLOCK_BALANCE(INDEXI):=vREC.BLOCK_BALANCE;
          BL_FIO(INDEXI):=vREC.FIO;
          BL_BALANCE(INDEXI):=vREC.BALANCE;
          BL_SMS(INDEXI):=SMS;
        END IF;                                
      END IF;      
    END IF;
        -- Не более vDISCONNECT_COUNT за 1 раз.
    vDISCONNECT_COUNT := vDISCONNECT_COUNT - 1;
    IF vDISCONNECT_COUNT <= 0 THEN
      EXIT;
    END IF;    
  END LOOP; 
  IF TO_NUMBER('0'||MS_CONSTANTS.GET_CONSTANT_VALUE('BLOCK_PHONE_DELAY'))>0 THEN
    DBMS_LOCK.SLEEP(TO_NUMBER('0'||MS_CONSTANTS.GET_CONSTANT_VALUE('BLOCK_PHONE_DELAY')));    
  ELSE
    DBMS_LOCK.SLEEP(180);
  END IF;  
  --определяем каким способом выполнять
  begin
  select strinlike('9',t.n_method,';','()') into nMethod from accounts t where t.account_id=pACCOUNT_ID;
  exception
  when others then nMethod:=0;
  end;  
  IF BL_PHONE.COUNT>0 THEN  
    FOR I IN BL_PHONE.FIRST..BL_PHONE.LAST LOOP
      vPHONE_READY_FOR_BLOCK:=TRUE; -- По умолчанию, номер готов к блоку, т.к. СМС уже отослано.      
      -- Проверка есть ли прямой запрет на блок данного номера
      IF MS_CONSTANTS.GET_CONSTANT_VALUE('USE_FULL_ACCESS_DENIED_BLOCK')='1' THEN
        FOR rec_null IN(SELECT *
                          FROM PHONE_NUMBER_BLOCK_DENIED PHAD
                          WHERE PHAD.PHONE_NUMBER = BL_PHONE(I)
                            AND ROWNUM = 1)
        LOOP
        -- Запрет найден, номер не готов.
          vPHONE_READY_FOR_BLOCK:=FALSE;
        END LOOP;
      END IF;
      IF (GET_ABONENT_BALANCE(BL_PHONE(I))< BL_BLOCK_BALANCE(I))  THEN    -- Проверка баланса, вдруг уже пополнил счет
        IF vPHONE_READY_FOR_BLOCK THEN   -- Проверка, что номер готов к блоку    
            LOOP
              ERROR_COL:=ERROR_COL+1;
              /*LOCK_PH:=LOADER3_pckg.LOCK_PHONE(BL_PHONE(I));*/
              IF (GET_ABONENT_BALANCE(BL_PHONE(I))< BL_BLOCK_BALANCE(I))  THEN
                LOCK_PH:=LOADER3_pckg.LOCK_PHONE(BL_PHONE(I),0,nMethod);--отработка с учётом метода, если через новый не получилось, Loader3  делает по старой.
              END IF;
              EXIT WHEN (LOCK_PH IS NULL) OR (ERROR_COL=2); 
            END LOOP;               
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
        END IF;
      ELSE 
        INSERT INTO AUTO_BLOCKED_PHONE(PHONE_NUMBER, BALLANCE, NOTE, BLOCK_DATE_TIME, ABONENT_FIO) 
          VALUES(BL_PHONE(I), BL_BALANCE(I), 'Номер не заблокирован по причине изменения баланса.', SYSDATE, BL_FIO(I));  
        DATE_ROWS.DELETE; 
        COST_ROWS.DELETE; 
        DESCRIPTION_ROWS.DELETE;
        CALC_BALANCE_ROWS2(BL_PHONE(I), DATE_ROWS, COST_ROWS, DESCRIPTION_ROWS, TRUE, sysdate);
        L := COST_ROWS.LAST;
        IF L IS NOT NULL THEN
         NEXTVALDET:=S_NEW_ID_DETAILS_INVPHDET.NEXTVAL;

         TEMPSUM_REPORTDATA:=0;
         BEGIN
          SELECT DETAIL_SUM INTO TEMPSUM_REPORTDATA FROM DB_LOADER_REPORT_DATA WHERE YEAR_MONTH=(SELECT * 
                                                       FROM (SELECT DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH 
                                                               FROM DB_LOADER_ACCOUNT_PHONES 
                                                               WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=BL_PHONE(I)
                                                               ORDER BY YEAR_MONTH DESC)
                                                       WHERE ROWNUM=1) AND PHONE_NUMBER=BL_PHONE(I) AND ROWNUM=1;
         EXCEPTION 
          WHEN OTHERS THEN TEMPSUM_REPORTDATA:=0;
         END;            
         FORALL I IN COST_ROWS.FIRST..L 
          INSERT INTO INVESTIGATION_PHONES_DETAILS (ID_DETAILS, PHONE_NUMBER, ROW_DATE, ROW_COST, ROW_COMMENT, DATEEVENT)
           VALUES (NEXTVALDET, BL_PHONE(I), DATE_ROWS(I), COST_ROWS(I), DESCRIPTION_ROWS(I), SYSDATE);
        END IF;
        INSERT INTO INVESTIGATION_PHONES (PHONE_NUMBER,TURN_ON_DATE) VALUES (BL_PHONE(I),SYSDATE);
      END IF;
      COMMIT;
    END LOOP;
  END IF; 
 --дошли до конца - логируем 
 INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
 VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,1,'', 9,null);commit;   
EXCEPTION
  --логируем печальку 
 when others then 
 err:=substr(SQLERRM,0,500);
 INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
 VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,0,err, 9,null);commit; 
END;