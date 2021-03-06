CREATE USER K7_LK
  IDENTIFIED BY K7_LK_USER6
  DEFAULT TABLESPACE USERS
  TEMPORARY TABLESPACE TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;
  -- 5 System Privileges for K7_LK 
  GRANT CREATE SEQUENCE TO K7_LK;
  GRANT CREATE SESSION TO K7_LK;
  GRANT CREATE TABLE TO K7_LK;
  GRANT CREATE TYPE TO K7_LK;
  GRANT UNLIMITED TABLESPACE TO K7_LK;
  -- 35 Object Privileges for K7_LK 
    GRANT SELECT ON CORP_MOBILE.ABONENTS TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.ACCOUNTS TO K7_LK;
    GRANT EXECUTE ON CORP_MOBILE.ADD_PROMISED_PAYMENT TO K7_LK;
    GRANT EXECUTE ON CORP_MOBILE.BEELINE_API_PCKG TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.BEELINE_BS_ZONES TO K7_LK;
    GRANT EXECUTE ON CORP_MOBILE.BEELINE_REST_API_PCKG TO K7_LK;
    GRANT EXECUTE ON CORP_MOBILE.CALC_BALANCE_ROWS2 TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.CONTRACTS TO K7_LK;
  GRANT UPDATE (USER_PASSWORD) ON CORP_MOBILE.CONTRACTS TO K7_LK;
  GRANT UPDATE (USER_PASSWORD_HASH) ON CORP_MOBILE.CONTRACTS TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.CONTRACT_CANCELS TO K7_LK;
    GRANT EXECUTE ON CORP_MOBILE.CRM_UNBLOCK_PHONE TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.DB_LOADER_ACCOUNT_PHONES TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.DB_LOADER_ACCOUNT_PHONE_OPTS TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.DB_LOADER_PAYMENTS TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.DB_LOADER_PHONE_STAT TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.DB_LOADER_SERVICE_TYPES TO K7_LK;
    GRANT EXECUTE ON CORP_MOBILE.GET_ABONENT_BALANCE TO K7_LK;
    GRANT EXECUTE ON CORP_MOBILE.GET_ACCOUNT_ID_BY_PHONE TO K7_LK;
    GRANT EXECUTE ON CORP_MOBILE.GET_TEXT_ABON_FOR_INET_TARIFF TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.HOT_BILLING_MONTH TO K7_LK;
    GRANT EXECUTE ON CORP_MOBILE.LOADER3_PCKG TO K7_LK;
    GRANT DELETE, INSERT, SELECT ON CORP_MOBILE.OPTIONS_ENABLED_FOR_TARIFFS TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.PROMISED_PAYMENTS TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.RECEIVED_PAYMENTS TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.RECEIVED_PAYMENT_TYPES TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.TARIFFS TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.TARIFF_OPTIONS TO K7_LK;
  GRANT UPDATE (CAN_BE_TURNED_BY_ABONENT) ON CORP_MOBILE.TARIFF_OPTIONS TO K7_LK;
  GRANT UPDATE (OPTION_NAME_FOR_AB) ON CORP_MOBILE.TARIFF_OPTIONS TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.TARIFF_OPTION_COSTS TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.TARIFF_OPTION_NEW_COST TO K7_LK;
    GRANT EXECUTE ON CORP_MOBILE.TARIFF_RESTS_TABLE TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.V_ACTIVE_PROMISED_PAYMENTS TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.V_BILL_FOR_CLIENT TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.V_PHONE_NUMBER_LIMITS TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.WWW_V_BILLS TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.WWW_V_PAYMENTS TO K7_LK;
    GRANT SELECT ON CORP_MOBILE.WWW_V_SERVICES TO K7_LK;
