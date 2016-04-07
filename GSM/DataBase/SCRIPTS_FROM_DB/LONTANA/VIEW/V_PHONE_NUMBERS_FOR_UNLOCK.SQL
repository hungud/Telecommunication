
  CREATE OR REPLACE FORCE VIEW "LONTANA"."V_PHONE_NUMBERS_FOR_UNLOCK" ("PHONE_NUMBER_FEDERAL", "BALANCE", "FIO", "DISCONNECT_LIMIT", "ACCOUNT_ID", "HAND_BLOCK") AS 
  SELECT V.PHONE_NUMBER_FEDERAL,
       GET_ABONENT_BALANCE(V.PHONE_NUMBER_FEDERAL) BALANCE,
       V.SURNAME||' '||NAME||' '||PATRONYMIC FIO,
       V.DISCONNECT_LIMIT,
       V.ACCOUNT_ID,
       v.HAND_BLOCK
  FROM v_abonent_balances_2 V,TARIFFS
  WHERE loader_script_name is not null
        AND TARIFFS.TARIFF_ID(+)=V.TARIFF_ID
        and GET_ABONENT_BALANCE(V.PHONE_NUMBER_FEDERAL)-NVL(V.DISCONNECT_LIMIT, 0)>NVL(V.CONNECT_LIMIT, 
                                                                                       NVL(CASE
                                                                                             WHEN NVL(V.IS_CREDIT_CONTRACT, 0)=1 THEN TARIFFS.BALANCE_UNBLOCK_CREDIT
                                                                                             ELSE TARIFFS.BALANCE_UNBLOCK
                                                                                           END, 0)) 
        --AND  rownum <= 1 
        and phone_is_active_code=0 
        and v.HAND_BLOCK=0
        and nvl(v.CONSERVATION, 0)<>1
        AND EXISTS (SELECT 1 
                      FROM DB_LOADER_ACCOUNT_PHONES
                      WHERE V.PHONE_NUMBER_FEDERAL=DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER
                        AND DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME>SYSDATE-5)
        and not exists (select 1 from fraud_blocked_phone fb
                          where fb.phone_number=V.PHONE_NUMBER_FEDERAL
                            and fb.status=1
                            and fb.date_block>= (select max(abp.block_date_time) 
                                                   from AUTO_BLOCKED_PHONE abp
                                                   where abp.phone_number=V.PHONE_NUMBER_FEDERAL))
        and not exists (select 1 
                          from DB_LOADER_ACCOUNT_PHONES dl
                          where dl.phone_number = V.PHONE_NUMBER_FEDERAL
                            and dl.system_block=1
                            and dl.year_month =
                                (select max(dl1.year_month)
                                   from DB_LOADER_ACCOUNT_PHONES dl1
                                   where dl1.phone_number = V.PHONE_NUMBER_FEDERAL))
        AND NOT EXISTS( 
          SELECT 1 
            FROM AUTO_UNBLOCKED_PHONE 
            WHERE V.PHONE_NUMBER_FEDERAL=AUTO_UNBLOCKED_PHONE.PHONE_NUMBER
              -- 6 HOUR
              AND  (AUTO_UNBLOCKED_PHONE.UNBLOCK_DATE_TIME > SYSDATE-6/24)
              and AUTO_UNBLOCKED_PHONE.Note IS NULL) 