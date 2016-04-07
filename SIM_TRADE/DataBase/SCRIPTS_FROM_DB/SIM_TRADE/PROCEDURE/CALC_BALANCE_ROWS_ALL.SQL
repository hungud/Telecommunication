
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."CALC_BALANCE_ROWS_ALL" IS
--#Version=1
  L BINARY_INTEGER;
BEGIN
  delete from ABONENT_BALANCE_ROWS_ALL; -- быстрее чем TRUNCATE
  commit;
  for rec in (select c.PHONE_NUMBER_FEDERAL
                from contracts c,
                     contract_cancels cc
                where c.CONTRACT_ID = cc.CONTRACT_ID(+)
                  and cc.CONTRACT_CANCEL_DATE is null)
  loop
    CALC_BALANCE_ROWS(rec.PHONE_NUMBER_FEDERAL);
    insert into ABONENT_BALANCE_ROWS_ALL(ROW_DATE, ROW_COST, ROW_COMMENT, phone_number)
      select ROW_DATE, ROW_COST, ROW_COMMENT, rec.PHONE_NUMBER_FEDERAL 
        from ABONENT_BALANCE_ROWS;
    commit;
  end loop;
END; 