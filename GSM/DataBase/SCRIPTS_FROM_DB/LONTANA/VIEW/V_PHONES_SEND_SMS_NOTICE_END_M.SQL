
  CREATE OR REPLACE FORCE VIEW "LONTANA"."V_PHONES_SEND_SMS_NOTICE_END_M" ("PHONE_NUMBER_FEDERAL", "BALANCE", "FIO", "DISCONNECT_LIMIT", "NEXT_MONTH_NOTICE_TEXT", "ACCOUNT_ID", "RECOMEND_SUMM") AS 
  SELECT v_abonent_balances.PHONE_NUMBER_FEDERAL,
         v_abonent_balances.BALANCE,
         v_abonent_balances.SURNAME || ' ' || v_abonent_balances.NAME || ' ' || v_abonent_balances.PATRONYMIC FIO,
         v_abonent_balances.DISCONNECT_LIMIT,
         ACCOUNTS.NEXT_MONTH_NOTICE_TEXT,
         ACCOUNTS.ACCOUNT_ID,
         100 - GET_ABONENT_BALANCE(PHONE_NUMBER_FEDERAL,SYSDATE + 2) RECOMEND_SUMM
    FROM v_abonent_balances,ACCOUNTS
    WHERE loader_script_name is not null
          AND v_abonent_balanceS.ACCOUNT_ID=ACCOUNTS.ACCOUNT_ID
          and (GET_ABONENT_BALANCE(PHONE_NUMBER_FEDERAL,SYSDATE + 2)-NVL(v_abonent_balances.DISCONNECT_LIMIT,0)<=ACCOUNTS.BALANCE_NOTICE_END_MONTH)  --?????? ????? 2 ??? ?????? ???? ?????? ??????????
          and phone_is_active_code=1 
          AND NOT EXISTS (SELECT 1
                            FROM PHONE_NUMBER_WITH_DAILY_ABON PHA
                            WHERE PHA.PHONE_NUMBER=v_abonent_balances.PHONE_NUMBER_FEDERAL)
          AND NOT EXISTS (SELECT 1
                            FROM TARIFFS TAR
                            WHERE TAR.TARIFF_ID = v_abonent_balances.TARIFF_ID
                              AND NVL(TAR.TARIFF_ABON_DAILY_PAY, 0) = 1)                   
          AND NOT EXISTS (SELECT 1 
                            FROM SEND_SMS_NOTICE_END_MONTH_LOG 
                            WHERE v_abonent_balances.PHONE_NUMBER_FEDERAL=SEND_SMS_NOTICE_END_MONTH_LOG.PHONE_NUMBER
                              AND (SEND_SMS_NOTICE_END_MONTH_LOG.SEND_DATE_TIME>SYSDATE-23/24)
                              AND SEND_SMS_NOTICE_END_MONTH_LOG.ERROR_TEXT IS NULL) 