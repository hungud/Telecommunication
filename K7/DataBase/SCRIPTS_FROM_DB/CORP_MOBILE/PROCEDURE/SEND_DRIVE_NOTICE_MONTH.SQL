
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SEND_DRIVE_NOTICE_MONTH" is

  --Version 2
  --
  --v2. Алексеев. 22.10.2015 Расширил отправку смс и в предпредпоследний день месяца. 
  --                                      Т.е. смс отправляем в последние 3 дня месца. 
  --                                      Изменил текст смс на 2 крайних дня месяца.
  --v1. Крайнов.

  shab varchar2(500 char);
  sms_text varchar2(500 char);
  month_name varchar2(20 char);
  v varchar2(500 char);
begin
  --отправляем в последние 3 дня месяца
  if (to_char(sysdate + 3, 'yyyymm') = to_char(add_months(sysdate, 1), 'yyyymm'))  then   
    --текст смс
    if (to_char(sysdate + 3, 'yyyymmdd') = to_char(add_months(sysdate, 1), 'yyyymm')||'01') then --смс в предпредпоследний день месяца         
      shab := 'Уважаемый Абонент! %new_date% спишется абон. плата за %month_name% - %abon_sum%руб. Не забудьте пополнить баланс. Подробности по тел.: +74997090202.';
    else --смс в последние 2 дня месяца
      shab := 'Уважаемый Абонент! %new_date% спишется абон. плата за %month_name% - %abon_sum% руб. Минимальный рекомендуемый платеж %rec_pay% руб. При недостатке суммы на балансе номер будет заблокирован %cur_date%. Тел.: +74997090202.';   
    end if;
    
    month_name := 
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
      
    shab:= replace(shab, '%new_date%', '01.'||to_char(add_months(sysdate, 1), 'mm.yyyy'));    
    shab:=replace(shab, '%month_name%', month_name);     
    
    --в качестве даты блокировки указываем крайний день месяца
    if (to_char(sysdate + 1, 'yyyymmdd') = to_char(add_months(sysdate, 1), 'yyyymm')||'01') or 
       (to_char(sysdate + 2, 'yyyymmdd') = to_char(add_months(sysdate, 1), 'yyyymm')||'01') then
       shab:= replace(shab, '%cur_date%', to_char((trunc(add_months(sysdate, 1), 'MM') - 1), 'DD.MM.YYYY')); 
    end if;  
    
    for rec in (select * 
                     from v_drave_info)
    loop
      --указываем абонку
      sms_text:=replace(shab, '%abon_sum%', to_char(rec.MONTHLY_PAYMENT));
      --если идет крайний или предпоследний день месяца
      if (to_char(sysdate + 1, 'yyyymmdd') = to_char(add_months(sysdate, 1), 'yyyymm')||'01') or
         (to_char(sysdate + 2, 'yyyymmdd') = to_char(add_months(sysdate, 1), 'yyyymm')||'01') then
        sms_text:=replace(sms_text, '%rec_pay%', to_char(trunc(rec.MONTHLY_PAYMENT - GET_ABONENT_BALANCE(rec.PHONE_NUMBER_FEDERAL))+1));     
      end if;  
            
      v:=loader3_pckg.SEND_SMS(rec.PHONE_NUMBER_FEDERAL, 'Teletie', sms_text);
    end loop;     
  end if;
end;