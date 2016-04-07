CREATE OR REPLACE PROCEDURE CHECK_ALL_DETAILS2 IS
  vYEAR_MONTH INTEGER;
  vCOST NUMBER(15, 4);  
  cursor c(pYEAR_MONTH in integer, pPHONE_NUMBER in varchar2) is
    select *
      from DILER_CALL_FOR_PHONE
      where YEAR_MONTH = pYEAR_MONTH
        and PHONE_NUMBER = pPHONE_NUMBER;
  dummy c%rowtype;
BEGIN
  vYEAR_MONTH:=TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYYMM'));
  FOR rec IN (SELECT PHONE_NUMBER, bill_sum
                FROM db_loader_full_finance_bill
                WHERE db_loader_full_finance_bill.YEAR_MONTH=vYEAR_MONTH ) 
  LOOP
    if rec.bill_sum <> 0 then 
      vCOST:=GET_DILER_COST_FROM_DETAIL(rec.PHONE_NUMBER,vYEAR_MONTH);
    else
      vCost:=0;
    end if;
    DELETE DILER_CALL_FOR_PHONE
      WHERE DILER_CALL_FOR_PHONE.YEAR_MONTH=vYEAR_MONTH
        AND DILER_CALL_FOR_PHONE.PHONE_NUMBER=rec.PHONE_NUMBER
        and NVL(DILER_CALL_FOR_PHONE.DILER_CALLS, 0) < vCOST;
    open c(vYEAR_MONTH, rec.PHONE_NUMBER);
    fetch c into dummy;
    if c%notfound then
      INSERT INTO DILER_CALL_FOR_PHONE(YEAR_MONTH, PHONE_NUMBER, DILER_CALLS)    
        VALUES(vYEAR_MONTH, rec.PHONE_NUMBER, vCOST);   
    end if;
    close c;     
    COMMIT;       
  END LOOP;
END;
/
