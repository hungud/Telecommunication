CREATE OR REPLACE Procedure EXPRESS_UNLOCK_PHONES IS   
--
--v4. Алексеев. Добавил активные обещаные платежи
--v3. Алексеев. Добавил проверку поля dg.hand_block на NVL (NVL(dg.hand_block,0)=0)
--v2. Алекссев. Заменил dg.tariff_id на dg.curr_tariff_id (т.к. dg.tariff_id это первоначальный тариф на номере, а dg.curr_tariff_id - код текущего тарифного плана)
--v1. Алексеев. Добавил скрипт (отсутствовал)  
    Respond varchar2(1000);
    TYPE acc_unbk IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    acc_ok acc_unbk;
    acc_err acc_unbk;
    s_ok number;
    s_err number;
  BEGIN
    for C in (
      select  p.phone_number
            --,cb.balance,cb.last_update,sum(p.payment_sum),sum(p.payment_sum)+cb.balance,
            ,get_abonent_balance(p.phone_number) BALANCE
            ,ab.surname|| ' ' ||ab.name|| ' ' ||ab.patronymic FIO
            ,(select account_id from db_loader_account_phones ph 
                where ph.PHONE_NUMBER = p.phone_number and ph.YEAR_MONTH = to_char(sysdate,'yyyymm') 
                  and ph.PHONE_IS_ACTIVE = 0 and ph.SYSTEM_BLOCK = 0 and rownum <=1 ) account_id
            ,decode(NVL(dg.hand_block,0),1,'Да',0,'Нет') hand_block
      from (SELECT 
	          lp.PHONE_NUMBER,
			  lp.DATE_CREATED,
			  lp.YEAR_MONTH
            FROM DB_LOADER_PAYMENTS lp
            UNION ALL
            SELECT 
			  pp.PHONE_NUMBER,
			  pp.DATE_CREATED,
              to_number(to_char(PAYMENT_DATE, 'YYYYMM')) YEAR_MONTH
            FROM V_ACTIVE_PROMISED_PAYMENTS pp) p
	        ,iot_current_balance cb
            ,contracts dg,tariffs tr,abonents ab
            where
            --связи
                dg.phone_number_federal=p.phone_number
            and dg.dop_status is null
            and cb.phone_number=p.phone_number
            and dg.curr_tariff_id=tr.tariff_id
            and ab.abonent_id=dg.abonent_id
            --отбор
            and not exists(select 1 from beeline_tickets bt where bt.phone_number=p.phone_number 
                                                              and bt.date_create>sysdate-1/24 and bt.ticket_type=10)
            and not exists(select 1 from contract_cancels cc where dg.contract_id=cc.contract_id)
            and exists (select 1 
                          from db_loader_account_phones ph 
                          where ph.PHONE_NUMBER = p.phone_number 
                            and ph.YEAR_MONTH = to_char(sysdate,'yyyymm') 
                            and ph.PHONE_IS_ACTIVE = 0 
                            and ph.SYSTEM_BLOCK! = 1 )
            --and p.payment_date>cb.last_update
--            and p.payment_date>sysdate-1
            and p.date_created>sysdate-1
            and p.YEAR_MONTH >=to_number(to_char(sysdate-1,'yyyymm'))
            and (NVL(dg.hand_block,0)=0 or (NVL(dg.hand_block,0)=1 and dg.hand_block_date_end<trunc(sysdate)))
            --
            group by p.phone_number,cb.balance,dg.disconnect_limit,dg.connect_limit,tr.balance_unblock
            --,cb.last_update
            ,ab.surname|| ' ' ||ab.name|| ' ' ||ab.patronymic
            ,dg.hand_block
            having (cb.balance)- NVL (dg.disconnect_limit, 0)>NVL (dg.connect_limit, NVL (tr.balance_unblock, 0))
           )
    LOOP
      Begin
        if instr(BEELINE_API_PCKG.phone_status(c.phone_number),'ACTIVE')<=0 then--проверяем текущий статус
          Respond:=BEELINE_API_PCKG.UNLOCK_PHONE(c.phone_number,0);
          if regexp_instr(Respond,'Заявка на разблок №\d+')>0 then
                 case 
                   when acc_ok.exists(c.account_id) 
                      then acc_ok(c.account_id):=acc_ok(c.account_id)+1;
                   else acc_ok(c.account_id):=1;
                  end case;
          else 
                 case 
                   when acc_err.exists(c.account_id) 
                      then acc_err(c.account_id):=acc_err(c.account_id)+1;
                   else acc_err(c.account_id):=1;
                  end case;
          end if;
        end if;
      exception
        when others then 
          case 
            when acc_err.exists(c.account_id) 
              then acc_err(c.account_id):=acc_err(c.account_id)+1;
            else acc_err(c.account_id):=1;
          end case;
      end;
    end loop;
   --Логирование
    for acc in (select t.account_id from accounts t)
    loop
      if acc_ok.exists(acc.account_id)  
        or acc_err.exists(acc.account_id) then
        case 
          when acc_ok.exists(acc.account_id) 
            then  s_ok:=acc_ok(acc.account_id); 
          else  s_ok:=0; 
        end case;
        case 
          when acc_err.exists(acc.account_id) 
            then s_err:=acc_err(acc.account_id); 
          else s_err:=0; 
        end case;     
        insert into account_load_logs(account_load_log_id, account_id, load_date_time, is_success
                                      , error_text, account_load_type_id)
          values (s_new_account_load_log_id.nextval, acc.account_id,sysdate, decode(to_char(s_err),0,1,0)
                  ,'Заявок поставлено:'||s_ok||',Ошибок:'||s_err,10);
      end if;
    end loop acc;
    commit;
  END;
/
