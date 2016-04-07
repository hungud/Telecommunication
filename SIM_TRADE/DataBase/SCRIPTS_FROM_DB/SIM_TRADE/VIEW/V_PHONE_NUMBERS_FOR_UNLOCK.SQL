
  CREATE OR REPLACE FORCE VIEW "SIM_TRADE"."V_PHONE_NUMBERS_FOR_UNLOCK" ("PHONE_NUMBER_FEDERAL", "BALANCE", "FIO", "DISCONNECT_LIMIT") AS 
  SELECT 
    PHONE_NUMBER_FEDERAL,
    BALANCE,
    SURNAME||' '||NAME||' '||PATRONYMIC FIO,
    DISCONNECT_LIMIT   
  FROM v_abonent_balances,TARIFFS
  WHERE loader_script_name is not null
        AND TARIFFS.TARIFF_ID=v_abonent_balances.TARIFF_ID
        and BALANCE-NVL(v_abonent_balances.DISCONNECT_LIMIT, 0)>NVL(v_abonent_balances.CONNECT_LIMIT, NVL(TARIFFS.BALANCE_UNBLOCK,0)) 
        --AND  rownum <= 1 
        and phone_is_active_code=0 
        and Hand_block=0
        AND NOT EXISTS( 
          SELECT 1 FROM AUTO_UNBLOCKED_PHONE WHERE 
          v_abonent_balances.PHONE_NUMBER_FEDERAL=AUTO_UNBLOCKED_PHONE.PHONE_NUMBER
          -- 6 HOUR
          AND  (AUTO_UNBLOCKED_PHONE.UNBLOCK_DATE_TIME > SYSDATE-6/24)
          and AUTO_UNBLOCKED_PHONE.Note IS NULL 
        )
        AND NOT EXISTS(SELECT 1 
                         FROM DB_LOADER_ACCOUNT_PHONES DD 
                         WHERE DD.YEAR_MONTH=(select max(ph.YEAR_MONTH)
                                                from DB_LOADER_ACCOUNT_PHONES ph)
                           AND DD.PHONE_NUMBER=v_abonent_balances.PHONE_NUMBER_FEDERAL 
                        /*   and 0 > (select x.LAST_BALANCE
                                      from v_last_block_balance x
                                      where x.PHONE_NUMBER = DD.PHONE_NUMBER) */                         
                           AND DD.CONSERVATION=1) 