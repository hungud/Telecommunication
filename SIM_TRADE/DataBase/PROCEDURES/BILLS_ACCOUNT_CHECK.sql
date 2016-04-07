CREATE OR REPLACE PROCEDURE BILLS_ACCOUNT_CHECK IS 
BEGIN
  FOR REC IN(
    SELECT B.ACCOUNT_ID, B.YEAR_MONTH
      FROM DB_LOADER_BILLS B
      WHERE (B.ACCOUNT_ID, B.YEAR_MONTH) NOT IN 
              (SELECT AB.ACCOUNT_ID, AB.YEAR_MONTH
                 FROM ACCOUNT_LOADED_BILLS AB)
      GROUP BY B.ACCOUNT_ID, B.YEAR_MONTH )
  LOOP
    INSERT INTO ACCOUNT_LOADED_BILLS(ACCOUNT_ID, YEAR_MONTH, LOAD_BILL_IN_BALANCE)
      VALUES(REC.ACCOUNT_ID, REC.YEAR_MONTH, 0); 
  END LOOP;
  FOR REC IN(
    SELECT B.ACCOUNT_ID, B.YEAR_MONTH
      FROM DB_LOADER_FULL_FINANCE_BILL B
      WHERE (B.ACCOUNT_ID, B.YEAR_MONTH) NOT IN 
              (SELECT AB.ACCOUNT_ID, AB.YEAR_MONTH
                 FROM ACCOUNT_LOADED_BILLS AB)
      GROUP BY B.ACCOUNT_ID, B.YEAR_MONTH )
  LOOP
    INSERT INTO ACCOUNT_LOADED_BILLS(ACCOUNT_ID, YEAR_MONTH, LOAD_BILL_IN_BALANCE)
      VALUES(REC.ACCOUNT_ID, REC.YEAR_MONTH, 0); 
  END LOOP;
  COMMIT;
END;                 