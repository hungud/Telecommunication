
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_TEMP3" ("SUBSCR_NO") AS 
  select cb.SUBSCR_NO
    from (select distinct ca.SUBSCR_NO
            from call_10_2013 ca
            where ca.AT_FT_DE <> 'Тарификация услуг SMS/RBT_CPA'
              and nvl(ca.CALLING_NO, ca.SUBSCR_NO) <> '0611'
              and nvl(ca.CALLING_NO, ca.SUBSCR_NO) <> '0622'
              and nvl(ca.DIALED_DIG, ca.SUBSCR_NO) <> '0611'
              and nvl(ca.DIALED_DIG, ca.SUBSCR_NO) <> '0622'
            /*  and exists (select 1
                            from contracts c, contract_cancels cc
                            where c.PHONE_NUMBER_FEDERAL = ca.SUBSCR_NO
                              and c.CONTRACT_ID = cc.CONTRACT_ID(+)
                              and cc.CONTRACT_CANCEL_DATE is null)*/
                              ) cb
    where exists (select 1
                    from contracts c, contract_cancels cc
                    where c.PHONE_NUMBER_FEDERAL = cb.SUBSCR_NO
                      and c.CONTRACT_ID = cc.CONTRACT_ID(+)
                      and cc.CONTRACT_CANCEL_DATE is null) 