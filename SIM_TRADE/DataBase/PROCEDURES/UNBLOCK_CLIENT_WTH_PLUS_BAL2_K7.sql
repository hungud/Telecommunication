CREATE OR REPLACE PROCEDURE UNBLOCK_CLIENT_WTH_PLUS_BAL2(pACCOUNT_ID IN INTEGER) AS
  err      varchar2(500);
  nMethod  number := 0;
  provv_id integer := 0;
  --
  --#Version=19
  --19 12.02.2015 Алексеев. При отправке смс добавлена проверк на имя провайдера - "Teletie"
  --18 12.11.2014 Крайнов. Замена извещения о разлоке.
  --17 28.02.2014 Николаев М.А. Добавлено смс оповещение о разблокировке
  --15 15.05.2013 Назин П. Сократил количество попыток разблокировки убрал доп. проверку на выполнение из НК.т.к. она дублируется в LOADER3
  --              Сейчас блок-разблок идёт в 2 попытки по старому и в 6 попыток по новому кабинету.
  --14 24.04.2013 Назин П. Логирование
  -- 13 11.11.2011 Крайнов. Поставил отсылку номера 
  -- 12 03.11.2011 Крайнов. Добавил учет галки робот в блоке.
  -- 11 21.09.2011 Крайнов. Добавил оключение, если не работает автоБлокировка
  -- 10 09.09.2011 Крайнов. Вынесен отбор телефонов во вьюшку
  --
  CURSOR C IS
    SELECT V_PHONE_NUMBERS_FOR_UNLOCK.FIO,
           V_PHONE_NUMBERS_FOR_UNLOCK.BALANCE,
           V_PHONE_NUMBERS_FOR_UNLOCK.PHONE_NUMBER_FEDERAL,
           V_PHONE_NUMBERS_FOR_UNLOCK.ACCOUNT_ID,
           V_PHONE_NUMBERS_FOR_UNLOCK.HAND_BLOCK
      FROM V_PHONE_NUMBERS_FOR_UNLOCK
      WHERE V_PHONE_NUMBERS_FOR_UNLOCK.ACCOUNT_ID = pACCOUNT_ID
        AND V_PHONE_NUMBERS_FOR_UNLOCK.HAND_BLOCK <> 1
        AND NOT EXISTS (SELECT 1
                          FROM QUEUE_PHONE_REBLOCK
                          WHERE QUEUE_PHONE_REBLOCK.PHONE_NUMBER = V_PHONE_NUMBERS_FOR_UNLOCK.PHONE_NUMBER_FEDERAL)
        AND NOT EXISTS (SELECT 1
                          FROM AUTO_UNBLOCKED_PHONE
                          WHERE V_PHONE_NUMBERS_FOR_UNLOCK.PHONE_NUMBER_FEDERAL = AUTO_UNBLOCKED_PHONE.PHONE_NUMBER
                            AND AUTO_UNBLOCKED_PHONE.NOTE = 'Ошибка. Error! Разблокировка через сайт не разрешена'
                            AND AUTO_UNBLOCKED_PHONE.UNBLOCK_DATE_TIME > SYSDATE - 4 / 24)
    --Номера с запретом не чаще раз в 4 часа
      order by BALANCE - NVL(DISCONNECT_LIMIT, 0) DESC;

  /*SELECT * 
  FROM v_abonent_balances
  WHERE  v_abonent_balances.PHONE_NUMBER_FEDERAL=9672217562; */
  --
  CURSOR BL(ID INTEGER) IS
    SELECT ACCOUNTS.DO_AUTO_BLOCK
      FROM ACCOUNTS
     WHERE ID = ACCOUNTS.ACCOUNT_ID;
  --    
  vBL             BL%ROWTYPE;
  unb_d_t         DATE;
  UNLOCK_PH       VARCHAR2(2000);
  ERROR_COL       NUMBER;
  CHECK_SEND_MAIL INTEGER;
BEGIN
  --определяем каким способом выполнять
  begin
    select strinlike('10', t.n_method, ';', '()')
      into nMethod
      from accounts t
     where t.account_id = pACCOUNT_ID;
  exception
    when others then
      nMethod := 0;
  end;
  --    
  FOR vREC IN C LOOP
    OPEN BL(vREC.ACCOUNT_ID);
    FETCH BL
      INTO vBL;
    CLOSE BL;
    IF vBL.DO_AUTO_BLOCK = 1 THEN
      ERROR_COL := 0;
      unb_d_t   := sysdate;    
      LOOP
        ERROR_COL := ERROR_COL + 1;
        /*UNLOCK_PH:=LOADER3_pckg.UNLOCK_PHONE(vREC.PHONE_NUMBER_FEDERAL, 0);*/ --  проверка на ошибку в НК есть в loader3 
        UNLOCK_PH := LOADER3_pckg.UNLOCK_PHONE(vREC.PHONE_NUMBER_FEDERAL, 0, nMethod); --с учётом метода если ошибка - то он там же идёт по старому
        EXIT WHEN(UNLOCK_PH IS NULL) OR(ERROR_COL = 2);
      END LOOP;
      --    
      IF ERROR_COL = 2 THEN
        IF UNLOCK_PH = 'Error! Разблокировка через сайт не разрешена' THEN
          CHECK_SEND_MAIL := 0;
          FOR CH IN (SELECT AUTO_UNBLOCKED_PHONE.PHONE_NUMBER
                       FROM AUTO_UNBLOCKED_PHONE, DB_LOADER_ACCOUNT_PHONES
                       WHERE AUTO_UNBLOCKED_PHONE.PHONE_NUMBER = vREC.PHONE_NUMBER_FEDERAL
                         AND AUTO_UNBLOCKED_PHONE.UNBLOCK_DATE_TIME > SYSDATE - 4 / 24
                         AND AUTO_UNBLOCKED_PHONE.PHONE_NUMBER = DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER(+)
                         AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
                         AND DB_LOADER_ACCOUNT_PHONES.CONSERVATION = 1) 
          LOOP
            CHECK_SEND_MAIL := 1;
          END LOOP;
          IF CHECK_SEND_MAIL = 1 THEN
            SEND_MAIL('tarifer@k7.ru', 'Разблокировать из сохранения', vREC.PHONE_NUMBER_FEDERAL);
          END IF;
        END IF;
        INSERT INTO AUTO_UNBLOCKED_PHONE
            (phone_number, Ballance, Note, unblock_date_time, ABONENT_FIO)
          VALUES
            (vREC.PHONE_NUMBER_FEDERAL, vREC.Balance, SUBSTR('Ошибка. ' || UNLOCK_PH, 1, 300), unb_d_t, vREC.FIO);
      ELSE
        UPDATE DB_LOADER_ACCOUNT_PHONES
          SET DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE = 1
          WHERE DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH =
                 (Select *
                    from (select DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH
                            from DB_LOADER_ACCOUNT_PHONES
                            where DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = vREC.PHONE_NUMBER_FEDERAL
                            order by YEAR_MONTH desc)
                    where rownum = 1)
            and DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = vREC.PHONE_NUMBER_FEDERAL;
        begin
          select ssa.provider_id
            into provv_id
            from SMS_SEND_PARAM_BY_ACCOUNT ssa, sms_send_parametrs ssp
            where ssa.account_id = GET_ACCOUNT_ID_BY_PHONE(vREC.PHONE_NUMBER_FEDERAL)
              and ssp.provider_id = ssa.provider_id
              and ((ssp.sender_name = 'AgSvyazi') or (ssp.sender_name = 'Teletie'))
              and not exists (select 1
                                from sms_log sl
                                where sl.phone = vREC.PHONE_NUMBER_FEDERAL
                                  and sl.send_date >= trunc(sysdate)
                                  and sl.message = 'Ваш номер разблокирован, спасибо за своевременную оплату.')
              and not exists (select 1
                                from sms_current sc
                                where sc.phone = vREC.PHONE_NUMBER_FEDERAL
                                  and sc.insert_date >= trunc(sysdate)
                                  and sc.message = 'Ваш номер разблокирован, спасибо за своевременную оплату.');
        exception
          when others then
            provv_id := 0;
        end;
        if provv_id <> 0 then
          sms_add_request(provv_id, vREC.PHONE_NUMBER_FEDERAL, 'Ваш номер разблокирован, спасибо за своевременную оплату.',
            sysdate+to_number(MS_params.GET_PARAM_VALUE('SMS_UNBLOCK_ADD_SEC'))/86400);
        end if;
      END IF;
      COMMIT;
    END IF;
  END LOOP;
  --дошли до конца - логируем 
  INSERT INTO ACCOUNT_LOAD_LOGS
      (ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME, IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID, BEELINE_RN)
    VALUES
      (NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE, 1, '', 10, null);
  commit;
EXCEPTION
  --логируем печальку 
  when others then
    err := substr(SQLERRM, 0, 500);
    INSERT INTO ACCOUNT_LOAD_LOGS
        (ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME, IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID, BEELINE_RN)
      VALUES
        (NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE, 0, err, 10, null);
    commit;  
END;
/
