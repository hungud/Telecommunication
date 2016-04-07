
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_BLOCKPHONE_WITH_ONEPAYMENT" ("ACCOUNT_ID", "ACCOUNT_NUMBER", "LOGIN", "COMPANY_NAME", "PHONE_NUMBER", "CONTRACT_NUM", "CONTRACT_DATE", "BLOCK_DATE", "BALANCE", "PHONE_IS_ACTIVE", "IS_COLLECTOR") AS 
  SELECT 
  a.account_id, a.account_number, a.login, a.company_name, d.phone_number,
  c.contract_num, c.contract_date,
  LAST_CHANGE_STATUS_DATE  block_date, 
  b.balance, 
  d.phone_is_active, 
  a.is_collector
FROM contracts c, 
         db_loader_account_phones d, 
         iot_current_balance b, 
         accounts a
WHERE NOT EXISTS (SELECT 1
                                FROM contract_cancels cc
                                WHERE cc.contract_id = c.contract_id)
AND (1 = (SELECT COUNT(*) 
               FROM v_full_balance_payments vfb
               LEFT JOIN RECEIVED_PAYMENTS pay ON vfb.RECEIVED_PAYMENT_ID = pay.RECEIVED_PAYMENT_ID
               WHERE vfb.phone_number = c.PHONE_NUMBER_FEDERAL AND vfb.payment_sum > 0 AND ((pay.RECEIVED_PAYMENT_TYPE_ID <> 1) OR (pay.RECEIVED_PAYMENT_TYPE_ID is null))))
AND EXISTS (SELECT * 
                    FROM db_loader_account_phone_hists
                    WHERE phone_number = c.PHONE_NUMBER_FEDERAL
                     AND phone_is_active = 1)
AND c.PHONE_NUMBER_FEDERAL = d.phone_number
AND d.year_month = (SELECT MAX(year_month) 
                                 FROM db_loader_account_phones
                                 WHERE phone_number = c.PHONE_NUMBER_FEDERAL)                  
AND c.PHONE_NUMBER_FEDERAL = b.phone_number
AND d.account_id = a.account_id
AND d.PHONE_IS_ACTIVE <> 1   
AND C.DOP_STATUS is null