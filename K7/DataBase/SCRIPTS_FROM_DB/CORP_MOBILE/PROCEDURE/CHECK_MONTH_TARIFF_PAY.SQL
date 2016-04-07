
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."CHECK_MONTH_TARIFF_PAY" IS

    --version 10
    --v.10 Алексеев. При записи номера в таблицу PHONE_CALC_ABON_TP_UNLIM_ON в качестве параметра YEAR_MONTH указываем следующий месяц.
    --v9. Алексеев. Убрал проверку на месяц существования контракта при записи данных в таблицу PHONE_CALC_ABON_TP_UNLIM_ON.
    --                     Теперь по алгоритму будут идти и старые номера.
    --v8. Алексеев. Отменил изменения версии 7. На заблокированные номера с отсрочкой абонки проставляем доп. статус 302
    --v7. Алексеев. Номера, у которых тп с автоподкл. пакетов и договор завден в текущем месяце в независимости от того блокирован или активен доп. статус 302 не проставляем
    --                     Ранее доп. статус не прсотавлялся только на активные номера.
    --v6. Алексеев. Ограничил запись в табл. PHONE_CALC_ABON_TP_UNLIM_ON только активными номерами
    --v5. Алексеев. При вставке в табл. PHONE_CALC_ABON_TP_UNLIM_ON добавил запись поля TARIFF_ID
    --v4. Алексеев. Добавил запись номеров, по которым делаем отсрочку списания АП в таблицу PHONE_CALC_ABON_TP_UNLIM_ON
    --v3. Алексеев.  Заменил табл.  CONTRACTS на views V_CONTRACTS. Добавил условие непроставления доп. статуса
    
    NOW_MONTH INTEGER;
    vRes INTEGER;
    pPhoneCnt INTEGER;
    vIS_ACTIVE INTEGER;
BEGIN
    --определяем год/месяц
    NOW_MONTH:=TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'));
    --в последний день месяца проставляем доп. статус "Драйв, недостаточно для абон.платы на мес."
    IF TO_CHAR(SYSDATE, 'YYYYMM') <> TO_CHAR(SYSDATE+1, 'YYYYMM') THEN
        FOR rec IN (SELECT 
                              C.CONTRACT_ID,
                              C.PHONE_NUMBER_FEDERAL, 
                              TR.MONTHLY_PAYMENT,
                              NVL(TR.IS_AUTO_INTERNET, 0) IS_AUTO_INTERNET,
                              C.CONTRACT_DATE, 
                              TR.TARIFF_ID
                          FROM V_CONTRACTS C, 
                                   TARIFFS TR/*, 
                                   DB_LOADER_ACCOUNT_PHONES D*/
                          WHERE C.TARIFF_ID = TR.TARIFF_ID(+)
                            AND NVL(TR.DISCR_SPISANIE, 0) = 1                    
                            AND C.DOP_STATUS IS NULL
                            /*AND D.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
                            AND D.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
                            AND NVL(D.PHONE_IS_ACTIVE, -1) = 1*/)
        LOOP
            --если на счету недостаточно средств для списания абонки
            IF GET_ABONENT_BALANCE(rec.PHONE_NUMBER_FEDERAL) <= rec.MONTHLY_PAYMENT THEN
                vRes := 1;
                --если на номере тп с автоподключение пакетов и контракт заведен в текущем месяце, то доп. статус не проставляем и запоминаем номер
                IF (NVL(ms_constants.GET_CONSTANT_VALUE('CALC_ABON_TP_UNLIM_ON'), 0) = 1) AND --если включен механизм списания абонки по тп с отсрочкой
                    (rec.IS_AUTO_INTERNET = 1) AND --если тп с признаком автоподключения пакетов
                    ((to_number(to_char(rec.CONTRACT_DATE, 'YYYYMM')) = to_number(to_char(sysdate, 'YYYYMM')))
                      OR
                     ((to_number(to_char(rec.CONTRACT_DATE, 'YYYYMM')) <> to_number(to_char(sysdate, 'YYYYMM'))) AND (to_number(MS_params.GET_PARAM_VALUE('CALC_ABON_TP_UNLIM_ON_4_OLD_PHN')) = 1))) THEN
                    --проверяем статус номера. Если активен, то запоминаем
                    vIS_ACTIVE := 0;
                    SELECT count(*)
                        INTO vIS_ACTIVE
                      FROM DB_LOADER_ACCOUNT_PHONES DB
                    WHERE DB.PHONE_NUMBER = rec.PHONE_NUMBER_FEDERAL
                         AND DB.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
                         AND NVL(DB.PHONE_IS_ACTIVE, 0) = 1;
                       
                    IF NVL(vIS_ACTIVE, 0) > 0 THEN                        
                        --проверяем наличие данного номера в табл., если нет, то запоминаем такие номера
                        --номера запоминаются с будущим годом/месяцем, т.е. запоминается второй месяц существования контракта (т.к. посуточные списания осущ. в данном месяце)
                        pPhoneCnt := 0;
                        SELECT count(*)
                            INTO pPhoneCnt
                           FROM PHONE_CALC_ABON_TP_UNLIM_ON
                         WHERE PHONE_NUMBER = rec.PHONE_NUMBER_FEDERAL
                             AND YEAR_MONTH = to_number(TO_CHAR(ADD_MONTHS(sysdate, 1), 'YYYYMM'))
                             AND TARIFF_ID = rec.TARIFF_ID;
                        --
                        IF pPhoneCnt = 0 THEN
                            INSERT INTO PHONE_CALC_ABON_TP_UNLIM_ON (YEAR_MONTH, PHONE_NUMBER, TARIFF_ID) 
                            VALUES (to_number(TO_CHAR(ADD_MONTHS(sysdate, 1), 'YYYYMM')), rec.PHONE_NUMBER_FEDERAL, rec.TARIFF_ID);
                            commit;                           
                        END IF;
                        --
                        vRes := 0; 
                    END IF;                  
                END IF;
                
                IF vRes = 1 THEN
                    UPDATE CONTRACTS C
                          SET C.DOP_STATUS = 302
                     WHERE C.CONTRACT_ID = rec.CONTRACT_ID;
                    COMMIT;
                END IF;
            END IF;
        END LOOP;  
    END IF;
    --снятие доп. статуса
    FOR rec IN (SELECT 
                         C.CONTRACT_ID,
                         C.PHONE_NUMBER_FEDERAL, 
                         TR.MONTHLY_PAYMENT
                      FROM V_CONTRACTS C, 
                                TARIFFS TR/*, 
                                DB_LOADER_ACCOUNT_PHONES D*/
                      WHERE C.TARIFF_ID = TR.TARIFF_ID(+)
                           AND NVL(TR.DISCR_SPISANIE, 0) = 1
                           AND NVL(C.DOP_STATUS, 0) = 302
                     /* AND D.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
                      AND D.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
                      AND NVL(D.PHONE_IS_ACTIVE, -1) = 0*/)
    LOOP
        IF GET_ABONENT_BALANCE(rec.PHONE_NUMBER_FEDERAL) > rec.MONTHLY_PAYMENT THEN
            UPDATE CONTRACTS C
                  SET C.DOP_STATUS = NULL
             WHERE C.CONTRACT_ID = rec.CONTRACT_ID;
            COMMIT;
        END IF;
    END LOOP;  
END;