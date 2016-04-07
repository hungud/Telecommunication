CREATE OR REPLACE VIEW V_UNBLOCK_BETWEEN_LIMITS AS
-- Version = 1
--
-- 2. 2015.10.30. Крайнов. Добавление отсева по доп статусу.
-- 1. 2015.09.29. Крайнов. Создание. Разблок номеров между порогами блокировки и разблокировки.
--
  SELECT V.*, B.BALANCE
    FROM V_PHONE_LIMITS V, 
         IOT_CURRENT_BALANCE B
    WHERE V.PHONE_NUMBER_FEDERAL = B.PHONE_NUMBER(+)
      AND B.PHONE_NUMBER IS NOT NULL
      AND B.BALANCE > V.BLOCK_LIMIT
      AND B.BALANCE < V.UNBLOCK_LIMIT
      AND V.PHONE_NUMBER_FEDERAL IN (SELECT C.PHONE_NUMBER_FEDERAL
                                       FROM V_CONTRACTS C
                                       WHERE C.DOP_STATUS IS NULL
                                         AND C.CONTRACT_CANCEL_DATE IS NULL)
      AND V.PHONE_NUMBER_FEDERAL IN (SELECT PHONE_NUMBER
                                       FROM DB_LOADER_ACCOUNT_PHONES D
                                       WHERE D.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
                                         AND D.PHONE_IS_ACTIVE = 0)
      AND EXISTS (SELECT 1 
                    FROM DB_LOADER_ABONENT_PERIODS D
                    WHERE D.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
                      AND D.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                      AND D.BEGIN_DATE <= TRUNC(SYSDATE)
                      AND D.END_DATE >= TRUNC(SYSDATE) 
                      AND D.IS_ACTIVE = 1);                                       
  -- order by abs(v.BLOCK_LIMIT - v.UNBLOCK_LIMIT ) desc