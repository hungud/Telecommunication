
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."P_TELETIE_PAY_SMS" is

  --Version 4
  --
  --v.4 23.03.2016 Алексеев. Для переводов по мобиденьгам (IS_MOBI_PAY) отправляем другой текст смс.
  --v.3 03.02.2016 Алексеев. Доп. информация отправляется только на номера с тарифами Драйв и тарифов с автоподкючением пакетов
  --v.2 03.02.2016 Алексеев. Для номеров, по которым был разблок благодаря платежу, добавил в смс текст "Для корректной работы интернета необходимо перезагрузить устройство."
  --                                      Привел код в читабельный вид
  --v1 Неизвестный исполнитель.
  
  sms varchar2(1000);
  pSmsDop varchar2(100 char);
  pTxtSms varchar2(500 char);
  pCount integer;
  pCntTariffs integer;
  pDate date;
begin
  update TELETIE_PAY_LOG pl 
       set pl.sms_send=0 --установить флажок, что смс-ка не нужна
  where pl.ssign is null --без токена
        or pl.http_answer!='200 Ok' --с плохим запросом
        or pl.res is not null --с ошибкой
        or pl.date_insert<sysdate-1; -- старше суток
  --фиксируем        
  commit;
  
  --отправка смс о зачислении
  for c in (
                 select 
                     distinct pl.phonenr,
                     pl.amount,
                     pl.numpay,
                     CT.TARIFF_ID,
                     PL.IS_MOBI_PAY
                   from teletie_pay_log pl, 
                           db_loader_account_phones ph, 
                           contracts ct
                 where ph.phone_number=pl.phonenr 
                     and ph.year_month in (to_char(sysdate,'YYYYMM'),to_char(sysdate-1,'YYYYMM'))
                     and ph.phone_number=ct.phone_number_federal
                     and not exists(
                                             select 1 
                                               from contract_cancels cc 
                                             where ct.contract_id=cc.contract_id
                                         )
                     and pl.sms_send is null
                     and pl.res is null
                     and pl.http_answer='200 Ok'
                     and nvl(ph.phone_is_active, 0)=1
                     and (trunc(sysdate)+nvl(to_number(regexp_substr(ct.paramdisable_sms,'\d,\d+',1,1)),0))<=sysdate
                     and (trunc(sysdate)+nvl(to_number(regexp_substr(ct.paramdisable_sms,'\d,\d+',1,2)),1))>=sysdate
            ) 
  loop
    pTxtSms := '';
    pSmsDop := '';
    pCount := 0;
    pCntTariffs := 0;
    --для номеров, по которым был разблок благодаря платежу в смс указываем доп. информацию
    begin
      --проверяем на принадлежность к необходимым тарифам
      select count(*)
         into pCntTariffs
        from tariffs tr
      where TR.TARIFF_ID = C.TARIFF_ID
          and (
                    (TR.TARIFF_NAME LIKE 'Драйв%')
                    or
                    (nvl(TR.IS_AUTO_INTERNET, 0) = 1)
                );
                  
      --если по тарифам подходит, то идем дальше
      if nvl(pCntTariffs, 0) > 0 then            
        --т.к. выборка идет по distinct, то учитывая дату, записей может быть больше, если платежи повторились
        --чтобы не отсылать лишних смс, берем максимальную дату вставки
        select max(LG.DATE_INSERT)
           into pDate
          from teletie_pay_log lg
        where LG.PHONENR = c.phonenr
            and lg.amount = c.amount
            and lg.numpay = c.numpay;

        --проверяем наличие заявки на разблок с датой превышающей дату платежа
        select count(*)
           into pCount 
          from beeline_tickets bt 
        where bt.phone_number=c.phonenr
            and bt.ticket_type=10 --разблокировка
            and bt.date_create > pDate;
      end if;
    exception
      when others then
        pCount := 0;   
    end;
      
    --если заявка на разблок есть и это не перевод мобиденег, то добавляем доп. информацию в смс
    if (nvl(pCount, 0) > 0) and (nvl(c.IS_MOBI_PAY, 0) = 0) then
      pSmsDop := 'Для корректной работы интернета необходимо перезагрузить устройство.';
    end if;
    
    --определяем текст смс
    if nvl(c.IS_MOBI_PAY, 0) = 0 then
      pTxtSms := 'Платёж на сумму '||c.amount||' руб. зачислен. '||pSmsDop;
    else
      pTxtSms := 'Сумма в размере '||abs(c.amount)||' руб. переведена с вашего баланса.';
    end if;
    
    --отправка смс
    sms:=null;
    sms:=loader3_pckg.SEND_SMS(pPHONE_NUMBER =>c.phonenr
                                                  ,pMAILING_NAME =>'TELETIE_PAY_SMS'
                                                  ,pSMS_TEXT =>pTxtSms
                                                  ,pSENDER_NAME => 'TELETIE');

    update TELETIE_PAY_LOG pl 
         set pl.sms_send=1 
    where pl.phonenr=c.phonenr
        and pl.numpay=c.numpay
        and pl.amount=c.amount
        and pl.sms_send is null
        and sms is null; -- смс отправлена без ошибок
    --фиксируем
    commit;                            
  end loop;                                     
end P_TELETIE_PAY_SMS;