CREATE OR REPLACE FUNCTION CHECK_TELETIE_PAYMENT (phonenr       IN     VARCHAR2, --номер абонента
                                            amount        IN     VARCHAR2, --сумма платежа
                                            numpay        IN     VARCHAR2, --номер платежа
                                            paycom        IN     VARCHAR2, --комментарий платежа
                                            ssign         IN     VARCHAR2, --sign
                                            HTTP_ANSWER      OUT VARCHAR2,
                                            pMobiPay      IN INTEGER DEFAULT 0)
   RETURN VARCHAR2
IS
   --
   --#Version=2
   --
   --v.2 Алексеев 22.03.2016 Добавил признак списания по мобиденьгам - pMobiPay. По дефолту 0.
   --                       Признак добавлен чтобы потом в логах понимать относится ли запись к функционалу по мобиденьгам.
   --v.1 Афросин 09.03.2016 функция проверки статуса платежа, полученного функцией  TELETIE_PAYMENT

   urls      VARCHAR2 (2000);
   res       VARCHAR2 (2000);
   SQLres    VARCHAR2 (2000);
   psign     VARCHAR2 (2000);
   flag      INTEGER;
   slogin    VARCHAR2 (30);
   summ      NUMBER;
   spaycom   VARCHAR2 (200);
BEGIN
  IF paycom IS NOT NULL THEN
    spaycom := UTL_URL.unescape (TRANSLATE (paycom, '+', ' '), 'CL8MSWIN1251'); --UTF8
  ELSE
    spaycom := NULL;
  END IF;

  IF phonenr IS NOT NULL THEN
    summ := TO_NUMBER (amount, '999999D99', ' NLS_NUMERIC_CHARACTERS = ''.,''');

    --проверку ссылки оставлем такой же как и в функции TELETIE_PAYMENT
    urls :=
        'teletiepay.php?phonenr='
     || phonenr
     || '&'
     || 'amount='
     || amount
     || '&'
     || 'numpay='
     || numpay
     || '&'
     || 'paycom='
     || paycom
     || MS_params.GET_PARAM_VALUE ('TELETIE_PAY_PASSWORD');

    psign := gnuhash_sha512 (urls);

    IF ssign = psign THEN
     
      SELECT COUNT (*)
        INTO flag
        FROM DB_LOADER_PAYMENTS dlp
        WHERE     dlp.phone_number = phonenr
            AND dlp.payment_number = numpay
            AND SIGN (dlp.payment_sum) = SIGN (summ);

      IF flag = 0 THEN
        slogin := NVL (get_login_by_phone (phonenr), 'A4582633'); --'A4582633';--get_login_by_phone(phonenr);

        IF slogin IS NOT NULL THEN

          HTTP_ANSWER := '200 Ok';
          res := 'Payment is not exists!';
          
        ELSE
          
          HTTP_ANSWER := '400 Error: Incorrect phone!';
          res := 'Error: Incorrect phone!';
          
        END IF;--IF slogin IS NOT NULL THEN
        
      ELSE
        HTTP_ANSWER := '200 Ok Payment exists!';
        res := 'Payment exists!';
      END IF;--IF flag = 0 THEN
    
    ELSE
      HTTP_ANSWER := '400 Error: Incorrect sign!';
      res := ' Error: Incorrect sign';
    END IF;-- IF ssign = psign THEN

    INSERT INTO teletie_pay_log (phonenr,
                               amount,
                               numpay,
                               ssign,
                               http_answer,
                               res,
                               date_insert,
                               paycom,
                               sms_send,
                               IS_MOBI_PAY)
       VALUES (phonenr,
               summ,
               numpay,
               ssign,
               HTTP_ANSWER,
               res,
               NULL,
               spaycom,
               NULL,
               pMobiPay);

    COMMIT;
  ELSE
    HTTP_ANSWER := '400 Error: Parameter is not passed!';
    RES := 'Parameter is not passed!';
  END IF;-- IF phonenr IS NOT NULL THEN

  RETURN RES;
EXCEPTION
  WHEN OTHERS THEN
    SQLres := SQLERRM;
    HTTP_ANSWER := '500 Error on the server side, partner!';
    res := 'Error on the server side, partner!';

    INSERT INTO teletie_pay_log (phonenr,
                               amount,
                               numpay,
                               ssign,
                               http_answer,
                               res,
                               date_insert,
                               paycom,
                               sms_send,
                               IS_MOBI_PAY)
       VALUES (phonenr,
               summ,
               numpay,
               ssign,
               HTTP_ANSWER,
               res || ' (' || SQLres || ')',
               NULL,
               spaycom,
               NULL,
               pMobiPay);

    COMMIT;
    RETURN RES;
END;