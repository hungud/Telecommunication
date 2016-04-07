CREATE OR REPLACE PROCEDURE BLOCK_LOYAL_WITH_0_BALANCE2 IS
CURSOR C IS
  SELECT *
    FROM LOYAL_PHONE_FOR_BLOCK
    ORDER BY GET_ABONENT_BALANCE(LOYAL_PHONE_FOR_BLOCK.PHONE_NUMBER) ASC;
CURSOR BL (ID INTEGER) IS
  SELECT 
    ACCOUNTS.DO_AUTO_BLOCK
  FROM ACCOUNTS
  WHERE ID=ACCOUNTS.ACCOUNT_ID;  
vBL BL%ROWTYPE;    
LOCK_PH VARCHAR2(300 CHAR);  
BALANCE NUMBER(13, 2);      
ERROR_COL INTEGER;
BEGIN
  FOR rec IN C LOOP
    BALANCE:=GET_ABONENT_BALANCE(REC.PHONE_NUMBER);
    OPEN BL(REC.ACCOUNT_ID);
    FETCH BL INTO vBL;
    CLOSE BL;    
    IF (vBL.DO_AUTO_BLOCK=1) THEN
      IF ((SYSDATE>REC.DATE_FUTURE_BLOCK)and(BALANCE < REC.BALANCE_BLOCK)) OR (BALANCE < REC.BALANCE_BLOCK-500) THEN
        LOCK_PH:=LOADER3_pckg.LOCK_PHONE(REC.PHONE_NUMBER,0);
        IF LOCK_PH IS NOT NULL THEN
          LOOP
            ERROR_COL:=ERROR_COL+1;
            LOCK_PH:=LOADER3_pckg.LOCK_PHONE(REC.PHONE_NUMBER); 
            EXIT WHEN (LOCK_PH IS NULL) OR (ERROR_COL=2); 
          END LOOP;
        END IF;     
        IF LOCK_PH IS NOT NULL THEN
          INSERT INTO AUTO_BLOCKED_PHONE(PHONE_NUMBER, BALLANCE, NOTE, BLOCK_DATE_TIME, ABONENT_FIO) 
            VALUES (REC.PHONE_NUMBER, BALANCE, SUBSTR('������. '||LOCK_PH, 300), SYSDATE, rec.FIO);
          COMMIT;
        ELSE 
          UPDATE DB_LOADER_ACCOUNT_PHONES
            SET DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE=0
            WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=REC.PHONE_NUMBER
              AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH=(SELECT * 
                                                         FROM (SELECT DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH 
                                                                 FROM DB_LOADER_ACCOUNT_PHONES 
                                                                 WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=REC.PHONE_NUMBER
                                                                 ORDER BY YEAR_MONTH DESC)
                                                         WHERE ROWNUM=1);
          DELETE FROM LOYAL_PHONE_FOR_BLOCK
            WHERE LOYAL_PHONE_FOR_BLOCK.PHONE_NUMBER=rec.PHONE_NUMBER;   
          COMMIT;                                            
        END IF;
      ELSE
        IF BALANCE > REC.BALANCE_BLOCK THEN  
          DELETE FROM LOYAL_PHONE_FOR_BLOCK
            WHERE LOYAL_PHONE_FOR_BLOCK.PHONE_NUMBER=rec.PHONE_NUMBER;   
          COMMIT;  
        END IF;
      END IF;
    END IF; 
  END LOOP;
END;

--GRANT EXECUTE ON BLOCK_LOYAL_WITH_0_BALANCE TO LONTANA ROLE;
/
