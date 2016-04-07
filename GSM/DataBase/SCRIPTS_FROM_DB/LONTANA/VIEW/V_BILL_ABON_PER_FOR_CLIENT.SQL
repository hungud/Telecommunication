
  CREATE OR REPLACE FORCE VIEW "LONTANA"."V_BILL_ABON_PER_FOR_CLIENT" ("ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "DATE_BEGIN", "DATE_END", "TARIFF_CODE", "ABON_MAIN_OLD", "ABON_MAIN", "TARIFF_ADD_COST_REAL", "ABON_ADD", "CALC_KOEFF", "TARIFF_ADD_COST", "TARIFF_ID", "TARIFF_NAME") AS 
  SELECT 
          --Version= 2
          --
          -- v2 - Матюнин - 21.03.2016 - Добавлено поле TARIFF_ADD_COST_REAL - добавочная стоимость тарифера по ТП, рассчитывается на основании спроавочника TARIFFS.TARIFF_ADD_COST   
          -- v1 - Матюнин - 21.03.2016 - до этого момента версии не велись  
          T1.ACCOUNT_ID,
          T1.YEAR_MONTH,
          T1.PHONE_NUMBER,
          T1.DATE_BEGIN,
          T1.DATE_END,
          T1.TARIFF_CODE,
          T1.ABON_MAIN AS ABON_MAIN_OLD,
          ROUND (
               T1.ABON_MAIN * NVL (TARIFFS.CALC_KOEFF, 1)
             + T1.COEFF_MONTH * NVL (TARIFFS.TARIFF_ADD_COST, 0),
             4)
             ABON_MAIN,
          ROUND (
               T1.COEFF_MONTH * NVL (TARIFFS.TARIFF_ADD_COST, 0),
             4)
             TARIFF_ADD_COST_REAL,  -- добавочная стоимость тарифера только по тарифу  
          T1.ABON_ADD,
          NVL (TARIFFS.CALC_KOEFF, 1) CALC_KOEFF,
          NVL (TARIFFS.TARIFF_ADD_COST, 0) TARIFF_ADD_COST,
          TARIFFS.TARIFF_ID,
          TARIFFS.TARIFF_NAME
     FROM (SELECT AP.*,
                  GET_PHONE_TARIFF_ID (AP.PHONE_NUMBER,
                                       AP.TARIFF_CODE,
                                       AP.DATE_END)
                     AS TARIFF_ID,
                    (AP.DATE_END - AP.DATE_BEGIN + 1)
                  / (  LAST_DAY (AP.DATE_BEGIN)
                     - TO_DATE (TO_CHAR (AP.DATE_BEGIN, 'YYYYMM') || '01',
                                'YYYYMMDD')
                     + 1)
                     COEFF_MONTH
             FROM DB_LOADER_FULL_BILL_ABON_PER AP) T1,
          TARIFFS
    WHERE T1.TARIFF_ID = TARIFFS.TARIFF_ID(+)