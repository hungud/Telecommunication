
  CREATE OR REPLACE PROCEDURE "LONTANA"."CHECK_ALL_DETAILS201310" IS
  vYEAR_MONTH INTEGER;
  flag number;
BEGIN
  vYEAR_MONTH:=TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE-7, -1), 'yyyymm'));
  for rec in (select d2.*
                from (select d.*,
                             (select sum(fb.CALLS_ALL)
                                    from db_loader_full_finance_bill fb
                                    where fb.YEAR_MONTH = d.YEAR_MONTH
                                      and fb.PHONE_NUMBER = d.PHONE_NUMBER) calls_all
                        from diler_call_for_phone d
                        where d.YEAR_MONTH = vYEAR_MONTH
                          and d.DILER_CALLS = 0
                        order by calls_all desc) d2
                where calls_all > 0 )
  loop
      update DILER_CALL_FOR_PHONE
      set DILER_CALL_FOR_PHONE.DILER_CALLS = GET_DILER_COST_FROM_DETAIL_BD(rec.PHONE_NUMBER, REC.YEAR_MONTH)
      WHERE DILER_CALL_FOR_PHONE.YEAR_MONTH = REC.YEAR_MONTH
        AND DILER_CALL_FOR_PHONE.PHONE_NUMBER = REC.PHONE_NUMBER
--        and (diler_call_for_phone.DILER_CALLS = 0
--              OR diler_call_for_phone.DILER_CALLS = -1)
        and exists (select 1
                      from db_loader_full_finance_bill
                      where db_loader_full_finance_bill.YEAR_MONTH = DILER_CALL_FOR_PHONE.YEAR_MONTH
                        and db_loader_full_finance_bill.PHONE_NUMBER = DILER_CALL_FOR_PHONE.PHONE_NUMBER
                        and db_loader_full_finance_bill.BILL_SUM > 0) ;
    commit;
  end loop;
END;
