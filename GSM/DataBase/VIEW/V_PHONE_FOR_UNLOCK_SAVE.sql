CREATE OR REPLACE VIEW V_PHONE_FOR_UNLOCK_SAVE AS
-- Version = 1
--
-- 1. 2015.11.09. Крайнов. Создание.
  SELECT C.PHONE_NUMBER_FEDERAL,
         (SELECT L.UNBLOCK_LIMIT 
            FROM V_PHONE_LIMITS L
            WHERE L.PHONE_NUMBER_FEDERAL = C.PHONE_NUMBER_FEDERAL) UNBLOCK_LIMIT,
         (SELECT AB.SURNAME || ' ' || AB.NAME || ' ' || AB.PATRONYMIC
            FROM ABONENTS AB
            WHERE AB.ABONENT_ID = C.ABONENT_ID) FIO 
    FROM V_CONTRACTS C
    WHERE C.CONTRACT_CANCEL_DATE IS NULL
      AND C.PHONE_NUMBER_FEDERAL NOT IN (SELECT PHONE_NUMBER FROM NUMBER_BLOCK_IN_SAVE)
      AND C.CONTRACT_ID NOT IN (SELECT CONTRACT_ID
                                  FROM CONTRACTS 
                                  WHERE CURR_TARIFF_ID IN (SELECT TARIFF_ID
                                                             FROM TARIFFS
                                                             WHERE ACCESS_UNLOCK_SAVE = 0))
      AND C.PHONE_NUMBER_FEDERAL IN (SELECT PHONE_NUMBER 
                                       FROM DB_LOADER_ACCOUNT_PHONES D, 
                                            BEELINE_STATUS_CODE B
                                       WHERE D.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
                                         AND D.STATUS_ID = B.STATUS_ID(+)
                                         AND B.STATUS_CODE = 'S1B'
                                         AND D.LAST_CHANGE_STATUS_DATE >= TRUNC(SYSDATE) - MS_PARAMS.GET_PARAM_VALUE('DAYS_FOR_UNLOCK_SAVE'));

GRANT SELECT ON V_PHONE_FOR_UNLOCK_SAVE TO LONTANA_ROLE;      

GRANT SELECT ON V_PHONE_FOR_UNLOCK_SAVE TO LONTANA_ROLE_RO;      