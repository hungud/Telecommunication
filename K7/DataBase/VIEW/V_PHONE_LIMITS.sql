CREATE OR REPLACE VIEW V_PHONE_LIMITS AS
-- Version = 1
--
-- 1. 2015.09.28. Крайнов. Создание.
--
  SELECT C.PHONE_NUMBER_FEDERAL,
         C.CONTRACT_ID,
         TR.TARIFF_ID,
         AC.ACCOUNT_ID, 
         C.DISCONNECT_LIMIT,
         NVL(C.DISCONNECT_LIMIT, 0)
         + CASE
             WHEN (NVL(C.HAND_BLOCK,0)=1) THEN NVL(C.BALANCE_BLOCK_HAND_BLOCK, 0)
             ELSE NVL(CASE
                        WHEN NVL(C.IS_CREDIT_CONTRACT, 0)=1 THEN TR.BALANCE_BLOCK_CREDIT
                        ELSE TR.BALANCE_BLOCK
                      END,
                      NVL(CASE
                            WHEN NVL(C.IS_CREDIT_CONTRACT, 0)=1 THEN AC.BALANCE_BLOCK_CREDIT
                            ELSE AC.BALANCE_BLOCK
                          END, 0))
           END BLOCK_LIMIT,
         NVL(C.DISCONNECT_LIMIT, 0) 
         + NVL(C.CONNECT_LIMIT,
               NVL(CASE
                     WHEN NVL(C.IS_CREDIT_CONTRACT, 0) = 1 THEN TR.BALANCE_UNBLOCK_CREDIT
                     ELSE TR.BALANCE_UNBLOCK
                   END,
                   0)) UNBLOCK_LIMIT
    FROM V_CONTRACTS C,
         TARIFFS TR,
         ACCOUNTS AC
    WHERE C.CONTRACT_CANCEL_DATE IS NULL
      AND TR.TARIFF_ID(+) = C.TARIFF_ID
      AND AC.ACCOUNT_ID(+) = CONVERT_PCKG.GET_ACCOUNT_ID_BY_PHONE(C.PHONE_NUMBER_FEDERAL)                                  