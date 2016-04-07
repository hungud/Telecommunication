CREATE OR REPLACE FUNCTION GET_ABONENT_BALANCE_USSD(
  pPHONEA IN VARCHAR2
  ) RETURN VARCHAR2 IS
--#Version=5
--20.02.2015 
--03.02.2015 Алексеев. Для коллекторов (93,99) в сообщении о балансе сумма 500 заменена на 800 (теперь: приведи друга и получи 800 рублей)
--12.11.2014 Алексеев. Отправка смс о баллансе с информацией об обещ. платеже (при его наличии). Для Teletie
--25.11.2014 Алексеев. Таблица PROMISED_PAYMENTS заменена на вьюху V_ACTIVE_PROMISED_PAYMENTS
  CURSOR C IS
    SELECT PROMISED_SUM, PROMISED_DATE
      FROM V_ACTIVE_PROMISED_PAYMENTS
      WHERE PHONE_NUMBER = pPHONEA;
  vDUMMY C%ROWTYPE;
  PRAGMA AUTONOMOUS_TRANSACTION;
  USSD_BACK_TXT VARCHAR2 (300 CHAR);
  accountid INTEGER;
  balance NUMBER;
  n_group_id NUMBER;
  vPHONEA VARCHAR2(10 CHAR);
  SMS_ITOG VARCHAR2(300 CHAR);
  vIS_COLLECTOR INTEGER;
  V_CONTRACT_ID INTEGER;
BEGIN
  IF NVL(MS_PARAMS.GET_PARAM_VALUE('USSD_BALANCE_INFO_ON'), 0) = '1' THEN
    IF (MS_CONSTANTS.GET_CONSTANT_VALUE ('USES_MNP') = 1) THEN
      vPHONEA := MNP_TEMP_TO_MAIN (pPHONEA);
    ELSE
      vPHONEA := pPHONEA;
    END IF;

    SELECT GET_ACCOUNT_ID_BY_PHONE (vPHONEA) INTO accountid FROM DUAL;

    BEGIN  --если стоит галочка возвращать баланс группы по групповым договрам.
      n_group_id := 0;

      SELECT ct.GROUP_ID
        INTO n_group_id
        FROM contracts ct
        WHERE ct.phone_number_federal = vPHONEA
          AND NOT EXISTS (SELECT 1
                            FROM contract_cancels cc
                            WHERE ct.contract_id = cc.contract_id)
          AND EXISTS (SELECT 1
                        FROM contract_groups cg
                        WHERE cg.GROUP_ID = ct.GROUP_ID
                          AND cg.paramussd_gr_bal > 0);

      SELECT SUM(get_abonent_balance(c.phone_number_federal, c.contract_cancel_date))
        INTO balance
        FROM v_contracts c
        WHERE c.GROUP_ID = n_group_id;
    EXCEPTION
      --если группы нет, то просто баланс
      WHEN OTHERS THEN
        SELECT GET_ABONENT_BALANCE (vPHONEA) INTO balance FROM DUAL;
    END;

    --определяем коллекторский счет или нет
    SELECT COUNT(IS_COLLECTOR)
      INTO vIS_COLLECTOR
      FROM ACCOUNTS
      WHERE ACCOUNT_ID = accountid AND IS_COLLECTOR IS NOT NULL;
    -- Определяем контракт.
    SELECT COUNT(C.CONTRACT_ID) INTO V_CONTRACT_ID
      FROM CONTRACTS C, CONTRACT_CANCELS CC
      WHERE C.CONTRACT_ID = CC.CONTRACT_ID(+)
        AND CC.CONTRACT_CANCEL_DATE IS NULL;
    IF (V_CONTRACT_ID <= 0) AND (vIS_COLLECTOR <> 0) THEN
      balance:=balance + 500;
    END IF;

    IF vIS_COLLECTOR <> 0 THEN
      IF accountid = 93 THEN
        --USSD_BACK_TXT:='Баланс '||balance||' руб. Приведи друга и получи 500 руб. на счет! Тел. 7(495)2230110';   Замена 29,09,2014 на...
        USSD_BACK_TXT:= 'Баланс ' || balance || ' руб. Приведи друга и получи 800 руб. на счет! Тел. +7(495)2230110';
      --'Баланс ХХХХ.ХХ руб. Приведи друга и получи 500 руб. на счет! Тел. 7(495)2230110'
      ELSIF accountid = 99 THEN
        --USSD_BACK_TXT:='Баланс '||balance||' руб. Приведи друга и получи 500 руб. на счет! Тел. 7(812)6432100';   Замена 29,09,2014 на...
        USSD_BACK_TXT := 'Баланс ' || balance || ' руб. Приведи друга и получи 800 руб. на счет! Тел. +7(495)2230110';
      ELSE
        USSD_BACK_TXT := 'Баланс ' || balance || ' руб. Приведи друга и получи 800 руб. на счет! Тел. +7(495)2230110';
      END IF;
    ELSE
      USSD_BACK_TXT := 'Ваш баланс ' || balance || ' руб.';
--      USSD_BACK_TXT := 'Проверка баланса временно недоступна.';
    END IF;

   --отправляем сообщение, если имеется обещанный платеж (только для Teletie)
    IF (vIS_COLLECTOR <> 0) THEN
      --проверяем наличие обещанного платежа
      OPEN C;
      FETCH C INTO vDUMMY;
      IF C%FOUND THEN
         IF vDUMMY.PROMISED_SUM <> 0 THEN
            SMS_ITOG := loader3_pckg.send_sms(vPHONEA, 'AgSv',
                     'Баланс ' || (balance - vDUMMY.PROMISED_SUM) || ' руб. Обещанный платеж ' || TO_CHAR (vDUMMY.PROMISED_SUM)
                      || ' руб., действует до ' || TO_CHAR (vDUMMY.PROMISED_DATE, 'DD.MM.YYYY') || '.');
         END IF;
      END IF;
    END IF;
  ELSE
    USSD_BACK_TXT:='Проверка баланса временно недоступна';
  END IF;

  RETURN USSD_BACK_TXT;
END;
/