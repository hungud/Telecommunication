
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."CALC_ALL_BALANCE_ROWS" is
begin
  delete from ABONENT_BALANCE_ROWS_all;
  commit;
  for rec in (select distinct c.PHONE_NUMBER_FEDERAL 
                from contracts c
                where c.CONTRACT_ID not in (select cc.CONTRACT_ID
                                              from contract_cancels cc))
  loop
    delete from abonent_balance_rows;
    calc_balance_rows(rec.PHONE_NUMBER_FEDERAL);
    insert into ABONENT_BALANCE_ROWS_all(ROW_DATE, ROW_COST, ROW_COMMENT, phone_number)
      select ROW_DATE, ROW_COST, ROW_COMMENT, rec.PHONE_NUMBER_FEDERAL 
        from abonent_balance_rows;
    commit;
  end loop;
end; 