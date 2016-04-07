--#if GetVersion("V_PHONE_NUMBERS_FOR_BLOCK") < 3
CREATE OR REPLACE VIEW V_PAYMENTS_WITHOUT_TRAFFIC AS


--#Version=4
--
-- Возвращается список номеров телефонов, у которых нет трафика за месяц, 
-- но по которым оператор выставил счёт.
--
-- v.4 11.03.2015 Гольцова Ксения добавила поля: Наличие контрактов, статус активности и Баланс
-- v.3 Назин Перелал на новую схему счетов.
SELECT DB_LOADER_BILLS.ACCOUNT_ID,
          DB_LOADER_BILLS.YEAR_MONTH,
          DB_LOADER_BILLS.PHONE_NUMBER,
          DB_LOADER_BILLS.BILL_SUM,
          DB_LOADER_BILLS.DISCOUNT_VALUE,
        case (select count(*) from db_loader_account_phones where   DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID =  DB_LOADER_BILLS.ACCOUNT_ID and 
            DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = DB_LOADER_BILLS.PHONE_NUMBER and 
            DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = DB_LOADER_BILLS.YEAR_MONTH and
            DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE = 1
            )    
        when 0 then 
            'Нет'
        else 
            'Акт'   
        end PHONE_IS_ACTIVE, 
     
        case (select count(*) from v_contracts where V_CONTRACTS.CONTRACT_CANCEL_DATE is null and DB_LOADER_BILLS.PHONE_NUMBER = V_CONTRACTS.PHONE_NUMBER_FEDERAL  and rownum <= 1)
        when 0 then 
            'Нет'
        else 
            'Да'     
        end CONTRACT,    
                   
        IOT_CURRENT_BALANCE.BALANCE 
       
     FROM DB_LOADER_BILLS, IOT_CURRENT_BALANCE
    WHERE                                                       -- Абонплата не = 0
         DB_LOADER_BILLS.BILL_SUM <> 0       -- DB_LOADER_BILLS.DISCOUNT_VALUE
          AND (DB_LOADER_BILLS.PHONE_NUMBER, DB_LOADER_BILLS.YEAR_MONTH) NOT IN
                 (SELECT PHONE_NUMBER, YEAR_MONTH
                    FROM DB_LOADER_PHONE_STAT
                   WHERE    (ZEROCOST_OUTCOME_MINUTES <> 0)
                         OR (CALLS_COUNT <> 0)
                         OR (CALLS_COST <> 0)
                         OR (SMS_COUNT <> 0)
                         OR (MMS_COUNT <> 0)
                         OR (INTERNET_MB <> 0))
 and (DB_LOADER_BILLS.PHONE_NUMBER =  IOT_CURRENT_BALANCE.PHONE_NUMBER(+)
     )

/
--#end if

