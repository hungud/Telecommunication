CREATE OR REPLACE FUNCTION PHONE_CHANGE_DOPST_AND_ACTIVE (pPHONE_NUMBER varchar2, pDOP_STATUS_ID INTEGER)
  RETURN VARCHAR2 AS
--
--Version=1
--v.1 17.03.2015 Афросин - добавил функцию изменения доп.статуса и блокировка/разблокировка номера в соответствии с доп статусом  
--
  PRAGMA AUTONOMOUS_TRANSACTION;
  
  vContractId CONTRACTS.CONTRACT_ID%TYPE;
  ResultMessage VARCHAR2(500);
  vPhoneNumber varchar2(10);
  vTempCount Integer;
  vOldDopStatus CONTRACTS.DOP_STATUS%TYPE;
    
BEGIN
  
  vPhoneNumber := trim(substr(pPHONE_NUMBER, -10));
  
  --проверяем номер на корректность
  if length(vPhoneNumber) < 10 OR nvl(pPHONE_NUMBER, '0') = '0' then
    Return 'Номер должен содержать 10 цифр';
  end if;
  
  --проверяем наличие доп статуса в базе
  select count(*) into vTempCount from CONTRACT_DOP_STATUSES
    where DOP_STATUS_ID = pDOP_STATUS_ID
      OR pDOP_STATUS_ID is null;
    
  if nvl(vTempCount, 0) = 0 then
    Return 'Неверный идентификатор для доп. статуса';
  end if;  
  
  --получаем действующий контракт по номеру
  vContractId := GET_ID_LAST_CONTRACT_BY_PHONE(vPhoneNumber, to_number(to_char(sysdate, 'yyyymm')));
  
  if nvl(vContractId, -1) = -1 then
    Return 'Нет действующего контракта для номера '||pPHONE_NUMBER;
  end if;
  
  --проверяем доп статутс у контракта
  select DOP_STATUS into vOldDopStatus
    from CONTRACTS
     where CONTRACT_ID = vContractId;
  
  if nvl(vOldDopStatus, -89) = nvl(pDOP_STATUS_ID, -89) then
    Return 'У номера '||pPHONE_NUMBER||' уже установлен статус '||pDOP_STATUS_ID;  
  end if;
   
  
  --все проверки прошли
  --обновляем стутус у контракта
  BEGIN
    UPDATE CONTRACTS
    SET
      DOP_STATUS = pDOP_STATUS_ID
    WHERE
      CONTRACT_ID = vContractId;
    
--   запись в логи изменения доп статусов есть в триггире на изменение CONTRACTS
   /* 
   --запишем изменение в лог
    INSERT INTO LOG_DOP_STATUS(PHONE_NUMBER, DOP_STATUS_ID_OLD, DOP_STATUS_ID_NEW, USER_LAST_UPDATED, DATE_LAST_UPDATED)
    VALUES
    (vPhoneNumber, vOldDopStatus, pDOP_STATUS_ID, USER, SYSDATE);
   */ 
    
    COMMIT;
    ResultMessage := 'Доп.Статус изменен!';
    
    --блокируем по API на сохранение(S1B)
    ResultMessage := ResultMessage || ' '||beeline_api_pckg.LOCK_PHONE(vPhoneNumber, 0, 'S1B');
    
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RETURN ResultMessage||' Ошибка: '||SQLERRM;
  end;
  
  Return ResultMessage;
END;  

GRANT EXECUTE ON PHONE_CHANGE_DOPST_AND_ACTIVE TO CORP_MOBILE_ROLE;
GRANT EXECUTE ON PHONE_CHANGE_DOPST_AND_ACTIVE TO CORP_MOBILE_ROLE_RO;
GRANT EXECUTE ON PHONE_CHANGE_DOPST_AND_ACTIVE TO CRM_USER;