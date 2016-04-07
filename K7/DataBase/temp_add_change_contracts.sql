/*update temp7
  set str2=(select c.contract_id 
              from contracts c 
              where c.PHONE_NUMBER_FEDERAL = str1 
                and not exists (select 1
                                  from contract_cancels cc
                                  where cc.CONTRACT_ID = c.CONTRACT_ID))*/
declare
begin
  for rec in (
    select *
      from temp7)
  loop
    insert into contract_changes(contract_id, FILIAL_ID, CONTRACT_CHANGE_DATE, TARIFF_ID, DOCUM_TYPE_ID)
      values(rec.str2, 49, to_date('11.02.2013','dd.mm.yyyy'),  391, 4);
  end loop;    
  commit;
end;