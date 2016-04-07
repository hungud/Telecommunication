
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_STAT_GROUP_CONTRACTS" ("PHONE_NUMBER", "PERIOD", "TARIFF_NAME", "TARIFF_CODE", "ABON_MAIN", "ABON_ADD", "GROUP_ID", "YEAR_MONTH", "OTHER_PAY") AS 
  select "PHONE_NUMBER","PERIOD","TARIFF_NAME","TARIFF_CODE","ABON_MAIN","ABON_ADD","GROUP_ID","YEAR_MONTH","OTHER_PAY" from 
(
   SELECT abon.phone_number,
             TO_CHAR (abon.date_begin, 'dd/mm')
          || ' - '
          || TO_CHAR (abon.date_end, 'dd/mm')
             period,
          t.tariff_name,
          abon.tariff_code,
          CASE NVL (abon.bill_abon, 0)
             WHEN 0
             THEN
                0
             ELSE
                NVL (
                   ROUND (
                      abon.abon_main * bill.ABON_TP_FULL_NEW / abon.bill_abon,
                      4),
                   0)
          END
             abon_main,
            abon.ABON_ADD
          + DECODE (
                  TO_CHAR (abon.date_begin, 'dd/mm')
               || ' - '
               || TO_CHAR (abon.date_end, 'dd/mm'),
                  TO_CHAR (bill.date_begin, 'dd/mm')
               || ' - '
               || TO_CHAR (bill.date_end, 'dd/mm'), NVL (bill.abon_add_new,
                                                         0),
               0)
             abon_add,
          abon.GROUP_ID,
          abon.year_month,
          0 OTHER_PAY
     FROM V_BILL_ABON_PER_FOR_GROUP abon
          LEFT JOIN tariffs t
             ON T.TARIFF_ID =
                   GET_PHONE_TARIFF_ID (abon.PHONE_NUMBER,
                                        abon.TARIFF_CODE,
                                        abon.DATE_END)
          LEFT JOIN
          TABLE (
             balance.GETTARIFFOPTIONADDBill (abon.ACCOUNT_ID,
                                             abon.year_month,
                                             abon.PHONE_NUMBER)) bill
             ON     abon.year_month = bill.year_month
                AND abon.date_begin = bill.date_begin
                AND abon.date_end = bill.date_end
   UNION ALL
     SELECT PHONE_NUMBER,
            null period,
            NULL tariff_name,
            NULL tariff_code,
            0 abon_main,
            0 abon_add,
            GROUP_ID,
            year_month,
            SUM (pay) other_pay
       FROM (SELECT D.PHONE_NUMBER,
                    d.GROUP_ID,
                    d.year_month,
                    D.DISCOUNT_NEW PAY
               FROM V_BILL_FINANCE_FOR_GROUP_DET d
              WHERE d.DISCOUNT_NEW <> 0
             UNION ALL
             SELECT D.PHONE_NUMBER,
                    d.GROUP_ID,
                    d.year_month,
                    D.SINGLE_PAYMENTS_NEW PAY
               FROM V_BILL_FINANCE_FOR_GROUP_DET d
              WHERE d.SINGLE_PAYMENTS_NEW <> 0)
   GROUP BY PHONE_NUMBER, GROUP_ID, year_month
   )
   
   union all
   
   select
    PHONE_NUMBER,
            '01/'||substr(db.YEAR_MONTH, 5,2) || ' - '||to_char(last_day( TO_DATE (db.YEAR_MONTH || '01', 'yyyymmdd')), 'dd') ||'/'||substr(db.YEAR_MONTH, 5,2)  period,
            NULL tariff_name,
            NULL tariff_code,
            0 abon_main,
            DB.SINGLE_ADD abon_add,
            GROUP_ID,
            year_month,
            0 other_pay
   
     from DB_LOADER_FULL_FINANCE_BILL db,
    V_CONTRACTS C
    WHERE     db.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
          AND C.CONTRACT_DATE <
                 ADD_MONTHS (TO_DATE (db.YEAR_MONTH || '01', 'yyyymmdd'), 1)
          AND (   C.CONTRACT_CANCEL_DATE IS NULL
               OR C.CONTRACT_CANCEL_DATE >=
                     TO_DATE (db.YEAR_MONTH || '01', 'yyyymmdd'))
          and DB.SINGLE_ADD <> 0
          AND C.GROUP_ID IS NOT NULL