
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_BILL_ABON_PER_FOR_GROUP" ("ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "DATE_BEGIN", "DATE_END", "TARIFF_CODE", "ABON_MAIN_OLD", "ABON_MAIN", "ABON_ADD", "CALC_KOEFF", "TARIFF_ADD_COST", "CONTRACT_ID", "CONTRACT_NUM", "CONTRACT_DATE", "GROUP_ID", "BILL_ABON") AS 
  SELECT B.ACCOUNT_ID,
          B.YEAR_MONTH,
          B.PHONE_NUMBER,
          B.DATE_BEGIN,
          B.DATE_END,
          B.TARIFF_CODE,
          B.ABON_MAIN_OLD,
          B.ABON_MAIN,
          B.ABON_ADD,
          B.CALC_KOEFF,
          B.TARIFF_ADD_COST,
          C.CONTRACT_ID,
          C.CONTRACT_NUM,
          C.CONTRACT_DATE,
          C.GROUP_ID,
          (select sum(ABON_MAIN) from V_BILL_ABON_PER_FOR_CLIENT fb where FB.PHONE_NUMBER= B.PHONE_NUMBER and  fb.year_month = b.year_month and fb.account_id = b.account_id) bill_abon
     FROM V_BILL_ABON_PER_FOR_CLIENT B, V_CONTRACTS C
    WHERE     B.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
          AND C.CONTRACT_DATE <
                 ADD_MONTHS (TO_DATE (b.YEAR_MONTH || '01', 'yyyymmdd'), 1)
          AND (   C.CONTRACT_CANCEL_DATE IS NULL
               OR C.CONTRACT_CANCEL_DATE >=
                     TO_DATE (b.YEAR_MONTH || '01', 'yyyymmdd'))
          AND C.GROUP_ID IS NOT NULL