CREATE OR REPLACE PROCEDURE BLOCK_CLIENT_WTH_0_BAL2 (pACCOUNT_ID IN INTEGER)
AS
   --
   --#Version=30
   --v.30 22.09.2015 Афросин Добавил в текст смс сумму обещанного платежа
   --29 13.08.2015 Алексеев. При запоминании баланса по номеру в массив для номеров с отсрочкой абонки, баланс пересчитывается заново, т.к. во views, которая 
   --                                     отбирает номера на блок, может быть уже устаревшая информация по балансу.
   --28 02.07.2015 Алексеев. Для номеров с отсрочкой абонки отправляется величина виртуального баланса вместо реального при их неравенстве
   --27 01.07.2015 Алексеев. Ограничил отправку смс. На номера с отсрочкой абонки и при откл. признаке отправки смс, не отправляем
   --26 16.02.2015 Афросин. Проверка на существование номера, полученном из админки
   --25 05.02.2015 Крайнов. Установка снятия снимков
   --24 добавлена проверка на отправку сообщение с таким же текстом в предыдущий раз (vCountSmsText)
   --23: 11.10.2013 Добавлена обработка параметра минимальной суммы оплаты для авторазблокировки
   --05.08.13 Крайнов. Добавил более плотную проверку баланса.
   --15.05.2013 Назин. Убрал дублированную c Loader3 проверку выполнения по НК
   --12.04.201. Крайнов. По константе('') проверка на полный запрет блокировки из таблицы "PHONE_NUMBER_BLOCK_DENIED"
   --21.11.2012 Овсянников. Добавления номеров по расследованию + проверка баланса непосредственно перед блокировкой.
   --09.09.2011 Крайнов. Вынесен отбор телефонов во вьюшку
   --Крайнов. Добавлен потеряггый коммит.
   --24.04.2013 Назин П. Логирование
   vDISCONNECT_COUNT        BINARY_INTEGER := 100;
   nMethod                  NUMBER := 0;
   err                      VARCHAR2 (500);
   PSender_name             VARCHAR2 (20);
   vCountSmsText            NUMBER := 0;
   vPromisedPayment         Number;
    
   --
   CURSOR C
   IS
        SELECT V_PHONE_NUMBERS_FOR_BLOCK.ACCOUNT_ID,
               V_PHONE_NUMBERS_FOR_BLOCK.PHONE_NUMBER_FEDERAL,
               V_PHONE_NUMBERS_FOR_BLOCK.BALANCE,
               V_PHONE_NUMBERS_FOR_BLOCK.FIO,
               V_PHONE_NUMBERS_FOR_BLOCK.BLOCK_NOTICE_TEXT,
               V_PHONE_NUMBERS_FOR_BLOCK.BLOCK_BALANCE,
               V_PHONE_NUMBERS_FOR_BLOCK.DEALER_KOD,
               V_PHONE_NUMBERS_FOR_BLOCK.BALANCE_UNBLOCK
          FROM V_PHONE_NUMBERS_FOR_BLOCK
         WHERE     V_PHONE_NUMBERS_FOR_BLOCK.ACCOUNT_ID = pACCOUNT_ID
               AND NOT EXISTS
                          (SELECT 1
                             FROM QUEUE_PHONE_REBLOCK
                            WHERE QUEUE_PHONE_REBLOCK.PHONE_NUMBER =
                                     V_PHONE_NUMBERS_FOR_BLOCK.PHONE_NUMBER_FEDERAL)
      ORDER BY BALANCE - NVL (DISCONNECT_LIMIT, 0) ASC;

   --
   CURSOR BL (ID INTEGER)
   IS
      SELECT ACCOUNTS.DO_AUTO_BLOCK
        FROM ACCOUNTS
       WHERE ID = ACCOUNTS.ACCOUNT_ID;

   --
   vBL                      BL%ROWTYPE;
   SMS                      VARCHAR2 (2000);
   LOCK_PH                  VARCHAR2 (2000);
   ERROR_COL                NUMBER;
   SMS_TXT                  VARCHAR2 (500 CHAR);
   INDEXI                   INTEGER;
   BL_PHONE                 DBMS_SQL.VARCHAR2_TABLE;
   BL_FIO                   DBMS_SQL.VARCHAR2_TABLE;
   BL_BALANCE               DBMS_SQL.NUMBER_TABLE;
   BL_SMS                   DBMS_SQL.VARCHAR2_TABLE;
   BL_BLOCK_BALANCE         DBMS_SQL.NUMBER_TABLE;
   DATE_ROWS                DBMS_SQL.DATE_TABLE;
   COST_ROWS                DBMS_SQL.NUMBER_TABLE;
   DESCRIPTION_ROWS         DBMS_SQL.VARCHAR2_TABLE;
   L                        BINARY_INTEGER;
   NEEDINVESTIGATION        INT;
   NEXTVALDET               INT;
   TEMPSUM_REPORTDATA       NUMBER (10, 2);
   vPHONE_READY_FOR_BLOCK   BOOLEAN;
   vContPh INTEGER;
   vRes INTEGER;
   resBalance NUMBER(15, 2);

   --
   CURSOR DL (
      KOD    INTEGER)
   IS
      SELECT PATTERN, REPLACEMENT, SENDER_NAME
        FROM DEALERS
       WHERE     DEALER_KOD = KOD
             AND PATTERN IS NOT NULL
             AND REPLACEMENT IS NOT NULL;
   
   vDL                      DL%ROWTYPE;
   
   
      
   -- ПРОВЕРКА НОМЕРА НА ВОЗСОЖНОСТЬ БЛОКИРОВКИ  
  function GET_PHONE_READY_FOR_BLOCK (pPhone_number in varchar2) 
  return Boolean AS
    PRAGMA AUTONOMOUS_TRANSACTION;
    fRes boolean;
    phone_count integer;
    access_denied_list CLOB;
    
  begin
    fRes := True;
    
--  проверка на возможность прямого запрета на блокировку номера  
    if MS_CONSTANTS.GET_CONSTANT_VALUE ('USE_FULL_ACCESS_DENIED_BLOCK') =  '1' then
  --  проверряем номер в списке введенном вручную  
      select nvl(min(count(PHAD.PHONE_NUMBER)), 0) into phone_count 
        FROM PHONE_NUMBER_BLOCK_DENIED PHAD
       WHERE PHAD.PHONE_NUMBER = pPhone_number
             AND ROWNUM = 1
       group by PHAD.PHONE_NUMBER;
       
      if phone_count = 0 then
        --  проверяем номер в списке полученном через сайт
        access_denied_list := GET_LIST_PHONE_NO_BL_FROM_SYTE;
        if DBMS_LOB.INSTR(access_denied_list, pPhone_number) > 0 then
          fRes := False;
        end if;
      else
        fRes := False;  
      end if;
    end if;
    Return  fRes; 
  end;
  
  --Проверяем на наличие обещанного платежа
  FUNCTION GET_PROMISED_PAYMENT(pPhoneNumber  in varchar2) Return Number as
    vRes Number;
  begin
  
    begin
      select nvl(
                  (
                    select max(promised_sum)
                    from PROMISED_PAYMENTS
                    where
                      PROMISED_DATE >= sysdate
                      and phone_number = pPhoneNumber
                   )
                 ,0
                ) into vRes
             from dual;
    exception
      when OTHERS then
        vRes := 0;  
    end;
    
    Return nvl(vRes, 0);
  end;

   
BEGIN
   BL_PHONE.DELETE;
   BL_FIO.DELETE;
   BL_BALANCE.DELETE;
   BL_SMS.DELETE;
   BL_BLOCK_BALANCE.DELETE;
   DATE_ROWS.DELETE;
   COST_ROWS.DELETE;
   DESCRIPTION_ROWS.DELETE;
   INDEXI := -1;

   --
   FOR vREC IN C
   LOOP
      OPEN BL (vREC.ACCOUNT_ID);

      FETCH BL INTO vBL;

      CLOSE BL;

      IF vBL.DO_AUTO_BLOCK = 1
      THEN
         IF NOT ROBOT_IN_BLOCK (vREC.PHONE_NUMBER_FEDERAL)
         THEN
            NEEDINVESTIGATION := 0;

            BEGIN
               SELECT 1
                 INTO NEEDINVESTIGATION
                 FROM INVESTIGATION_PHONES
                WHERE PHONE_NUMBER = vREC.PHONE_NUMBER_FEDERAL AND ROWNUM = 1;
            EXCEPTION
               WHEN OTHERS
               THEN
                  NEEDINVESTIGATION := 0;
            END;

            IF NEEDINVESTIGATION = 1
            THEN
               CALC_BALANCE_ROWS2 (vREC.PHONE_NUMBER_FEDERAL,
                                   DATE_ROWS,
                                   COST_ROWS,
                                   DESCRIPTION_ROWS,
                                   TRUE,
                                   SYSDATE);
               L := COST_ROWS.LAST;

               IF L IS NOT NULL
               THEN
                  NEXTVALDET := S_NEW_ID_DETAILS_INVPHDET.NEXTVAL;
                  TEMPSUM_REPORTDATA := 0;

                  BEGIN
                     SELECT DETAIL_SUM
                       INTO TEMPSUM_REPORTDATA
                       FROM DB_LOADER_REPORT_DATA
                      WHERE     YEAR_MONTH =
                                   (SELECT *
                                      FROM (  SELECT DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH
                                                FROM DB_LOADER_ACCOUNT_PHONES
                                               WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER =
                                                        vREC.PHONE_NUMBER_FEDERAL
                                            ORDER BY YEAR_MONTH DESC)
                                     WHERE ROWNUM = 1)
                            AND PHONE_NUMBER = vREC.PHONE_NUMBER_FEDERAL
                            AND ROWNUM = 1;
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        TEMPSUM_REPORTDATA := 0;
                  END;

                  FORALL I IN COST_ROWS.FIRST .. L
                     INSERT
                       INTO INVESTIGATION_PHONES_DETAILS (ID_DETAILS,
                                                          PHONE_NUMBER,
                                                          ROW_DATE,
                                                          ROW_COST,
                                                          ROW_COMMENT,
                                                          DATEEVENT,
                                                          SUM_REPORTDATA)
                     VALUES (NEXTVALDET,
                             vREC.PHONE_NUMBER_FEDERAL,
                             DATE_ROWS (I),
                             COST_ROWS (I),
                             DESCRIPTION_ROWS (I),
                             SYSDATE,
                             TEMPSUM_REPORTDATA);
               END IF;

               COMMIT;
            END IF;

            --для номеров с отсрочкой АП (данные номера находятся в таблице PHONE_CALC_ABON_TP_UNLIM_ON) изменеяем величину баланса
            --указывается виртуальный баланс в смс, но сам номер блокируется по реальному балансу
            vContPh := 0;
            SELECT count(*)
            INTO vContPh
            FROM PHONE_CALC_ABON_TP_UNLIM_ON ph
            WHERE PH.PHONE_NUMBER = vREC.PHONE_NUMBER_FEDERAL
            AND PH.YEAR_MONTH = to_number(to_char(sysdate, 'YYYYMM'))
            AND PH.TARIFF_ID = NVL(GET_CURR_PHONE_TARIFF_ID(vREC.PHONE_NUMBER_FEDERAL), 0);
            
            ERROR_COL := 0;
            vPHONE_READY_FOR_BLOCK := TRUE;
            --указываем баланс
            IF NVL(vContPh, 0) > 0 THEN
                resBalance := GET_ABONENT_BALANCE(vREC.PHONE_NUMBER_FEDERAL, null, null, 1);
            ELSE
                resBalance := vRec.Balance;
            END IF;
            SMS_TXT :=
               REPLACE (vREC.BLOCK_NOTICE_TEXT,
                        '%balance%',
                        ROUND (resBalance - 0.5));
            SMS_TXT := REPLACE (SMS_TXT, '%dolg%', ROUND (-resBalance));
            
            -- версия #23
            --смс с обещанным платежом делаем только для К7
            if nvl(CONVERT_PCKG.GET_IS_COLLECTOR_BY_PHONE(vREC.PHONE_NUMBER_FEDERAL), 0) = 0 then
              --полуаем сумму обещанного платежа
              vPromisedPayment := GET_PROMISED_PAYMENT(vREC.PHONE_NUMBER_FEDERAL);
              if vPromisedPayment <> 0 then
                SMS_TXT :=
                          REPLACE (
                                    SMS_TXT,
                                    '%minsumunbl% руб.',
                                    ROUND (
                                            ABS (resBalance)
                                            + vRec.BALANCE_UNBLOCK
                                            + 0.5
                                            + vPromisedPayment
                                          ) 
                                          ||' руб. с учетом предоставленного обещанного платежа '
                                          || ROUND(vPromisedPayment)
                                          ||' руб.'
                                          
                                   );   
              else
                 SMS_TXT :=
                 REPLACE (
                    SMS_TXT,
                    '%minsumunbl%',
                    ROUND (ABS (resBalance) + vRec.BALANCE_UNBLOCK + 0.5));
              end if;
            else
              SMS_TXT :=
                 REPLACE (
                    SMS_TXT,
                    '%minsumunbl%',
                    ROUND (ABS (resBalance) + vRec.BALANCE_UNBLOCK + 0.5));
            end if;

            
            PSender_name := NULL;

            --Замена подставных параметров для дилеров по справочнику
            FOR vDL IN DL (vREC.DEALER_KOD)
            LOOP
               SMS_TXT := REPLACE (SMS_TXT, vDL.pattern, vDL.replacement);
               PSender_name := vDL.Sender_Name;
            END LOOP;

            --Оставшиеся после замены подставные параметры делаем дефолтными
            FOR vDL IN DL (0)
            LOOP
               SMS_TXT := REPLACE (SMS_TXT, vDL.pattern, vDL.replacement);
            END LOOP;

            vPHONE_READY_FOR_BLOCK := GET_PHONE_READY_FOR_BLOCK(vREC.PHONE_NUMBER_FEDERAL);

            -- Если номер готов, шлем СМС и добавляем в список.
            IF vPHONE_READY_FOR_BLOCK
            THEN
               SELECT COUNT (*)
                 INTO vCountSmsText -- было ли отправлено такое же сообщение в предыдущий раз
                 FROM log_send_sms a
                WHERE     phone_number = vREC.PHONE_NUMBER_FEDERAL
                      AND a.note IS NULL
                      AND DATE_SEND =
                             (SELECT MAX (DATE_SEND)
                                FROM log_send_sms a
                               WHERE phone_number = vREC.PHONE_NUMBER_FEDERAL)
                      AND a.sms_text = SMS_TXT;

               IF vCountSmsText = 0
               THEN
                  vRes := 1;                  
                  --если по номеру имеется отсрочка абонки и выключен признак отправки смс, то смс не отсылаем
                  IF (vContPh > 0) AND (to_number(MS_params.GET_PARAM_VALUE('DO_NOT_SEND_SMS_BLOCK_PHN_PEPR_ABON')) = 0) THEN
                    vRes := 0;  
                  END IF;
                  
                  IF vRes = 1 THEN
                  SMS :=
                     LOADER3_pckg.SEND_SMS (vREC.PHONE_NUMBER_FEDERAL,
                                            'Смс-оповещение',
                                            SMS_TXT,
                                            0,
                                            PSender_name);
                  END IF;
               END IF;

               --DBMS_LOCK.SLEEP(2);
               INDEXI := INDEXI + 1;
               BL_PHONE (INDEXI) := vREC.PHONE_NUMBER_FEDERAL;
               BL_BLOCK_BALANCE (INDEXI) := vREC.BLOCK_BALANCE;
               BL_FIO (INDEXI) := vREC.FIO;
               --для номеров с отсрочкой абонки, необходимо учитывать всегда баланс на текущий момент времени
               IF NVL(vContPh, 0) > 0 THEN
                 BL_BALANCE (INDEXI) := GET_ABONENT_BALANCE(vREC.PHONE_NUMBER_FEDERAL);
               ELSE
                 BL_BALANCE (INDEXI) := vREC.BALANCE;
               END IF;
               BL_SMS (INDEXI) := SMS;
            END IF;
         END IF;
      END IF;

      -- Не более vDISCONNECT_COUNT за 1 раз.
      vDISCONNECT_COUNT := vDISCONNECT_COUNT - 1;

      IF vDISCONNECT_COUNT <= 0
      THEN
         EXIT;
      END IF;
   END LOOP;

   IF TO_NUMBER (
         '0' || MS_CONSTANTS.GET_CONSTANT_VALUE ('BLOCK_PHONE_DELAY')) > 0
   THEN
      DBMS_LOCK.SLEEP (
         TO_NUMBER (
            '0' || MS_CONSTANTS.GET_CONSTANT_VALUE ('BLOCK_PHONE_DELAY')));
   ELSE
      --DBMS_LOCK.SLEEP(180);
      NULL;
   END IF;

   --определяем каким способом выполнять
   BEGIN
      SELECT strinlike ('9',
                        t.n_method,
                        ';',
                        '()')
        INTO nMethod
        FROM accounts t
       WHERE t.account_id = pACCOUNT_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         nMethod := 0;
   END;

   IF BL_PHONE.COUNT > 0
   THEN
      FOR I IN BL_PHONE.FIRST .. BL_PHONE.LAST
      LOOP
         vPHONE_READY_FOR_BLOCK := TRUE; -- По умолчанию, номер готов к блоку, т.к. СМС уже отослано.

         vPHONE_READY_FOR_BLOCK := GET_PHONE_READY_FOR_BLOCK(BL_PHONE (I));

         IF (GET_ABONENT_BALANCE (BL_PHONE (I)) < BL_BLOCK_BALANCE (I))
         THEN                     -- Проверка баланса, вдруг уже пополнил счет
            IF vPHONE_READY_FOR_BLOCK
            THEN                          -- Проверка, что номер готов к блоку
               CREATE_SNAPSHOT (BL_PHONE (I));
               ERROR_COL := 0;

               LOOP
                  ERROR_COL := ERROR_COL + 1;

                  /*LOCK_PH:=LOADER3_pckg.LOCK_PHONE(BL_PHONE(I));*/
                  IF (GET_ABONENT_BALANCE (BL_PHONE (I)) <
                         BL_BLOCK_BALANCE (I))
                  THEN
                     LOCK_PH :=
                        LOADER3_pckg.LOCK_PHONE (BL_PHONE (I), 0, nMethod); --отработка с учётом метода, если через новый не получилось, Loader3  делает по старой.
                  END IF;

                  EXIT WHEN (LOCK_PH IS NULL) OR (ERROR_COL >= 2);
               END LOOP;

               IF LOCK_PH IS NOT NULL
               THEN
                  INSERT INTO AUTO_BLOCKED_PHONE (PHONE_NUMBER,
                                                  BALLANCE,
                                                  NOTE,
                                                  BLOCK_DATE_TIME,
                                                  ABONENT_FIO)
                       VALUES (BL_PHONE (I),
                               BL_BALANCE (I),
                               SUBSTR ('Ошибка. ' || LOCK_PH, 300),
                               SYSDATE,
                               BL_FIO (I));
               /* ELSE
                  UPDATE DB_LOADER_ACCOUNT_PHONES
                    SET DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE=0
                    WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=BL_PHONE(I)
                      AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH=(SELECT *
                                                                 FROM (SELECT DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH
                                                                         FROM DB_LOADER_ACCOUNT_PHONES
                                                                         WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=BL_PHONE(I)
                                                                         ORDER BY YEAR_MONTH DESC)
                                                                 WHERE ROWNUM=1);*/
               END IF;
            END IF;
         ELSE
            INSERT INTO AUTO_BLOCKED_PHONE (PHONE_NUMBER,
                                            BALLANCE,
                                            NOTE,
                                            BLOCK_DATE_TIME,
                                            ABONENT_FIO)
                    VALUES (
                              BL_PHONE (I),
                              BL_BALANCE (I),
                              'Номер не заблокирован по причине изменения баланса.',
                              SYSDATE,
                              BL_FIO (I));

            DATE_ROWS.DELETE;
            COST_ROWS.DELETE;
            DESCRIPTION_ROWS.DELETE;
            CALC_BALANCE_ROWS2 (BL_PHONE (I),
                                DATE_ROWS,
                                COST_ROWS,
                                DESCRIPTION_ROWS,
                                TRUE,
                                SYSDATE);
            L := COST_ROWS.LAST;

            IF L IS NOT NULL
            THEN
               NEXTVALDET := S_NEW_ID_DETAILS_INVPHDET.NEXTVAL;

               TEMPSUM_REPORTDATA := 0;

               BEGIN
                  SELECT DETAIL_SUM
                    INTO TEMPSUM_REPORTDATA
                    FROM DB_LOADER_REPORT_DATA
                   WHERE     YEAR_MONTH =
                                (SELECT *
                                   FROM (  SELECT DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH
                                             FROM DB_LOADER_ACCOUNT_PHONES
                                            WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER =
                                                     BL_PHONE (I)
                                         ORDER BY YEAR_MONTH DESC)
                                  WHERE ROWNUM = 1)
                         AND PHONE_NUMBER = BL_PHONE (I)
                         AND ROWNUM = 1;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     TEMPSUM_REPORTDATA := 0;
               END;

               FORALL I IN COST_ROWS.FIRST .. L
                  INSERT INTO INVESTIGATION_PHONES_DETAILS (ID_DETAILS,
                                                            PHONE_NUMBER,
                                                            ROW_DATE,
                                                            ROW_COST,
                                                            ROW_COMMENT,
                                                            DATEEVENT)
                       VALUES (NEXTVALDET,
                               BL_PHONE (I),
                               DATE_ROWS (I),
                               COST_ROWS (I),
                               DESCRIPTION_ROWS (I),
                               SYSDATE);
            END IF;

            INSERT INTO INVESTIGATION_PHONES (PHONE_NUMBER, TURN_ON_DATE)
                 VALUES (BL_PHONE (I), SYSDATE);
         END IF;

         COMMIT;
      END LOOP;
   END IF;

   --дошли до конца - логируем
   INSERT INTO ACCOUNT_LOAD_LOGS (ACCOUNT_LOAD_LOG_ID,
                                  ACCOUNT_ID,
                                  LOAD_DATE_TIME,
                                  IS_SUCCESS,
                                  ERROR_TEXT,
                                  ACCOUNT_LOAD_TYPE_ID,
                                  BEELINE_RN)
        VALUES (NEW_ACCOUNT_LOAD_LOG_ID,
                pACCOUNT_ID,
                SYSDATE,
                1,
                'Номеров обработано:' || INDEXI,
                9,
                NULL);

   COMMIT;
EXCEPTION
   --логируем печальку
   WHEN OTHERS
   THEN
      err := SUBSTR (SQLERRM, 0, 500);

      INSERT INTO ACCOUNT_LOAD_LOGS (ACCOUNT_LOAD_LOG_ID,
                                     ACCOUNT_ID,
                                     LOAD_DATE_TIME,
                                     IS_SUCCESS,
                                     ERROR_TEXT,
                                     ACCOUNT_LOAD_TYPE_ID,
                                     BEELINE_RN)
           VALUES (NEW_ACCOUNT_LOAD_LOG_ID,
                   pACCOUNT_ID,
                   SYSDATE,
                   0,
                   err,
                   9,
                   NULL);

      COMMIT;
END;