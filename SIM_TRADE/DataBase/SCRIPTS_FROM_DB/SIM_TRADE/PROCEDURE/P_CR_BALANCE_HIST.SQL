
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."P_CR_BALANCE_HIST" (onlycontracts in number default null,
                                              p_exist_contract in number default null
                                              ) is
Type Thistory is record (-- iot_balance_history%rowtype;
 phone number
,st_date date
,end_date date
,last_update date
,balance number
);
history Thistory;
old_history Thistory;

cursor c_dbl is --все номера (и с контрактом и без)
select distinct(dbl.phone_number),sysdate,null,sysdate,null from db_loader_account_phones dbl
;
cursor c_contr(exst number) is --курсор по контрактам (если exst!=null) то по действующим
select c.phone_number_federal,sysdate,null,sysdate,null from contracts c,contract_cancels cc
 where c.contract_id=cc.contract_id(+)
 and ((exst is not null and cc.contract_cancel_id is not null) or exst is null)
group by c.phone_number_federal
;
cursor c_hist(p_phone number) is--курсор по истории балансов с блокировкой
select bh.* from iot_balance_history bh where bh.phone_number=p_phone and bh.end_time is null
for update
;
begin
if onlycontracts is not null then open c_contr(p_exist_contract);
else open c_dbl;end if;
loop--c_contr
if onlycontracts is not null then fetch c_contr into history; exit when c_contr%notfound;
else fetch c_dbl into history;exit when c_dbl%notfound; end if;
  history.balance:=get_abonent_balance(history.phone);
       open c_hist(history.phone);
       fetch c_hist into old_history;
       if c_hist%notfound then
         insert into iot_balance_history values history;
       elsif history.balance!=old_history.balance then
         update iot_balance_history t set t.end_time=sysdate where t.phone_number=old_history.phone and t.end_time is null;
         insert into iot_balance_history values history;
       else
         update iot_balance_history t set t.last_update=history.last_update where t.phone_number=old_history.phone and t.end_time is null;
       end if;
       commit;
       close c_hist;
end loop;--c_contr

end p_cr_balance_hist;
