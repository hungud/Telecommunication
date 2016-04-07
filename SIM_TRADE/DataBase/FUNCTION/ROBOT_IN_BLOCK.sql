CREATE OR REPLACE FUNCTION ROBOT_IN_BLOCK(pPHONE_NUMBER IN VARCHAR2,is_unblock in boolean default false)
  RETURN BOOLEAN IS
  --
  -- Version=3
  --26.03.2012 Переписано.Добавлена проверка на блокировку по мошенничеству
  --
  V_HAND_BLOCK          CONTRACTS.HAND_BLOCK%TYPE;
  V_HAND_BLOCK_DATE_END CONTRACTS.HAND_BLOCK_DATE_END%TYPE;
  v_contract_date       contracts.contract_date%TYPE;
  flag                  number;
BEGIN
  begin
    SELECT CT.HAND_BLOCK, CT.HAND_BLOCK_DATE_END, max(ct.contract_date)
      into V_HAND_BLOCK, V_HAND_BLOCK_DATE_END, v_contract_date
      FROM CONTRACTS ct
     WHERE CT.PHONE_NUMBER_FEDERAL = pPHONE_NUMBER
     group by CT.HAND_BLOCK, CT.HAND_BLOCK_DATE_END;
  exception
    when others then
      RETURN FALSE;
  end;

  select count(*)
    into flag
    from fraud_blocked_phone fb
   where fb.phone_number = pPHONE_NUMBER
   and fb.status=1
     and fb.date_block>=(select max(abp.block_date_time) from AUTO_BLOCKED_PHONE abp
where abp.phone_number=pPHONE_NUMBER);

  IF ((TRUNC(V_HAND_BLOCK_DATE_END) > TRUNC(SYSDATE)) AND
     (V_HAND_BLOCK = 1) and
     (MS_CONSTANTS.GET_CONSTANT_VALUE('HAND_BLOCK_IS_ROBOT_BLOCK') = '1')) or
     ((flag <> 0) and is_unblock) THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
END;
/  
  
