CREATE OR REPLACE FUNCTION GET_AVG_PAY_ON_CONTRACT_DATE (
   p_phone_number   IN VARCHAR2,
   p_contract_date  in DATE default SYSDATE,
   p_contract_cancel_date  in DATE default SYSDATE,
   p_date_from         DATE DEFAULT SYSDATE,
   p_date_to           DATE DEFAULT SYSDATE)
   RETURN NUMBER
IS
--функция получения среднего платежа в зависимости от даты контракта
--
--Version=1
--
--v.1 24.07.2015 Добавил функцию
--   
   v_average_payment   NUMBER (10);
   v_date_from DATE;
   v_date_to DATE;
   v_contract_date DATE;
   v_contract_cancel_date date;
   
BEGIN
  v_date_from :=  TRUNC (p_date_from);
  v_date_to := TRUNC (p_date_to);
  v_contract_date := TRUNC(nvl(p_contract_date, trunc(ADD_MONTHS(sysdate, -(12*100)), 'yyyy')));-- если дата нулевая то берем за весь период
  v_contract_cancel_date := trunc(nvl(p_contract_cancel_date, sysdate)); -- если дата нулевая то берем по текущую
   
  if (v_date_from < v_contract_date and 
    v_date_to < v_contract_date) 
    OR
    (v_contract_cancel_date < v_contract_date)
    OR
    (v_date_to < v_contract_date)
    then
  
    v_average_payment := null;
  else    
  
    if v_date_from < v_contract_date then
      v_date_from := v_contract_date;
    end if;
    
    if v_date_to > v_contract_cancel_date then
      v_date_to := v_contract_cancel_date;
    end if;   
     
     
     SELECT AVG (lp.payment_sum)
       INTO v_average_payment
       FROM V_FULL_BALANCE_PAYMENTS lp
      WHERE     lp.phone_number = p_phone_number
            AND lp.PAYMENT_TYPE IN (2)
            AND TRUNC (lp.payment_date) >= trunc(v_date_from)
            AND TRUNC (lp.payment_date)  <= trunc(v_date_to);
  end if;
  
  RETURN v_average_payment;
END;
/

GRANT EXECUTE ON GET_AVG_PAY_ON_CONTRACT_DATE TO CORP_MOBILE_ROLE;
GRANT EXECUTE ON GET_AVG_PAY_ON_CONTRACT_DATE TO CORP_MOBILE_ROLE_RO;