CREATE OR REPLACE package BALANCE  as

  
  --#Version=2
  --v.2 Àôðîñèí 09.03.2016 - Ïåðåèìåíîâàë ñòîëáåö STARTING_BALANCE â BALANCE_TYPE_ID
  
  -- Author  :Êî÷íåâ Å.
  -- Created : 16.02.2016 14:12:44
  -- Âåðñèÿ 1
  
   type cur_bal_cursor is ref cursor return BALANCE_VIRT_ACOUNTS%rowtype;

   PROCEDURE INSERT_BEGINNER_BALANCE (P_VIRTUAL_ACCOUNTS_ID INTEGER, P_SUM_BALANCE NUMBER, P_DATE_BALANCE DATE);
   
   PROCEDURE DELETE_BEGINNER_BALANCE (P_ID_BALANCE_VIRT_ACOUNTS INTEGER); 
  
   PROCEDURE INSERT_PAYMENT_INTO_BALANCE (P_VIRTUAL_ACCOUNTS_ID INTEGER, P_DATE_BALANCE DATE, P_PAYMENT_ID INTEGER, P_PHONE_ID INTEGER, P_SUM_PAY NUMBER); 
 
   PROCEDURE INSERT_BILLS_INTO_BALANCE (P_ACCOUNTS_ID INTEGER, P_DATE_BALANCE DATE, P_BILL_ID INTEGER, P_PHONE_ID INTEGER, P_BILL_SUM NUMBER);
   
   PROCEDURE RECALC_BALANCE (P_VIRTUAL_ACCOUNTS_ID INTEGER, P_YEAR_MONTH INTEGER);
  
   PROCEDURE RECALC_BALANCE2 (P_VIRTUAL_ACCOUNTS_ID INTEGER, P_YEAR_MONTH INTEGER);
   
   FUNCTION GET_PHONE_ON_ACCOUNTS_ID (P_PHONE_ID INTEGER) RETURN INTEGER;
   
   PROCEDURE INSERT_PAYMENT_INTO_BALANCE_TR (P_VIRTUAL_ACCOUNTS_ID INTEGER, P_DATE_BALANCE DATE, P_PAYMENT_ID INTEGER, P_PHONE_ID INTEGER, P_SUM_PAY NUMBER);
     
   PROCEDURE INSERT_BILLS_INTO_BALANCE_TR (P_ACCOUNTS_ID INTEGER, P_DATE_BALANCE DATE, P_BILL_ID INTEGER, P_PHONE_ID INTEGER, P_BILL_SUM NUMBER);
   
end BALANCE;
/

CREATE OR REPLACE package body BALANCE is
  ñSTART_BALANCE_AUTO_TYPE CONSTANT BALANCE_TYPES.BALANCE_TYPE_ID%TYPE := -1;--  íà÷àëüíûé, íàçíà÷åííûé
  ñSTART_BALANCE_CALC_TYPE CONSTANT BALANCE_TYPES.BALANCE_TYPE_ID%TYPE := 0; --  íà÷àëüíûé, âû÷èñëåííûé
  ñSTART_BALANCE_INTERIM_TYPE CONSTANT BALANCE_TYPES.BALANCE_TYPE_ID%TYPE := 1; --  ïðîìåæóòî÷íûé
  ñSTART_BALANCE_LAST_TYPE CONSTANT BALANCE_TYPES.BALANCE_TYPE_ID%TYPE := 2; --  ïîñëåäíèé çà ïåðèîä
  ñSTART_BALANCE_NO_TYPE CONSTANT BALANCE_TYPES.BALANCE_TYPE_ID%TYPE := 3; --  íåò áàëàíñà

  PROCEDURE INSERT_BEGINNER_BALANCE  (P_VIRTUAL_ACCOUNTS_ID INTEGER, P_SUM_BALANCE NUMBER, P_DATE_BALANCE DATE)
  as
    CALC_YEAR_MONTH              INTEGER;
    CALC_SUM_BALANCE             NUMBER;
    LAST_ID_BALANCE_VIRT_ACOUNTS INTEGER;
    v_cur_bal_cursor             cur_bal_cursor;
    v_cur_balance BALANCE_VIRT_ACOUNTS%rowtype;
  begin
    if P_VIRTUAL_ACCOUNTS_ID is null then
      return;
    end if;
    
    if (P_SUM_BALANCE is not null) then  
      CALC_YEAR_MONTH := to_number(to_char(P_DATE_BALANCE, 'yyyymm'));
         
      delete from BALANCE_VIRT_ACOUNTS  
       where VIRTUAL_ACCOUNTS_ID = P_VIRTUAL_ACCOUNTS_ID
         and YEAR_MONTH = CALC_YEAR_MONTH
         and BALANCE_TYPE_ID < ñSTART_BALANCE_INTERIM_TYPE;
          
      INSERT INTO BALANCE_VIRT_ACOUNTS (VIRTUAL_ACCOUNTS_ID, PHONE_ON_ACCOUNTS_ID, PAYMENT_ID, BILL_ID, PHONE_ID,     YEAR_MONTH,   DATE_BALANCE,   SUM_BALANCE, SUM_PAY, BILL_SUM, BALANCE_TYPE_ID) 
                                VALUES (P_VIRTUAL_ACCOUNTS_ID, 0, 0, 0, 0, CALC_YEAR_MONTH, P_DATE_BALANCE, P_SUM_BALANCE, 0, 0, ñSTART_BALANCE_AUTO_TYPE);
      
      CALC_SUM_BALANCE := P_SUM_BALANCE;
      
      
      open v_cur_bal_cursor for
        select * 
          from BALANCE_VIRT_ACOUNTS bva 
         where bva.VIRTUAL_ACCOUNTS_ID = P_VIRTUAL_ACCOUNTS_ID
           and bva.DATE_BALANCE >= P_DATE_BALANCE
           and bva.YEAR_MONTH = CALC_YEAR_MONTH
           and BALANCE_TYPE_ID > ñSTART_BALANCE_CALC_TYPE
      order by bva.DATE_BALANCE;
        
      loop
        fetch v_cur_bal_cursor into v_cur_balance;
        exit when v_cur_bal_cursor%NOTFOUND;
      
        CALC_SUM_BALANCE := CALC_SUM_BALANCE + v_cur_balance.SUM_PAY - v_cur_balance.BILL_SUM; 
        
        LAST_ID_BALANCE_VIRT_ACOUNTS := v_cur_balance.ID_BALANCE_VIRT_ACOUNTS;
        
        update BALANCE_VIRT_ACOUNTS set 
           SUM_BALANCE = CALC_SUM_BALANCE
         where ID_BALANCE_VIRT_ACOUNTS = LAST_ID_BALANCE_VIRT_ACOUNTS;
      
      end loop; 
    
      close v_cur_bal_cursor;
      
      update BALANCE_VIRT_ACOUNTS set 
           BALANCE_TYPE_ID = ñSTART_BALANCE_LAST_TYPE
         where ID_BALANCE_VIRT_ACOUNTS = LAST_ID_BALANCE_VIRT_ACOUNTS;
         
    end if;   
  end; 
  
  PROCEDURE DELETE_BEGINNER_BALANCE  (P_ID_BALANCE_VIRT_ACOUNTS INTEGER)
  AS
    V_VIRTUAL_ACCOUNTS_ID     INTEGER;
    CALC_YEAR_MONTH           INTEGER;
    CALC_DATE_BALANCE         DATE;   
    CALC_SUM_BALANCE          NUMBER;
                              
    v_cur_bal_cursor cur_bal_cursor;
    v_cur_balance BALANCE_VIRT_ACOUNTS%rowtype;
  BEGIN
    select VIRTUAL_ACCOUNTS_ID,  DATE_BALANCE INTO V_VIRTUAL_ACCOUNTS_ID, CALC_DATE_BALANCE 
      from BALANCE_VIRT_ACOUNTS 
    where ID_BALANCE_VIRT_ACOUNTS = P_ID_BALANCE_VIRT_ACOUNTS;
     
     CALC_YEAR_MONTH := to_number(to_char(CALC_DATE_BALANCE, 'yyyymm'));
    
    delete from BALANCE_VIRT_ACOUNTS 
     where ID_BALANCE_VIRT_ACOUNTS = P_ID_BALANCE_VIRT_ACOUNTS;
      
    CALC_SUM_BALANCE := 0; 
    
    open v_cur_bal_cursor for 
      select * 
        from BALANCE_VIRT_ACOUNTS bva 
       where bva.VIRTUAL_ACCOUNTS_ID = V_VIRTUAL_ACCOUNTS_ID
         and bva.DATE_BALANCE > CALC_DATE_BALANCE
         and bva.YEAR_MONTH = CALC_YEAR_MONTH
       order by bva.DATE_BALANCE;
    
    loop
      fetch v_cur_bal_cursor into v_cur_balance;
      exit when v_cur_bal_cursor%NOTFOUND;
      
      CALC_SUM_BALANCE := CALC_SUM_BALANCE + nvl(v_cur_balance.SUM_PAY,0) - nvl(v_cur_balance.BILL_SUM,0); 
      update BALANCE_VIRT_ACOUNTS set 
                      SUM_BALANCE = CALC_SUM_BALANCE
       where ID_BALANCE_VIRT_ACOUNTS = v_cur_balance.ID_BALANCE_VIRT_ACOUNTS;
      
    end loop; 
   
    close v_cur_bal_cursor;
  END;

  FUNCTION GET_PHONE_ON_ACCOUNTS_ID (P_PHONE_ID INTEGER) RETURN INTEGER
  as
    CALC_PHONE_ON_ACCOUNTS_ID  INTEGER;
  begin
    select max(PHONE_ON_ACCOUNTS_ID) into CALC_PHONE_ON_ACCOUNTS_ID from PHONE_ON_ACCOUNTS where PHONE_ID = P_PHONE_ID;
    return CALC_PHONE_ON_ACCOUNTS_ID;    
  end;
  
  
  PROCEDURE INSERT_PAYMENT_INTO_BALANCE (P_VIRTUAL_ACCOUNTS_ID INTEGER, P_DATE_BALANCE DATE,  
                                         P_PAYMENT_ID INTEGER, P_PHONE_ID INTEGER, P_SUM_PAY NUMBER)
  as
    CALC_PHONE_ON_ACCOUNTS_ID INTEGER;
    CALC_YEAR_MONTH           INTEGER;
    CALC_PHONE_ID             INTEGER;
  begin
  
   CALC_YEAR_MONTH := to_number(to_char(P_DATE_BALANCE, 'yyyymm'));
      
    select max(PHONE_ON_ACCOUNTS_ID) into CALC_PHONE_ON_ACCOUNTS_ID from CONTRACTS where VIRTUAL_ACCOUNTS_ID = P_VIRTUAL_ACCOUNTS_ID;
   
    if CALC_PHONE_ON_ACCOUNTS_ID is null then
    
      INSERT INTO DB_LOADER_BILLS_INS_BALANCE(PAYMENT_ID, PHONE_ID ) 
                                      VALUES (P_PAYMENT_ID, P_PHONE_ID);
      
      CALC_PHONE_ON_ACCOUNTS_ID := 0; 
    
    end if; 
    
    if P_PHONE_ID is null then 
      
      SELECT PHONE_ID into CALC_PHONE_ID
        FROM PHONE_ON_ACCOUNTS
       where PHONE_ON_ACCOUNTS_ID = CALC_PHONE_ON_ACCOUNTS_ID;
     
      if CALC_PHONE_ID is null then
        CALC_PHONE_ID := 0;
      end if;
 
    else 
      CALC_PHONE_ID := P_PHONE_ID;
    end if;

       
     begin

       INSERT INTO BALANCE_VIRT_ACOUNTS (VIRTUAL_ACCOUNTS_ID,      PHONE_ON_ACCOUNTS_ID,   PAYMENT_ID, BILL_ID,     PHONE_ID,      YEAR_MONTH,   DATE_BALANCE, SUM_BALANCE,   SUM_PAY, BILL_SUM, BALANCE_TYPE_ID) 
                               VALUES (P_VIRTUAL_ACCOUNTS_ID, CALC_PHONE_ON_ACCOUNTS_ID, P_PAYMENT_ID, 0, CALC_PHONE_ID, CALC_YEAR_MONTH, P_DATE_BALANCE, 0, P_SUM_PAY, 0, ñSTART_BALANCE_INTERIM_TYPE);

       if P_PHONE_ID is null then 
         INSERT INTO DB_LOADER_BILLS_INS_BALANCE(PAYMENT_ID, PHONE_ID ) 
                                       VALUES (P_PAYMENT_ID, P_PHONE_ID); 
       end if;
      
     exception
          when others then
         INSERT INTO DB_LOADER_BILLS_INS_BALANCE(PAYMENT_ID, PHONE_ID ) 
                                      VALUES (P_PAYMENT_ID, P_PHONE_ID);  
     end;

  end;                                                                                                              


  PROCEDURE INSERT_PAYMENT_INTO_BALANCE_TR (P_VIRTUAL_ACCOUNTS_ID INTEGER, P_DATE_BALANCE DATE,  
                                                P_PAYMENT_ID INTEGER, P_PHONE_ID INTEGER, P_SUM_PAY NUMBER)
  as
    PRAGMA AUTONOMOUS_TRANSACTION;
    
    CALC_PHONE_ON_ACCOUNTS_ID    INTEGER;
    CALC_YEAR_MONTH              INTEGER;
    CALC_PHONE_ID                INTEGER;
    CALC_SUM_BALANCE             NUMBER;
  begin
  
   CALC_YEAR_MONTH := to_number(to_char(P_DATE_BALANCE, 'yyyymm'));
      
    select max(PHONE_ON_ACCOUNTS_ID) into CALC_PHONE_ON_ACCOUNTS_ID from CONTRACTS where VIRTUAL_ACCOUNTS_ID = P_VIRTUAL_ACCOUNTS_ID;
   
    if CALC_PHONE_ON_ACCOUNTS_ID is null then
    
      INSERT INTO DB_LOADER_BILLS_INS_BALANCE(PAYMENT_ID, PHONE_ID ) 
                                      VALUES (P_PAYMENT_ID, P_PHONE_ID);
      
      CALC_PHONE_ON_ACCOUNTS_ID := 0; 
    
    end if; 
    
    if P_PHONE_ID is null then 
      
      SELECT PHONE_ID into CALC_PHONE_ID
        FROM PHONE_ON_ACCOUNTS
       where PHONE_ON_ACCOUNTS_ID = CALC_PHONE_ON_ACCOUNTS_ID;
     
      if CALC_PHONE_ID is null then
        CALC_PHONE_ID := 0;
      end if;
 
    else 
      CALC_PHONE_ID := P_PHONE_ID;
    end if;

       
     begin
       CALC_SUM_BALANCE := 0;
       begin
       select SUM_BALANCE into CALC_SUM_BALANCE  
         from BALANCE_VIRT_ACOUNTS
        where VIRTUAL_ACCOUNTS_ID = P_VIRTUAL_ACCOUNTS_ID
          and YEAR_MONTH = CALC_YEAR_MONTH
          and BALANCE_TYPE_ID = ñSTART_BALANCE_LAST_TYPE;
       exception
        when others then
          CALC_SUM_BALANCE := 0; --çíà÷èò íå áûëî åùå ïëàòåæåé
       end;
        
       CALC_SUM_BALANCE := NVL(CALC_SUM_BALANCE, 0) + P_SUM_PAY;
       
         
       update BALANCE_VIRT_ACOUNTS set 
           BALANCE_TYPE_ID = ñSTART_BALANCE_INTERIM_TYPE
         where VIRTUAL_ACCOUNTS_ID = P_VIRTUAL_ACCOUNTS_ID
          and YEAR_MONTH = CALC_YEAR_MONTH
          and BALANCE_TYPE_ID = ñSTART_BALANCE_LAST_TYPE;
    
    
       INSERT INTO BALANCE_VIRT_ACOUNTS (VIRTUAL_ACCOUNTS_ID,      PHONE_ON_ACCOUNTS_ID,   PAYMENT_ID, BILL_ID,     PHONE_ID,      YEAR_MONTH,   DATE_BALANCE,      SUM_BALANCE,   SUM_PAY, BILL_SUM, BALANCE_TYPE_ID) 
                               VALUES (P_VIRTUAL_ACCOUNTS_ID, CALC_PHONE_ON_ACCOUNTS_ID, P_PAYMENT_ID, 0,      CALC_PHONE_ID, CALC_YEAR_MONTH, P_DATE_BALANCE, CALC_SUM_BALANCE, P_SUM_PAY, 0, ñSTART_BALANCE_LAST_TYPE);

       if P_PHONE_ID is null then 
         INSERT INTO DB_LOADER_BILLS_INS_BALANCE(PAYMENT_ID, PHONE_ID ) 
                                       VALUES (P_PAYMENT_ID, P_PHONE_ID); 
       end if;
       commit; 
     
     exception
          when others then
         INSERT INTO DB_LOADER_BILLS_INS_BALANCE(PAYMENT_ID, PHONE_ID ) 
                                      VALUES (P_PAYMENT_ID, P_PHONE_ID);  
         commit;                             
     end;

  end; 

  PROCEDURE INSERT_BILLS_INTO_BALANCE (P_ACCOUNTS_ID INTEGER, P_DATE_BALANCE DATE, 
                                         P_BILL_ID INTEGER, P_PHONE_ID INTEGER, P_BILL_SUM NUMBER)
  as
    CALC_PHONE_ON_ACCOUNTS_ID INTEGER;
    CALC_VIRTUAL_ACCOUNTS_ID  INTEGER;
    CALC_YEAR_MONTH           INTEGER;
  begin
    CALC_YEAR_MONTH := to_number(to_char(P_DATE_BALANCE, 'yyyymm'));
    
    select max(PHONE_ON_ACCOUNTS_ID) into CALC_PHONE_ON_ACCOUNTS_ID from PHONE_ON_ACCOUNTS where PHONE_ID = P_PHONE_ID and ACCOUNT_ID = P_ACCOUNTS_ID;
    
    if CALC_PHONE_ON_ACCOUNTS_ID is null then
      INSERT INTO DB_LOADER_BILLS_INS_BALANCE(BILL_ID, ACCOUNT_ID, PHONE_ID ) 
                                      VALUES (P_BILL_ID, P_ACCOUNTS_ID, P_PHONE_ID);
      CALC_PHONE_ON_ACCOUNTS_ID := 0;                                      
      CALC_VIRTUAL_ACCOUNTS_ID := 107;
    else 
      select max(VIRTUAL_ACCOUNTS_ID) into CALC_VIRTUAL_ACCOUNTS_ID from CONTRACTS where PHONE_ON_ACCOUNTS_ID = CALC_PHONE_ON_ACCOUNTS_ID;
    end if;
 
    if not CALC_VIRTUAL_ACCOUNTS_ID is null then
       
      INSERT INTO BALANCE_VIRT_ACOUNTS (VIRTUAL_ACCOUNTS_ID,      PHONE_ON_ACCOUNTS_ID, PAYMENT_ID,   BILL_ID,   PHONE_ID,      YEAR_MONTH,   DATE_BALANCE, SUM_BALANCE,   SUM_PAY, BILL_SUM, BALANCE_TYPE_ID) 
                           VALUES (CALC_VIRTUAL_ACCOUNTS_ID, CALC_PHONE_ON_ACCOUNTS_ID, 0,          P_BILL_ID, P_PHONE_ID, CALC_YEAR_MONTH, P_DATE_BALANCE, 0,             0,     P_BILL_SUM, ñSTART_BALANCE_INTERIM_TYPE);
    end if;                     

  end;                                                                                                              
 

  PROCEDURE INSERT_BILLS_INTO_BALANCE_TR (P_ACCOUNTS_ID INTEGER, P_DATE_BALANCE DATE, 
                                         P_BILL_ID INTEGER, P_PHONE_ID INTEGER, P_BILL_SUM NUMBER)
  as
    PRAGMA AUTONOMOUS_TRANSACTION;
    CALC_PHONE_ON_ACCOUNTS_ID INTEGER;
    CALC_VIRTUAL_ACCOUNTS_ID     INTEGER;
    CALC_YEAR_MONTH              INTEGER;
    CALC_SUM_BALANCE             NUMBER;
  begin
    CALC_YEAR_MONTH := to_number(to_char(P_DATE_BALANCE, 'yyyymm'));
    
    select max(PHONE_ON_ACCOUNTS_ID) into CALC_PHONE_ON_ACCOUNTS_ID from PHONE_ON_ACCOUNTS where PHONE_ID = P_PHONE_ID and ACCOUNT_ID = P_ACCOUNTS_ID;
    
    if CALC_PHONE_ON_ACCOUNTS_ID is null then
      INSERT INTO DB_LOADER_BILLS_INS_BALANCE(BILL_ID, ACCOUNT_ID, PHONE_ID ) 
                                      VALUES (P_BILL_ID, P_ACCOUNTS_ID, P_PHONE_ID);
      CALC_PHONE_ON_ACCOUNTS_ID := 0;                                      
      CALC_VIRTUAL_ACCOUNTS_ID := 107;
    else 
      select max(VIRTUAL_ACCOUNTS_ID) into CALC_VIRTUAL_ACCOUNTS_ID from CONTRACTS where PHONE_ON_ACCOUNTS_ID = CALC_PHONE_ON_ACCOUNTS_ID;
    end if;
 
    if not CALC_VIRTUAL_ACCOUNTS_ID is null then
       
       select SUM_BALANCE into CALC_SUM_BALANCE  
         from BALANCE_VIRT_ACOUNTS
        where VIRTUAL_ACCOUNTS_ID = CALC_VIRTUAL_ACCOUNTS_ID
          and YEAR_MONTH = CALC_YEAR_MONTH
          and BALANCE_TYPE_ID = ñSTART_BALANCE_LAST_TYPE;
        
       CALC_SUM_BALANCE := NVL(CALC_SUM_BALANCE, 0) - P_BILL_SUM;
         
       update BALANCE_VIRT_ACOUNTS set 
           BALANCE_TYPE_ID = ñSTART_BALANCE_INTERIM_TYPE
         where VIRTUAL_ACCOUNTS_ID = CALC_VIRTUAL_ACCOUNTS_ID
          and YEAR_MONTH = CALC_YEAR_MONTH
          and BALANCE_TYPE_ID = ñSTART_BALANCE_LAST_TYPE;
    
    
      INSERT INTO BALANCE_VIRT_ACOUNTS (VIRTUAL_ACCOUNTS_ID,      PHONE_ON_ACCOUNTS_ID, PAYMENT_ID,   BILL_ID,   PHONE_ID,      YEAR_MONTH,   DATE_BALANCE,      SUM_BALANCE,   SUM_PAY, BILL_SUM, BALANCE_TYPE_ID) 
                           VALUES (CALC_VIRTUAL_ACCOUNTS_ID, CALC_PHONE_ON_ACCOUNTS_ID, 0,          P_BILL_ID, P_PHONE_ID, CALC_YEAR_MONTH, P_DATE_BALANCE, CALC_SUM_BALANCE,   0,     P_BILL_SUM, ñSTART_BALANCE_LAST_TYPE);
    
       commit; 
    end if;                     

  end;                                                                                                              
 

  PROCEDURE RECALC_BALANCE (P_VIRTUAL_ACCOUNTS_ID INTEGER, P_YEAR_MONTH INTEGER) 
  as
    CALC_SUM_BALANCE             NUMBER;
    CALC_BALANCE                 NUMBER;
    old_YEAR_MONTH               INTEGER;
    CALC_DATE_BALANCE            DATE;
    LAST_DATE_BALANCE            DATE;
    LAST_ID_BALANCE_VIRT_ACOUNTS integer;
    cnt                          integer;
    c_ID_BALANCE_VIRT_ACOUNTS    integer;
    v_cur_bal_cursor             cur_bal_cursor;
    v_cur_balance BALANCE_VIRT_ACOUNTS%rowtype;
    lYEAR_MONTH integer;
    
  begin
       
    if nvl(P_YEAR_MONTH, 0) = 0 then
      lYEAR_MONTH := to_number(to_char(sysdate, 'yyyymm'));
    else
      lYEAR_MONTH := P_YEAR_MONTH;  
    end if;
    
    select count(sum_balance) into cnt 
      from BALANCE_VIRT_ACOUNTS  
     where BALANCE_TYPE_ID < ñSTART_BALANCE_INTERIM_TYPE 
       and YEAR_MONTH = lYEAR_MONTH
       and VIRTUAL_ACCOUNTS_ID = P_VIRTUAL_ACCOUNTS_ID;   
       
    if cnt = 0 then  
        
      select max(DATE_BALANCE) into LAST_DATE_BALANCE 
      from BALANCE_VIRT_ACOUNTS  
     where BALANCE_TYPE_ID < ñSTART_BALANCE_INTERIM_TYPE
       and YEAR_MONTH < lYEAR_MONTH
       and VIRTUAL_ACCOUNTS_ID = P_VIRTUAL_ACCOUNTS_ID;   
 
      LAST_DATE_BALANCE := nvl(LAST_DATE_BALANCE, sysdate);
      old_YEAR_MONTH := to_number(to_char(nvl(LAST_DATE_BALANCE, sysdate), 'yyyymm'));
     
      select count(sum_balance) into cnt 
      from BALANCE_VIRT_ACOUNTS  
     where BALANCE_TYPE_ID < ñSTART_BALANCE_INTERIM_TYPE
       and YEAR_MONTH = old_YEAR_MONTH
       and VIRTUAL_ACCOUNTS_ID = P_VIRTUAL_ACCOUNTS_ID;   

       
      if cnt = 0 then  
        CALC_SUM_BALANCE := 0;
      else
      
        select sum(sum_balance) into CALC_SUM_BALANCE 
        from BALANCE_VIRT_ACOUNTS  
       where BALANCE_TYPE_ID < ñSTART_BALANCE_INTERIM_TYPE
         and YEAR_MONTH = old_YEAR_MONTH
         and VIRTUAL_ACCOUNTS_ID = P_VIRTUAL_ACCOUNTS_ID;
         
        if CALC_SUM_BALANCE is null then
          CALC_SUM_BALANCE := 0;
        end if;
            
      end if;  
      
      select sum(nvl(sum_pay,0)) - sum(nvl(bill_sum,0)) into CALC_BALANCE 
      from BALANCE_VIRT_ACOUNTS  
      where YEAR_MONTH = old_YEAR_MONTH
       and BALANCE_TYPE_ID > ñSTART_BALANCE_CALC_TYPE
       and VIRTUAL_ACCOUNTS_ID = P_VIRTUAL_ACCOUNTS_ID;
      
      CALC_BALANCE := nvl(CALC_BALANCE, 0);
      
    
      CALC_SUM_BALANCE := CALC_SUM_BALANCE + CALC_BALANCE; 
      CALC_DATE_BALANCE := to_date('01.'||substr(to_char(lYEAR_MONTH), 5,2)||'.'||substr(to_char(lYEAR_MONTH), 1,4), 'dd.mm.yyyy');
       
      INSERT INTO BALANCE_VIRT_ACOUNTS (VIRTUAL_ACCOUNTS_ID, PHONE_ON_ACCOUNTS_ID, PAYMENT_ID, BILL_ID, PHONE_ID,   YEAR_MONTH,      DATE_BALANCE,      SUM_BALANCE, SUM_PAY, BILL_SUM, BALANCE_TYPE_ID) 
                                VALUES (P_VIRTUAL_ACCOUNTS_ID,    0,               0,          0,       0,        lYEAR_MONTH, CALC_DATE_BALANCE, CALC_SUM_BALANCE, 0,       0,        ñSTART_BALANCE_CALC_TYPE);
   
    else 
     select sum_balance, DATE_BALANCE into CALC_SUM_BALANCE, CALC_DATE_BALANCE 
      from BALANCE_VIRT_ACOUNTS  
     where BALANCE_TYPE_ID < ñSTART_BALANCE_INTERIM_TYPE
       and YEAR_MONTH = lYEAR_MONTH
       and VIRTUAL_ACCOUNTS_ID = P_VIRTUAL_ACCOUNTS_ID;
  
     end if;
    
    open v_cur_bal_cursor for
        select * 
          from BALANCE_VIRT_ACOUNTS bva 
         where bva.VIRTUAL_ACCOUNTS_ID = P_VIRTUAL_ACCOUNTS_ID
           and bva.DATE_BALANCE >= CALC_DATE_BALANCE
           and bva.YEAR_MONTH = lYEAR_MONTH
           and bva.BALANCE_TYPE_ID > ñSTART_BALANCE_CALC_TYPE
      order by bva.DATE_BALANCE, bva.ID_BALANCE_VIRT_ACOUNTS;
        
    loop
        fetch v_cur_bal_cursor into v_cur_balance;
        exit when v_cur_bal_cursor%NOTFOUND;
        --
        c_ID_BALANCE_VIRT_ACOUNTS := v_cur_balance.ID_BALANCE_VIRT_ACOUNTS;
        
        CALC_SUM_BALANCE := CALC_SUM_BALANCE + v_cur_balance.SUM_PAY - v_cur_balance.BILL_SUM; 
        
        LAST_ID_BALANCE_VIRT_ACOUNTS := v_cur_balance.ID_BALANCE_VIRT_ACOUNTS;
        
        update BALANCE_VIRT_ACOUNTS set 
           SUM_BALANCE = CALC_SUM_BALANCE
         where ID_BALANCE_VIRT_ACOUNTS = LAST_ID_BALANCE_VIRT_ACOUNTS;
      
    end loop; 
    
    close v_cur_bal_cursor;
    
        update BALANCE_VIRT_ACOUNTS set 
           BALANCE_TYPE_ID = ñSTART_BALANCE_LAST_TYPE
         where ID_BALANCE_VIRT_ACOUNTS = LAST_ID_BALANCE_VIRT_ACOUNTS;
    
    
    
  end;
  
 PROCEDURE RECALC_BALANCE2 (P_VIRTUAL_ACCOUNTS_ID INTEGER, P_YEAR_MONTH INTEGER) 
  as
    CURSOR MNTH IS
      SELECT distinct BALANCE_VIRT_ACOUNTS.YEAR_MONTH
        FROM BALANCE_VIRT_ACOUNTS
       WHERE BALANCE_VIRT_ACOUNTS.YEAR_MONTH > P_YEAR_MONTH;
   vMNTH       MNTH%ROWTYPE;
  begin
    
    if P_VIRTUAL_ACCOUNTS_ID is null then
      return;
    end if;
  
    if P_YEAR_MONTH is null then
      return;
    end if;

    delete from BALANCE_VIRT_ACOUNTS 
     where VIRTUAL_ACCOUNTS_ID = P_VIRTUAL_ACCOUNTS_ID
       and YEAR_MONTH = P_YEAR_MONTH
       and BALANCE_TYPE_ID = ñSTART_BALANCE_CALC_TYPE;
       
    RECALC_BALANCE (P_VIRTUAL_ACCOUNTS_ID, P_YEAR_MONTH); 
    FOR vMNTH IN MNTH
    LOOP

      delete from BALANCE_VIRT_ACOUNTS 
       where VIRTUAL_ACCOUNTS_ID = P_VIRTUAL_ACCOUNTS_ID
         and YEAR_MONTH = vMNTH.YEAR_MONTH
         and BALANCE_TYPE_ID = ñSTART_BALANCE_CALC_TYPE;

       RECALC_BALANCE (P_VIRTUAL_ACCOUNTS_ID, vMNTH.YEAR_MONTH);
    end loop;
  end;
 
end BALANCE;
/


GRANT EXECUTE ON BALANCE TO BUSINESS_COMM_ROLE;

GRANT EXECUTE ON BALANCe TO BUSINESS_COMM_ROLE_RO;