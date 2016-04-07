CREATE OR REPLACE FUNCTION USSD_K7_LK_RESET_PASSWORD (
   pPHONE_NUMBER   IN VARCHAR2
   )
   RETURN VARCHAR2
AS
   --
   --#Version=1
   --
   --v.1 Афросин 26.11.2015 - Функция получения пароля по USSD для входа в K7_LK (ag-sv.ru)
   --
   PRAGMA AUTONOMOUS_TRANSACTION;
   vRESULT  VARCHAR2 (2000);
BEGIN
  if nvl(CONVERT_PCKG.GET_IS_COLLECTOR_BY_PHONE(pPHONE_NUMBER), 0) = 0 then
    vRESULT := case K7_LK.RESET_PASSWORD(pPHONE_NUMBER)
                 when 'OK' then
                   'Пароль отправлен по SMS'
                 when 'NO_PHONE' then
                   'Телефонный номер не найден. Обратитесь в службу технической поддержки'
                 when 'ERROR' then
                   'Ошибка, повторите позже.'
               end;
  else
    vRESULT := 'Команда недоступна';   
  end if;
  commit;
  RETURN TRIM (vRESULT);
END;
/
