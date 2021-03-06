
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."IS_BLOCKED_EXISTS" (
    pPHONE_NUMBER IN VARCHAR2,
    pBALANCE IN NUMBER
  ) RETURN NUMBER IS
        -- 26.11.12 г. А. Пискунов
  --   
vPHONE_NUMBER VARCHAR2(20);
v_RESULT VARCHAR2(10);  

BEGIN
     
    v_RESULT := '1';
  
    BEGIN
        SELECT V_PHONE_NUMBERS_FOR_UNLOCK.PHONE_NUMBER_FEDERAL INTO vPHONE_NUMBER
           FROM V_PHONE_NUMBERS_FOR_UNLOCK
        WHERE V_PHONE_NUMBERS_FOR_UNLOCK.PHONE_NUMBER_FEDERAL=pPHONE_NUMBER
          AND V_PHONE_NUMBERS_FOR_UNLOCK.HAND_BLOCK<>1
          AND V_PHONE_NUMBERS_FOR_UNLOCK.DISCONNECT_LIMIT <= pBALANCE
          AND NOT EXISTS(SELECT 1
                           FROM AUTO_UNBLOCKED_PHONE
                           WHERE V_PHONE_NUMBERS_FOR_UNLOCK.PHONE_NUMBER_FEDERAL=AUTO_UNBLOCKED_PHONE.PHONE_NUMBER
                             AND AUTO_UNBLOCKED_PHONE.NOTE='Ошибка. Error! Разблокировка через сайт не разрешена'
                             AND AUTO_UNBLOCKED_PHONE.UNBLOCK_DATE_TIME>SYSDATE-4/24) 
                                 --Номера с запретом не чаще раз в 4 часа
        order by BALANCE-NVL(DISCONNECT_LIMIT, 0) DESC;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        v_RESULT := '0';
    END;

    RETURN v_RESULT;

END;