CREATE OR REPLACE PROCEDURE ADD_PHONE_FOR_CHECK_STATUS (pPhone in varchar2) as
--
--Version=1
--
--v.1 Афросин 07.05.2015 добавил процедуру для вставкив очередь для проверку статусов
--
  PRAGMA AUTONOMOUS_TRANSACTION;
  vPhoneCount Integer;
begin
  
  IF NVL(pPhone, '0') <> 0 THEN
    
    --СЧИТАЕМ КОЛИЧЕСТВО ПЕРЕДАННЫХ НОМЕРОВ В ОЧЕРЕДИ
    select 
      count(*) into vPhoneCount 
    from 
      QUEUE_FOR_CHECK_PHONE_STATUS
    where phone_number = pPhone;
    
    --ЕСЛИ НОМЕРА В ОЧЕРЕДИ НЕТ, ТО ДОБАВЛЯЕМ ЕГО
    if nvl(vPhoneCount, 0) = 0 then
      INSERT INTO QUEUE_FOR_CHECK_PHONE_STATUS (phone_number)
      VALUES (pPhone);
    end if;
    
    commit;  
  END IF;
end;