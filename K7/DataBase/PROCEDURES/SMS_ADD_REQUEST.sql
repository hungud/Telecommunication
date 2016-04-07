CREATE OR REPLACE PROCEDURE SMS_ADD_REQUEST(pprovider_id in integer,
                                            pphone       in varchar2,
                                            pmessage     in varchar2,
                                            pdate_start   in date DEFAULT sysdate,
                                            pSMS_SenderName in varchar2 DEFAULT NULL
                                            ) is
                                            
--Version=3
--
--v.3 Афросин 25.11.2014 - Запрос поправил
--v.2 Афросин 24.11.2014 - Добавил отправку письма либо от переданного имени, либо от имени по умолчанию
--
  SENDER_NAME SMS_SENDER_NAME.SMS_SENDER_NAME%TYPE;
BEGIN
   
-- Если SENDER_NAME пусто, то используем имя, которое привызано к счету   
   SENDER_NAME := nvl(trim(pSMS_SenderName) , GET_SMS_SENDER_NAME_BY_PHONE(pphone));

-- Если SENDER_NAME пусто, то используем имя, которое задано по-умолчанию   
   SENDER_NAME := nvl(SENDER_NAME, MS_CONSTANTS.GET_CONSTANT_VALUE('SMS_SENDER_NAME') );

  insert into sms_current
    (
    
      PROVIDER_ID,
      PHONE,
      MESSAGE,
      RESULT_STR,
      STATUS_CODE,
      DESCRIPTION_STR,
      SMS_ID,
      INSERT_DATE,
      UPDATE_DATE,
      ERROR_CODE,
      REQ_COUNT,
      DATE_START,
      SMS_SENDER_NAME
    
    )
  values
    (pprovider_id,
     pphone,
     pmessage,
     null,
     99,
     null,
     null,
     null,
     null,
     null,
     0,
     pdate_start,
     SENDER_NAME
     );
  commit;
end;
/