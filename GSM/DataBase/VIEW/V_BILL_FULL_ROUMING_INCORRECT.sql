CREATE OR REPLACE VIEW V_BILL_FULL_ROUMING_INCORRECT AS
  SELECT *
    FROM DB_LOADER_FULL_FINANCE_BILL FB
    WHERE FB.BILL_SUM <> 0
      AND ((FB.ROUMING_INTERNATIONAL <> 0
              AND FB.ROUMING_INTERNATIONAL <> NVL((SELECT SUM(MNR.ROUMING_SUM)
                                                     FROM DB_LOADER_FULL_BILL_MN_ROUMING MNR
                                                     WHERE MNR.ACCOUNT_ID=FB.ACCOUNT_ID
                                                       AND MNR.YEAR_MONTH=FB.YEAR_MONTH
                                                       AND MNR.PHONE_NUMBER=FB.PHONE_NUMBER
                                                       AND NVL(MNR.BAN, 0) = NVL(FB.BAN, 0)), 0))
            OR (FB.ROUMING_NATIONAL <> 0
                  AND FB.ROUMING_NATIONAL <> NVL((SELECT SUM(MNR.ROUMING_SUM)
                                                    FROM DB_LOADER_FULL_BILL_MG_ROUMING MNR
                                                    WHERE MNR.ACCOUNT_ID=FB.ACCOUNT_ID
                                                      AND MNR.YEAR_MONTH=FB.YEAR_MONTH
                                                      AND MNR.PHONE_NUMBER=FB.PHONE_NUMBER
                                                      AND NVL(MNR.BAN, 0) = NVL(FB.BAN, 0)), 0)));
               
--GRANT SELECT ON V_BILL_FULL_ROUMING_INCORRECT TO SIM_TRADE_ROLE;
               
--GRANT SELECT ON V_BILL_FULL_ROUMING_INCORRECT TO LONTANA_ROLE;
            
--GRANT SELECT ON V_BILL_FULL_ROUMING_INCORRECT TO CORP_MOBILE_ROLE;
               
--GRANT SELECT ON V_BILL_FULL_ROUMING_INCORRECT TO CORP_MOBILE_ROLE_RO;    