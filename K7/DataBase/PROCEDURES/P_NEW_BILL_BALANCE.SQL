CREATE OR REPLACE procedure CORP_MOBILE.p_new_bill_balance(acc_id in number, yearmonth in number) is --идентификатор аккаунта

CURSOR c_bb is --все номера, у которыхзаданный тариф
select distinct(AP.PHONE_NUMBER) phone_NUMBERf from DB_LOADER_ACCOUNT_PHONES ap 
where AP.YEAR_MONTH=yearmonth and AP.ACCOUNT_ID=acc_id
;

phone_numberf DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER%TYPE;

--
begin
    open c_bb;
    
    loop--c_bb

        fetch c_bb into phone_numberf;
        exit when c_bb%notfound;
        INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE) VALUES(PHONE_NUMBERf, 44);
        commit;
        end 
    loop;--c_bb


end p_new_bill_balance;
/
