CREATE OR REPLACE PROCEDURE SEND_SMS_END_PROMISED_PAY IS
--
-- Version=4
--v.4 02.09.2015 Кочнев Изменил текст смс для коллекторов .Взять обещанный платеж 200руб. - *132*132# коллекторам не виден.
--v.3 09.05.2015 Афросин Изменил текст смс с: Уважаемый Абонент, напоминаем, что срок действия обещанного платежа заканчивается сегодня. Проверить баланс *132*11#.
--                  на: Уважаемый Абонент, напоминаем, срок действия обещанного платежа заканчивается сегодня. Баланс - *132*11#.Взять обещанный платеж 200руб. - *132*132#.
--v.2 11.02.2015 Изменил PROMISED_DATE_END на PROMISED_DATE
--v.1 11.02.2015 Добавил процедуру оповещения номеров об окончании обещанного платежа
--
  l_sms_text varchar2(250 CHAR);
  l_sms_text2 varchar2(250 CHAR);
  l_res varchar2(2000);
  
  procedure UPDATE_PROMISED_PAYMENTS (pRowId rowid) as
  PRAGMA AUTONOMOUS_TRANSACTION;
  begin
    update PROMISED_PAYMENTS
      set SMS_SENDED = 1
    where rowid = pRowID;
    commit;
  end;
  
BEGIN
  l_sms_text  := 'Уважаемый Абонент, напоминаем, срок действия обещанного платежа заканчивается сегодня. Баланс - *132*11#.Взять обещанный платеж 200руб. - *132*132#.'; 
  l_sms_text2 := 'Уважаемый Абонент, напоминаем, срок действия обещанного платежа заканчивается сегодня. Баланс - *132*11#.'; 
  for r in (select T.PHONE_NUMBER, rowid rid 
               from PROMISED_PAYMENTS t
              where 
              --проверка на окончание платежа завтрашней датой
              trunc(T.PROMISED_DATE) = trunc(sysdate + 1)
              
              
              --проверка рассылку не раньше MS_CONSTANTS.GET_CONSTANT_VALUE('HOUR_START_SEND_PROMIZED_MESS')
              and to_number(to_char(sysdate, 'hh24')) >= to_number(nvl(MS_CONSTANTS.GET_CONSTANT_VALUE('HOUR_START_SEND_PROMIZED_MESS'), '-1')) 

              --проверка на то, что смс еще не была отослана
              and nvl(SMS_SENDED, 0) = 0
              )
               
  loop
    if GET_IS_COLLECTOR_BY_PHONE(R.PHONE_NUMBER) = 1 then
      l_res := LOADER3_PCKG.SEND_SMS(R.PHONE_NUMBER, 'Оповещение', l_sms_text);
    else
      l_res := LOADER3_PCKG.SEND_SMS(R.PHONE_NUMBER, 'Оповещение', l_sms_text2);
    end if;  
    UPDATE_PROMISED_PAYMENTS (R.rid);
  end loop;
   
END SEND_SMS_END_PROMISED_PAY;
/