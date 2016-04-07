--проверка вычислени€ новых тарифов в договорах ќвс€нников 25.01.2013

CREATE OR REPLACE FORCE VIEW V_CHECK_CONTRACT_TARIFF_ID
AS
   SELECT PHONE_NUMBER_FEDERAL,
          CURR_TARIFF_ID GET_CURR_PHONE_TARIFF_ID_NEW,
          GET_PHONE_TARIFF_ID (PHONE_NUMBER_FEDERAL,
                               DLA.CELL_PLAN_CODE,
                               SYSDATE)
             GET_CURR_PHONE_TARIFF_ID_OLD
     FROM CONTRACTS C, DB_LOADER_ACCOUNT_PHONES DLA WHERE tariff_id IS NOT NULL
     AND DLA.PHONE_NUMBER=C.PHONE_NUMBER_FEDERAL(+)
     AND DLA.YEAR_MONTH=(SELECT MAX(YEAR_MONTH) 
                                                                 FROM DB_LOADER_ACCOUNT_PHONES 
                                                                 WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=C.PHONE_NUMBER_FEDERAL) 