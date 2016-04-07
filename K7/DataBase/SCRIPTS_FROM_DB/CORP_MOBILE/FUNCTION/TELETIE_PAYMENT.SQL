
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."TELETIE_PAYMENT" (phonenr     IN VARCHAR2, --номер абонента
                                           amount      IN VARCHAR2, --сумма платежа 
                                           numpay      IN VARCHAR2, --номер платежа 
                                           paycom      IN VARCHAR2, --комментарий платежа 
                                           ssign       IN VARCHAR2, --sign 
                                           HTTP_ANSWER out VARCHAR2,
                                           pMobiPay    IN INTEGER DEFAULT 0) 
  RETURN VARCHAR2 IS 
--
--#Version=5
--
--v.5 Алексеев 22.03.2016 Добавил запись признака списания мобиденег в поле IS_MOBI_PAY таблицы teletie_pay_log.
--v.4 Алексеев 17.03.2016 Добавил дефолтный параметр pMobiPay, который передается в db_loader_pckg.ADD_PAYMENT.
--                        Если параметр = 1, то это списание по мобиденьгам.
--                       Текущая функция будет вызываться с параметром =1 в ссылке, которая дергается на стороне клиента.
--v.3 Афроси 05.05.2015 Добавил получение лоигна в зависимости от номера телефона nvl(get_login_by_phone(phonenr), 'A4582633'); 
--v2. Назин. Добавил смс-уведомления. 


  urls   VARCHAR2(2000); 
  res    VARCHAR2(2000); 
  SQLres    VARCHAR2(2000); 
  psign    VARCHAR2(2000); 
  flag   integer; 
  slogin varchar2(30); 
  summ   number; 
  spaycom varchar2(200); 

BEGIN 

  if paycom is not null then 
     spaycom:=UTL_URL.unescape(translate(paycom, '+', ' '), 'CL8MSWIN1251'); --UTF8 
  else 
    spaycom:=null; 
  end if;
   
  if phonenr is not null then 
    summ := to_number(amount, 
                      '999999D99', 
                      ' NLS_NUMERIC_CHARACTERS = ''.,''');
                       
    urls := 'teletiepay.php?phonenr=' || phonenr || '&' || 'amount=' || 
            amount || '&' || 'numpay=' || numpay|| '&' || 'paycom=' || paycom|| 
                      MS_params.GET_PARAM_VALUE('TELETIE_PAY_PASSWORD'); 
             
    psign := gnuhash_sha512(urls);
      
    if ssign = psign then 
      select count(*) 
        into flag 
        from DB_LOADER_PAYMENTS dlp 
       where dlp.phone_number = phonenr 
         and dlp.payment_number = numpay 
         and SIGN(dlp.payment_sum) = SIGN(summ);
          
      if flag = 0 then 
        slogin :=  nvl(get_login_by_phone(phonenr), 'A4582633'); --'A4582633';--get_login_by_phone(phonenr);
         
        if slogin is not null then 
          db_loader_pckg.ADD_PAYMENT(to_number(to_char(sysdate, 'yyyy')), 
                                     to_number(to_char(sysdate, 'mm')), 
                                     slogin, 
                                     phonenr, 
                                     trunc(sysdate), 
                                     summ, 
                                     numpay, 
                                     1, 
                                     'TELETIE '||spaycom,
                                     nvl(pMobiPay,0)); 
          HTTP_ANSWER := '200 Ok'; 
          --res         := loader3_pckg.SEND_SMS(phonenr,'TELETIE_PAY_SMS','Платёж на сумму '||summ||' руб. зачислен.'); 
  --          res         := loader3_pckg.SEND_SMS(pPHONE_NUMBER =>phonenr, pMAILING_NAME =>'TELETIE_PAY_SMS', pSMS_TEXT =>'Платёж на сумму '||summ||' руб. зачислен.', pSENDER_NAME => 'TELETIE'); 
  --СМС-сообщения теперь рассылает JOB J_TELETIE_PAY_SMS
          res:=''; 
        else 
          HTTP_ANSWER := '400 Error: Incorrect phone!'; 
          res         := 'Error: Incorrect phone!'; 
        end if; 
      else 
        HTTP_ANSWER := '400 Error: Payment already exists!'; 
        res         := 'Error: Payment already exists!'; 
      end if; 
    else 
      HTTP_ANSWER := '400 Error: Incorrect sign!'; 
      res         := ' Error: Incorrect sign'; 
    end if; 
     
    insert into teletie_pay_log
      (phonenr, amount, numpay, ssign, http_answer, res, date_insert, paycom, sms_send, IS_MOBI_PAY)
    values
        (phonenr, summ, numpay, ssign, HTTP_ANSWER, res, null,spaycom,null, pMobiPay); 
    commit; 
  else 
    HTTP_ANSWER := '400 Error: Parameter is not passed!'; 
    RES         := 'Parameter is not passed!'; 
  end if; 
  RETURN RES; 
EXCEPTION 
  WHEN others THEN 
    SQLres:=SQLERRM; 
    HTTP_ANSWER := '500 Error on the server side, partner!'; 
    res         := 'Error on the server side, partner!'; 
    insert into teletie_pay_log 
      (phonenr, amount, numpay, ssign, http_answer, res, date_insert, paycom, sms_send, IS_MOBI_PAY)
    values 
      (phonenr, summ, numpay, ssign, HTTP_ANSWER, res||' ('||SQLres||')', null,spaycom,null, pMobiPay); 
    commit; 
    RETURN RES; 
END;