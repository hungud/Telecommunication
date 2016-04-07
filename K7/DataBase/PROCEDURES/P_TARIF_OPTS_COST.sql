CREATE OR REPLACE procedure p_tarif_opts_cost(opt_id in number) is --идентификатор тарифа
-- Version = 2
-- v.2 31.08.2015 Соколов убрал обращение к таблицы TARIFF_OPTION_COSTS
CURSOR c_contr is --все номера, у которыхзаданный тариф
select distinct(OPT.PHONE_NUMBER) phone_NUMBERf from DB_LOADER_ACCOUNT_PHONE_OPTS opt 
where OPT.OPTION_CODE=(select TOq.OPTION_CODE
                        from TARIFF_OPTIONS TOq
                        where TOq.TARIFF_OPTION_ID=opt_id) 
and OPT.YEAR_MONTH = to_char(sysdate,'YYYYMM')
;

phone_numberf contracts.PHONE_NUMBER_FEDERAL%TYPE;

--
begin
   /* open c_contr;
    
    loop--c_contr

        fetch c_contr into phone_numberf;
        exit when c_contr%notfound;
        INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE) VALUES(PHONE_NUMBERf, 52);
        end 
    loop;--c_contr*/
  for rec in c_contr 
  loop
    INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE) VALUES(rec.phone_NUMBERf , 52);
  end loop;

end p_tarif_opts_cost;
/