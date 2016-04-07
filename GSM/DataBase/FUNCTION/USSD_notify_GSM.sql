CREATE OR REPLACE FUNCTION USSD_notify(XCPAXActiont IN VARCHAR2, --Идентификатор транзакции
                                       XCPAMSGIDt   IN VARCHAR2, --Идентификатор кадра. Для запросов типа deliver это идентификатор для кадра, который будет отправлен в ответе. Нужен для “связки” кадра и нотификации.
                                       XCPAStatust  IN VARCHAR2, --Статус обработки/доставки сообщения. Список статусов приведен в приложении 1.
                                       XCPAErrort   IN VARCHAR2, --Ошибка, полученная от USSD Gateway. Список ошибок приведен в приложении 3.
                                       HTTP_ANSWER out varchar2)
  RETURN varchar2 IS
  xcpaussdsessiont    VARCHAR2(3);
  msisdnt             VARCHAR2(11);
  ussd_cur_date      date;
  rowid_USSD_CURRENT rowid;
  id_ussd            integer;

  --#Version=1
BEGIN
  id_ussd       := 0;
  ussd_cur_date := sysdate;
  begin
    select uc.rowid, uc.id, uc.update_date, uc.msisdn, uc.xcpaussdsession
      into rowid_USSD_CURRENT,
           id_ussd,
           ussd_cur_date,
           msisdnt,
           xcpaussdsessiont
      from USSD_CURRENT uc
     where uc.xcpaxaction = XCPAXActiont
       and uc.xcpamsgid = XCPAMSGIDt;
    IF ((MS_CONSTANTS.GET_CONSTANT_VALUE('USSD_LOG_LEVEL') = '2') or
       (MS_CONSTANTS.GET_CONSTANT_VALUE('USSD_LOG_LEVEL') = '1')) and
       ((XCPAStatust <> 'ACCEPTED') or (XCPAUSSDSessiont = 'no')) then
      insert into ussd_log
        (id,
         xcpaxaction,
         xcpamsgid,
         ussd_date,
         msisdn,
         error_text,
         xcpastatus,
         xcpaerror,
         TYPE_LOG)
      values
        (id_ussd,
         XCPAXActiont,
         XCPAMSGIDt,
         ussd_cur_date,
         msisdnt,
         'NOTIFY LOG',
         xcpastatust,
         xcpaerrort,
         2);
      commit;
    elsif (MS_CONSTANTS.GET_CONSTANT_VALUE('USSD_LOG_LEVEL') = '2')  and
       (XCPAStatust = 'ACCEPTED') and (XCPAUSSDSessiont = 'yes') then
       insert into ussd_log
        (id,
         xcpaxaction,
         xcpamsgid,
         ussd_date,
         msisdn,
         error_text,
         xcpastatus,
         xcpaerror,
         TYPE_LOG)
      values
        (id_ussd,
         XCPAXActiont,
         XCPAMSGIDt,
         ussd_cur_date,
         msisdnt,
         'NOTIFY LOG',
         xcpastatust,
         xcpaerrort,
         2);
      commit;
    end if;
    if (XCPAUSSDSessiont = 'no') or (XCPAStatust <> 'ACCEPTED') then
      delete USSD_CURRENT uc
      where uc.rowid=rowid_USSD_CURRENT;
      commit;
    end if;
  EXCEPTION
    WHEN others THEN
      null;
  end;
  HTTP_ANSWER := '200 Ok!';
  RETURN   sys.utl_url.escape(url => 'Ok!',
                                url_charset => 'CL8MSWIN1251');
EXCEPTION
  WHEN others THEN
    HTTP_ANSWER := '200 Ok!';
  RETURN   sys.utl_url.escape(url => 'Ok!',
                                url_charset => 'CL8MSWIN1251');
END;
