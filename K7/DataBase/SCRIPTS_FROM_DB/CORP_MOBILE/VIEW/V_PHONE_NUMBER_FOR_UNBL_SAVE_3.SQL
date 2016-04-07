
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_PHONE_NUMBER_FOR_UNBL_SAVE_3" ("PHONE_NUMBER", "BALANCE", "FIO", "ACCOUNT_ID", "HAND_BLOCK") AS 
  select  p.phone_number
--,cb.balance,cb.last_update,sum(p.payment_sum),sum(p.payment_sum)+cb.balance,
,get_abonent_balance(p.phone_number) BALANCE
,ab.surname|| ' ' ||ab.name|| ' ' ||ab.patronymic FIO
,ph.account_id
,decode(dg.hand_block,1,'Да',0,'Нет') hand_block
from db_loader_payments p,db_loader_account_phones ph,iot_current_balance cb
,contracts dg,tariffs tr,abonents ab
where
--связи
p.phone_number=ph.phone_number
and dg.phone_number_federal=ph.phone_number
and dg.dop_status is null
and cb.phone_number=p.phone_number
and dg.tariff_id=tr.tariff_id
and ab.abonent_id=dg.abonent_id
--отбор
and not exists(select 1 from contract_cancels cc where dg.contract_id=cc.contract_id)
and ph.year_month=(SELECT MAX (P2.YEAR_MONTH)
                               FROM DB_LOADER_ACCOUNT_PHONES P2
                               WHERE P2.ACCOUNT_ID = ph.account_id)
--and p.payment_date>cb.last_update
and p.payment_date>sysdate-3
and ph.phone_is_active=0
and ph.conservation=1
and ph.system_block!=1
and (dg.hand_block=0 or (dg.hand_block=1 and dg.hand_block_date_end<trunc(sysdate)))

--
group by ph.account_id, p.phone_number,cb.balance,dg.disconnect_limit,dg.connect_limit,tr.balance_unblock
--,cb.last_update
,ab.surname|| ' ' ||ab.name|| ' ' ||ab.patronymic
,dg.hand_block
having (cb.balance)- NVL (dg.disconnect_limit, 0)>NVL (dg.connect_limit, NVL (tr.balance_unblock, 0)) 