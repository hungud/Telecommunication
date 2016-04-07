
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SEND_DRIVE_NITICE_MONTH" is
shab varchar2(200 char);
sms_text varchar2(200 char);
month_name varchar2(20 char);
v varchar2(500 char);
begin
  shab:='Уважаемый Абонент! %new_date% спишется абон. плата за %month_name% - %abon_sum%руб. Не забудьте пополнить баланс. Подробности по тел.: +74997090202.';
  if to_char(sysdate + 3, 'yyyymmdd') = to_char(add_months(sysdate, 1), 'yyyymm')||'01' 
      or to_char(sysdate + 1, 'yyyymmdd') = to_char(add_months(sysdate, 1), 'yyyymm')||'01' then   
    month_name:= case
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
    for rec in (select * 
                  from v_drave_info)
    loop
      sms_text:=replace(shab, '%abon_sum%', to_char(rec.MONTHLY_PAYMENT));
      v:=loader3_pckg.SEND_SMS(rec.PHONE_NUMBER_FEDERAL, 'Teletie', sms_text);
    end loop;     
  end if;
end; 