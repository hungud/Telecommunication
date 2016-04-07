--#if GetVersion("V_PHONE_NUMBERS_FOR_BLOCK") < 3
CREATE OR REPLACE VIEW V_PHONE_NUMBERS_FOR_BLOCK AS
SELECT
--#Version=3.
--3 ���������� �.�. ���������� ����������� ���-�� ����� + ����� 6 ����� ����� ��������, �� 1 ���
--2 �������. ������������� � IOT_CURRENT_BALANCE
--1 30.05.2013 ����� �. ������� V_PHONE_NUMBERS_FOR_BLOCK.DEALER_KOD
    V.DEALER_KOD,
    V.PHONE_NUMBER_FEDERAL,
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
    /*CASE
      WHEN V.IS_CREDIT_CONTRACT=1 THEN ACCOUNTS.BALANCE_BLOCK_CREDIT
      ELSE ACCOUNTS.BALANCE_BLOCK
    END BALANCE_BLOCK,*/
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
    END + NVL(V.DISCONNECT_LIMIT, 0) BALANCE_BLOCK
  FROM v_abonent_balances_2 V,
       ACCOUNTS,
       TARIFFS,
       IOT_CURRENT_BALANCE ICB
  WHERE loader_script_name is not null
    AND V.ACCOUNT_ID=ACCOUNTS.ACCOUNT_ID(+)
    AND TARIFFS.TARIFF_ID(+)=V.TARIFF_ID
    AND V.PHONE_NUMBER_FEDERAL = ICB.PHONE_NUMBER(+)
    and (CASE
           WHEN (ICB.LAST_UPDATE IS NOT NULL) AND (ICB.LAST_UPDATE > SYSDATE -15/24/60 ) THEN ICB.BALANCE
           ELSE GET_ABONENT_BALANCE(V.PHONE_NUMBER_FEDERAL)
         END - NVL(V.DISCONNECT_LIMIT, 0) <
        CASE
          WHEN (NVL(V.HAND_BLOCK,0)=1) AND
               (MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE') THEN
            V.BALANCE_BLOCK_HAND_BLOCK
          ELSE
           NVL(CASE
                 WHEN NVL(V.IS_CREDIT_CONTRACT, 0)=1 THEN TARIFFS.BALANCE_BLOCK_CREDIT
                    ELSE TARIFFS.BALANCE_BLOCK
               END,
               NVL(CASE
                     WHEN NVL(V.IS_CREDIT_CONTRACT, 0)=1 THEN ACCOUNTS.BALANCE_BLOCK_CREDIT
                     ELSE ACCOUNTS.BALANCE_BLOCK
                   END, 0))
        END)
    and V.phone_is_active_code=1
--    and V.HAND_BLOCK=0
    AND EXISTS (SELECT 1
                  FROM DB_LOADER_ACCOUNT_PHONES
                  WHERE V.PHONE_NUMBER_FEDERAL=DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER
                    and DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH >= to_number(to_char(sysdate-5, 'yyyymm'))
                    AND DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME>SYSDATE-5)
    AND NOT EXISTS (SELECT 1
                      FROM AUTO_BLOCKED_PHONE
                      WHERE V.PHONE_NUMBER_FEDERAL=AUTO_BLOCKED_PHONE.PHONE_NUMBER
                        -- �� ����� 1 ���� �����
                        AND  (AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME > sysdate-1/24)
                        and AUTO_BLOCKED_PHONE.Note IS NULL)
    AND NOT EXISTS (SELECT 1
                      FROM LOYAL_PHONE_FOR_BLOCK
                      WHERE V.PHONE_NUMBER_FEDERAL=LOYAL_PHONE_FOR_BLOCK.PHONE_NUMBER);
                  
--#end if
