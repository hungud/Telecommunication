CREATE OR REPLACE package BEELINE_SMPP_API is
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
  FUNCTION GET_SMS_STATUS ( p_host in varchar2,
                            p_port in varchar2,       
                            p_user in varchar2,
                            p_passw in varchar2,
                            p_sourceAddr in varchar2,
                            p_messageId in varchar2
                         )
  RETURN VARCHAR2;
  
  /* Функция отправки СМС
     Возвращаемое значение - код отправленной смс
     p_host - хост сервиса SMPP
     p_port - порт сервиса SMPP       
     p_user - пользователь для авторизации
     p_passw - пароль для авторизации
     p_sourceAddr - Адрес отправителя (выдается провайдером)
     p_serviceType - тип сервиса (напр "CMT")     
     p_phone - телефон
     p_Message - текст СМС
  */
  FUNCTION SEND_SMS (   p_host in varchar2,
                        p_port in varchar2,       
                        p_user in varchar2,
                        p_passw in varchar2,
                        p_sourceAddr in varchar2,
                        p_serviceType in varchar2,     
                        p_phone in varchar2,
                        p_Message in varchar2
                     )
  RETURN VARCHAR2;
    
end;
/

CREATE OR REPLACE package body BEELINE_SMPP_API is

FUNCTION FSHORTSMS (  p_host in varchar2,
                      p_port in varchar2,       
                      p_user in varchar2,
                      p_passw in varchar2,
                      p_sourceAddr in varchar2,
                      p_serviceType in varchar2,     
                      p_phone in varchar2,
                      p_shortMessage in varchar2,
                      p_is_rus in varchar2,
                      p_maxlen in varchar2     
                   )
RETURN VARCHAR2
AS LANGUAGE JAVA
NAME 'MYJSMPP.FShortSMS ( java.lang.String,
                          java.lang.String,
                          java.lang.String,
                          java.lang.String,
                          java.lang.String,
                          java.lang.String,
                          java.lang.String,
                          java.lang.String ,     
                          java.lang.String , 
                          java.lang.String
                                 ) 
      return java.lang.String';

FUNCTION GET_SMS_STATUS ( p_host in varchar2,
                          p_port in varchar2,       
                          p_user in varchar2,
                          p_passw in varchar2,
                          p_sourceAddr in varchar2,
                          p_messageId in varchar2
                       )
RETURN VARCHAR2
AS LANGUAGE JAVA
NAME 'MYJSMPP.FCHECKSMS ( java.lang.String,
                          java.lang.String,
                          java.lang.String,
                          java.lang.String,
                          java.lang.String,
                          java.lang.String
                        ) 
      return java.lang.String';
      
FUNCTION FLONGSMS (  p_host in varchar2,
                     p_port in varchar2,       
                     p_user in varchar2,
                     p_passw in varchar2,
                     p_sourceAddr in varchar2,
                     p_serviceType in varchar2,
                     p_phone in varchar2,
                     p_longMessage in varchar2,
                     p_is_rus in varchar2,
                     p_maxlen in varchar2                                         
                  )
RETURN VARCHAR2
AS LANGUAGE JAVA
NAME 'MYJSMPP.FLONGSMS( java.lang.String ,     
                        java.lang.String ,     
                        java.lang.String ,     
                        java.lang.String ,     
                        java.lang.String ,     
                        java.lang.String ,     
                        java.lang.String , 
                        java.lang.String ,     
                        java.lang.String , 
                        java.lang.String      
                    ) 
return java.lang.String';    

FUNCTION SEND_SMS (   p_host in varchar2,
                      p_port in varchar2,       
                      p_user in varchar2,
                      p_passw in varchar2,
                      p_sourceAddr in varchar2,
                      p_serviceType in varchar2,     
                      p_phone in varchar2,
                      p_Message in varchar2
                   )
RETURN VARCHAR2
is
  i integer;
  v_is_rus varchar2(1);
  v_maxlen varchar2(5);
  v_chr number(5);
begin
  v_is_rus:='0';
  v_maxlen:='140';
  for i in 1..length(p_Message) loop
    v_chr := ascii( substr(p_Message,i,1) );
    if (( v_chr > 128 ) or ( v_chr <32))
    then
      v_is_rus := '1';
      v_maxlen:='70';
      EXIT;
    end if;
  end loop;
  if length(p_Message)>to_number(v_maxlen) then
    if v_is_rus = '1' then
      v_maxlen:='67';
    end if;
    return FLONGSMS (  p_host ,
                       p_port ,       
                       p_user ,
                       p_passw ,
                       p_sourceAddr ,
                       p_serviceType ,
                       p_phone ,
                       p_Message,
                       v_is_rus,
                       v_maxlen                                         
                    );
  else
    return FSHORTSMS ( p_host ,
                       p_port ,       
                       p_user ,
                       p_passw ,
                       p_sourceAddr ,
                       p_serviceType ,
                       p_phone ,
                       p_Message,
                       v_is_rus,
                       v_maxlen  
                     );
  end if;
end; 

end;
/