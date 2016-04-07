
CREATE OR REPLACE FORCE VIEW V_REPORT_SUMMARY_MINUTES
AS
--#VERSION=2
-- 
--v.2 Пределал VIEW согласно:Необходимо исправить отчет, чтоб в нем выгружались все тарифы не зависимо от того сколько минут 5 или 500, на данный момент выгружаются только 
--три "Формула свободы плюс", "Формула свободы Область" и "Формула свободы Москва". Раньше выгружалось все!
-- добавлены столбцы: наличие контракта да/нет и статус номера ,активен /блок
--
   SELECT                                                         --#VERSION=1
         V_REPORT_PHONE_STAT_NO_BALANCE."ACCOUNT_ID",
          V_REPORT_PHONE_STAT_NO_BALANCE."YEAR_MONTH",
          V_REPORT_PHONE_STAT_NO_BALANCE."PHONE_NUMBER",
          --V_REPORT_PHONE_STAT_NO_BALANCE."BALANCE_VALUE",
          V_REPORT_PHONE_STAT_NO_BALANCE."OPERATOR_NAME",
          V_REPORT_PHONE_STAT_NO_BALANCE."TARIFF_NAME",
          V_REPORT_PHONE_STAT_NO_BALANCE."TARIFF_ID",
          V_REPORT_PHONE_STAT_NO_BALANCE."ESTIMATE_SUM",
          V_REPORT_PHONE_STAT_NO_BALANCE."ZEROCOST_OUTCOME_MINUTES",
          V_REPORT_PHONE_STAT_NO_BALANCE."ZEROCOST_OUTCOME_COUNT",
          V_REPORT_PHONE_STAT_NO_BALANCE."CALLS_COUNT",
          V_REPORT_PHONE_STAT_NO_BALANCE."CALLS_MINUTES",
          V_REPORT_PHONE_STAT_NO_BALANCE."CALLS_COST",
          V_REPORT_PHONE_STAT_NO_BALANCE."SMS_COUNT",
          V_REPORT_PHONE_STAT_NO_BALANCE."SMS_COST",
          V_REPORT_PHONE_STAT_NO_BALANCE."MMS_COUNT",
          V_REPORT_PHONE_STAT_NO_BALANCE."MMS_COST",
          V_REPORT_PHONE_STAT_NO_BALANCE."INTERNET_MB",
          V_REPORT_PHONE_STAT_NO_BALANCE."INTERNET_COST",
          V_REPORT_PHONE_STAT_NO_BALANCE."OTHER_SERVICES_COST",         
          case ap.PHONE_IS_ACTIVE
            when 1 then 'Активен'
            else
                'Блокирован'
          end as "IS_ACTIVE",
         
         case nvl(C.CONTRACT_ID, 0)
            when 0 then 'Нет'
            else 'Да'
          end as "IS_CONTRACT"
             
          
     FROM V_REPORT_PHONE_STAT_NO_BALANCE, DB_LOADER_ACCOUNT_PHONES ap, contracts c
     --, TARIFFS
    WHERE     V_REPORT_PHONE_STAT_NO_BALANCE.phone_number = AP.PHONE_NUMBER
            and V_REPORT_PHONE_STAT_NO_BALANCE.YEAR_MONTH = AP.YEAR_MONTH 
            and V_REPORT_PHONE_STAT_NO_BALANCE.phone_number = C.PHONE_NUMBER_FEDERAL (+)
            and C.CONTRACT_ID not in (select CONTRACT_CANCELS.CONTRACT_ID from CONTRACT_CANCELS where CONTRACT_CANCELS.CONTRACT_ID =  C.CONTRACT_ID)
          -- Количество бесплатных минут превышает лимит, заданный в справочнике.
--          AND V_REPORT_PHONE_STAT_NO_BALANCE.ZEROCOST_OUTCOME_MINUTES >
--                 TARIFFS.FREE_MONTH_MINUTES_CNT_FOR_RPT
--            V_REPORT_SUMMARY_MINUTES
