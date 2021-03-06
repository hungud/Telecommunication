
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."WWW_V_USERS" ("ID", "BEGIN_DATE", "LOGIN", "USER_PASSWORD", "USER_PASSWORD_HASH", "FIO", "TARIFF_NAME", "BALANCE", "PROMISED_PAYMENT_SUM", "PROMISED_PAYMENT_DATE", "EMAIL", "CONTACT_INFO") AS 
  SELECT
--#Version=4
  CONTRACTS.CONTRACT_ID ID,
  CONTRACTS.CONTRACT_DATE BEGIN_DATE,
  CONTRACTS.PHONE_NUMBER_FEDERAL LOGIN,
  CONTRACTS.USER_PASSWORD USER_PASSWORD,
  CONTRACTS.USER_PASSWORD_HASH,
  ABONENTS.SURNAME || ' ' || ABONENTS.NAME || ' ' || ABONENTS.PATRONYMIC FIO,
  TARIFFS.TARIFF_NAME,
  GET_ABONENT_BALANCE (CONTRACTS.PHONE_NUMBER_FEDERAL) BALANCE,
  NVL((SELECT SUM(PROMISED_SUM) FROM V_ACTIVE_PROMISED_PAYMENTS WHERE V_ACTIVE_PROMISED_PAYMENTS.PHONE_NUMBER=CONTRACTS.PHONE_NUMBER_FEDERAL), 0) PROMISED_PAYMENT_SUM,
  (SELECT MIN(PROMISED_DATE) FROM V_ACTIVE_PROMISED_PAYMENTS WHERE V_ACTIVE_PROMISED_PAYMENTS.PHONE_NUMBER=CONTRACTS.PHONE_NUMBER_FEDERAL) PROMISED_PAYMENT_DATE,
  ABONENTS.EMAIL,
  ABONENTS.CONTACT_INFO
FROM 
  CONTRACTS, 
  CONTRACT_CANCELS CCS, 
  ABONENTS,
  TARIFFS 
WHERE 
  (CONTRACTS.USER_PASSWORD IS NOT NULL OR CONTRACTS.USER_PASSWORD_HASH IS NOT NULL)
  AND CONTRACTS.CONTRACT_ID = CCS.CONTRACT_ID(+) 
  AND CCS.CONTRACT_CANCEL_DATE IS NULL
  AND ABONENTS.ABONENT_ID(+)=CONTRACTS.ABONENT_ID
  AND TARIFFS.TARIFF_ID(+)=CONTRACTS.CURR_TARIFF_ID