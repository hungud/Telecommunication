CREATE OR REPLACE VIEW V_PHONE_FOR_BLOCK_NO_CONTR AS
--Version=5
SELECT V.PHONE_NUMBER,
       GET_ABONENT_BALANCE(V.PHONE_NUMBER) BALANCE,
       '��� ��������' FIO,
       ACCOUNTS.BLOCK_NOTICE_TEXT,
       ACCOUNTS.BALANCE_BLOCK,
       V.ACCOUNT_ID
  FROM DB_LOADER_ACCOUNT_PHONES V,
       ACCOUNTS
  WHERE v.YEAR_MONTH = (select max(ap.YEAR_MONTH)
                          from db_loader_account_phones ap)
    and V.ACCOUNT_ID=ACCOUNTS.ACCOUNT_ID(+)
    and (GET_ABONENT_BALANCE(V.PHONE_NUMBER) < NVL(ACCOUNTS.BALANCE_BLOCK, 0)) 
    and V.PHONE_IS_ACTIVE = 1
    AND NOT EXISTS (SELECT 1
                      FROM CONTRACTS C, CONTRACT_CANCELS CC
                      WHERE C.PHONE_NUMBER_FEDERAL = V.PHONE_NUMBER
                        AND C.CONTRACT_ID = CC.CONTRACT_ID(+)
                        AND CC.CONTRACT_CANCEL_DATE IS NULL)
    AND NOT EXISTS (SELECT 1 
                      FROM AUTO_BLOCKED_PHONE 
                      WHERE V.PHONE_NUMBER =AUTO_BLOCKED_PHONE.PHONE_NUMBER
                        -- �� ����� 6 ����� �����
                        AND  (AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME > sysdate-6/24)
                        and AUTO_BLOCKED_PHONE.Note IS NULL) 
    AND NOT EXISTS (SELECT 1 
                      FROM LOYAL_PHONE_FOR_BLOCK 
                      WHERE V.PHONE_NUMBER=LOYAL_PHONE_FOR_BLOCK.PHONE_NUMBER);                         