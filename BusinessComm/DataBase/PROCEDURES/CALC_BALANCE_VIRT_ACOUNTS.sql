CREATE OR REPLACE PROCEDURE CALC_BALANCE_VIRT_ACOUNTS 
(
  P_VIRTUAL_ACCOUNTS_ID  INTEGER, --обязательный параметр для ссылки
  P_SUM_BALANCE          NUMBER default null, -- сумма начального баланса, при передаче этого параметра считается начальный баланс указанного месяца
                                            -- обязательно ав этом случае указывать либо дату баланса, либо YEAR_MONTH 
  P_DATE_BALANCE              DATE  default null,
  P_YEAR_MONTH                INTEGER, -- подсчет баланся за указанный период
  P_PAYMENT_ID                INTEGER,
  P_BILL_ID                   INTEGER,
  P_PHONE_ID                  INTEGER,
  P_SUM_PAY                   NUMBER,
  P_BILL_SUM                  NUMBER
)                              
 AS                          
  CALC_PHONE_ON_ACCOUNTS_ID INTEGER;
  --CALC_ACCOUNT_ID           INTEGER;
  --CALC_PHONE_ID             INTEGER;
  CALC_DATE_BALANCE         DATE; 
  CALC_YEAR_MONTH           INTEGER;
  CALC_SUM_BALANCE          NUMBER;
                              
/******************************************************************************
   NAME:       CALC_BALANCE_VIRT_ACOUNTS
   PURPOSE: Считает баланс в таблице BALANCE_VIRT_ACOUNTS   
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        11/02/2016   KOCHNEV_E       1. Created this procedure.
******************************************************************************/
BEGIN
  if P_VIRTUAL_ACCOUNTS_ID is null then
    return;
  end if;

  -- для заполнения начального баланса
  if (P_SUM_BALANCE is not null) then  
    if (P_DATE_BALANCE is not null) then
      CALC_DATE_BALANCE := P_DATE_BALANCE;
      CALC_YEAR_MONTH := to_number(to_char(P_DATE_BALANCE, 'yyyymm'));
    else
      if (P_YEAR_MONTH is null) then
        return;
      else
        CALC_DATE_BALANCE := to_date('01.'||substr(to_char(P_YEAR_MONTH), 5,2)||'.'||substr(to_char(P_YEAR_MONTH), 1,4), 'dd.mm.yyyy');
        CALC_YEAR_MONTH := P_YEAR_MONTH;
      end if;
    end if;
    CALC_SUM_BALANCE          := P_SUM_BALANCE;
    CALC_PHONE_ON_ACCOUNTS_ID := 0;
   -- CALC_ACCOUNT_ID           := 16272;
  --  CALC_PHONE_ID             := 0;
    
    INSERT INTO BALANCE_VIRT_ACOUNTS (VIRTUAL_ACCOUNTS_ID,        PHONE_ON_ACCOUNTS_ID, PAYMENT_ID, BILL_ID, PHONE_ID,     YEAR_MONTH,      DATE_BALANCE,      SUM_BALANCE, SUM_PAY, BILL_SUM, STARTING_BALANCE) 
                              VALUES (P_VIRTUAL_ACCOUNTS_ID, CALC_PHONE_ON_ACCOUNTS_ID, 0,          0,       0,       CALC_YEAR_MONTH, CALC_DATE_BALANCE, CALC_SUM_BALANCE, 0,       0,        1);
    
  end if;
  
  select max(PHONE_ON_ACCOUNTS_ID) into CALC_PHONE_ON_ACCOUNTS_ID from PHONE_ON_ACCOUNTS where PHONE_ID = P_PHONE_ID;
  
  if (P_PAYMENT_ID is not null) then

   CALC_YEAR_MONTH := P_YEAR_MONTH;

   select bv.sum_balance into CALC_SUM_BALANCE  
     from BALANCE_VIRT_ACOUNTS bv
    where bv.VIRTUAL_ACCOUNTS_ID = 865
      and BV.DATE_BALANCE = (
                             select max(BV.DATE_BALANCE) 
                             from BALANCE_VIRT_ACOUNTS bv
                             where bv.VIRTUAL_ACCOUNTS_ID = 865
                            );
                            
   CALC_SUM_BALANCE := CALC_SUM_BALANCE + P_SUM_PAY;
  
   INSERT INTO BALANCE_VIRT_ACOUNTS (VIRTUAL_ACCOUNTS_ID,      PHONE_ON_ACCOUNTS_ID, PAYMENT_ID,   BILL_ID,   PHONE_ID,      YEAR_MONTH,      DATE_BALANCE,      SUM_BALANCE,   SUM_PAY, BILL_SUM, STARTING_BALANCE) 
                           VALUES (P_VIRTUAL_ACCOUNTS_ID, CALC_PHONE_ON_ACCOUNTS_ID, P_PAYMENT_ID, 0,       P_PHONE_ID, CALC_YEAR_MONTH, CALC_DATE_BALANCE, CALC_SUM_BALANCE, P_SUM_PAY,       0,        0);
  end if; 
  
  if P_BILL_ID is not null then
    CALC_YEAR_MONTH := P_YEAR_MONTH;
       select bv.sum_balance into CALC_SUM_BALANCE  
     from BALANCE_VIRT_ACOUNTS bv
    where bv.VIRTUAL_ACCOUNTS_ID = 865
      and BV.DATE_BALANCE = (
                             select max(BV.DATE_BALANCE) 
                             from BALANCE_VIRT_ACOUNTS bv
                             where bv.VIRTUAL_ACCOUNTS_ID = 865
                            );
    CALC_SUM_BALANCE := CALC_SUM_BALANCE - P_BILL_SUM;

    INSERT INTO BALANCE_VIRT_ACOUNTS (VIRTUAL_ACCOUNTS_ID,      PHONE_ON_ACCOUNTS_ID, PAYMENT_ID,   BILL_ID,   PHONE_ID,      YEAR_MONTH,      DATE_BALANCE,      SUM_BALANCE,   SUM_PAY, BILL_SUM, STARTING_BALANCE) 
                            VALUES (P_VIRTUAL_ACCOUNTS_ID, CALC_PHONE_ON_ACCOUNTS_ID, 0,          P_BILL_ID, P_PHONE_ID, CALC_YEAR_MONTH, CALC_DATE_BALANCE, CALC_SUM_BALANCE,   0,     P_BILL_SUM,        0);
                             
    
  end if;

  EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CALC_BALANCE_VIRT_ACOUNTS;



/
