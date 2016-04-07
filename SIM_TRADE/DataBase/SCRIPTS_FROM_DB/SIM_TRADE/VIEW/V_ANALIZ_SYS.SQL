
  CREATE OR REPLACE FORCE VIEW "SIM_TRADE"."V_ANALIZ_SYS" ("ACC", "COL", "MESSAGE") AS 
  select to_char(acc.account_id)as acc,null as col,'Встали платежи' message
from accounts acc where
not exists (select 1 from account_load_logs t where t.load_date_time>sysdate-30/1440
           and t.is_success=1
           and t.account_load_type_id=1
           and acc.account_id=t.account_id) and acc.account_id not in (93,225,98)
union all
select to_char(acc.account_id)as acc,null as col,'Встали статусы' message
from accounts acc where
not exists (select 1 from account_load_logs t where t.load_date_time>sysdate-30/1440
           and t.is_success=1
           and t.account_load_type_id=3
           and acc.account_id=t.account_id) and acc.account_id not in (93,225,98)
union all
select to_char(acc.account_id)as acc,null as col,'Встали начисления' message
from accounts acc where
not exists (select 1 from account_load_logs t where t.load_date_time>sysdate-30/1440
           and t.is_success=1
           and t.account_load_type_id=6
           and acc.account_id=t.account_id) and acc.account_id not in (93,225,98)
union all
select to_char(acc.account_id)as acc,null as col,'Встали услуги' message
from accounts acc where
not exists (select 1 from account_load_logs t where t.load_date_time>sysdate-1
           and t.is_success=1
           and t.account_load_type_id=4
           and acc.account_id=t.account_id) and acc.account_id not in (93,225,98)
union all
select to_char(acc.account_id)as acc,null as col,'Нет блоков' message
from accounts acc where
(not exists (select 1 from account_load_logs t where t.load_date_time>sysdate-3/24
           and t.is_success=1
           and t.account_load_type_id=9
           and acc.account_id=t.account_id)
and not exists(select 1 from  loader_call_n_log t
               where t.report_type in (9)
               and t.load_date>sysdate-3/24
               and t.file_name like '%OK'
               and t.account_id=acc.account_id
              )
)
and acc.account_id not in (98,96,225)
union all
select to_char(acc.account_id)as acc,null as col,'Нет разблоков' message
from accounts acc where
(not exists (select 1 from account_load_logs t where t.load_date_time>sysdate-3/24
           and t.is_success=1
           and t.account_load_type_id=9
           and acc.account_id=t.account_id)
and not exists(select 1 from  loader_call_n_log t
               where t.report_type in (10)
               and t.load_date>sysdate-3/24
               and t.file_name like '%OK'
               and t.account_id=acc.account_id
              )
)
and acc.account_id not in (98,96,225)
union all
select to_char(ph.account_id)as acc/*,ph.phone_number--*/,count(ph.account_id) col,'Абон.с низким балансом вне сохр.' message
from iot_current_balance t,db_loader_account_phones ph,contracts c
 where ((t.balance<-1000 and nvl(c.disconnect_limit,0)=0)
        or (t.balance-c.disconnect_limit)<-1000)
and c.phone_number_federal=ph.phone_number and c.hand_block!=1
and ph.phone_number=t.phone_number and ph.year_month=to_char(sysdate,'YYYYMM')
and ph.conservation<1
and not exists(select 1 from contract_cancels cc where cc.contract_id=c.contract_id)

group by  ph.account_id
union all
select to_char(account_id)as acc,count(phone_number) col,'Дубли начислений более 3-х мес.' message
from (
      select ph.account_id,t.phone_number,get_abonent_balance(t.phone_number)
      from db_loader_report_data t, db_loader_account_phones ph
      where t.year_month in (to_char(sysdate,'YYYYMM'),to_char(add_months(sysdate,-1),'YYYYMM'),to_char(add_months(sysdate,-2),'YYYYMM')) and t.detail_sum>0
      and ph.phone_number=t.phone_number and ph.year_month=to_char(sysdate,'YYYYMM') and ph.phone_is_active=0
      group by ph.account_id,t.phone_number,t.detail_sum
      having count(t.phone_number)=3
      )
group by account_id
union all
select regexp_substr(t.error_text,'http://\d+\.\d+\.\d+\.\d+') as acc,count(t.account_id) col, 'Заболел сервер' message
from account_load_logs t where
t.load_date_time between (sysdate-15/1440) and (sysdate)
and regexp_substr(t.error_text,'http://\d+\.\d+\.\d+\.\d+')is not null
group by regexp_substr(t.error_text,'http://\d+\.\d+\.\d+\.\d+')
having count(t.account_id)>0.5*(select count(*) from accounts)
