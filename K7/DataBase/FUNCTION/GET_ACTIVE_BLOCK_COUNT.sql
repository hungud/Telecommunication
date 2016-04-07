CREATE OR REPLACE FUNCTION GET_ACTIVE_BLOCK_COUNT (
   p_phone_number   IN VARCHAR2,
   p_date         DATE, -- месяц за который считаем количество
   p_contract_date  in DATE default NULL,
   p_is_active  in INTEGER default 0--0 -блокирован 1 - активен
   )
   RETURN NUMBER
IS
--функция получения количества блокировок/активностей в зависимости от даты договора
--
--Version=1
--
--v.1 27.07.2015 Добавил функцию
--   
   v_count   Integer;
   v_is_active integer;
   v_contract_date date;
   v_date date;
   
BEGIN
  v_is_active := nvl(p_is_active, 0);
  v_contract_date := trunc(p_contract_date);
  v_date := trunc(p_date, 'mm');
  select
    count(*) into v_count
  from
    db_loader_account_phone_hists
  where
    phone_number = p_phone_number 
    and phone_is_active = v_is_active 
    and trunc(date_created, 'mm') = v_date
    and (p_contract_date is null or trunc(date_created) >= v_contract_date)
  ;
  if v_count = 0 then
    v_count := null;
  end if; 
  RETURN v_count;
END;
/
GRANT EXECUTE ON GET_ACTIVE_BLOCK_COUNT TO CORP_MOBILE_ROLE;
GRANT EXECUTE ON GET_ACTIVE_BLOCK_COUNT TO CORP_MOBILE_ROLE_RO; 