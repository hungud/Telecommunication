CREATE OR REPLACE VIEW V_DISCR_ABON_ADD AS
  SELECT C.CONTRACT_ID, 
         C.PHONE_NUMBER_FEDERAL,
         GET_DISCR_ABON_ADD(C.PHONE_NUMBER_FEDERAL) NEW_ABON_ADD,
         GET_DISCR_ABON_ADD_OPTIONS(C.PHONE_NUMBER_FEDERAL) NEW_ABON_ADD_OPTS,
         NVL(L.BLOCK_LIMIT, 0) BLOCK_LIMIT,
         I.BALANCE 
    FROM V_CONTRACTS C,
         V_PHONE_LIMITS L,
         IOT_CURRENT_BALANCE I
    WHERE C.PHONE_NUMBER_FEDERAL = L.PHONE_NUMBER_FEDERAL(+)
      AND C.PHONE_NUMBER_FEDERAL = I.PHONE_NUMBER(+)
      AND C.DOP_STATUS IS NULL
      AND CONVERT_PCKG.GET_IS_COLLECTOR_BY_PHONE(C.PHONE_NUMBER_FEDERAL) = 0 
      AND C.PHONE_NUMBER_FEDERAL IN (SELECT D.PHONE_NUMBER
                                       FROM DB_LOADER_ACCOUNT_PHONES D
                                       WHERE D.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
                                         AND D.PHONE_IS_ACTIVE = 1)
      AND C.PHONE_NUMBER_FEDERAL IN (SELECT DISTINCT D.PHONE_NUMBER
                                       FROM DB_LOADER_ACCOUNT_PHONE_OPTS D
                                       WHERE D.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
                                         AND D.OPTION_CODE IN (SELECT O.OPTION_CODE
                                                                 FROM TARIFF_OPTIONS O
                                                                 WHERE O.DISCR_SPISANIE = 1))
      AND I.BALANCE - GET_DISCR_ABON_ADD(C.PHONE_NUMBER_FEDERAL) < NVL(L.BLOCK_LIMIT, 0);