
  CREATE OR REPLACE FORCE VIEW "LONTANA"."CRM_V_ABONPERLIST" ("ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "DATE_BEGIN", "DATE_END", "TARIFF_CODE", "ABON_MAIN_OLD", "ABON_MAIN", "ABON_ADD", "CALC_KOEFF", "TARIFF_ADD_COST", "TARIFF_ID", "TARIFF_NAME") AS 
  SELECT "ACCOUNT_ID","YEAR_MONTH","PHONE_NUMBER","DATE_BEGIN","DATE_END","TARIFF_CODE","ABON_MAIN_OLD","ABON_MAIN","ABON_ADD","CALC_KOEFF","TARIFF_ADD_COST","TARIFF_ID","TARIFF_NAME"
  FROM V_BILL_ABON_PER_FOR_CLIENT V
  ORDER BY V.DATE_BEGIN DESC