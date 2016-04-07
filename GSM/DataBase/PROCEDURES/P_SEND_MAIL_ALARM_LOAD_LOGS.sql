create or replace procedure P_SEND_MAIL_ALARM_LOAD_LOGS is
--
--#Version=1
--
--v.1 Афросин 22.05.2015 Процедура для рассылки оповещений с ошибками авторизазии в личный кабинет билайна
--
  
  vSubject varchar2(100);
  vBody varchar2(1000);
  vList varchar2(30000);
  vClob CLOB;
  vErr number:=0;
  vEmails varchar2(100):='';
  vYEAR_MONTH number;
  
CURSOR C IS
  select a.account_number, l.*
    from ACCOUNT_LOAD_LOGS l, accounts a
   where a.account_id = l.account_id
   --ибираем экомобайл
     and nvl(A.DO_AUTO_LOAD_DATA, 0) = 1
     and l.is_success <> 1
     and l.ACCOUNT_LOAD_TYPE_ID in (1,3) and rownum=1
     and not exists
   (select 1 from ACCOUNT_LOAD_LOGS l1
           where l1.account_id = l.account_id
             and l1.is_success=1
             and l1.ACCOUNT_LOAD_TYPE_ID in (1,3)
             and abs(sysdate-l1.load_date_time)*1440<10);
begin
  vList:='';  
  FOR vREC IN C LOOP
    vList:=vList||to_char(vRec.Account_Number)||',';
    if length(vList)>30000-20 then
      exit;
    end if;
  end loop; 
  if length(vList)>0 then
    vList := SUBSTR(vList,1,length(vList)-1);  -- уберем последнюю запятую
    begin
      select value
        into vSubject
        from PARAMS
       where name = 'EMAIL_ALARM_TEMPLATE_SUBJECT'
         and rownum = 1;
    exception
    when no_data_found then
      vSubject:='Ошибка при аворизации в личный кабинет';  
    end;
    begin
      select value
        into vBody
        from PARAMS
       where name = 'EMAIL_ALARM_TEMPLATE_BODY'
         and rownum = 1;
    exception
    when no_data_found then
      vBody:='Ошибка при входе в личный кабинет для счетов: %%% ';  
    end;
    begin
      select value
        into vEmails
        from PARAMS
       where name = 'EMAIL_ALARM_LOAD_LOGS'
         and rownum = 1;
    exception
    when no_data_found then
      vEmails:='';  
    end;
    vClob := replace(vBody,'%%%',vList);
    if trim(vEmails) is not null then
      begin
        send_sys_mail (vSubject, vClob, 'EMAIL_ALARM_LOAD_LOGS');
      exception 
      when others then                
        vErr:=1;
      end;
      if vErr=0 then
        vYEAR_MONTH:=to_number(replace(to_char(sysdate,'yyyymm'),' ','0'));
        insert into SEND_MAIL_ALARM_LOAD_LOGS
          (
            YEAR_MONTH ,
            DATE_CREATED ,
            MESSAGE_TITLE ,
            MAIL_TEXT ,
            MAIL_RECIPIENT 
          )
        values 
          (
            vYEAR_MONTH,
            sysdate,
            vSubject,
            vClob,
            vEmails
          );
      end if;
    end if;
  end if;
end;
/
