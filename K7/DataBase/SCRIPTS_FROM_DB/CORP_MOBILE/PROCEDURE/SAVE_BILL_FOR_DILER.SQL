
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SAVE_BILL_FOR_DILER" (
  pYEAR_MONTH IN INTEGER
  ) IS
-- Version = 1  
-- Сохранение(фиксация) дилерских счетов за месяц
begin
  for recNumber in(
    SELECT c.PHONE_NUMBER_FEDERAL
      FROM CONTRACTS c
      where exists (select 1
                      from db_loader_full_finance_bill fb
                      where fb.PHONE_NUMBER = c.PHONE_NUMBER_FEDERAL
                        and fb.YEAR_MONTH = pYEAR_MONTH
                        and fb.COMPLETE_BILL = 1
                        and not exists (select 1
                                          from BILL_FOR_DILER_SAVED bs 
                                          where fb.ACCOUNT_ID = bs.ACCOUNT_ID 
                                            and fb.YEAR_MONTH = bs.YEAR_MONTH 
                                            and fb.PHONE_NUMBER = bs.PHONE_NUMBER))   
        and not exists (select 1
                          from contract_cancels cc
                          where cc.CONTRACT_ID = c.CONTRACT_ID
                            and nvl(cc.CONTRACT_CANCEL_DATE, to_date('20500101','yyyymmdd')) < to_date(to_char(pYEAR_MONTH)||'01', 'yyyymmdd'))  
      GROUP BY c.PHONE_NUMBER_FEDERAL
                  )
  loop
    for rec in(
      select V.*
        from V_BILL_FOR_DILER V
        where V.YEAR_MONTH=pYEAR_MONTH
          and v.PHONE_NUMBER = recNumber.PHONE_NUMBER_FEDERAL
          --and v.PHONE_NUMBER = '9623630138'
          AND NOT EXISTS (SELECT 1
                            FROM BILL_FOR_DILER_SAVED BS
                            WHERE BS.ACCOUNT_ID = V.ACCOUNT_ID
                              AND BS.YEAR_MONTH = V.YEAR_MONTH
                              AND BS.PHONE_NUMBER = V.PHONE_NUMBER)
      order by   V.YEAR_MONTH Asc                      
          )
    loop
      insert into BILL_FOR_DILER_SAVED(
          ACCOUNT_ID, YEAR_MONTH, PHONE_NUMBER, BILL_SUM_ORIGIN, BILL_SUM, 
          DISCOUNT_VALUE, DILER_PAYMENT, DILER_PAYMENT_FULL, 
          SUBSCRIBER_PAYMENT_NEW, SUBSCRIBER_PAYMENT_OLD, SUBSCRIBER_PAYMENT_ADD_OLD,
          OPTION_COST_DILER, OPTION_COST_DILER_BEELINE, OPTION_COST_FULL, 
          TARIFF_NAME, TAIL, CHECK_LONG_PLUS_BALANCE, 
          INSTALLMENT_PAYMENT_SUM, DILER_SUMM_OLD_MONTH_IN_MINUS)
        values(
          rec.ACCOUNT_ID, rec.YEAR_MONTH, rec.PHONE_NUMBER, rec.BILL_SUM_ORIGIN, rec.BILL_SUM, 
          rec.DISCOUNT_VALUE, rec.DILER_PAYMENT, rec.DILER_PAYMENT_FULL, 
          rec.SUBSCRIBER_PAYMENT_NEW, rec.SUBSCRIBER_PAYMENT_OLD, rec.SUBSCRIBER_PAYMENT_ADD_OLD,
          rec.OPTION_COST_DILER, rec.OPTION_COST_DILER_BEELINE, rec.OPTION_COST_FULL, 
          NVL(rec.TARIFF_NAME, 'Тариф не найден'), rec.TAIL, rec.CHECK_LONG_PLUS_BALANCE, 
          0, 0);
      commit;
    end loop;
  end loop;
end;

--#end if 