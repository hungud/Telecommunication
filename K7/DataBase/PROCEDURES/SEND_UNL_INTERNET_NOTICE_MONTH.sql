CREATE OR REPLACE procedure SEND_UNL_INTERNET_NOTICE_MONTH is

    --Version 5
    --
    --v.5 01.02.2016. Алексеев. Изменил текст смс, которое отправляется в последний и предпоследний дни месяца.
    --v4. 22.10.2015. Алексеев. По просьбе клиента смс теперь отправляем и в предпоследний день месяца.
    --                                       Т.е. шлем 3 последних дня месяца. В предпосл. день смс такое же как и в последний.
    --v3. 29.06.2015. Алексеев. Изменен текст смс, отправляемое в последний день месяца
    --v2. 17.04.2015. Алексеев. Растянул отправку смс по времени
    --v1. 16.04.2015. Алексеев. Процедура отправки смс о списание абон платы для номеров с безлимитным интернетом, у которых баланс меньше абонки
    
    shab varchar2(500 char);
    shabVs varchar2(500 char);   
    month_name varchar2(20 char);
    pCountPh integer;
    vSpeedSendSms integer;
    pLastMin integer;
    vRes integer;
    
    PROCEDURE SEND_SMS_ABON (pShab in varchar2, pShabVs in varchar2, pNumRow in integer default 0) IS
        --процедура пробегает по отобранным номерам и отправляет смс
        v varchar2(500 char);
        sms_text varchar2(500 char);
        curnm sys_refcursor;
        str varchar2(100 char);
        v_phone varchar2(10 char);
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
                                    v.MONTHLY_PAYMENT
                                from V_PHONE_UNL_INET_BAL_LESS_ABON v
                                where not exists
                                                    (
                                                        select 1
                                                        from LOG_SEND_SMS sm
                                                        where SM.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                                                        and SM.NOTE is null
                                                        and trunc(SM.DATE_SEND) = trunc(sysdate)
                                                        and SM.SMS_TEXT like :pshabVs
                                                    ) '||str using pshabVs;
        loop
            FETCH curnm INTO v_phone, v_monthly_payment;
            EXIT WHEN curnm%NOTFOUND;          
            sms_text:=replace(pshab, '%abon_sum%', to_char(v_monthly_payment));  
            --если идет крайний или предпоследний день месяца
            if (to_char(sysdate + 1, 'yyyymmdd') = to_char(add_months(sysdate, 1), 'yyyymm')||'01') or
               (to_char(sysdate + 2, 'yyyymmdd') = to_char(add_months(sysdate, 1), 'yyyymm')||'01') then
                sms_text:=replace(sms_text, '%rec_pay%', to_char(trunc(v_monthly_payment - GET_ABONENT_BALANCE(v_phone))+1));     
            end if;          
            v:=loader3_pckg.SEND_SMS(v_phone, 'Teletie', sms_text);
        end loop;
    END;
  
BEGIN
    --отправляем только в последние 3 деня месяца
    if to_char(sysdate + 3, 'yyyymm') = to_char(add_months(sysdate, 1), 'yyyymm') then    
         
        --отсылаем смс в период с 10 до 16 (после 1 срабатывания в 16 часов отключаем процедуру). В течении часа процедура будет работать и искать номера (на случай стопов)
        if (to_number(to_char(sysdate, 'HH24')) = 10)  then
            --признаку работы процедуры присваиваем 1
            vRes := MS_params.SET_PARAM_VALUE('CHECK_NEED_WORK_PROC_SEND_UNL_INTERNET', 1); --работаем
        end if;
        
        if (to_number(to_char(sysdate, 'HH24')) >= 10) and
           (to_number(MS_params.GET_PARAM_VALUE('CHECK_NEED_WORK_PROC_SEND_UNL_INTERNET')) = 1) then
            --текст смс
            if (to_char(sysdate + 3, 'yyyymmdd') = to_char(add_months(sysdate, 1), 'yyyymm')||'01') then --смс в предпредпоследний день месяца
                shab:='Уважаемый Абонент! %new_date% будет списана абон. плата по тарифу за %month_name% - %abon_sum% руб. Во избежании блокировки, пополняйте баланс заранее. Подробности: +74997090202.';
            else
                --рекомендуемый платеж: (абон.плата - баланс), полученная разность с округлением до рубля в большую сторону
                shab:='Уважаемый Абонент! %new_date% спишется абон. плата за %month_name% - %abon_sum% руб. Минимальный рекомендуемый платеж %rec_pay% руб. При недостатке суммы на балансе номер может быть заблокирован %cur_date%. Тел.: +74997090202.';
            end if;
            --определяем месяц, по которому необходимо заплатить абонку
            month_name:= 
                case
                    when to_char(sysdate, 'mm') = '01' then 'февраль'
                    when to_char(sysdate, 'mm') = '02' then 'март'
                    when to_char(sysdate, 'mm') = '03' then 'апрель'
                    when to_char(sysdate, 'mm') = '04' then 'май'
                    when to_char(sysdate, 'mm') = '05' then 'июнь'
                    when to_char(sysdate, 'mm') = '06' then 'июль'
                    when to_char(sysdate, 'mm') = '07' then 'август'
                    when to_char(sysdate, 'mm') = '08' then 'сентябрь'
                    when to_char(sysdate, 'mm') = '09' then 'октябрь'
                    when to_char(sysdate, 'mm') = '10' then 'ноябрь'
                    when to_char(sysdate, 'mm') = '11' then 'декабрь'
                    when to_char(sysdate, 'mm') = '12' then 'январь'
                    else ''
                end;
            --замена шаблонов
            shab:= replace(shab, '%new_date%', '01.'||to_char(add_months(sysdate, 1), 'mm.yyyy'));    
            shab:= replace(shab, '%month_name%', month_name);
            --если это последний или предпоследний  день месяца, то указываем дату последнего дня месяца
            if (to_char(sysdate + 1, 'yyyymmdd') = to_char(add_months(sysdate, 1), 'yyyymm')||'01') or
               (to_char(sysdate + 2, 'yyyymmdd') = to_char(add_months(sysdate, 1), 'yyyymm')||'01') then
                shab:= replace(shab, '%cur_date%', to_char((trunc(add_months(sysdate, 1), 'MM') - 1), 'DD.MM.YYYY')); 
            end if;
                
            --шаблон для поиска
            shabVs := replace(shab, '%abon_sum%', '%');
            if (to_char(sysdate + 1, 'yyyymmdd') = to_char(add_months(sysdate, 1), 'yyyymm')||'01') or
               (to_char(sysdate + 2, 'yyyymmdd') = to_char(add_months(sysdate, 1), 'yyyymm')||'01') then
                shabVs := replace(shabVs, '%rec_pay%', '%');
            end if;
            --определяем количество номеров, которые необходимо отправить
            --отсекаем те, по которым смс были уже отправлены за сегодняшний день
            select count(*)
            into pCountPh
            from V_PHONE_UNL_INET_BAL_LESS_ABON v
            where not exists
                                (
                                    select 1
                                    from LOG_SEND_SMS sm
                                    where SM.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                                    and SM.NOTE is null
                                    and trunc(SM.DATE_SEND) = trunc(sysdate)
                                    and SM.SMS_TEXT like shabVs
                                );
                                
            --отсылаем если количество смс > 0
            if pCountPh > 0 then  
                --проверяем во сколько срабатывает процедура. Если это уже 16 часов, то отсылаем все что осталось и отключаем выполнение процедуры
                if (to_number(to_char(sysdate, 'HH24')) < 16) then
                    --после обсуждений с клиентом, за норму отправки смс в минуту было принято 14 смс.
                    --если количество смс < 14, то отправляем сразу все
                    if pCountPh <= 14 then
                        --отсылаем все смс сразу
                        SEND_SMS_ABON(shab, shabVs);   
                        --отключаем выполнение процедуры
                        vRes := MS_params.SET_PARAM_VALUE('CHECK_NEED_WORK_PROC_SEND_UNL_INTERNET', 0); --НЕ работаем 
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
                                SEND_SMS_ABON(shab, shabVs, 14);    
                            else
                                --отсылаем по скорости которую определили
                                SEND_SMS_ABON(shab, shabVs, vSpeedSendSms);                 
                            end if;
                        end if;            
                    end if;                
                else
                    --отсылаем все смс сразу
                    SEND_SMS_ABON(shab, shabVs);                    
                    --отключаем выполнение процедуры
                    vRes := MS_params.SET_PARAM_VALUE('CHECK_NEED_WORK_PROC_SEND_UNL_INTERNET', 0); --НЕ работаем   
                end if;
            else --если количество номеров = 0, то отключаем выполнение процедуры
                vRes := MS_params.SET_PARAM_VALUE('CHECK_NEED_WORK_PROC_SEND_UNL_INTERNET', 0); --НЕ работаем     
            end if;
        end if; 
    end if;
END;