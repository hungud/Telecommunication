/* Formatted on 10/03/2015 16:51:07 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW V_RECEIVED_PAYMENTS_TYPE_141

AS
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
          AND GET_ACCOUNT_ID_BY_PHONE (rp.phone_number) = acc.account_id;