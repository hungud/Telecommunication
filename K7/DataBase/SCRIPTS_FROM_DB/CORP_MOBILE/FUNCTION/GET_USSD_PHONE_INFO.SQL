
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_USSD_PHONE_INFO" (pMSISDN IN VARCHAR2)
   RETURN VARCHAR2
IS
--
--#Version=2
--
--v2 12.11.2014 - Афросин - Добавил отправку смс для коллектора
--
   pragma autonomous_transaction;
   vITOG   VARCHAR2 (300 CHAR);

   CURSOR C
   IS
      SELECT AC.IS_COLLECTOR
        FROM DB_LOADER_ACCOUNT_PHONES D, ACCOUNTS AC
       WHERE     D.YEAR_MONTH = TO_NUMBER (TO_CHAR (SYSDATE, 'YYYYMM'))
             AND D.ACCOUNT_ID = AC.ACCOUNT_ID
             AND D.PHONE_NUMBER = pMSISDN;

   DUMMY   C%ROWTYPE;
   vSTR    VARCHAR2 (500 CHAR);
BEGIN
   OPEN C;

   FETCH C INTO DUMMY;

   IF C%FOUND
   THEN
      vITOG := 'Ваш номер +7' || pMSISDN || '.';
      IF NVL (DUMMY.IS_COLLECTOR, 0) = 1
      THEN                                                   -- Ищем коллектор
         vSTR := loader3_pckg.send_sms (pMSISDN, 'AgSv', vITOG||' Teletie.ru');
         vITOG := vITOG ||' Ожидайте смс сообщения.';
      END IF;
   ELSE
      vITOG := 'Данный номер не числится на л/с.';
   END IF;

   CLOSE C;

   RETURN vITOG;
END;