
  CREATE OR REPLACE FORCE VIEW "LONTANA"."V_COUNT_LOADED_BILLS" ("LOGIN", "ACCOUNT_ID", "YEAR_MONTH", "COUNT_DETAIL_NONZERO_BILL", "COUNT_NONZERO_BILL_FROM_ACC", "COUNT_DETAIL_BILL", "COUNT_BILL_FROM_ACC", "COUNT_PHONES_ON_END_MONTH", "DIF_BETWEEN_NONZERO_BILLS", "DIF_BETWEEN_BILLS", "QUERY_LOAD") AS 
  select ac.login, b_fb.ACCOUNT_ID, b_fb.YEAR_MONTH,
         bill_nz_fb COUNT_DETAIL_NONZERO_BILL,
         bill_nz_b COUNT_NONZERO_BILL_FROM_ACC,
         bill_all_fb COUNT_DETAIL_BILL,
         bill_all_b COUNT_BILL_FROM_ACC,
         (SELECT COUNT (*)
            FROM DB_LOADER_ACCOUNT_PHONES FB_ZERO
            WHERE FB_ZERO.ACCOUNT_ID = b_fb.ACCOUNT_ID
              AND FB_ZERO.PHONE_NUMBER <> '0000000000'
              AND FB_ZERO.YEAR_MONTH = b_fb.YEAR_MONTH) AS COUNT_PHONES_ON_END_MONTH,
         bill_nz_b - bill_nz_fb DIF_BETWEEN_NONZERO_BILLS,
         bill_all_b - bill_all_fb DIF_BETWEEN_BILLS,
         (SELECT COUNT(*) FROM db_loader_bills V
            WHERE V.ACCOUNT_ID = b_fb.ACCOUNT_ID AND V.YEAR_MONTH = b_fb.YEAR_MONTH
              AND V.PHONE_NUMBER not in ('0000000000', '0886980555') and v.BILL_SUM > 0
              AND EXISTS (SELECT 1 FROM db_loader_account_phones BS
                            WHERE BS.ACCOUNT_ID = V.ACCOUNT_ID AND BS.PHONE_NUMBER = V.PHONE_NUMBER
                              AND BS.YEAR_MONTH = to_char(add_months(to_date(V.YEAR_MONTH, 'yyyymm'), 1), 'yyyymm'))
              AND EXISTS (SELECT 1 FROM db_loader_account_phones BS
                            WHERE BS.ACCOUNT_ID = V.ACCOUNT_ID AND BS.PHONE_NUMBER = V.PHONE_NUMBER
                              AND BS.YEAR_MONTH = V.YEAR_MONTH)
              AND not EXISTS (SELECT 1 FROM DB_LOADER_FULL_FINANCE_BILL fb
                                WHERE fb.ACCOUNT_ID = V.ACCOUNT_ID AND fb.YEAR_MONTH = v.YEAR_MONTH
                                  AND fb.PHONE_NUMBER = V.PHONE_NUMBER and fb.COMPLETE_BILL = 1 and nvl(fb.BAN, 0) <> -1 )) query_load
    from accounts ac,
         (select ACCOUNT_ID, YEAR_MONTH, sum(bill_count) bill_all_fb, 
                 sum(case when zero=1 then bill_count else 0 end) bill_nz_fb
            from (select ACCOUNT_ID, YEAR_MONTH, case when BILL_SUM = 0 then 0 else 1 end zero, count(*) bill_count
                    from DB_LOADER_FULL_FINANCE_BILL 
                    WHERE COMPLETE_BILL = 1 and phone_number <> '0000000000'
                    GROUP BY ACCOUNT_ID, YEAR_MONTH, case when BILL_SUM = 0 then 0 else 1 end)
            group by ACCOUNT_ID, YEAR_MONTH) b_fb,
         (select ACCOUNT_ID, YEAR_MONTH, sum(bill_count) bill_all_b, 
                 sum(case when zero=1 then bill_count else 0 end) bill_nz_b
            from (select ACCOUNT_ID, YEAR_MONTH, case when BILL_SUM = 0 then 0 else 1 end zero, count(*) bill_count
                    from DB_LOADER_BILLs
                    WHERE phone_number <> '0000000000'
                    GROUP BY ACCOUNT_ID, YEAR_MONTH, case when BILL_SUM = 0 then 0 else 1 end)
            group by ACCOUNT_ID, YEAR_MONTH) b_b
    where ac.ACCOUNT_ID = b_fb.ACCOUNT_ID(+)  
      and b_fb.ACCOUNT_ID = b_b.ACCOUNT_ID(+) 
      and b_fb.YEAR_MONTH = b_b.YEAR_MONTH(+)  
   -- order by b_fb.YEAR_MONTH desc, b_fb.ACCOUNT_ID asc 