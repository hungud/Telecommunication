CREATE OR REPLACE VIEW V_PHONE_NUMBER_LIMITS
AS 
SELECT
--#Version=2
--2. ������. ����� �������� DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME �� �������.
--1. ��������� ������ (��������� �� V_PHONE_NUMBERS_FOR_BLOCK).
-- 
    V.CONTRACT_ID,
    V.DEALER_KOD,
    TARIFFS.BALANCE_UNBLOCK,
    V.PHONE_NUMBER_FEDERAL as PHONE_NUMBER,
    CASE
      WHEN (ICB.LAST_UPDATE IS NOT NULL) AND (ICB.LAST_UPDATE > SYSDATE -15/24/60 ) THEN ICB.BALANCE
      ELSE GET_ABONENT_BALANCE(V.PHONE_NUMBER_FEDERAL)
    END BALANCE,
    V.SURNAME || ' ' || V.NAME || ' ' || V.PATRONYMIC FIO,
    V.DISCONNECT_LIMIT,
    V.IS_CREDIT_CONTRACT,
    CASE
      WHEN V.IS_CREDIT_CONTRACT=1 THEN ACCOUNTS.TEXT_NOTICE_BLOCK_CREDIT
      ELSE ACCOUNTS.BLOCK_NOTICE_TEXT
    END BLOCK_NOTICE_TEXT,
    CASE
      WHEN V.IS_CREDIT_CONTRACT=1 THEN ACCOUNTS.BALANCE_BLOCK_CREDIT
      ELSE ACCOUNTS.BALANCE_BLOCK
    END BALANCE_BLOCK,
    ACCOUNTS.ACCOUNT_ID,
    CASE
      WHEN (NVL(V.HAND_BLOCK,0)=1) AND
           (MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE') THEN
        V.BALANCE_BLOCK_HAND_BLOCK
      ELSE
        NVL(
        CASE
          WHEN NVL(V.IS_CREDIT_CONTRACT, 0)=1 THEN TARIFFS.BALANCE_BLOCK_CREDIT
          ELSE TARIFFS.BALANCE_BLOCK
        END,
        NVL(CASE
              WHEN NVL(V.IS_CREDIT_CONTRACT, 0)=1 THEN ACCOUNTS.BALANCE_BLOCK_CREDIT
              ELSE ACCOUNTS.BALANCE_BLOCK
            END, 0))
    END + NVL(V.DISCONNECT_LIMIT, 0) block_balance
  FROM v_abonent_balances_2 V,
       ACCOUNTS,
       TARIFFS,
       IOT_CURRENT_BALANCE ICB
  WHERE V.ACCOUNT_ID=ACCOUNTS.ACCOUNT_ID(+)
    AND TARIFFS.TARIFF_ID(+)=V.TARIFF_ID
    AND V.PHONE_NUMBER_FEDERAL = ICB.PHONE_NUMBER(+)
--    and V.HAND_BLOCK=0
    AND EXISTS (SELECT 1
                  FROM DB_LOADER_ACCOUNT_PHONES
                  WHERE V.PHONE_NUMBER_FEDERAL=DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER
                    and DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH >= to_number(to_char(sysdate-5, 'yyyymm'))
                    -- AND DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME>SYSDATE-5 -- 07.05.15 
                    );


GRANT SELECT ON V_PHONE_NUMBER_LIMITS TO CORP_MOBILE_ROLE;

GRANT SELECT ON V_PHONE_NUMBER_LIMITS TO CORP_MOBILE_ROLE_RO;
