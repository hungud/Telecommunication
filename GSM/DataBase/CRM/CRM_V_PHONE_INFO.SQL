CREATE OR REPLACE VIEW CRM_V_INFO AS 
SELECT 
    DB.PHONE_NUMBER PHONE_NUMBER, 
    GET_ABONENT_BALANCE(DB.PHONE_NUMBER) balance,
    case when DB.PHONE_IS_ACTIVE=1 then 'Активный'
         when NVL(DB.PHONE_IS_ACTIVE,0)=0 and DB.CONSERVATION=1 then 'На сохренении'
         when NVL(DB.PHONE_IS_ACTIVE,0)=0 and DB.CONSERVATION=0 then 'Неактивный'
    end is_active,
    DOP.DOP_STATUS_NAME dop_status,
    TAR.TARIFF_NAME TARIFF_NAME,
    HIST.DATE_LAST_UPDATED UPDATED,
    decode((select count(1) from V_PHONE_NUMBERS_FOR_UNLOCK vv where vv.PHONE_NUMBER_FEDERAL=DB.PHONE_NUMBER),0,'Нет','Да') POSSIBLE_TO_UNLOCK
    from db_loader_account_phones db, 
              db_loader_account_phone_hists hist,
              contracts con,
              tariffs tar,
              CONTRACT_DOP_STATUSES dop
    where year_month=to_char(sysdate,'yyyymm') 
    and DB.PHONE_NUMBER=HIST.PHONE_NUMBER 
    and HIST.END_DATE = to_date('01.01.3000','dd.mm.yyyy')
    and CON.PHONE_NUMBER_FEDERAL(+)=DB.PHONE_NUMBER 
    and CON.CONTRACT_ID not in (select CAN.CONTRACT_ID from contract_cancels can) 
    and tar.tariff_id= CON.CURR_TARIFF_ID
    and DOP.DOP_STATUS_ID(+)=CON.DOP_STATUS


GRANT SELECT ON CRM_V_INFO TO CRM_USER;
CREATE SYNONYM CRM_USER.V_INFO FOR CRM_V_INFO;
