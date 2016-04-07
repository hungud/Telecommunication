CREATE OR REPLACE PROCEDURE IVIDEON.UNBLOCK_CLIENT_WTH_PLUS_BAL AS
--
--#Version=2
--
--v.2 - Соколов. Добавил баланс в историю
--v.1 - Соколов Процедура разблока
--
  --
  CURSOR ABONENTS IS
    SELECT IA.ABONENT_ID 
      FROM IVIDEON_ABONENTS IA,
           ABONENT_BLOCK_UNLOCK ABU
      WHERE IA.ABONENT_ID = ABU.ABONENT_ID
        AND ABU.ABONENT_IS_ACTIVE = 0;
    
  CURSOR BALANCE (pABONENT_ID INTEGER) IS
    SELECT BALANCE
      FROM ABONENT_BALANCE AB       
      WHERE AB.ABONENT_ID = pABONENT_ID;  
  --
  vBL BALANCE%ROWTYPE;
  LOCK_PH VARCHAR2(100 BYTE);
  OK BOOLEAN := FALSE;
  RESULT VARCHAR2(20);
BEGIN
  --
  FOR vREC IN ABONENTS LOOP
    OPEN BALANCE (vREC.ABONENT_ID);
    FETCH BALANCE INTO vBL;
    CLOSE BALANCE;
    IF vBL.BALANCE > 0 THEN
    
     UNLOCK_ABONENT (vREC.ABONENT_ID,LOCK_PH,OK); -- Процедура отправки разблока 
     
    IF OK THEN 
      BEGIN
      
      SELECT SUBSTR(LOCK_PH,instr(LOCK_PH,':',1)+1,instr(LOCK_PH,',',1)-instr(LOCK_PH,':',1)-1) 
      INTO RESULT
      FROM dual;
      
      IF RESULT='true' THEN     
        UPDATE ABONENT_BLOCK_UNLOCK
        SET ABONENT_IS_ACTIVE = 1,
            BALANCE = vBL.BALANCE
        WHERE ABONENT_ID = vREC.ABONENT_ID;
      END IF;
     
      INSERT INTO ABONENT_BLOCK_UNLOCK_HISTORY(
                                              ABONENT_ID,
                                              ACTION_TYPE_ID,
                                              HISTORY_DATE,
                                              ANSWER,
                                              BALANCE
                                             )
                                       VALUES(       
                                              vREC.ABONENT_ID,
                                              1,
                                              SYSDATE,
                                              LOCK_PH,
                                              vBL.BALANCE
                                              );
      
      COMMIT; 
      END;
    ELSE
      INSERT INTO ABONENT_BLOCK_UNLOCK_HISTORY(
                                              ABONENT_ID,
                                              ACTION_TYPE_ID,
                                              HISTORY_DATE,
                                              ANSWER,
                                              BALANCE
                                             )
                                       VALUES(       
                                              vREC.ABONENT_ID,
                                              1,
                                              SYSDATE,
                                              NVL(LOCK_PH,'Нет соединения'),
                                              vBL.BALANCE
                                              ); 
    COMMIT;                                          
    END IF; 
    END IF;      
  END LOOP;
END;
/
