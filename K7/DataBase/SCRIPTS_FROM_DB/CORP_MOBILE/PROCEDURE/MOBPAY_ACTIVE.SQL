
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."MOBPAY_ACTIVE" 
IS
   CURSOR c_ep
   IS
      SELECT phone_number FROM TEMP_ANDREY;


   phone_numberf   VARCHAR (50 CHAR);
   str             VARCHAR (2000 CHAR);
--
BEGIN
   OPEN c_ep;

   LOOP                                                                 --c_ep
      FETCH c_ep INTO phone_numberf;

      EXIT WHEN c_ep%NOTFOUND;
      str := GET_MOB_PAY_TXT (phone_numberf);
      DBMS_OUTPUT.PUT_LINE (phone_numberf || ' ' || str);
   END LOOP;                                                            --c_ep

   CLOSE c_ep;
END MobPay_Active;