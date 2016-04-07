CREATE OR REPLACE VIEW V_DRAVE_INFO AS
  select c.PHONE_NUMBER_FEDERAL, r.MONTHLY_PAYMENT
    from contracts c,
         contract_cancels cc,
         tariffs r
    where c.CONTRACT_ID = cc.CONTRACT_ID(+)
      and cc.CONTRACT_CANCEL_DATE is null
      and c.CURR_TARIFF_ID = r.TARIFF_ID(+)
      and r.DISCR_SPISANIE = 1
      and r.TARIFF_NAME like 'ִנאיג%'
      and exists (select 1
                    from db_loader_account_phone_hists h
                    where h.PHONE_NUMBER = c.PHONE_NUMBER_FEDERAL
                      and h.PHONE_IS_ACTIVE = 1
                      and h.END_DATE >= to_date('01'||TO_CHAR(SYSDATE, 'MMYYYY'),'ddmmyyyy'))
      and get_abonent_balance(c.PHONE_NUMBER_FEDERAL) < r.MONTHLY_PAYMENT;

GRANT SELECT ON V_DRAVE_INFO TO CORP_MOBILE_ROLE;

GRANT SELECT ON V_DRAVE_INFO TO CORP_MOBILE_ROLE_RO;

CREATE SYNONYM CRM_USER.V_DRAVE_INFO FOR V_DRAVE_INFO;


GRANT SELECT ON V_DRAVE_INFO TO CRM_USER;
