CREATE OR REPLACE procedure CORP_MOBILE.p_new_tarif(tar_id in number) is --������������� ������

CURSOR c_contr is --��� ������, � ��������������� �����
select distinct(C.PHONE_NUMBER_FEDERAL) phone_NUMBERf from contracts c where C.CURR_TARIFF_ID=tar_id
;

phone_numberf contracts.PHONE_NUMBER_FEDERAL%TYPE;

--
begin
    open c_contr;
    
    loop--c_contr

        fetch c_contr into phone_numberf;
        exit when c_contr%notfound;
        INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE) VALUES(PHONE_NUMBERf, 51);
        commit;
        end 
    loop;--c_contr


end p_new_tarif;
/
