
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_RECEIVED_PAYMENTS_TYPE_141" ("ACCOUNT_ID", "LOGIN", "COMPANY_NAME", "PHONE_NUMBER", "PAYMENT_SUM", "PAYMENT_DATE_TIME", "CONTRACT_DATE", "CONTRACT_CANCEL_DATE", "START_BALANCE") AS 
  SELECT acc.account_id,
          acc.login,
          acc.company_name,
          rp.phone_number,
          RP.PAYMENT_SUM,
          rp.PAYMENT_DATE_TIME,
          c.contract_date,
          --c.START_BALANCE,
          c.CONTRACT_CANCEL_DATE,
          c.START_BALANCE
     FROM RECEIVED_PAYMENTS rp, V_CONTRACTS c, accounts acc
    WHERE     RECEIVED_PAYMENT_TYPE_ID = 141
          AND rp.phone_number = C.PHONE_NUMBER_FEDERAL(+)
          AND GET_ACCOUNT_ID_BY_PHONE (rp.phone_number) = acc.account_id