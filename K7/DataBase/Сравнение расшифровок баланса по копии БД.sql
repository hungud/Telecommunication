begin
  delete from TEMP_ABON_BAL_ROW; CORP_MOBILE_C14012016.calc_balance_rows(:ph);
  insert into TEMP_ABON_BAL_ROW select * from CORP_MOBILE_C14012016.ABONENT_BALANCE_ROWS;
  commit;  calc_balance_rows(:ph);
end;  

  select *
    from TEMP_ABON_BAL_ROW n
    full outer join ABONENT_BALANCE_ROWS o 
      on o.ROW_COST = n.ROW_COST and n.ROW_DATE = o.ROW_DATE and o.ROW_COMMENT = n.ROW_COMMENT 
    where (nvl(o.ROW_COST, 0) <> nvl(n.ROW_COST,0))   
    order by nvl(o.ROW_DATE, n.ROW_DATE) desc
    
 
/*
select x.* ,
       get_abonent_balance(x.phone_number) old_bal,             
       corp_mobile_c20150722.get_abonent_balance(x.phone_number) new_bal   
from (   
select dd.*, 
       DD.DEST_BALANCE-DD.SOURCE_BALANCE DIFFR,
       (select contract_date from contracts c, contract_cancels cc
          where c.PHONE_NUMBER_FEDERAL = dd.PHONE_NUMBER 
            and c.CONTRACT_ID = cc.CONTRACT_ID(+)
            and cc.CONTRACT_CANCEL_DATE is null) contract_date           
  from BALANCE_COMPARE_RESULT dd 
  WHERE SOURCE_BALANCE<>DEST_BALANCE AND ID_DATABASE = :ID_DATABASE 
  ORDER BY DIFFR DESC
) x where x.contract_date is not null   
   */ 
    