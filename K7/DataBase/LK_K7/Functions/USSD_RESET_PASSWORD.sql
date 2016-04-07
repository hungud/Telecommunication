CREATE OR REPLACE FUNCTION K7_LK.USSD_RESET_PASSWORD(
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN VARCHAR2 IS
--
--#Version=1
--
-- Функция сбрасывает пароль для телефона и отправляет его на SMS. при запросе сброса пароля через USSD
-- Возвращаемое значение:
--  'Пароль будет направлен по смс': операция выполнена успешно;
--  'NO_PHONE': нет такого номера;
--  'ERROR': Ошибка, повторить позже.
--
  vRESULT VARCHAR2(50 char);
BEGIN

  vRESULT := RESET_PASSWORD(pPHONE_NUMBER);

  if vRESULT = 'OK' then
    vRESULT := 'Пароль будет направлен по смс';
  end if;
  
  RETURN vRESULT;
END;
