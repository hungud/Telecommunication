
  CREATE OR REPLACE TRIGGER "LONTANA"."BUI_DB_LOADER_ACC_PHONES" 
-- Version = 4
-- V4 Соколов Ю. Исправлена ошибка v3
  --V3. Кочневв Е. реализовано создание заявки в CRM с информацией
  --V2. Соколов Ю. реализовано добавление в очередь на пересчет тарифа при изменение кода тарифа
  before insert or update ON LONTANA.DB_LOADER_ACCOUNT_PHONES  
  for each row
declare
  -- local variables here
  CURSOR C(YM IN INTEGER, PH IN VARCHAR2) IS
    SELECT *
      FROM DB_LOADER_PHONE_PERIODS DB
      WHERE DB.YEAR_MONTH = YM
        AND DB.PHONE_NUMBER = PH;
   vDUMMY C%ROWTYPE;
  v_HANDS_BILLING INTEGER;  
  v_ID_REQUEST    INTEGER;  
   
--  CURSOR D(CP IN VARCHAR2, PH IN VARCHAR2) IS
--    SELECT *
--      FROM DB_LOADER_ACCOUNT_PHONES DP
--      WHERE DP.YEAR_MONTH = (SELECT MAX(YEAR_MONTH) FROM DB_LOADER_ACCOUNT_PHONES WHERE PHONE_NUMBER = PH)
--        AND DP.PHONE_NUMBER = PH AND DP.CELL_PLAN_CODE = CP;
--   vDUM D%ROWTYPE;                    
begin
  :new.last_check_date_time:=sysdate;
  OPEN C(:NEW.YEAR_MONTH, :NEW.PHONE_NUMBER);
  FETCH C INTO vDUMMY;
  IF C%FOUND THEN
    UPDATE DB_LOADER_PHONE_PERIODS DB
      SET DB.ACCOUNT_ID = :NEW.ACCOUNT_ID,
          DB.TARIFF_CODE = :NEW.CELL_PLAN_CODE
      WHERE DB.YEAR_MONTH = :NEW.YEAR_MONTH 
        AND DB.PHONE_NUMBER = :NEW.PHONE_NUMBER;
  ELSE
    INSERT INTO DB_LOADER_PHONE_PERIODS(YEAR_MONTH, PHONE_NUMBER, ACCOUNT_ID, TARIFF_CODE)
      VALUES(:NEW.YEAR_MONTH, :NEW.PHONE_NUMBER, :NEW.ACCOUNT_ID, :NEW.CELL_PLAN_CODE);
  END IF;
  CLOSE C;
  
  if inserting then
    if :NEW.PHONE_IS_ACTIVE = 0 then
      begin
        select c.HANDS_BILLING 
         into v_HANDS_BILLING
         from CONTRACTS c
        where c.CONTRACT_ID = GET_ID_LAST_CONTRACT_BY_PHONE(:NEW.PHONE_NUMBER);
      exception
        when others then 
          v_HANDS_BILLING := 0;
      end;    
    
      if v_HANDS_BILLING = 1 then
        v_ID_REQUEST := CRM_ADD_REQUEST(:NEW.PHONE_NUMBER, user, 7);
      end if; 
      
    end if;
  end if;
  
  if updating then
    if (:NEW.PHONE_IS_ACTIVE = 0) and (:OLD.PHONE_IS_ACTIVE = 1) then
    
      begin   
        select c.HANDS_BILLING 
         into v_HANDS_BILLING
         from CONTRACTS c
        where c.CONTRACT_ID = GET_ID_LAST_CONTRACT_BY_PHONE(:NEW.PHONE_NUMBER);
      exception
        when others then 
          v_HANDS_BILLING := 0;
      end;    
    
      if v_HANDS_BILLING = 1 then
        v_ID_REQUEST := CRM_ADD_REQUEST(:NEW.PHONE_NUMBER, user, 7);
      end if; 

    end if;
  end if;
   
--  OPEN D(:NEW.CELL_PLAN_CODE, :NEW.PHONE_NUMBER);
--  FETCH D INTO vDUM;
--  IF D%NOTFOUND THEN
--       INSERT INTO PHONES_TARIF_FOR_RECALC(PHONE_NUMBER)
--        VALUES(:NEW.PHONE_NUMBER); 
--  END IF;
--  CLOSE D;
   
end BUI_db_loader_acc_phones;
ALTER TRIGGER "LONTANA"."BUI_DB_LOADER_ACC_PHONES" ENABLE