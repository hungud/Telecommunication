CREATE OR REPLACE procedure CORP_MOBILE.p_new_tarif_opts(opt_code in varchar2) is --код тарифной опции

CURSOR c_opt is --все номера, у которых заданная тарифная опция
select distinct(OPT.PHONE_NUMBER) phone_NUMBERf from DB_LOADER_ACCOUNT_PHONE_OPTS opt 
where OPT.OPTION_CODE=opt_code and OPT.YEAR_MONTH = to_char(sysdate,'YYYYMM')
;

phone_numberf DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER%TYPE;

--
begin
    open c_opt;
    
    loop--c_opt

        fetch c_opt into phone_numberf;
        exit when c_opt%notfound;
        INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE) VALUES(PHONE_NUMBERf, 52);
        commit;
        end 
    loop;--c_opt


end p_new_tarif_opts;
/
