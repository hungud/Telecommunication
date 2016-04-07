SELECT v.PHONE_NUMBER_FEDERAL PHONE_NUMBER,
         GET_ABONENT_BALANCE(v.PHONE_NUMBER_FEDERAL) BALANCE,
         v.SURNAME||' '||v.NAME||' '||v.PATRONYMIC FIO,
         P.ACCOUNT_ID,
         case 
           when v.HAND_BLOCK=1 then 'Да'
           when v.HAND_BLOCK=0 then 'Нет'
         end as HAND_BLOCK    
    FROM v_abonent_balances_2 v,
         TARIFFS,
         DB_LOADER_ACCOUNT_PHONES P
    WHERE TARIFFS.TARIFF_ID=v.TARIFF_ID
      and GET_ABONENT_BALANCE(v.PHONE_NUMBER_FEDERAL)-NVL(v.DISCONNECT_LIMIT, 0)>NVL(v.CONNECT_LIMIT, NVL(TARIFFS.BALANCE_UNBLOCK,0)) 
      and phone_is_active_code=0 
      and Hand_block=0
      AND v.PHONE_NUMBER_FEDERAL=P.PHONE_NUMBER
      and P.YEAR_MONTH=(SELECT MAX(P2.YEAR_MONTH)
                          FROM DB_LOADER_ACCOUNT_PHONES P2
                          WHERE P2.ACCOUNT_ID=P.ACCOUNT_ID)
      AND P.PHONE_IS_ACTIVE=0
      AND P.CONSERVATION=1 
      AND P.SYSTEM_BLOCK<>1