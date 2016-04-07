
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_DRAVE_INFO" ("PHONE_NUMBER_FEDERAL", "MONTHLY_PAYMENT") AS 
  select c.PHONE_NUMBER_FEDERAL, r.MONTHLY_PAYMENT
    from contracts c,
         contract_cancels cc,
         tariffs r
    where c.CONTRACT_ID = cc.CONTRACT_ID(+)
      and cc.CONTRACT_CANCEL_DATE is null
      and c.CURR_TARIFF_ID = r.TARIFF_ID(+)
      and r.DISCR_SPISANIE = 1
      and r.TARIFF_NAME like 'Драйв%'
      and exists (select 1
                    from db_loader_account_phone_hists h
                    where h.PHONE_NUMBER = c.PHONE_NUMBER_FEDERAL
                      and h.PHONE_IS_ACTIVE = 1
                      and h.END_DATE >= to_date('01'||TO_CHAR(SYSDATE, 'MMYYYY'),'ddmmyyyy'))
      and get_abonent_balance(c.PHONE_NUMBER_FEDERAL) < r.MONTHLY_PAYMENT 