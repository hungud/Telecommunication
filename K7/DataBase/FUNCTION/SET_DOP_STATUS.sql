CREATE OR REPLACE FUNCTION SET_DOP_STATUS (pPhoneNumber in varchar2, pDOP_STATUS_ID in INTEGER)
   Return varchar2
   as
--
--#Version=1
--
--v.1 05.11.2015 Афросин - Процедура устанавливает доп.статус на номер по последнему контракту
--
  cursor c_contract (pphone varchar2) is
    select
      contract_id
    from
      v_contracts c
    where
      C.PHONE_NUMBER_FEDERAL = pphone
      and C.CONTRACT_CANCEL_DATE is null;
      
  vRec c_contract%rowtype; 
  vResult varchar2(150 char);
  
  --проверяем доп статус на существование
  function CHECK_DOP_STATUS (ppDOP_STATUS_ID integer) RETURN INTEGER AS
    vRes Integer;
    vCount Integer;
  begin
    
    select
      count(*) into vCount
    from
      CONTRACT_DOP_STATUSES cd
    where 
      CD.DOP_STATUS_ID = ppDOP_STATUS_ID;
      
    if nvl(vCount, 0) > 0 then
      vRes := 1;
    else
      vRes := 0;
    end if;
    
    Return vRes; 
  end;

      
begin
  
  open c_contract (pPhoneNumber);
  
  if c_contract%NOTFOUND then
    vResult := 'Нет действующих контрактов';
  else
    FETCH c_contract into vRec;
  
    if CHECK_DOP_STATUS(pDOP_STATUS_ID) = 1 then
      UPDATE CONTRACTS
        SET
          DOP_STATUS = pDOP_STATUS_ID
      WHERE
          CONTRACT_ID = vRec.contract_id;
      vResult := 'OK';
    else
      vResult := 'Указанного доп.статуса не существует';  
    end if;-- if CHECK_DOP_STATUS(pDOP_STATUS_ID) = 1
  end if;
  close c_contract;
  
  RETURN vResult;
end;

GRANT EXECUTE ON SET_DOP_STATUS TO CORP_MOBILE_ROLE;
GRANT EXECUTE ON SET_DOP_STATUS TO CORP_MOBILE_ROLE_RO;