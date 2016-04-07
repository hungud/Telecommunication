
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."P_EVERYDAY_PAY" is 

CURSOR c_ep is 
select distinct CC.PHONE_NUMBER_FEDERAL phone_NUMBERf from CONTRACTS cc
where CC.PHONE_NUMBER_FEDERAL in (select AP.PHONE_NUMBER 
                                    from DB_LOADER_ACCOUNT_PHONES AP
                                    where AP.YEAR_MONTH=to_char(sysdate,'YYYYMM')
                                    and NVL(AP.CONSERVATION,0) <> 1
                                  UNION
                                  select AP.PHONE_NUMBER 
                                    from DB_LOADER_ACCOUNT_PHONES AP
                                    where AP.YEAR_MONTH=to_char(sysdate,'YYYYMM')
                                    and NVL(AP.CONSERVATION,0) = 1
                                    and AP.PHONE_NUMBER in ( Select distinct APH.PHONE_NUMBER 
                                                                from DB_LOADER_ACCOUNT_PHONE_HISTS APH
                                                                where (trunc(APH.DATE_LAST_UPDATED) > trunc(sysdate)-31)    
                                                                AND APH.PHONE_IS_ACTIVE=1 ))
and CC.IS_CREDIT_CONTRACT IS NULL--NVL(CC.IS_CREDIT_CONTRACT,0) = 0
and CC.TARIFF_ID in (select T.TARIFF_ID 
                    from TARIFFS t
                    where nvl(T.MONTHLY_PAYMENT,0) > 0)
and CC.CONTRACT_ID not in (select CCC.CONTRACT_ID 
                            from CONTRACT_CANCELS ccc)
;

CURSOR c_ips is
select phone_number_federal phone_NUMBERf2
from contracts 
where INSTALLMENT_PAYMENT_SUM is not null
;


phone_numberf DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER%TYPE;
phone_numberf2 contracts.phone_number_federal%TYPE;

--
begin
    open c_ep;
    
    loop--c_ep

        fetch c_ep into phone_numberf;
        exit when c_ep%notfound;
        INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE) VALUES(PHONE_NUMBERf, 49);
        commit;
        end 
    loop;--c_ep


    open c_ips;
    
    loop--c_ips

        fetch c_ips into phone_numberf2;
        exit when c_ips%notfound;
        INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE) VALUES(PHONE_NUMBERf2, 53);
        commit;
        end 
    loop;--c_ips


end p_everyday_pay;