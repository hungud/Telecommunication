CREATE OR REPLACE FUNCTION GET_AVERAGE_PAYMENT (
   p_phone_number   IN VARCHAR2,
   p_date_from         DATE DEFAULT SYSDATE,
   p_date_to           DATE DEFAULT SYSDATE)
   RETURN NUMBER
IS
   v_average_payment   NUMBER (10);
   v_date_from DATE;
   v_date_to DATE;
   
-- v1.Бакунов К. - функция GET_AVERAGE_PAYMENT - возвращает среднее значение платежа по номеру телефона за указанный период   
BEGIN
   v_date_from :=  TRUNC (p_date_from);
   v_date_to := TRUNC (p_date_to);
   
   
   SELECT AVG (lp.payment_sum)
     INTO v_average_payment
     FROM V_FULL_BALANCE_PAYMENTS lp
    WHERE     lp.phone_number = p_phone_number
          AND lp.PAYMENT_TYPE IN (1, 2)
          AND TRUNC (lp.payment_date) >= trunc(v_date_from)
          AND TRUNC (lp.payment_date)  <= trunc(v_date_to);

   RETURN v_average_payment;
END;
/

GRANT EXECUTE ON GET_AVERAGE_PAYMENT TO CORP_MOBILE_ROLE;
GRANT EXECUTE ON GET_AVERAGE_PAYMENT TO CORP_MOBILE_ROLE_RO;