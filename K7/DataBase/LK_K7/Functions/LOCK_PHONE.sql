CREATE OR REPLACE FUNCTION K7_LK.LOCK_PHONE(
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN VARCHAR2 IS
--
--#Version=1
--
--v.1 05.11.2015 Функция блокирует телефон по S1B и проставляет доп.статус "Добровольная блокировка 2015" (382)
--
--
  cMANUAL_LOCK_PHONE CONSTANT INTEGER := 1;--ПРИЗНАК ТОГО, ЧТО БЛОКИРОВКА БЫЛА СДЕЛАНА ВРУЧНУЮ
  vRESULT VARCHAR2(500 char);
BEGIN

  --устанавливаем доп статус "Добровольная блокировка 2015" 
  vRESULT := CORP_MOBILE.SET_DOP_STATUS (pPHONE_NUMBER, 382);
  if vRESULT = 'OK' then
    vRESULT := CORP_MOBILE.beeline_api_pckg.LOCK_PHONE(pPHONE_NUMBER, cMANUAL_LOCK_PHONE,'S1B');
  
    if INSTR(vRESULT, 'Заявка') > 0 THEN
      vRESULT := 'Заявка принята в работу';
    else
      vRESULT := 'Произошла ошибка! Попробуйте позже.';
    end if;
  end if;
  
  RETURN vRESULT;
END;
