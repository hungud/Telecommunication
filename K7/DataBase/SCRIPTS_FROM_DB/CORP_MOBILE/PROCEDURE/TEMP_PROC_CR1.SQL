
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."TEMP_PROC_CR1" is
begin
  for rec in (select distinct YEAR_MONTH
                from db_loader_bills 
                order by YEAR_MONTH asc)
  loop
    insert into TARIFER_BILL_FOR_CLIENTS(YEAR_MONTH, PHONE_NUMBER, BILL_SUMM,
                                         ABON_TP, ABON_ADD, DISCOUNT,
                                         SINGLE_PAYMENTS, SINGLE_CHANGE_TARIFF, CALLS,
                                         CALLS_COUNTRY, CALLS_SITY, CALLS_LOCAL,
                                         CALLS_SMS_MMS, CALLS_GPRS, CALLS_RUS_RPP, 
                                         CALLS_ALL, ROUMING_NATIONAL, ROUMING_INTERNATIONAL)
      select v.YEAR_MONTH, 
             v.PHONE_NUMBER, 
             nvl(sum(v.BILL_SUM ), 0) BILL_SUMM,
             nvl(sum(v.SUBSCRIBER_PAYMENT_NEW ), 0) ABON_TP,
             nvl(sum(0 ), 0) ABON_ADD,
             nvl(sum(v.DISCOUNT_VALUE ), 0) DISCOUNT,
             nvl(sum(0 ), 0) SINGLE_PAYMENTS,
             0 SINGLE_CHANGE_TARIFF,
             nvl(sum(0), 0) CALLS,
             nvl(sum(0), 0) CALLS_COUNTRY,
             nvl(sum(0), 0) CALLS_SITY,
             nvl(sum(0), 0) CALLS_LOCAL,
             nvl(sum(0), 0) CALLS_SMS_MMS,
             nvl(sum(0), 0) CALLS_GPRS,
             nvl(sum(0), 0) CALLS_RUS_RPP,
             nvl(sum(0), 0) CALLS_ALL,
             nvl(sum(0), 0) ROUMING_NATIONAL,
             nvl(sum(0), 0) ROUMING_INTERNATIONAL
        FROM V_BILL_FOR_CLIENT v,
             TARIFER_BILL_FOR_CLIENTS
        WHERE (v.ACCOUNT_ID, v.YEAR_MONTH) in (select ab.ACCOUNT_ID, ab.YEAR_MONTH
                                                     from account_loaded_bills ab
                                                     where ab.load_bill_in_balance = 1)
          and TARIFER_BILL_FOR_CLIENTS.YEAR_MONTH(+) = v.YEAR_MONTH
          and TARIFER_BILL_FOR_CLIENTS.PHONE_NUMBER(+) = v.PHONE_NUMBER
          and TARIFER_BILL_FOR_CLIENTS.BILL_SUMM is null
          and v.YEAR_MONTH = rec.year_month
        group by v.YEAR_MONTH, v.PHONE_NUMBER;
    commit;
  end loop;
end; 