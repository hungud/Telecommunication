
  CREATE OR REPLACE FUNCTION "SIM_TRADE"."GET_LOGIN_BY_PHONE_M" (pPHONE_NUMBER   IN VARCHAR2,
                                                 mont               DATE)
   RETURN VARCHAR2
IS
   --Vesion=1
   CURSOR C
   IS
      SELECT acs.login
        FROM DB_LOADER_ACCOUNT_PHONES, accounts acs
       WHERE     DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
             AND acs.account_id = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
             AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH =
                    TO_CHAR (mont, 'yyyymm');

   DUMMY   VARCHAR2 (30);
   ITOG    VARCHAR2 (30);
BEGIN
   OPEN C;

   FETCH C INTO DUMMY;

   IF C%FOUND
   THEN
      ITOG := DUMMY;
   ELSE
      ITOG := '';
   END IF;

   CLOSE C;

   RETURN ITOG;
END;