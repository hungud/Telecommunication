CREATE OR REPLACE procedure SEND_SMS_PHN_WITH_REPRIEVE_AP IS
    
    --Version 3
    --
    --v3. 29.12.2015. Алексеев. Поправил ошибку в запросе, вместо VC.CONTRACT_DATE необходимо было написать V.CONTRACT_DATE
    --v2. 17.12.2015. Алексеев. Логика разделена для новых контрактов и для старых контрактов по дням отправки.
    --                                       Определяем максимальное значение дня, по который отправляем в зависимости от параметров
    --                                       DAY_BLOCK_PHN_CALC_ABON_TP_UNLIM_NEW_PHN для новых контрактов
    --                                       DAY_BLOCK_PHN_CALC_ABON_TP_UNLIM_OLD_PHN для старых контрактов
    --v1. 30.06.2015. Алексеев. Процедура отправки смс о списании абонки на номера с отсрочкой абонки (отправляются 1 и 2 числа)
    
    shab varchar2(500 char);
    shabVs varchar2(500 char);   
    pCountPh integer;
    vSpeedSendSms integer;
    pLastMin integer;
    vRes integer;
    vDay_New integer;
    vDay_Old integer;
    vDay integer;
    
    PROCEDURE SEND_SMS_ABON (pShab in varchar2, pShabVs in varchar2, pDay_New integer, pDay_Old integer, pNumRow in integer default 0) IS
        --процедура пробегает по отобранным номерам и отправляет смс
        v varchar2(500 char);
        sms_text varchar2(500 char);
        curnm sys_refcursor;
        str varchar2(100 char);
        v_phone varchar2(10 char);
        v_tariff_name varchar2(100 char);
        v_monthly_payment NUMBER(15,2);
    BEGIN
        --определяем стоит ли отсекать выборку
        if pNumRow = 0 then
            str := '';
        else
            str := ' and ROWNUM <= '||to_char(pNumRow);
        end if;
        -- пробегаем по всем номерам из таблицы CALL
        open curnm for 'select 
                                    v.PHONE_NUMBER_FEDERAL, 
                                    v.TARIFF_NAME,
                                    v.MONTHLY_PAYMENT
                                from V_PHN_UNL_INET_WITH_REPRI_ABON v
                                where (
                                            (
                                              (to_number(TO_CHAR(ADD_MONTHS(V.CONTRACT_DATE, 1), ''YYYYMM'')) = to_number(to_char(sysdate, ''YYYYMM''))) 
                                              AND
                                              (to_number(to_char(sysdate, ''DD'')) <= :pDay_New)
                                            )
                                            OR
                                            (
                                              (to_number(TO_CHAR(ADD_MONTHS(V.CONTRACT_DATE, 1), ''YYYYMM'')) <> to_number(to_char(sysdate, ''YYYYMM''))) 
                                              AND
                                              (to_number(to_char(sysdate, ''DD'')) <= :pDay_Old)
                                            )
                                          )
                                    and not exists
                                                    (
                                                        select 1
                                                        from LOG_SEND_SMS sm
                                                        where SM.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                                                        and SM.NOTE is null
                                                        and trunc(SM.DATE_SEND) = trunc(sysdate)
                                                        and SM.SMS_TEXT like :pshabVs
                                                    ) '||str using pDay_New, pDay_Old, pshabVs;
        loop
            FETCH curnm INTO v_phone, v_tariff_name, v_monthly_payment;
            EXIT WHEN curnm%NOTFOUND;  
            --проверим что баланс с учетом дискретного списания меньше или равен 0
            IF (GET_ABONENT_BALANCE(v_phone, null, null, 1) <= 0) THEN        
                sms_text:=replace(pshab, '%bal%', to_char(GET_ABONENT_BALANCE(v_phone, null, null, 1)));  
                sms_text:=replace(sms_text, '%tar%', v_tariff_name);
                sms_text:=replace(sms_text, '%abon_sum%', to_char(v_monthly_payment));
                --       
                v:=loader3_pckg.SEND_SMS(v_phone, 'Teletie', sms_text);
            END IF;
        end loop;
    END;
  
BEGIN
    --логика разделена для новых контрактов и для старых контрактов по дням отправки
    --определяем максимальное значение дня, по который отправляем
    vDay_New := to_number(MS_params.GET_PARAM_VALUE('DAY_BLOCK_PHN_CALC_ABON_TP_UNLIM_NEW_PHN')); --новые
    vDay_Old := to_number(MS_params.GET_PARAM_VALUE('DAY_BLOCK_PHN_CALC_ABON_TP_UNLIM_OLD_PHN')); --старые
    
    --определяем максимальный день
    if vDay_New > vDay_Old then
      vDay := vDay_New;
    else
      vDay := vDay_Old;
    end if;
    
    --отправляем максимальный день отправки
    if (to_number(to_char(sysdate, 'dd')) <= vDay) then         
        --отсылаем смс в период с 10 до 16 (после 1 срабатывания в 16 часов отключаем процедуру). В течении часа процедура будет работать и искать номера (на случай стопов)
        if (to_number(to_char(sysdate, 'HH24')) = 10)  then
            --признаку работы процедуры присваиваем 1
            vRes := MS_params.SET_PARAM_VALUE('CHECK_WORK_PROC_SEND_SMS_PHN_PEPR_ABON', 1); --работаем
        end if;
        
        if (to_number(to_char(sysdate, 'HH24')) >= 10) and
           (to_number(MS_params.GET_PARAM_VALUE('CHECK_WORK_PROC_SEND_SMS_PHN_PEPR_ABON')) = 1) then
            --текст смс: Баланс: %bal% руб., списана абон.плата по тарифу %tar% на сумму %abon_sum%. Во избежание блокировки необходимо пополнить баланс!
            shab:=MS_params.GET_PARAM_VALUE('TXT_SMS_4_PHONE_WITH_REPRIEVE_ABON');
                
            --шаблон для поиска
            shabVs := replace(shab, '%bal%', '%');
            shabVs := replace(shabVs, '%tar%', '%');
            shabVs := replace(shabVs, '%abon_sum%', '%');
            --определяем количество номеров, которые необходимо отправить
            --отсекаем те, по которым смс были уже отправлены за сегодняшний день
            select count(*)
            into pCountPh
            from V_PHN_UNL_INET_WITH_REPRI_ABON v
            where not exists
                                (
                                    select 1
                                    from LOG_SEND_SMS sm
                                    where SM.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                                    and SM.NOTE is null
                                    and trunc(SM.DATE_SEND) = trunc(sysdate)
                                    and SM.SMS_TEXT like shabVs
                                )
                and (
                        (
                          (to_number(TO_CHAR(ADD_MONTHS(V.CONTRACT_DATE, 1), 'YYYYMM')) = to_number(to_char(sysdate, 'YYYYMM'))) 
                          AND
                          (to_number(to_char(sysdate, 'DD')) <= vDay_New)
                        )
                        OR
                        (
                          (to_number(TO_CHAR(ADD_MONTHS(V.CONTRACT_DATE, 1), 'YYYYMM')) <> to_number(to_char(sysdate, 'YYYYMM'))) 
                          AND
                          (to_number(to_char(sysdate, 'DD')) <= vDay_Old)
                        )
                      );                                
                                
            --отсылаем если количество смс > 0
            if pCountPh > 0 then  
                --проверяем во сколько срабатывает процедура. Если это уже 16 часов, то отсылаем все что осталось и отключаем выполнение процедуры
                if (to_number(to_char(sysdate, 'HH24')) < 16) then
                    --после обсуждений с клиентом, за норму отправки смс в минуту было принято 14 смс.
                    --если количество смс < 14, то отправляем сразу все
                    if pCountPh <= 14 then
                        --отсылаем все смс сразу
                        SEND_SMS_ABON(shab, shabVs, vDay_New, vDay_Old);   
                        --отключаем выполнение процедуры
                        vRes := MS_params.SET_PARAM_VALUE('CHECK_WORK_PROC_SEND_SMS_PHN_PEPR_ABON', 0); --НЕ работаем 
                    else
                        --количество оставшихся минут
                        pLastMin := trunc(((trunc(sysdate) + 16/24) - sysdate)*24*60);
                        
                        if pLastMin > 0 then --по идеи никогда не будет отрицательным, т.к. выше стоит проверка по времени (to_number(to_char(sysdate, 'HH24')) < 16)
                            --считаем скорость отправки смс 
                            --количество смс делим на количество оставшихся минут
                            vSpeedSendSms := round(pCountPh/pLastMin);
                            --если количество смс, которые можно отправить за необходимый период меньше 14, то отсылаем по 14 смс в минуту
                            --иначе отсылаем со скоростью которая получилась
                            if vSpeedSendSms <= 14 then
                                --отсылаем по 14 смс
                                SEND_SMS_ABON(shab, shabVs, vDay_New, vDay_Old, 14);    
                            else
                                --отсылаем по скорости которую определили
                                SEND_SMS_ABON(shab, shabVs, vDay_New, vDay_Old, vSpeedSendSms);                 
                            end if;
                        end if;            
                    end if;                
                else
                    --отсылаем все смс сразу
                    SEND_SMS_ABON(shab, shabVs, vDay_New, vDay_Old);                    
                    --отключаем выполнение процедуры
                    vRes := MS_params.SET_PARAM_VALUE('CHECK_WORK_PROC_SEND_SMS_PHN_PEPR_ABON', 0); --НЕ работаем   
                end if;
            else --если количество номеров = 0, то отключаем выполнение процедуры
                vRes := MS_params.SET_PARAM_VALUE('CHECK_WORK_PROC_SEND_SMS_PHN_PEPR_ABON', 0); --НЕ работаем     
            end if;
        end if; 
    end if;
END;