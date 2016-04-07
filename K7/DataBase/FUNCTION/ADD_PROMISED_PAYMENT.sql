CREATE OR REPLACE FUNCTION ADD_PROMISED_PAYMENT (pPHONE_NUMBER   IN VARCHAR2,
                                                 pPAYMENT_SUM    IN NUMBER,
                                                 pPAYMENT_DATE   IN DATE)
   RETURN VARCHAR2
IS
   --Version = 6
   --v.6 14.10.2015 Афросин. Добавил отправку сообщения о предоставлении обещанного платежа
   --v.5 17.03.2015 Афросин. Добавил  PRAGMA AUTONOMOUS_TRANSACTION;   
   --25.11.2014 Алексеев. Таблица PROMISED_PAYMENTS заменена на views V_ACTIVE_PROMISED_PAYMENTS
   PRAGMA AUTONOMOUS_TRANSACTION;
   CURSOR C (aPHONE_NUMBER VARCHAR2)
   IS
      SELECT PP.*
        FROM V_ACTIVE_PROMISED_PAYMENTS PP
       WHERE PP.PHONE_NUMBER = aPHONE_NUMBER AND PP.PAYMENT_DATE <= SYSDATE;

   ITOG    VARCHAR2 (300 CHAR);
   REC_C   C%ROWTYPE;
   vSMS_TEXT varchar2(500 char);
BEGIN
   ITOG := '';
   vSMS_TEXT := '';

   OPEN C (pPHONE_NUMBER);

   FETCH C INTO REC_C;

   IF C%NOTFOUND
   THEN
      INSERT INTO PROMISED_PAYMENTS (PHONE_NUMBER,
                                     PAYMENT_DATE,
                                     PROMISED_DATE,
                                     PROMISED_SUM,
                                     PROMISED_DATE_END)
           VALUES (pPHONE_NUMBER,
                   SYSDATE,
                   pPAYMENT_DATE,
                   pPAYMENT_SUM,
                   pPAYMENT_DATE);

      COMMIT;
      ITOG :=
            'Добавлен обещанный платеж '
         || TO_CHAR (pPAYMENT_SUM)
         || 'р до '
         || TO_CHAR (pPAYMENT_DATE, 'DD.MM.YYYY HH24:MI:SS')
         || ' на номер '
         || pPHONE_NUMBER
         || '.';
         
      
      vSMS_TEXT := 'Вам предоставлен обещанный платеж на сумму '||TO_CHAR (pPAYMENT_SUM)||'р, срок действия до '|| TO_CHAR (pPAYMENT_DATE, 'DD.MM.YYYY');
      SEND_SMS_PROMISED_PAYMENT (pPHONE_NUMBER, vSMS_TEXT);
      
   ELSE
      ITOG :=
            'Для номера '
         || pPHONE_NUMBER
         || ' уже существует обещанный платеж.';
   END IF;

   CLOSE C;

   RETURN ITOG;
END;
/

GRANT EXECUTE ON  ADD_PROMISED_PAYMENT TO CORP_MOBILE_ROLE;
GRANT EXECUTE ON  ADD_PROMISED_PAYMENT TO CORP_MOBILE_ROLE_RO;
CREATE SYNONYM CRM_USER.ADD_PROMISED_PAYMENT FOR ADD_PROMISED_PAYMENT;
GRANT EXECUTE ON  ADD_PROMISED_PAYMENT TO CRM_USER;
