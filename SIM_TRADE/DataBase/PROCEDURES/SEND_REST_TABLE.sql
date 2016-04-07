CREATE OR REPLACE PROCEDURE SEND_REST_TABLE AS
--
--Version=2
--
--v.2 Афросин 25.02.2015 - Переделки касательно текста сообщения и тарифов MSK1000_F
--v.1 Афросин 20.02.2015 - Добавил процедуру
--
CURSOR phones is
  select PHONE_NUMBER from USSD_TARIFF_REST_QUEUE;

C_CELL_PLAN_CODE  CONSTANT  VARCHAR2(9) := 'MSK1000_F'; 

res VARCHAR2(1000);
--призанк удаления строки международной связи - Международная связь
del_str boolean;

tar_count Integer; 


BEGIN

    
  for ph in phones loop
    del_str := false;
    tar_count := 0;
    
    --проверка на коллекторский счет и тариф  C_CELL_PLAN_CODE
    if GET_IS_COLLECTOR_BY_PHONE(ph.phone_number) = 1 then
      select 
        count(CELL_PLAN_CODE) into tar_count
        from db_loader_account_phones
             where year_month = to_number(to_char(sysdate, 'yyyymm'))
                and phone_number = ph.phone_number
                and CELL_PLAN_CODE = C_CELL_PLAN_CODE;
      if nvl(tar_count, 0) > 0 then
        del_str := TRUE;
      end if;
    end if; 
    
    

    res := 'Остаток:'||chr(13);
    for c in (
          select 
          --SOC_NAME,  -- Услуга
          REST_NAME,
          
          case 
            when CURR_VALUE < 0 then 0
            else
              CURR_VALUE
          end       
          
          ||
          
          CASE UNIT_TYPE
                when 'INTERNET' then 'Мб;'
                when 'SMS_MMS' then 'шт.;'
                when 'VOICE' then 'мин.;'
              else
                  ''
              end CURR_VALUE --Остаток,
              
          from table (TARIFF_RESTS_TABLE(ph.phone_number))
        ) loop
        
      if del_str AND UPPER(C.REST_NAME) = 'МЕЖДУНАРОДНАЯ СВЯЗЬ ЗОЛОТО' then
        NULL;
      else
        res := res ||c.REST_NAME||' - '||c.CURR_VALUE||chr(13);
      end if;
    end loop;
    
    
    res := LOADER3_PCKG.SEND_SMS(ph.phone_number, 'Остаток по пакетам', res );
    
    delete from USSD_TARIFF_REST_QUEUE where PHONE_NUMBER =ph.phone_number;
    commit;
  end loop;
END;
/