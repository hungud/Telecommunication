create or replace procedure P_TELETIE_PAY_SMS is
sms varchar2(1000);
begin
update TELETIE_PAY_LOG pl set pl.sms_send=0 --установить флажок, что смс-ка не нужна
                          where pl.ssign is null --без токена
                             or pl.http_answer!='200 Ok' --с плохим запросом
                             or pl.res is not null --с ошибкой
                             or pl.date_insert<sysdate-1; -- старше суток
commit;
for c in (select distinct pl.phonenr,pl.amount,pl.numpay
          from teletie_pay_log pl, db_loader_account_phones ph , contracts ct
            where ph.phone_number=pl.phonenr and ph.year_month in (to_char(sysdate,'YYYYMM'),to_char(sysdate-1,'YYYYMM'))
            and ph.phone_number=ct.phone_number_federal
            and not exists(select 1 from contract_cancels cc where ct.contract_id=cc.contract_id)
            and pl.sms_send is null
            and pl.res is null
            and pl.http_answer='200 Ok'
            and ph.phone_is_active=1
            and (trunc(sysdate)+nvl(to_number(regexp_substr(ct.paramdisable_sms,'\d,\d+',1,1)),0))<=sysdate
            and (trunc(sysdate)+nvl(to_number(regexp_substr(ct.paramdisable_sms,'\d,\d+',1,2)),1))>=sysdate
         ) loop
  sms:=null;
  sms:=loader3_pckg.SEND_SMS(pPHONE_NUMBER =>c.phonenr
                            ,pMAILING_NAME =>'TELETIE_PAY_SMS'
                            ,pSMS_TEXT =>'Платёж на сумму '||c.amount||' руб. зачислен.'
                            ,pSENDER_NAME => 'TELETIE');

  update TELETIE_PAY_LOG pl set  pl.sms_send=1 
                            where pl.phonenr=c.phonenr
                            and pl.numpay=c.numpay
                            and pl.amount=c.amount
                            and pl.sms_send is null
                            and sms is null-- смс отправлена без ошибок
                            ;
commit;                            
end loop;                                     


end P_TELETIE_PAY_SMS;
/
