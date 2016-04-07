CREATE OR REPLACE procedure CORP_MOBILE.p_everyday_pay is 

CURSOR c_ep is 
select phone_NUMBER phone_NUMBERf from (select AP.PHONE_NUMBER from DB_LOADER_ACCOUNT_PHONES AP
where AP.YEAR_MONTH=to_char(sysdate,'YYYYMM')
and NVL(AP.CONSERVATION,0) <> 1
UNION
select AP.PHONE_NUMBER from DB_LOADER_ACCOUNT_PHONES AP
where AP.YEAR_MONTH=to_char(sysdate,'YYYYMM')
and NVL(AP.CONSERVATION,0) = 1
and AP.PHONE_NUMBER in ( Select distinct APH.PHONE_NUMBER 
                            from DB_LOADER_ACCOUNT_PHONE_HISTS APH
                            where (trunc(APH.DATE_LAST_UPDATED) > trunc(sysdate)-31)    
                            AND APH.PHONE_IS_ACTIVE=1 )) NT
;

phone_numberf DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER%TYPE;

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


end p_everyday_pay;
/
