CREATE OR REPLACE FORCE VIEW V_BILLS
as
   SELECT                                                                   
  --
  --#Version=9
  --
  --
  -- v.9 Афросин 15.02.2016 Переделки касатеьно новой структуры (MOBILE_OPERATOR_NAME_ID на FILAL_ID)
  -- v.8 Афросин 29.01.2016 Убрал сумму платежей из общего счета абоненту. Прицепил таблицу payments для каждого номера телефона
  -- v.7 Афросин 15.01.2016 Добавил вывод поля счет мегафона (BILL_SUM) и сумму наценки (MARGIN)
  -- v.6 Афросин 03.12.2015 Не приавлялся роуминг
  -- v.5 Афросин 03.12.2015 Переделалусловие выбора на left join
  -- v.4 Кочнев добавил поля                                                                          
  --v.3 Афросин 02.11.2015 Добавил исключения на добавочную стоимость для тарифов с абон платой > 2500
                                     --v.2 Афросин 29.10.2015 добавил поле ИНН
          --v.1 Кочнев 28.10.2015 создал вьюху по счетам вирутального опертора
                                                                            --
        ACCOUNT_ID,
        tariff_id,
        abonent_id,
        filial_id,
        CONTRACT_ID,
        SIM_NUMBER,
        MOBILE_OPERATOR_NAME_ID,
        VIRTUAL_ACCOUNTS_ID,
        MOBILE_OPERATOR_NAME,
        ACCOUNT_NUMBER,
        login,
        ACCOUNT_NUMBER_LOGIN,
        filial_name,
        phone_id,
        PHONE_NUMBER_CITY,
        surname,
        VIRTUAL_ACCOUNTS_name,
        tariff_name,
        CALL_LOCAL,
        CALL_INTERCITY,
        MESSAGE,
        INTERNET,
        OTHERS_SERVISES,
        SUBSCRIPTION_SUM,
        INTERNATIONAL_ROAMING,
        NATIONAL_INTRANET_ROAMING,
        ADJUSTMENT,
        PAYMENTS,
          CALL_LOCAL
        + CALL_INTERCITY
        + MESSAGE
        + INTERNET
        + OTHERS_SERVISES
        + SUBSCRIPTION_SUM
        + INTERNATIONAL_ROAMING
        + NATIONAL_INTRANET_ROAMING
        + ADJUSTMENT
           AS ALL_CLIENT_SCHET,
        DATE_CREATED,
        USER_CREATED,
        USER_LAST_UPDATED,
        DATE_LAST_UPDATED,
        LOG_BILL_ID,
        YEAR_MONTH,
        INN,
        YEAR_MONTH_NAME,
        BILL_SUM,
        MARGIN
   FROM (SELECT BILL.ACCOUNT_ID,
                c.tariff_id,
                c.abonent_id,
                c.filial_id,
                c.CONTRACT_ID,
                c.SIM_NUMBER,
                mo.MOBILE_OPERATOR_NAME_ID,
                C.VIRTUAL_ACCOUNTS_ID,
                mo.MOBILE_OPERATOR_NAME,
                ac.ACCOUNT_NUMBER,
                ac.login,
                ac.ACCOUNT_NUMBER || '; ' || ac.login ACCOUNT_NUMBER_LOGIN,
                f.filial_name,
                bill.phone_id,
                ph.PHONE_NUMBER_CITY,
                a.surname || ' ' || a.NAME || ' ' || PATRONYMIC surname,
                v.VIRTUAL_ACCOUNTS_name,
                t.tariff_name,
                CALL_LOCAL,
                CALL_INTERCITY,
                SMS + MMS MESSAGE,
                INTERNET,
                SUBSCRIPTION_ADD + OTHERS_COST OTHERS_SERVISES,
                  SUBSCRIPTION
                + SUBSCRIPTION_DIRECT
                + DECODE (
                     BILL_SUM,
                     0, 0,
                     nvl(
                          CASE
                            WHEN     UPPER (t.tariff_name) IN ('"ФЕДЕРАЛЬНЫЙ ГЕНЕРАЛЬНЫЙ +"',
                                                               'ФЕД.ГЕНЕРАЛЬНЫЙ +  SPB',
                                                               '"ФЕДЕРАЛЬНЫЙ ГЕНЕРАЛЬНЫЙ + СИТИ"')
                                 AND SUBSCRIPTION > 2500
                            THEN
                               10
                            ELSE
                             t.tariff_add_cost
                          END,
                          0
                        )
                     )
                   SUBSCRIPTION_SUM,
                DECODE (
                     BILL_SUM,
                     0, 0,
                     nvl(
                          CASE
                            WHEN     UPPER (t.tariff_name) IN ('"ФЕДЕРАЛЬНЫЙ ГЕНЕРАЛЬНЫЙ +"',
                                                               'ФЕД.ГЕНЕРАЛЬНЫЙ +  SPB',
                                                               '"ФЕДЕРАЛЬНЫЙ ГЕНЕРАЛЬНЫЙ + СИТИ"')
                                 AND SUBSCRIPTION > 2500
                            THEN
                               10
                            ELSE
                             t.tariff_add_cost
                          END,
                          0
                        )
                     )
                        MARGIN,
                INTERNATIONAL_ROAMING,
                NATIONAL_INTRANET_ROAMING,
                ADJUSTMENT,
                PAYMENTS
                  +
                  nvl(
                       (
                        select
                          sum(sum_pay) from payments pp
                        where
                          pp.YEAR_MONTH = bill.YEAR_MONTH
                          and pp.phone_id = bill.phone_id
                       ),
                       0
                     ) PAYMENTS,
                     
                BILL_SUM,
                bill.DATE_CREATED,
                bill.USER_CREATED,
                bill.USER_LAST_UPDATED,
                bill.DATE_LAST_UPDATED,
                bill.LOG_BILL_ID,
                bill.YEAR_MONTH,
                v.INN,
                per.YEAR_MONTH_NAME
          from
            DB_LOADER_BILLS bill
                   
                  left join phone_on_accounts pa
                    on bill.phone_id = PA.PHONE_ID
                      AND BILL.ACCOUNT_ID = PA.ACCOUNT_ID
                  
                  left join  ACCOUNTS ac
                    on BILL.ACCOUNT_ID = ac.account_id
                  
                  left join  contracts c
                    on PA.PHONE_ON_ACCOUNTS_ID = c.PHONE_ON_ACCOUNTS_ID
                  
                  left join  tariffs t
                    on c.tariff_id = t.tariff_id
                  
                  left join   abonents a
                    on c.abonent_id = a.abonent_id
                  left join  VIRTUAL_ACCOUNTS v
                    on C.VIRTUAL_ACCOUNTS_ID = v.VIRTUAL_ACCOUNTS_ID
                  
                  left join  filials f
                    on f.filial_id = c.filial_id
                  
                  left join  PHONES ph
                    on ph.PHONE_ID = pa.PHONE_ID
                  
                  left join V_PERIODS per
                    on per.YEAR_MONTH = bill.YEAR_MONTH
                   
                 
                  left join  MOBILE_OPERATOR_NAMES mo
                    on mo.MOBILE_OPERATOR_NAME_ID = F.MOBILE_OPERATOR_NAME_ID);
                 

GRANT SELECT, UPDATE ON BUSINESS_COMM.V_BILLS TO BUSINESS_COMM_ROLE;

GRANT SELECT, UPDATE ON BUSINESS_COMM.V_BILLS TO BUSINESS_COMM_ROLE_RO;


GRANT SELECT, UPDATE ON V_BILLS TO BUSINESS_COMM_ROLE;

GRANT SELECT, UPDATE ON V_BILLS TO BUSINESS_COMM_ROLE_RO;