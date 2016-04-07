
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."UNLOCK_PHONE" (pPHONE_NUMBER IN VARCHAR2)
   RETURN VARCHAR2
IS
   --
   vUNLOCK_RESULT   VARCHAR2 (2000);
   vPHONE_NUMBER    VARCHAR (10);
BEGIN
   vPHONE_NUMBER := '0';
   vUNLOCK_RESULT := '';

   BEGIN
        SELECT V_PHONE_NUMBERS_FOR_UNLOCK.PHONE_NUMBER_FEDERAL
          INTO vPHONE_NUMBER
          FROM V_PHONE_NUMBERS_FOR_UNLOCK
         WHERE     V_PHONE_NUMBERS_FOR_UNLOCK.PHONE_NUMBER_FEDERAL =
                      pPHONE_NUMBER
               AND V_PHONE_NUMBERS_FOR_UNLOCK.HAND_BLOCK <> 1
               AND NOT EXISTS
                          (SELECT 1
                             FROM AUTO_UNBLOCKED_PHONE
                            WHERE     V_PHONE_NUMBERS_FOR_UNLOCK.PHONE_NUMBER_FEDERAL =
                                         AUTO_UNBLOCKED_PHONE.PHONE_NUMBER
                                  AND AUTO_UNBLOCKED_PHONE.NOTE =
                                         'Ошибка. Error! Разблокировка через сайт не разрешена'
                                  AND AUTO_UNBLOCKED_PHONE.UNBLOCK_DATE_TIME >
                                         SYSDATE - 4 / 24)
      --Номера с запретом не чаще раз в 4 часа
      ORDER BY BALANCE - NVL (DISCONNECT_LIMIT, 0) DESC;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         vPHONE_NUMBER := '0';
         vUNLOCK_RESULT :=
            'Номер нет необходимости разблокировать, т.к. он не заблокирован.';
   END;

   IF vPHONE_NUMBER <> '0'
   THEN
      BEGIN
         vUNLOCK_RESULT := LOADER3_pckg.UNLOCK_PHONE (pPHONE_NUMBER);
      END;
   END IF;

   INSERT INTO CRM_UNBLOCK_PHONE_LOG (PHONE_NUMBER,
                                      BALANCE,
                                      DATE_INSERT,
                                      ERROR_TEXT,
                                      CRM_MESSAGE_TYPE)
        VALUES (pPHONE_NUMBER,
                999,
                SYSDATE,
                'Ошибка. ',
                1);

   COMMIT;
   RETURN vUNLOCK_RESULT;
END;