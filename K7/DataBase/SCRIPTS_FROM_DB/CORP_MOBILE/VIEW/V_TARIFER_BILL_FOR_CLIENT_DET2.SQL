
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_TARIFER_BILL_FOR_CLIENT_DET2" ("YEAR_MONTH", "PHONE_NUMBER", "DATE_BEGIN", "DATE_END", "ABON_PAY", "TARIFF_CODE", "TARIFF_NAME", "ROW_TYPE") AS 
  SELECT v.YEAR_MONTH,
       v.PHONE_NUMBER,
       v.DATE_BEGIN,
       v.DATE_END,
       v.ABON_PAY,
       v.TARIFF_CODE,       
      nvl(v.TARIFF_NAME,
          (SELECT TARIFF_NAME
            FROM TARIFFS 
            WHERE TARIFF_ID = GET_PHONE_TARIFF_ID(V.PHONE_NUMBER, V.TARIFF_CODE, CASE 
                                                                                   WHEN V.DATE_END = V.DATE_BEGIN THEN V.DATE_BEGIN + 12/24
                                                                                   ELSE V.DATE_END - 1/24
                                                                                 END ))) TARIFF_NAME,
       v.ROW_TYPE
  FROM V_TARIFER_BILL_FOR_CLIENT_DET V
 -- WHERE ROWNUM <=2 