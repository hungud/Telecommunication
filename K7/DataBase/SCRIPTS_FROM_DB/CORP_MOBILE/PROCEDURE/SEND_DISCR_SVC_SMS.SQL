
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SEND_DISCR_SVC_SMS" is
--
-- 2015-03-31 12:25 - А.Ларин - строка 44 - добавлено ограничение на рассылку сообщений для тарифных опций авто-инетрнет, сообщение будет отослано если IS_AUTO_INTERNET = 0
--#Version=1
--
 vYear_Month number:=to_char(sysdate,'YYYYMM');
  SMS      VARCHAR2(500 CHAR);
  SMS_TEXT VARCHAR2(500 CHAR);
  i number:=0;
   CURSOR C IS

select a.phone_number ,
       a.option_code,
       a.option_name,
       d.begin_date,
       d.end_date,
       b.OPTION_NAME_FOR_AB,
       d.monthly_cost,
       CB.BALANCE,
       CASE
        WHEN NVL(L.PHONE_NUMBER,0) = 0
               THEN
                  0
               ELSE
                  1
            END SENDING,
       'У Вас подключены опции:'||a.option_code||'. '||(LAST_DAY(trunc(sysdate)) + 1)||' будет списана сумма '||d.monthly_cost ,
'Уважаемый абонент! '||(LAST_DAY(trunc(sysdate)) + 1)||' произойдет списание за услугу "'
||b.OPTION_NAME_FOR_AB||'" - '||d.monthly_cost||' руб. Ваш текущий баланс ' || replace(to_char(CB.BALANCE,'99999999990.00'), ' ') || ' руб.' as sms_txt
 from DB_LOADER_ACCOUNT_PHONE_OPTS a,
       tariff_options               b,
       TARIFF_OPTION_COSTS          d,
       USER_NAMES                   u,
       IOT_CURRENT_BALANCE         cb,
        (SELECT distinct LG.PHONE_NUMBER
        FROM SEND_SMS_NOTICE_END_MONTH_LOG lg
        WHERE trunc(lg.SEND_DATE_TIME) in (LAST_DAY(trunc(sysdate))-2, LAST_DAY(trunc(sysdate))-1,LAST_DAY(trunc(sysdate)))
        AND lg.ERROR_TEXT IS NULL) l
 where a.year_month = vYear_Month
   and a.option_code = b.option_code
   and A.PHONE_NUMBER = CB.PHONE_NUMBER
   and A.PHONE_NUMBER = L.PHONE_NUMBER (+)
   and b.discr_spisanie = 1
   and nvl(B.IS_AUTO_INTERNET,0) = 0
   and d.TARIFF_OPTION_ID = b.tariff_option_id
   AND d.USER_LAST_UPDATED = u.USER_NAME(+)
    and nvl(a.turn_off_date, LAST_DAY(trunc(sysdate)) + 1) >= LAST_DAY(trunc(sysdate)) + 1
   and nvl(a.turn_on_date, LAST_DAY(trunc(sysdate)) + 1) <= LAST_DAY(trunc(sysdate))
   and A.PHONE_NUMBER in (select AP.PHONE_NUMBER 
                            from DB_LOADER_ACCOUNT_PHONES AP
                            where AP.PHONE_IS_ACTIVE = 1
                            and AP.YEAR_MONTH=vYear_Month)
   and not exists
   (select 1 from TARIFF_OPTION_NEW_COST  f, TARIFFS t where t.TARIFF_ID = f.TARIFF_ID and f.monthly_cost=0
   and d.tariff_option_cost_id=f.tariff_option_cost_id
   and f.TARIFF_ID = GET_PHONE_TARIFF_ID(a.PHONE_NUMBER, t.tariff_CODE)
   )
   
   AND NOT EXISTS (SELECT 1 
                   FROM SEND_SMS_NOTICE_END_MONTH_LOG 
                   WHERE a.PHONE_NUMBER=SEND_SMS_NOTICE_END_MONTH_LOG.PHONE_NUMBER
                   AND (SEND_SMS_NOTICE_END_MONTH_LOG.SEND_DATE_TIME>SYSDATE-12/24)
                   AND SEND_SMS_NOTICE_END_MONTH_LOG.ERROR_TEXT IS NULL)
   and trunc(sysdate) in (LAST_DAY(trunc(sysdate))-2, LAST_DAY(trunc(sysdate))-1,LAST_DAY(trunc(sysdate)))
   /*and a.phone_number='9037602277'*/;
   begin

     for x in c loop
        i:=i+1;
        if (x.BALANCE<=x.monthly_cost) then           
            SMS_TEXT:=x.sms_txt || ' Во избежание блокировки, пополните счет.';
            begin
            SMS := LOADER3_pckg.SEND_SMS(x.phone_number,'SMS-info',SMS_TEXT);
            --dbms_output.put_line(i||' : '||x.phone_number||' : '||SMS_TEXT);
            INSERT INTO SEND_SMS_NOTICE_END_MONTH_LOG (
             phone_number,
             ABONENT_FIO,
             SEND_DATE_TIME,
             ERROR_TEXT
             ) VALUES (
             x.phone_number,
             '',
             SYSDATE,
             SMS
             );
            exception  when others  then null;
            end;
        elsif (x.SENDING = 0) then 
            begin
            SMS := LOADER3_pckg.SEND_SMS(x.phone_number,'SMS-info',x.sms_txt);
            --dbms_output.put_line(i||' : '||x.phone_number||' : '||x.sms_txt);
            INSERT INTO SEND_SMS_NOTICE_END_MONTH_LOG (
             phone_number,
             ABONENT_FIO,
             SEND_DATE_TIME,
             ERROR_TEXT
             ) VALUES (
             x.phone_number,
             '',
             SYSDATE,
             SMS
             );
            exception  when others  then null;
            end;                  
        end if;

     end loop;

  end;