
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."CALC_BALANCE_ROWS_ALL" IS
--#Version=2
--
-- 2. 2015.10.29. Крайнов. 
  L BINARY_INTEGER;
BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE ABONENT_BALANCE_ROWS_ALL'; 
  commit;
  for rec in (select d.PHONE_NUMBER
                from db_loader_phone_periods d
                where d.YEAR_MONTH = TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYYMM'))
                  and not exists (select 1
                                    from tarifer_bill_for_clients v
                                    where v.YEAR_MONTH = d.YEAR_MONTH
                                      and v.PHONE_NUMBER = d.PHONE_NUMBER)
             )
  loop
    CALC_BALANCE_ROWS_NO_CREDIT(rec.PHONE_NUMBER);
    insert into ABONENT_BALANCE_ROWS_ALL(phone_number, ROW_DATE, ROW_COST, ROW_COMMENT)
      select rec.PHONE_NUMBER, ROW_DATE, ROW_COST, ROW_COMMENT  
        from ABONENT_BALANCE_ROWS;
    commit;
  end loop;
  update ABONENT_BALANCE_ROWS_ALL
    set ROW_TYPE = case
                     when ROW_COMMENT LIKE '1 Абонплата%' then 1
                     when ROW_COMMENT LIKE '2 Абонплата за услугу%' then 2
                     when ROW_COMMENT LIKE 'Дет. зв. из тек. нач.%' then 3
                     when ROW_COMMENT LIKE 'Детализация звонков%' then 4
                     when ROW_COMMENT LIKE 'Подключена услуга%' then 5                     
                     when ROW_COMMENT LIKE 'Рассрочка:%' then 6  
                     when ROW_COMMENT LIKE 'Депозит клиента%' then 7 
                     when ROW_COMMENT LIKE 'Добровольная блокировка номера (3р в день)' then 8  
                     when ROW_COMMENT LIKE 'Счёт%' then 10
                     when ROW_COMMENT LIKE 'Оплата: Стартовый баланс%' then 11
                     when ROW_COMMENT LIKE 'Оплата: Зарегистрирован в офисе:%' then 12
                     when ROW_COMMENT LIKE 'Оплата Компенсирующая:%' then 13
                     when ROW_COMMENT LIKE 'Стартовый баланс' then 14
                     when ROW_COMMENT LIKE 'Оплата:%' then 20
                     else -1
                   end;
  COMMIT;
END; 