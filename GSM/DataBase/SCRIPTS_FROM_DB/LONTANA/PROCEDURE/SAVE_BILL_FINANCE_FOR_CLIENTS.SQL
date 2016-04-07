
  CREATE OR REPLACE PROCEDURE "LONTANA"."SAVE_BILL_FINANCE_FOR_CLIENTS" (
  pYEAR_MONTH IN INTEGER
  ) IS
-- Version = 1  
-- Сохранение(фиксация) детальных счетов по месяц
begin
  for rec in(
    select V.*
      from V_BILL_FINANCE_FOR_CLIENTS V
      where V.YEAR_MONTH<=pYEAR_MONTH
        AND V.COMPLETE_BILL = 1
        AND NOT EXISTS (SELECT 1
                          FROM BILL_FINANCE_FOR_CLIENTS_SAVED BS
                          WHERE BS.ACCOUNT_ID = V.ACCOUNT_ID
                            AND BS.YEAR_MONTH = V.YEAR_MONTH
                            AND BS.PHONE_NUMBER = V.PHONE_NUMBER)
        )
  loop
    insert into BILL_FINANCE_FOR_CLIENTS_SAVED(
        ACCOUNT_ID, YEAR_MONTH, PHONE_NUMBER, BILL_SUM_OLD, BILL_SUM_NEW, 
        ABON_TP_OLD, ABON_TP_NEW, ABON_ADD_OLD, ABON_ADD_NEW, 
        DISCOUNT_OLD, DISCOUNT_NEW, SINGLE_PENALTI, 
        SINGLE_PAYMENTS_OLD, SINGLE_PAYMENTS_NEW, 
        CALLS_COUNTRY, CALLS_SITY, CALLS_LOCAL, 
        CALLS_SMS_MMS, CALLS_GPRS, CALLS_RUS_RPP, COMPLETE_BILL)
      values(
        rec.ACCOUNT_ID, rec.YEAR_MONTH, rec.PHONE_NUMBER, rec.BILL_SUM_OLD, rec.BILL_SUM_NEW, 
        rec.ABON_TP_OLD, rec.ABON_TP_NEW, rec.ABON_ADD_OLD, rec.ABON_ADD_NEW, 
        rec.DISCOUNT_OLD, rec.DISCOUNT_NEW, rec.SINGLE_PENALTI, 
        rec.SINGLE_PAYMENTS_OLD, rec.SINGLE_PAYMENTS_NEW, 
        rec.CALLS_COUNTRY, rec.CALLS_SITY, rec.CALLS_LOCAL, 
        rec.CALLS_SMS_MMS, rec.CALLS_GPRS, rec.CALLS_RUS_RPP, rec.COMPLETE_BILL);
  end loop;
  commit;
end; 