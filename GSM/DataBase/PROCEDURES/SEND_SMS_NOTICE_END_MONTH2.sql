CREATE OR REPLACE PROCEDURE SEND_SMS_NOTICE_END_MONTH2(
    pACCOUNT_ID IN INTEGER
    ) AS
    --
    --#Version=5
    --v5. Соколов 03.09.2015 - Убрал задержку 2 секунды.
    --v4. Алексеев 14.05.2015 - В условие отбора номеров добавил порог блокировки. Ввел учет номеров с ежедневным списание абонки (ранее они отсекались)
    --v3. Алексеев 13.05.2015 - Изменил условия отбора данных и формулу расчета рекомендуемого платежа
    --v.2 Афросин 27.02.2015 - Добавил абонентскую плату в рассчет суммы задолжности
    --
    pDAY constant integer:=2;
    DAY_NOTICE INTEGER;  
    CURSOR C IS
        SELECT 
            v_abonent_balances.PHONE_NUMBER_FEDERAL,
            v_abonent_balances.BALANCE,
            v_abonent_balances.SURNAME || ' ' || v_abonent_balances.NAME || ' ' || v_abonent_balances.PATRONYMIC FIO,
            v_abonent_balances.DISCONNECT_LIMIT,
            ACCOUNTS.NEXT_MONTH_NOTICE_TEXT,
            ACCOUNTS.ACCOUNT_ID,
            --trunc((100 - v_abonent_balances.BALANCE  + nvl(TAR.MONTHLY_PAYMENT, 0) ), -1) RECOMEND_SUMM
            ABS(
                    GET_ABONENT_BALANCE(PHONE_NUMBER_FEDERAL,SYSDATE+DAY_NOTICE) 
                    - NVL(v_abonent_balances.DISCONNECT_LIMIT,0)
                    - NVL(
                                  CASE
                                    WHEN NVL (v_abonent_balances.IS_CREDIT_CONTRACT, 0) = 1
                                    THEN
                                       tar.BALANCE_BLOCK_CREDIT
                                    ELSE
                                       tar.BALANCE_BLOCK
                                  END,
                                  NVL (
                                    CASE
                                       WHEN NVL (v_abonent_balances.IS_CREDIT_CONTRACT, 0) = 1
                                       THEN
                                          ACCOUNTS.BALANCE_BLOCK_CREDIT
                                       ELSE
                                          ACCOUNTS.BALANCE_BLOCK
                                    END,
                                    0)
                            )
                  ) RECOMEND_SUMM
        FROM v_abonent_balances,
                  ACCOUNTS, 
                  tariffs tar
        WHERE v_abonent_balances.ACCOUNT_ID=pACCOUNT_ID 
             AND loader_script_name is not null
             AND v_abonent_balanceS.ACCOUNT_ID=ACCOUNTS.ACCOUNT_ID
             --and (GET_ABONENT_BALANCE(PHONE_NUMBER_FEDERAL,SYSDATE+DAY_NOTICE)-NVL(v_abonent_balances.DISCONNECT_LIMIT,0)<=ACCOUNTS.BALANCE_NOTICE_END_MONTH)  --баланс через 2 дня станет ниже порога отключения
             and (
                     GET_ABONENT_BALANCE(PHONE_NUMBER_FEDERAL,SYSDATE+DAY_NOTICE)
                     - NVL(v_abonent_balances.DISCONNECT_LIMIT,0) <
                     NVL (
                                 CASE
                                    WHEN NVL (v_abonent_balances.IS_CREDIT_CONTRACT, 0) = 1
                                    THEN
                                       tar.BALANCE_BLOCK_CREDIT
                                    ELSE
                                       tar.BALANCE_BLOCK
                                 END,
                                 NVL (
                                    CASE
                                       WHEN NVL (v_abonent_balances.IS_CREDIT_CONTRACT, 0) = 1
                                       THEN
                                          ACCOUNTS.BALANCE_BLOCK_CREDIT
                                       ELSE
                                          ACCOUNTS.BALANCE_BLOCK
                                    END,
                                    0)
                           )
                    )
             and phone_is_active_code=1 
             and GET_CURR_PHONE_TARIFF_ID(v_abonent_balances.PHONE_NUMBER_FEDERAL)  = TAR.TARIFF_ID (+)       
             /*AND NOT EXISTS 
                                (
                                    SELECT 1
                                    FROM PHONE_NUMBER_WITH_DAILY_ABON PHA
                                    WHERE PHA.PHONE_NUMBER=v_abonent_balances.PHONE_NUMBER_FEDERAL
                                )
            AND NOT EXISTS 
                                (
                                    SELECT 1
                                    FROM TARIFFS TAR
                                    WHERE TAR.TARIFF_ID = v_abonent_balances.TARIFF_ID
                                         AND NVL(TAR.TARIFF_ABON_DAILY_PAY, 0) = 1
                                ) */                 
            AND NOT EXISTS 
                                (
                                    SELECT 1 
                                    FROM SEND_SMS_NOTICE_END_MONTH_LOG 
                                    WHERE v_abonent_balances.PHONE_NUMBER_FEDERAL=SEND_SMS_NOTICE_END_MONTH_LOG.PHONE_NUMBER
                                         AND (SEND_SMS_NOTICE_END_MONTH_LOG.SEND_DATE_TIME>SYSDATE-23/24)
                                         AND SEND_SMS_NOTICE_END_MONTH_LOG.ERROR_TEXT IS NULL
                                );     
    --
    CURSOR BL (ID INTEGER) IS
        SELECT ACCOUNTS.DO_BALANCE_NOTICE_MONTH
        FROM ACCOUNTS
        WHERE ID=ACCOUNTS.ACCOUNT_ID;
    --
    vBL BL%ROWTYPE;
    SMS VARCHAR2(2000); 
    SMS_TXT VARCHAR2(500);
    MM INTEGER;
    MONTH_NAME VARCHAR2(20);
    NEXT_MONTH_NAME varchar2(20);
    LAST_DAY_MONTH varchar2(20); 
    --
BEGIN
    --отправляем в 2 последних дня месяца
    IF TO_CHAR(SYSDATE+pDAY, 'MM')<>TO_CHAR(SYSDATE, 'MM') THEN 
        --отправляем с 9 до 21 часа 
        IF ((SYSDATE-TRUNC(SYSDATE) > 9/24) and (SYSDATE-TRUNC(SYSDATE) < 21/24)) THEN 
            --определяем количество дней до начала нового месяца
            IF TO_CHAR(SYSDATE+1, 'MM')<>TO_CHAR(SYSDATE, 'MM') THEN
                DAY_NOTICE := 1;
            ELSE
                DAY_NOTICE := 2;
            END IF;
            --
            FOR vREC IN C
            LOOP
                OPEN BL(vREC.ACCOUNT_ID);
                FETCH BL INTO vBL;
                CLOSE BL; 
                --если имеется признак автоматической рассылки смс о конце месяца              
                IF vBL.DO_BALANCE_NOTICE_MONTH=1 THEN
                    --если сумма рекомендуемого платежа больше 50, то отправляем смс
                    IF vREC.RECOMEND_SUMM > 0 THEN
                        NEXT_MONTH_NAME := 
                            CASE TO_CHAR(SYSDATE+pDAY,'MM')
                                WHEN '01' THEN 'январь'
                                WHEN '02' THEN 'февраль'
                                WHEN '03' THEN 'март'
                                WHEN '04' THEN 'апрель'
                                WHEN '05' THEN 'май'
                                WHEN '06' THEN 'июнь'
                                WHEN '07' THEN 'июль'
                                WHEN '08' THEN 'август'
                                WHEN '09' THEN 'сентябрь'
                                WHEN '10' THEN 'октябрь'
                                WHEN '11' THEN 'ноябрь'
                                WHEN '12' THEN 'декабрь'
                            END;
                        LAST_DAY_MONTH:=to_char(last_day(sysdate),'dd.mm.yy');
                        SMS_TXT:=REPLACE(vREC.NEXT_MONTH_NOTICE_TEXT,'%month%',NEXT_MONTH_NAME);
                        SMS_TXT:=REPLACE(sms_txt,'%date%',LAST_DAY_MONTH);
                        SMS_TXT:=REPLACE(sms_txt,'%summa%',vREC.RECOMEND_SUMM);
                        SMS:=LOADER3_pckg.SEND_SMS(vREC.PHONE_NUMBER_FEDERAL,
                                                                          'СМС-Оповещение',
                                                                          SMS_TXT);   --текст предупреждения
                        INSERT INTO SEND_SMS_NOTICE_END_MONTH_LOG 
                            (
                                phone_number,
                                ABONENT_FIO,
                                SEND_DATE_TIME,
                                ERROR_TEXT
                            ) 
                        VALUES 
                            (
                                vREC.PHONE_NUMBER_FEDERAL,
                                vREC.FIO,
                                SYSDATE,
                                SMS
                            );
                      --  DBMS_LOCK.SLEEP(2);  
                        COMMIT;
                    END IF;
                END IF;  
            END LOOP; 
        END IF;  
    END IF;
END;
/
