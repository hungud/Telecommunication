CREATE OR REPLACE VIEW EXP_1C_PHONE_TARIFFS2 AS
  SELECT T.*,
         T1.TARIFF_NAME OLD_TAR_NAME,
         T1.TARIFF_CODE_CRM OLD_GUID,
         T2.TARIFF_NAME NEW_TAR_NAME,
         T2.TARIFF_CODE_CRM NEW_GUID
    FROM (SELECT H.HISTORY_ID,
                 H.PHONE_NUMBER,
                 GET_PHONE_TARIFF_ID(H.PHONE_NUMBER, 
                                     (select h2.CELL_PLAN_CODE
                                        from DB_LOADER_ACCOUNT_PHONE_HISTS h2
                                        where h2.PHONE_NUMBER = h.PHONE_NUMBER
                                          and h2.BEGIN_DATE <= H.BEGIN_DATE - 10/24/60
                                          and h2.END_DATE >=H.BEGIN_DATE - 10/24/60
                                          and rownum = 1),
                                     H.BEGIN_DATE - 10/24/60) OLD_TAR_ID,
                 GET_PHONE_TARIFF_ID(H.PHONE_NUMBER, H.CELL_PLAN_CODE, H.BEGIN_DATE + 10/24/60) NEW_TAR_ID,
                 H.BEGIN_DATE DATE_CHANGE
            FROM DB_LOADER_ACCOUNT_PHONE_HISTS H) T,
         TARIFFS T1,
         TARIFFS T2  
    WHERE T.OLD_TAR_ID <> T.NEW_TAR_ID
      AND T.OLD_TAR_ID = T1.TARIFF_ID(+)
      AND T.NEW_TAR_ID = T2.TARIFF_ID(+);
      
CREATE OR REPLACE SYNONYM WWW_DEALER.EXP_1C_PHONE_TARIFFS2 FOR EXP_1C_PHONE_TARIFFS2;

GRANT SELECT ON WWW_DEALER.EXP_1C_PHONE_TARIFFS2 TO USER_1C;