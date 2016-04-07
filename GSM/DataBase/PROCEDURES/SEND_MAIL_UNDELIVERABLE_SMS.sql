CREATE OR REPLACE PROCEDURE SEND_MAIL_UNDELIVERABLE_SMS is
  
  --Version 1
  --
  --v.1 Алексеев 20.10.2015 Процедура отправки письма с информацией о номерах, по которым имеются недоставленные смс
  
  vText CLOB;
  vMess_Title varchar2(200 char);
  vError varchar2(2000 char);
  v_cnt integer;
begin
  vText := '';
  --проверяем наличие данных в таблице LIST_PHONE_UNDELIVERABLE_SMS
  select count(*)
     into v_cnt 
   from LIST_PHONE_UNDELIVERABLE_SMS;
   
  if nvl(v_cnt, 0) > 0 then
    --очищаем временную таблицу 
    DELETE FROM TEMP_LIST_UNDELIVERABLE_SMS;

    --отбираем номера, по которым были недоставленны смс и запоминаем их во временную таблицу
    INSERT INTO TEMP_LIST_UNDELIVERABLE_SMS
    (
      LIST_PHONE_SMS_ID,
      PHONE_NUMBER, 
      STATUS_SMS, 
      SLERROR, 
      DATE_INSERT
    )
    SELECT sm.LIST_PHONE_SMS_ID,
                sm.PHONE_NUMBER, 
                sm.STATUS_SMS, 
                sm.SLERROR, 
                sm.DATE_INSERT
      FROM LIST_PHONE_UNDELIVERABLE_SMS sm;

    for rec in (
                     SELECT LIST_PHONE_SMS_ID,
                                 PHONE_NUMBER, 
                                 STATUS_SMS, 
                                 SLERROR, 
                                 DATE_INSERT
                       FROM TEMP_LIST_UNDELIVERABLE_SMS
                  )
    loop
      vText := vText||rec.PHONE_NUMBER||'     '||rec.STATUS_SMS||'     '||rec.SLERROR||'<br>';
    end loop;   

    --удаляем номера, которые получили
    DELETE FROM LIST_PHONE_UNDELIVERABLE_SMS
    WHERE LIST_PHONE_SMS_ID in (
                                                      select LIST_PHONE_SMS_ID
                                                        from TEMP_LIST_UNDELIVERABLE_SMS
                                                   );
    commit;

    --отправляем по почте
    vMess_Title := 'Список номеров, по которым имеются недоставленные смс!';
    begin
      send_sys_mail(vMess_Title, vText, 'EMAIL_SEND_INFO_UNDELIVERABLE_SMS');
      vError := '';
    exception 
      when others then   
        vError := 'Ошибка отпраки письма!';             
    end;

    --логируем отправку
    INSERT INTO LOG_SEND_MAIL_INFO_SMS 
    (
       YEAR_MONTH, 
       DATE_CREATED, 
       MESSAGE_TITLE, 
       MAIL_TEXT, 
       MAIL_RECIPIENT, 
       ERROR_TEXT
    ) 
    VALUES 
    (
       to_number(to_char(sysdate, 'YYYYMM')),
       sysdate,
       vMess_Title,
       vText,
       MS_params.GET_PARAM_VALUE ('EMAIL_SEND_INFO_UNDELIVERABLE_SMS'),
       vError
    );
    commit; 
  end if;           
end;