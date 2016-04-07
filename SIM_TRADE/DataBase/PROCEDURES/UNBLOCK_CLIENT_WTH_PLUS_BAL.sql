CREATE OR REPLACE PROCEDURE UNBLOCK_CLIENT_WTH_PLUS_BAL AS     
--
--#Version=14
--
-- 14 26.03.2012 Николаев. Добавил параметр в ROBOT_IN_BLOCK
-- 13 11.11.2011 Крайнов. Поставил отсылку номера 
-- 12 03.11.2011 Крайнов. Добавил учет галки робот в блоке.
-- 11 21.09.2011 Крайнов. Добавил оключение, если не работает автоБлокировка
-- 10 09.09.2011 Крайнов. Вынесен отбор телефонов во вьюшку
--
CURSOR C IS
  SELECT V_PHONE_NUMBERS_FOR_UNLOCK.FIO,
         V_PHONE_NUMBERS_FOR_UNLOCK.BALANCE,
         V_PHONE_NUMBERS_FOR_UNLOCK.PHONE_NUMBER_FEDERAL,
         V_PHONE_NUMBERS_FOR_UNLOCK.ACCOUNT_ID
    FROM V_PHONE_NUMBERS_FOR_UNLOCK
    WHERE NOT EXISTS(SELECT 1
                       FROM AUTO_UNBLOCKED_PHONE
                       WHERE V_PHONE_NUMBERS_FOR_UNLOCK.PHONE_NUMBER_FEDERAL=AUTO_UNBLOCKED_PHONE.PHONE_NUMBER
                         AND AUTO_UNBLOCKED_PHONE.NOTE='Ошибка. Error! Разблокировка через сайт не разрешена'
                         AND AUTO_UNBLOCKED_PHONE.UNBLOCK_DATE_TIME>SYSDATE-4/24) 
                             --Номера с запретом не чаще раз в 4 часа
    order by BALANCE-NVL(DISCONNECT_LIMIT, 0) DESC;

      /*SELECT * 
  FROM v_abonent_balances
  WHERE  v_abonent_balances.PHONE_NUMBER_FEDERAL=9672217562; */
--
CURSOR BL (ID INTEGER) IS
  SELECT 
    ACCOUNTS.DO_AUTO_BLOCK
  FROM ACCOUNTS
  WHERE ID=ACCOUNTS.ACCOUNT_ID;
--    
  vBL BL%ROWTYPE;
  unb_d_t DATE;
  UNLOCK_PH VARCHAR2(2000);
  ERROR_COL NUMBER;
  CHECK_SEND_MAIL INTEGER;
BEGIN
--       
  FOR vREC IN C LOOP
    OPEN BL(vREC.ACCOUNT_ID);
    FETCH BL INTO vBL;
    CLOSE BL;
    IF vBL.DO_AUTO_BLOCK=1 THEN
      IF NOT ROBOT_IN_BLOCK(vREC.PHONE_NUMBER_FEDERAL,true) THEN
        ERROR_COL:=0; 
        unb_d_t:=sysdate;
        UNLOCK_PH:=LOADER3_pckg.UNLOCK_PHONE(vREC.PHONE_NUMBER_FEDERAL, 0);
        --  
        IF UNLOCK_PH IS NOT NULL THEN
          LOOP
            ERROR_COL:=ERROR_COL+1;
            --           UNLOCK_PH:=LOADER3_pckg.UNLOCK_PHONE(vREC.PHONE_NUMBER_FEDERAL, 0);
            EXIT WHEN (UNLOCK_PH IS NULL) OR (ERROR_COL=2); 
          END LOOP;
        END IF;
        --

        IF ERROR_COL=2  THEN
          IF UNLOCK_PH='Error! Разблокировка через сайт не разрешена' THEN
            CHECK_SEND_MAIL:=0;
            FOR CH IN(
              SELECT AUTO_UNBLOCKED_PHONE.PHONE_NUMBER
                FROM AUTO_UNBLOCKED_PHONE,
                     DB_LOADER_ACCOUNT_PHONES
                WHERE AUTO_UNBLOCKED_PHONE.PHONE_NUMBER=vREC.PHONE_NUMBER_FEDERAL
                  AND AUTO_UNBLOCKED_PHONE.UNBLOCK_DATE_TIME>SYSDATE-4/24
                  AND AUTO_UNBLOCKED_PHONE.PHONE_NUMBER=DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER(+)
                  AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH=TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMM'))
                  AND DB_LOADER_ACCOUNT_PHONES.CONSERVATION=1)
            LOOP
              CHECK_SEND_MAIL:=1;
            END LOOP;
            IF CHECK_SEND_MAIL=1 THEN
              SEND_MAIL('tarifer@k7.ru','Разблокировать из сохранения',vREC.PHONE_NUMBER_FEDERAL);
            END IF;
          END IF;
          INSERT INTO AUTO_UNBLOCKED_PHONE  
              (phone_number,
              Ballance,
              Note,
              unblock_date_time,
              ABONENT_FIO) 
            VALUES (vREC.PHONE_NUMBER_FEDERAL, vREC.Balance, SUBSTR('Ошибка. '||UNLOCK_PH, 1, 300), unb_d_t,vREC.FIO);
        ELSE 
          UPDATE DB_LOADER_ACCOUNT_PHONES
            SET DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE=1
            WHERE DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH=(Select * 
                                                         from (select DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH 
                                                                 from DB_LOADER_ACCOUNT_PHONES 
                                                                 where DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=vREC.PHONE_NUMBER_FEDERAL 
                                                                 order by YEAR_MONTH desc) 
                                                         where rownum=1) 
            and DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=vREC.PHONE_NUMBER_FEDERAL;
        END IF;
        COMMIT;
      END IF;
    END IF;
  END LOOP;
END;
/
