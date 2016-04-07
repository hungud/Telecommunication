CREATE OR REPLACE PROCEDURE UNBLOCK_BETWEEN_LIMITS IS
-- Version = 3
--
-- 3. 2016.03.02 Афросин. Заменил условие выборки с вьюхи v_contracts
-- 2. 2016.03.02 Соколов. Заменил вьюху V_UNBLOCK_BETWEEN_LIMITS на запрос (вьюха отказывается работать, походу вспышки на солнце).
-- 1. 2015.09.29. Крайнов. Создание. Разблок номеров между порогами блокировки и разблокировки.
--
  vNOW_BALANCE NUMBER;
  vANSWER VARCHAR2(500 CHAR);
BEGIN
  FOR rec IN (SELECT V.PHONE_NUMBER_FEDERAL,
                     V.BLOCK_LIMIT,
                     V.UNBLOCK_LIMIT
               FROM V_PHONE_LIMITS V, IOT_CURRENT_BALANCE B     
                 WHERE  V.PHONE_NUMBER_FEDERAL = B.PHONE_NUMBER(+)    
                 AND B.PHONE_NUMBER IS NOT NULL
                 AND EXISTS
                      /*
                      (SELECT 1
                         FROM v_contracts c
                         WHERE c.DOP_STATUS IS NULL
                         AND c.CONTRACT_CANCEL_DATE IS NULL
                         AND c.PHONE_NUMBER_FEDERAL = V.PHONE_NUMBER_FEDERAL)
                         */
                         (SELECT 1
                             FROM CONTRACTS C--, V_CONTRACT_CHANGES CC
                            WHERE 
                             C.DOP_STATUS is null
                             and not exists
                             (select 1  
                                     FROM CONTRACT_CANCELS CCS
                                    WHERE CCS.CONTRACT_ID = C.CONTRACT_ID 
                             )
     
                          and  c.PHONE_NUMBER_FEDERAL = V.PHONE_NUMBER_FEDERAL
)
                         
                 AND B.BALANCE > V.BLOCK_LIMIT
                 AND B.BALANCE < V.UNBLOCK_LIMIT
                 AND EXISTS
                      (SELECT D.PHONE_NUMBER
                         FROM DB_LOADER_ACCOUNT_PHONES D
                         WHERE     D.YEAR_MONTH = TO_NUMBER (TO_CHAR (SYSDATE, 'YYYYMM'))
                         AND D.PHONE_IS_ACTIVE = 0
                         AND D.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL)
                 AND EXISTS
                      (SELECT 1
                         FROM DB_LOADER_ABONENT_PERIODS D
                         WHERE     D.YEAR_MONTH = TO_NUMBER (TO_CHAR (SYSDATE, 'YYYYMM'))
                         AND D.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                         AND D.BEGIN_DATE <= TRUNC (SYSDATE)
                         AND D.END_DATE >= TRUNC (SYSDATE)
                         AND D.IS_ACTIVE = 1)
                 AND NOT EXISTS (SELECT 1 
                                   FROM AUTO_UNBLOCKED_PHONE R
                                   WHERE R.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                                   AND R.UNBLOCK_DATE_TIME > SYSDATE - 15/24/60))
  LOOP
    vNOW_BALANCE:= GET_ABONENT_BALANCE(rec.PHONE_NUMBER_FEDERAL);
    IF (vNOW_BALANCE > rec.BLOCK_LIMIT) AND (vNOW_BALANCE < rec.UNBLOCK_LIMIT) THEN
      vANSWER := LOADER3_PCKG.UNLOCK_PHONE(rec.PHONE_NUMBER_FEDERAL, 0, 1);
    END IF;
  END LOOP;
END;
/
