
  CREATE OR REPLACE FORCE VIEW "LONTANA"."V_PHONE_NUMBERS_FOR_NOTICE_BAL" ("PHONE_NUMBER_FEDERAL", "BALANCE", "FIO", "DISCONNECT_LIMIT", "BALANCE_NOTICE_TEXT", "ACCOUNT_ID") AS 
  SELECT 
    v_abonent_balances.PHONE_NUMBER_FEDERAL,
    v_abonent_balances.BALANCE,
    v_abonent_balances.SURNAME || ' ' || v_abonent_balances.NAME || ' ' || v_abonent_balances.PATRONYMIC FIO,
    v_abonent_balances.DISCONNECT_LIMIT,
    ACCOUNTS.BALANCE_NOTICE_TEXT,
    ACCOUNTS.ACCOUNT_ID
  FROM v_abonent_balances,ACCOUNTS, TARIFFS
  WHERE loader_script_name is not null
        AND v_abonent_balanceS.ACCOUNT_ID=ACCOUNTS.ACCOUNT_ID
        AND TARIFFS.TARIFF_ID(+)=v_abonent_balances.TARIFF_ID    
        and v_abonent_balances.BALANCE-NVL(v_abonent_balances.DISCONNECT_LIMIT, 0)<NVL(TARIFFS.BALANCE_NOTICE, NVL(ACCOUNTS.BALANCE_NOTICE, 0))
        AND v_abonent_balances.BALANCE-NVL(v_abonent_balances.DISCONNECT_LIMIT, 0)>=NVL(TARIFFS.BALANCE_BLOCK, NVL(ACCOUNTS.BALANCE_BLOCK, 0))
        and phone_is_active_code=1 
        AND NOT EXISTS( 
        SELECT 1 FROM BLOCK_SEND_SMS WHERE 
          v_abonent_balances.PHONE_NUMBER_FEDERAL=BLOCK_SEND_SMS.PHONE_NUMBER
          AND  BLOCK_SEND_SMS.SEND_DATE_TIME>SYSDATE-1) 