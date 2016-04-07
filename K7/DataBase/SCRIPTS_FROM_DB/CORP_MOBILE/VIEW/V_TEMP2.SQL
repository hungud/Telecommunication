
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_TEMP2" ("SUBSCR_NO") AS 
  select cb.SUBSCR_NO
    from v_temp1 cb
    where exists (select 1
                    from contracts c, contract_cancels cc
                    where c.PHONE_NUMBER_FEDERAL = cb.SUBSCR_NO
                      and c.CONTRACT_ID = cc.CONTRACT_ID(+)
                      and cc.CONTRACT_CANCEL_DATE is null) 