CREATE OR REPLACE VIEW V_BILL_ROUMING_FOR_CLIENT AS
  SELECT MG.*
    FROM DB_LOADER_FULL_BILL_MG_ROUMING MG
  UNION ALL 
  SELECT MN.*
    FROM DB_LOADER_FULL_BILL_MN_ROUMING MN;
               
--GRANT SELECT ON V_BILL_ROUMING_FOR_CLIENT TO SIM_TRADE_ROLE;
               
--GRANT SELECT ON V_BILL_ROUMING_FOR_CLIENT TO LONTANA_ROLE;
            
--GRANT SELECT ON V_BILL_ROUMING_FOR_CLIENT TO CORP_MOBILE_ROLE;
               
--GRANT SELECT ON V_BILL_ROUMING_FOR_CLIENT TO CORP_MOBILE_ROLE_RO;    