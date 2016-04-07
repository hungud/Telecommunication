
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_PHONES_FOR_UNLOCK_CRM_N" ("PHONE_NUMBER_FEDERAL", "BALANCE", "FIO", "DISCONNECT_LIMIT", "ACCOUNT_ID", "HAND_BLOCK", "CONNECT_LIMIT", "BALUNLOCK", "DOP_STATUS_ID", "CONTRACT_ID") AS 
  SELECT v.phone_number_federal,
         get_abonent_balance (v.phone_number_federal) balance,
         v.surname || ' ' || NAME || ' ' || patronymic fio,
         v.disconnect_limit, v.account_id, v.hand_block, v.connect_limit,
         CASE
            WHEN NVL (v.is_credit_contract, 0) = 1
               THEN tariffs.balance_unblock_credit
            ELSE tariffs.balance_unblock
         END balunlock,
         v.DOP_STATUS_ID,
         v.CONTRACT_ID
    FROM v_abonent_balances_2 v, tariffs
    WHERE loader_script_name IS NOT NULL
      AND tariffs.tariff_id(+) = v.tariff_id
      /* AND   GET_ABONENT_BALANCE (V.PHONE_NUMBER_FEDERAL)
           - NVL (V.DISCONNECT_LIMIT, 0) >
              NVL (V.CONNECT_LIMIT, NVL( CASE
                                           WHEN NVL (V.IS_CREDIT_CONTRACT, 0) = 1
                                           THEN TARIFFS.BALANCE_UNBLOCK_CREDIT
                                           ELSE TARIFFS.BALANCE_UNBLOCK
                                        END, 0))*/--AND  rownum <= 1
     -- AND v.phone_is_active_code = 0
      AND v.hand_block = 0
      AND (NVL(v.DOP_STATUS_ID, -1) = -1   -- Без доп. статуса
            OR V.DOP_STATUS_ID = 141 --  "Блок по неактивности"
            OR V.DOP_STATUS_ID = 222 
             )     -- "Первоначальная"
      --AND v.CONSERVATION = 0
      AND EXISTS(SELECT 1
                   FROM db_loader_account_phones
                   WHERE v.phone_number_federal = db_loader_account_phones.phone_number
                     AND db_loader_account_phones.year_month >= TO_NUMBER (TO_CHAR (SYSDATE - 5, 'yyyymm'))
                     AND db_loader_account_phones.last_check_date_time >  SYSDATE - 5)
      AND NOT EXISTS (
             SELECT 1
               FROM fraud_blocked_phone fb
              WHERE fb.phone_number = v.phone_number_federal
                AND fb.status = 1
                AND fb.date_block >=
                            (SELECT MAX (abp.block_date_time)
                               FROM auto_blocked_phone abp
                              WHERE abp.phone_number = v.phone_number_federal))
      AND NOT EXISTS (
             SELECT 1
               FROM db_loader_account_phones dl
              WHERE dl.phone_number = v.phone_number_federal
                AND dl.system_block = 1
                AND dl.year_month =
                            (SELECT MAX (dl1.year_month)
                               FROM db_loader_account_phones dl1
                              WHERE dl1.phone_number = v.phone_number_federal))
     /* AND NOT EXISTS (
             SELECT 1
               FROM auto_unblocked_phone
              WHERE v.phone_number_federal = auto_unblocked_phone.phone_number
                AND (auto_unblocked_phone.unblock_date_time > SYSDATE - 6 / 24
                    )                                                -- 6 HOUR
                AND auto_unblocked_phone.note IS NULL)*/