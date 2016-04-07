CREATE OR REPLACE PROCEDURE PARSE_VIRT_ACCOUNT_FILES
--
--#Version=3
--
--v.3 Афросин 16.02.2016 - Изменения касательно новой структуры
--v.2 Кочнев 03.12.2015 - Парсер данных добавляет данные в договора
--v.1 Кочнев 25.11.2015 - Парсер данных из временного файла виртуальных счетов
AS
  v_NUMBERS               VARCHAR2(256);
  v_NUMBERS2              VARCHAR2(256);
  v_INN                   INTEGER;
  v_VIRTUAL_ACCOUNTS_ID   INTEGER;
  pos                     INTEGER;
  v_number_phone          varchar2(50);
  v_phone_number          varchar2(50);
  v_PHONE_ON_ACCOUNTS_ID  INTEGER;
  cnt_ACCOUNTS_ID         INTEGER;
  undefined_MO_ID         INTEGER;
  undefined_Account_ID    INTEGER;
  v_PHONE_ID              INTEGER;
  v_COUNTRY_ID            INTEGER;
  v_REGIONS_ID            INTEGER;
  v_NAME                  VARCHAR2(256);  --(100)
  v_EMAIL                 VARCHAR2(100); -- (50)
  cnt_ABONENT_ID          INTEGER; 
  undefined_FILIAL_ID     INTEGER; 
  undefined_TARIFF_ID     INTEGER; 
  v_CONTRACT_ID           INTEGER; 
  undefined_ABONENT_ID    INTEGER; 
  cnt_VIRTUAL_ACCOUNTS_ID INTEGER; 
  cnt_PHONE_ID            INTEGER;
  cnt_CONTRACT_ID         INTEGER;
  
  type t_VAT_cursor is  ref cursor;
  cursor Parse_file is
    SELECT FILE_ID, FILE_NAME
    FROM VIRT_ACCOUNT_FILES 
    where PARSER_END_DATE  is null 
      and LOAD_END_DATE is not null
    order by file_id;    
  VAT_cursor t_VAT_cursor;
  
begin
  
  cnt_VIRTUAL_ACCOUNTS_ID := 0;
  cnt_PHONE_ID            := 0;
  cnt_CONTRACT_ID         := 0;
  
  select count(MOBILE_OPERATOR_NAME_ID) into cnt_ACCOUNTS_ID
    from MOBILE_OPERATOR_NAMES
   where MOBILE_OPERATOR_NAME = 'Неопределенный мобильный оператор';
   
  if cnt_ACCOUNTS_ID = 0 then
    INSERT INTO MOBILE_OPERATOR_NAMES (MOBILE_OPERATOR_NAME_ID, MOBILE_OPERATOR_NAME)
             VALUES (S_NEW_MOBILE_OPERATOR_NAME_ID.NEXTVAL, 'Неопределенный мобильный оператор')
    RETURNING MOBILE_OPERATOR_NAME_ID into undefined_MO_ID;
  else
    select MOBILE_OPERATOR_NAME_ID into undefined_MO_ID
      from MOBILE_OPERATOR_NAMES
     where MOBILE_OPERATOR_NAME = 'Неопределенный мобильный оператор';
  end if; 


  -----------------найдем неопределенный филиал
  select count(FILIAL_ID) into cnt_ACCOUNTS_ID
    from FILIALS
   where FILIAL_NAME = 'Неопределенный филиал';
  if cnt_ACCOUNTS_ID = 0 then
    INSERT INTO FILIALS (FILIAL_ID, FILIAL_NAME)
             VALUES (S_NEW_FILIALS.NEXTVAL, 'Неопределенный филиал')
    RETURNING FILIAL_ID into undefined_FILIAL_ID;
  else
    select FILIAL_ID into undefined_FILIAL_ID
      from FILIALS
     where FILIAL_NAME = 'Неопределенный филиал';
  end if;
 ---------------------------------------------
 
 select count(ACCOUNT_ID) into cnt_ACCOUNTS_ID
    from ACCOUNTS
   where LOGIN = 'Неопределен';
  if cnt_ACCOUNTS_ID = 0 then
    INSERT INTO ACCOUNTS (ACCOUNT_ID, FILIAL_ID, ACCOUNT_NUMBER, LOGIN, PASSWORD)
             VALUES (S_NEW_ACCOUNT_ID.NEXTVAL, undefined_FILIAL_ID, 0, 'Неопределен', 'Неопределен')
    RETURNING ACCOUNT_ID into undefined_Account_ID;
  else
    select ACCOUNT_ID into undefined_Account_ID
      from ACCOUNTS
     where LOGIN = 'Неопределен';
  end if;
     

 -----------------найдем неопределенный тариф
   select count(TARIFF_ID) into cnt_ACCOUNTS_ID
    from TARIFFS
   where TARIFF_NAME = 'Неопределенный тариф';  
 if cnt_ACCOUNTS_ID = 0 then
    INSERT INTO TARIFFS (TARIFF_ID, TARIFF_CODE, TARIFF_NAME, FILIAL_ID)
             VALUES (S_NEW_TARIFFS.NEXTVAL, 'NO_TARIFF_CODE', 'Неопределенный тариф', undefined_FILIAL_ID)
    RETURNING TARIFF_ID into undefined_TARIFF_ID;
  else
    select TARIFF_ID into undefined_TARIFF_ID
      from TARIFFS
     where TARIFF_NAME = 'Неопределенный тариф';
  end if; 
 ---------------------------------------------


  select min(COUNTRY_ID) into v_COUNTRY_ID
    from COUNTRIES  
   where  IS_DEFAULT = 1;

  select min(REGIONS_ID) into v_REGIONS_ID
    from REGIONS
    where COUNTRY_ID = v_COUNTRY_ID;


  select count(P.ABONENT_ID) into cnt_ABONENT_ID
    from ABONENTS p
   where (upper(P.SURNAME) = 'НЕТ ДАННЫХ');

  if cnt_ABONENT_ID = 0 then
    insert into ABONENTS (ABONENT_ID, SURNAME, COUNTRY_ID_CITIZENSHIP, REGION_ID, COUNTRY_ID, DESCRIPTION)
                 values(S_NEW_ABONENT_ID.NEXTVAL, 'НЕТ ДАННЫХ', v_COUNTRY_ID, v_REGIONS_ID, v_COUNTRY_ID, 'Запись используется по умолчанию')
              RETURNING ABONENT_ID into undefined_ABONENT_ID;  
  else
    select P.ABONENT_ID into undefined_ABONENT_ID
      from ABONENTS p
     where (upper(P.SURNAME) = 'НЕТ ДАННЫХ');
  end if;              

     
 for rec in Parse_file 
 loop
   -- фиксируем начало изменений
   update VIRT_ACCOUNT_FILES
     set PARSER_START_DATE = sysdate
   where
     file_id = rec.file_id;
   commit;
    
   select count(DBF_ID) into v_VIRTUAL_ACCOUNTS_ID
     from VIRT_ACCOUNT_TEMP
    where DBF_ID = rec.FILE_ID;
   
   if v_VIRTUAL_ACCOUNTS_ID = 0 then
     update VIRT_ACCOUNT_FILES
      set ERROR_TEXT = 'Нет данных в VIRT_ACCOUNT_TEMP по этому файлу' 
       where
      file_id = rec.file_id;
    commit;
    continue;
   end if; 
   
   merge into VIRTUAL_ACCOUNTS va
   using (select VAT.INN, NAME, EMAIL from VIRT_ACCOUNT_TEMP vat where vat.DBF_ID = rec.FILE_ID) vat
   on (VA.INN =to_char(VAT.INN))
   when matched then
   update
   set
   VA.COMMENTS              = 'Обновлено из 1С - '||rec.FILE_NAME||' от '||to_char(sysdate,('dd.mm.yyyy')),
   VA.VIRTUAL_ACCOUNTS_NAME = vat.NAME,
   VA.EMAIL                 = vat.EMAIL
   when not matched then
   insert (VIRTUAL_ACCOUNTS_NAME, VIRTUAL_ACCOUNTS_IS_ACTIVE, COMMENTS, INN, EMAIL) 
   values (vat.NAME, 0, 'Вставлено из 1С - '||rec.FILE_NAME||' от '||to_char(sysdate,('dd.mm.yyyy')),to_char(VAT.INN), VAT.EMAIL);
   
   open VAT_cursor for 
     SELECT vat.INN, vat.NUMBERS, vat.NUMBERS, vat.NAME, vat.EMAIL 
     FROM VIRT_ACCOUNT_TEMP vat
     where vat.DBF_ID = rec.FILE_ID;
   loop
    fetch VAT_cursor into v_INN, v_NUMBERS, v_NUMBERS2, v_NAME, v_EMAIL;
    
    cnt_VIRTUAL_ACCOUNTS_ID := cnt_VIRTUAL_ACCOUNTS_ID + 1;
    
    select va.VIRTUAL_ACCOUNTS_ID into v_VIRTUAL_ACCOUNTS_ID
      from VIRTUAL_ACCOUNTS va 
     where VA.INN = v_INN; 
       if (v_VIRTUAL_ACCOUNTS_ID is not null) then
         
       
         
         v_NUMBERS2 := REPLACE (REPLACE (TRIM(v_NUMBERS), chr(13),';'), chr(10), ';');
         pos := 10;
         v_phone_number := '1';
         
         while (pos > 0) AND (v_phone_number IS NOT NULL) loop
           pos          := instr(v_NUMBERS2,';',1);
           v_number_phone := substr(v_NUMBERS2,1,pos-1);
           v_NUMBERS2 := substr(v_NUMBERS2, pos+1); 
           if pos > 0 then
             v_phone_number := v_number_phone;
           else
             v_phone_number := v_NUMBERS2;
           end if;  
           
           IF (v_phone_number IS NOT NULL) then

             select count(P.PHONE_ID) into cnt_ACCOUNTS_ID
               from PHONES p
              where (P.PHONE_ID = to_number(v_phone_number)) or
                   (PHONE_NUMBER = v_phone_number) or
                   (PHONE_NUMBER_CITY = v_phone_number);
            
             if cnt_ACCOUNTS_ID = 0 then
               insert into PHONES (PHONE_ID, PHONE_NUMBER, PHONE_NUMBER_CITY)                                    
                           values (to_number(v_phone_number), v_phone_number, v_phone_number) 
                 RETURNING PHONE_ID into v_PHONE_ID;
             else
               select P.PHONE_ID into v_PHONE_ID
                 from PHONES p
                where (P.PHONE_ID = to_number(v_phone_number)) or
                      (PHONE_NUMBER = v_phone_number) or
                      (PHONE_NUMBER_CITY = v_phone_number);
             end if;
           


             select count(PA.PHONE_ON_ACCOUNTS_ID) into cnt_ACCOUNTS_ID
               from PHONE_ON_ACCOUNTS pa
              where PA.PHONE_ID = v_PHONE_ID;
             if cnt_ACCOUNTS_ID = 0 then
               insert into PHONE_ON_ACCOUNTS (PHONE_ON_ACCOUNTS_ID, ACCOUNT_ID, PHONE_IS_ACTIVE, PHONE_ID)                                    
                                      values (S_NEW_PHONE_ON_ACCOUNTS_ID.NEXTVAL, undefined_Account_ID, 0, v_PHONE_ID) 
               RETURNING PHONE_ON_ACCOUNTS_ID into v_PHONE_ON_ACCOUNTS_ID;
               cnt_PHONE_ID := cnt_PHONE_ID + 1;
             else
               select PA.PHONE_ON_ACCOUNTS_ID into v_PHONE_ON_ACCOUNTS_ID
                 from PHONE_ON_ACCOUNTS pa
                where PA.PHONE_ID = v_PHONE_ID;
             end if;
             
              --- получили v_VIRTUAL_ACCOUNTS_ID, v_PHONE_ON_ACCOUNTS_ID,undefined_FILIAL_ID, undefined_TARIFF_ID,  v_ABONENT_ID - можно добавить в контракты              
             
             select count(CONTRACT_ID) into cnt_ACCOUNTS_ID
               from CONTRACTS 
              where VIRTUAL_ACCOUNTS_ID  = v_VIRTUAL_ACCOUNTS_ID
                and PHONE_ON_ACCOUNTS_ID = v_PHONE_ON_ACCOUNTS_ID 
                and ABONENT_ID           = undefined_ABONENT_ID;
 
             if cnt_ACCOUNTS_ID = 0 then
               insert into CONTRACTS (CONTRACT_ID, CONTRACT_DATE, VIRTUAL_ACCOUNTS_ID, PHONE_ON_ACCOUNTS_ID, FILIAL_ID, TARIFF_ID, ABONENT_ID, DESCRIPTION)                                    
                             values (S_NEW_CONTRACTS.NEXTVAL, sysdate, v_VIRTUAL_ACCOUNTS_ID, v_PHONE_ON_ACCOUNTS_ID, undefined_FILIAL_ID, undefined_TARIFF_ID, undefined_ABONENT_ID, 'Добавлено из 1С - '||rec.FILE_NAME) 
               RETURNING CONTRACT_ID into v_CONTRACT_ID;
               cnt_CONTRACT_ID := cnt_CONTRACT_ID +1;
             else
               select CONTRACT_ID into v_CONTRACT_ID
                 from CONTRACTS 
                where VIRTUAL_ACCOUNTS_ID  = v_VIRTUAL_ACCOUNTS_ID
                  and PHONE_ON_ACCOUNTS_ID = v_PHONE_ON_ACCOUNTS_ID 
                  and ABONENT_ID           = undefined_ABONENT_ID;
                  
              update CONTRACTS 
                 set 
                DESCRIPTION = 'Обновлено из 1С - '||rec.FILE_NAME
               where CONTRACT_ID = v_CONTRACT_ID;       
               
             end if;
 
             
             --insert into VIRT_ACCOUNT_TEMP_SVOD (VIRTUAL_ACCOUNTS_ID, INN, PHONE_ID, PHONE_ON_ACCOUNTS_ID, PHONE_NUMBER_, FILE_ID)
              --                      values (v_VIRTUAL_ACCOUNTS_ID, v_INN, v_PHONE_ID, v_PHONE_ON_ACCOUNTS_ID, v_phone_number, rec.file_id);
              -- Это только для тестирования             
           
           end if;
         end loop;
         
          
         

       end if;
     exit when VAT_cursor%NOTFOUND;
     
   end loop;
   
   close VAT_cursor;
     -- фиксируем окончание изменений   
    
    delete from VIRT_ACCOUNT_TEMP where DBF_ID = rec.file_id;
    
    update VIRT_ACCOUNT_FILES   
      set PARSER_END_DATE = sysdate,
         ERROR_TEXT = 'Добавлено : юр. лиц - '||To_char(cnt_VIRTUAL_ACCOUNTS_ID)||'; телефонных номеров - '|| cnt_PHONE_ID||'; договоров - '|| cnt_CONTRACT_ID
    where
      file_id = rec.file_id;
    commit;
   
 end loop; 
 exception
      when OTHERS then
       null;   
END PARSE_VIRT_ACCOUNT_FILES;
/