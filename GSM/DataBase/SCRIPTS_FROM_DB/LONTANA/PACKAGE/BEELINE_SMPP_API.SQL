
  CREATE OR REPLACE PACKAGE "LONTANA"."BEELINE_SMPP_API" is
--
--Version=3
--
--v.3 Афросин 02.11.2015 - переделал работу пакета по отправке смс. Всю логику перенес в MYJSMPP
--v.2 Афросин 06.03.2015 - уменьшил максимальную длину сообщения при рассылки длинного смс
--
  /* функция проверки статуса СМС
     Возвращаемое значение - одна из строк :
     "ENROUTE"
     "DELIVERED"
     "EXPIRED"
     "DELETED"
     "UNDELIVERABLE"
     "ACCEPTED"
     "UNKNOWN"
     "REJECTED"
     "UNKNOWN"
     Параметры :
     p_host - хост сервиса SMPP
     p_port - порт сервиса SMPP       
     p_user - пользователь для авторизации
     p_passw - пароль для авторизации
     p_sourceAddr - Адрес отправителя (выдается провайдером)
     p_messageId - код отправленной смс
  */

   
  procedure CreateSession (p_host in varchar2,
                        p_port in varchar2,       
                        p_user in varchar2,
                        p_passw in varchar2)
                          
  AS LANGUAGE JAVA
  NAME 'MYJSMPP.CreateSession (java.lang.String ,
                                      java.lang.String ,
                                      java.lang.String ,
                                      java.lang.String )';   
  procedure DisconnectSession 
  AS LANGUAGE JAVA
  NAME 'MYJSMPP.DisconnectSession ()';
  
  procedure SEND_CHECK_STATUS_SMS
  AS LANGUAGE JAVA
  NAME 'MYJSMPP.SEND_CHECK_STATUS_SMS ()';
end;
